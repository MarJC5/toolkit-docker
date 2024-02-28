ARG NODE_VERSION

FROM node:${NODE_VERSION}

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf

LABEL maintainer="Martin Jean-Christio <martin@jean-christio.ch>"

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    openssh-client \
    rsync \
    expect

# Install npm packages
COPY ./themes/${APP_NAME}/package*.json ./themes/${APP_NAME}/.npmrc* ./

# Copy the copy-if-exists script
COPY ./scripts/gulp_install.expect /usr/src/app/gulp_install.expect
RUN chmod +x /usr/src/app/gulp_install.expect

RUN npm install

# Copy the entrypoint script to a different directory
COPY ./scripts/entrypoint.sh /usr/src/app/entrypoint.sh

# Change ownership and permissions
RUN chown www-data:www-data /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 3000 5173

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
