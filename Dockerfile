FROM caddy:2-alpine

# Install bcrypt for password hashing
RUN apk add --no-cache apache2-utils

# Copy Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Create volume for files and logs
VOLUME /srv
VOLUME /var/log/caddy

EXPOSE 7432

# Set up environment variables for authentication
ENV BROWSE_USERNAME=changeme
ENV BROWSE_PASSWORD=changeme

# Start script to set up authentication and start Caddy
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
