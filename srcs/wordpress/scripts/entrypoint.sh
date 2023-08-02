#!/usr/bin/env bash

# Debug mode
# set -x
set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Configure wordpress core installation
if [ ! -f "wp-config.php" ]; then
    echo -e "${GREEN}WordPress setup${NC}"

    # Install wordpress
    wp core download --allow-root

    # Wait until wp download is finished and then install
    while [ ! -f "wp-config-sample.php" ]; do
        sleep 1
    done

    # Wait until db is ready
    while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
        sleep 1
    done

    wp core config \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" --allow-root

   # FS_METHOD
    wp config set FS_METHOD direct --allow-root

    # Wait until wp-config.php is created
    while [ ! -f "wp-config.php" ]; do
        sleep 1
    done

    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_USER" \
        --admin_password="$WORDPRESS_PASSWORD" \
        --admin_email="$WORDPRESS_EMAIL" --skip-email --allow-root

    # Wait until wp core install is finished
    while [ ! -f "wp-login.php" ]; do
        sleep 1
    done

    wp option set blog_public 0 --allow-root # Don't index my website

    echo -e "${GREEN}ACF Pro plugin installation${NC}"
    wp plugin install "https://connect.advancedcustomfields.com/v2/plugins/download?p=pro&k=$ACF_KEY" --activate --allow-root

    # Wait until acf is installed
    while [ ! -f "wp-content/plugins/advanced-custom-fields-pro/acf.php" ]; do
        sleep 1
    done

    # Check if plugin is enabled
    wp plugin is-active advanced-custom-fields-pro --allow-root

    echo -e "${GREEN}Updraftplus plugin installation${NC}"
    wp plugin install "https://updraftplus.com/wp-content/uploads/updraftplus.zip" --activate --allow-root

    # Wait until updraftplus is installed
    while [ ! -f "wp-content/plugins/updraftplus/updraftplus.php" ]; do
        sleep 1
    done

    # Check if plugin is enabled
    wp plugin is-active updraftplus --allow-root

    echo -e "${GREEN}Delete default plugins${NC}"
    wp plugin delete akismet --allow-root
    wp plugin delete hello --allow-root

    echo -e "${GREEN}Update plugins${NC}"
    wp plugin update --all --allow-root

    # Wait to swtich to the correct theme
    echo -e "${GREEN}Enabling Toolkit theme${NC}"
    while [[ $(find wp-content/themes/toolkit -name "style.css" | wc -l) -eq 0 ]]; do
        sleep 10
    done

    wp theme activate $THEME_NAME --allow-root

    # Check theme is enabled
    wp theme is-active $THEME_NAME --allow-root

    echo -e "${GREEN}Delete default themes${NC}"
    wp theme delete twentytwentyone --allow-root
    wp theme delete twentytwentythree --allow-root
    wp theme delete twentytwentytwo --allow-root

    # wp updraftplus connect \
    #     --email="$UPDRAFTPLUS_EMAIL" \
    #     --password="$UPDRAFTPLUS_PASSWORD" \
    #     --allow-root

    # # Use the last backup
    # wp updraftplus restore \
    #     --all \
    #     --allow-root
fi

echo -e "${GREEN}Start wp server${NC}"
wp server --host=0.0.0.0 --port=8000 --allow-root