#!/bin/sh

# Generate password hash
BROWSE_PASSWORD_HASH=$(htpasswd -nbB -C 10 $BROWSE_USERNAME $BROWSE_PASSWORD | cut -d ":" -f 2)

# Export the password hash as an environment variable
export BROWSE_PASSWORD_HASH

# Start Caddy
exec caddy run --config /etc/caddy/Caddyfile
