FROM node:18.8.0

LABEL maintainer="Martin Jean-Christio <martin@jean-christio.ch>"

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    openssh-client \
    rsync

# Install npm packages
COPY ./themes/toolkit/package*.json .

# GSAP auth
COPY ./themes/toolkit/.npmrc .

RUN npm install

# Copy the entrypoint script to a different directory
COPY ./scripts/entrypoint.sh /usr/src/app/entrypoint.sh

# Change ownership and permissions
RUN chown www-data:www-data /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
