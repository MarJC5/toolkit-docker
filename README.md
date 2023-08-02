# Docker Compose Setup for WordPress and Node.js with Hawaii Interactive Toolkit

This Docker Compose configuration sets up a development environment with WordPress, MySQL, Node.js, and Adminer. It allows you to develop WordPress themes and Node.js applications simultaneously.

## Prerequisites

Before using this Docker Compose setup, make sure you have the following installed:

- Docker: [Install Docker](https://www.docker.com/get-started)

## Usage

1. Clone this repository to your local machine:

2. Create a `.env` file in the root directory of the cloned repository with the following environment variables:

   ```env
   MYSQL_ROOT_PASSWORD=your-mysql-root-password
   WORDPRESS_DB_NAME=your-wordpress-db-name
   WORDPRESS_DB_USER=your-wordpress-db-user
   WORDPRESS_DB_PASSWORD=your-wordpress-db-password
   WORDPRESS_TITLE=your-wordpress-title
   WORDPRESS_USER=your-wordpress-admin-user
   WORDPRESS_PASSWORD=your-wordpress-admin-password
   WORDPRESS_EMAIL=your-wordpress-admin-email
   ACF_KEY=your-acf-pro-key
   ```

   Replace `your-mysql-root-password`, `your-wordpress-db-name`, `your-wordpress-db-user`, `your-wordpress-db-password`, `your-wordpress-title`, `your-wordpress-admin-user`, `your-wordpress-admin-password`, `your-wordpress-admin-email`, and `your-acf-pro-key` with your desired values.

3. Start the Docker Compose services:

   ```bash
   docker-compose up -d
   ```

4. Access the following services:

   - WordPress: [http://localhost:8000](http://localhost:8000)
   - Node.js: [http://localhost:3000](http://localhost:3000)
   - Adminer (MySQL management): [http://localhost:8080](http://localhost:8080)

## WordPress Setup

The WordPress setup is automated using a custom entrypoint script located in `./srcs/wordpress/entrypoint.sh`. The script performs the following actions:

- Downloads the WordPress core in French locale
- Creates a WordPress configuration with the provided database credentials
- Resets the WordPress database
- Installs WordPress with the specified admin user and email
- Sets the website to private mode (blog_public = 0)
- Installs and activates the ACF Pro plugin using the provided `ACF_KEY`
- Installs and activates the UpdraftPlus plugin
- Restores and enables a custom-made theme named "toolkit" placed in `./srcs/themes/toolkit`
- Sets the correct permissions for the theme files
- Starts the WordPress server

## Node.js Setup

The Node.js setup is automated using a custom entrypoint script located in `./srcs/nodejs/entrypoint.sh`. The script performs the following actions:

- Installs the Node.js application dependencies using `npm install`
- Checks the project type (`webpack` or `gulp`) and runs the appropriate scripts:
  - If the project type is `webpack`, it starts the server in production mode (`npm run production`) or watch mode (`npm run watch`) based on the `NODE_ENV` environment variable.
  - If the project type is `gulp`, it installs Gulp dependencies (`gulp install`) and starts the watch task (`npm run watch`).

## Customization

You can customize the Docker Compose setup to suit your specific needs:

- Change the WordPress theme: Replace the custom-made "toolkit" theme in `./srcs/themes/toolkit` with your own WordPress theme.
- Modify Node.js application: Place your Node.js application files in the `./srcs/nodejs` directory and adjust the `Dockerfile` accordingly.
- Change environment variables: Adjust the `.env` file to provide appropriate environment variable values.

## Notes

- This Docker Compose setup is intended for local development purposes. In a production environment, additional configurations and security measures are required.
