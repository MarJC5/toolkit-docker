FROM wordpress:cli-2.8-php8.1

LABEL maintainer="Martin Jean-Christio <martin@jean-christio.ch>"

WORKDIR /var/www/html

USER root

# Install mysql-client
RUN apk add --no-cache mysql-client

# Copy the entrypoint script to a different directory
COPY ./scripts/entrypoint.sh /usr/src/app/entrypoint.sh

# Change ownership and permissions
RUN chown www-data:www-data /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
