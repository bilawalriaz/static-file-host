# Static File Host with Caddy
## Create your own self hosted CDN

This project sets up a lightweight static file hosting solution using Docker and Caddy. It provides a secure way to host and serve static files with features like file browsing (password protected) and direct file access.

![This is hosted using Static File Host!](https://cdn.hyperflash.uk/staticfilehostscreenshot.png)
*This screenshot itself is hosted using Static File Host!*
## Features

- Lightweight and fast static file serving
- Secure file browsing with basic authentication
- Direct file access without authentication
- GZIP and Zstandard compression
- Configurable through environment variables
- Logging to host machine

## Prerequisites

- Docker
- A directory on your host machine to store the files (e.g., `/cdn`)
- Free Cloudflare account for tunnelling (optional)

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/bilawalriaz/static-file-host.git
   cd static-file-host
   ```

2. Build the Docker image:
   ```
   docker build -t static-file-host .
   ```

3. Run the container:
   ```
   docker run -d \
     -p 7432:7432 \
     -v /cdn:/srv \
     -v /var/log/caddy:/var/log/caddy \
     -e BROWSE_USERNAME=your_username \
     -e BROWSE_PASSWORD='your_C0mP!3X_password' \
     --name static-file-host \
     static-file-host
   ```

   Replace `your_username` and `your_password` with your desired credentials for directory browsing. ***It is recommended to change this or else anyone can browse the contents of the CDN from the root page.***

4. Access your files:
   - Drop any files into your CDN directory (e.g /cdn)
   - File browsing: `http://localhost:7432` (requires authentication)
   - Direct file access: `http://localhost:7432/your-file.jpg` (no authentication required)
   - Use Cloudflare Tunnel to expose HTTP localhost on port 7432 with your desired domain

![Cloudflare Tunnel](https://cdn.hyperflash.uk/cftunnelstaticfilehost.png)

## Configuration

### Environment Variables

- `BROWSE_USERNAME`: Username for file browsing authentication
- `BROWSE_PASSWORD`: Password for file browsing authentication

### Volumes

- `/srv`: This is the directory within the container that needs to be mapped to your host directory that contains your files (e.g., `-v /cdn:/srv` if your files are in /cdn and `-v /tmp/anyfolder:/srv` if they're in /tmp/anyfolder)
- `/var/log/caddy`: Mount a directory to store Caddy logs (e.g., `-v /var/log/caddy:/var/log/caddy`)

### Port

The container exposes port 7432. Map it to any port on your host if you wish (e.g., `-p 8080:7432`).

## File Structure

- `Dockerfile`: Defines the Docker image
- `Caddyfile`: Caddy server configuration
- `start.sh`: Startup script to set up authentication and start Caddy

## Security Considerations

- Use strong, unique passwords for file browsing authentication
- Regularly monitor the Caddy logs for suspicious activity
- Consider implementing additional security measures like IP whitelisting if needed

## Customization

You can modify the `Caddyfile` to add additional Caddy directives or change existing configurations. Remember to rebuild the Docker image after making changes.

## Troubleshooting

- If you can't access the file host, check if the container is running: `docker ps`
- View container logs: `docker logs static-file-host`
- Check Caddy logs in `/var/log/caddy/access.log` on your host machine

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.