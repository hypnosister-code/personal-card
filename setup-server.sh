#!/bin/bash

# Install Apache
sudo apt-get update
sudo apt-get install apache2 -y

# Enable required Apache modules
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod ssl

# Create a new virtual host configuration
sudo bash -c 'cat > /etc/apache2/sites-available/personal-card.conf << EOL
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/personal-card
    
    <Directory /var/www/html/personal-card>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/personal-card_error.log
    CustomLog ${APACHE_LOG_DIR}/personal-card_access.log combined
</VirtualHost>
EOL'

# Create the website directory
sudo mkdir -p /var/www/html/personal-card

# Copy website files
sudo cp -r * /var/www/html/personal-card/

# Set proper permissions
sudo chown -R www-data:www-data /var/www/html/personal-card
sudo chmod -R 755 /var/www/html/personal-card

# Enable the site
sudo a2ensite personal-card.conf

# Restart Apache
sudo systemctl restart apache2

echo "Setup complete! Your website should now be accessible at http://localhost"
echo "To make it accessible from the internet, make sure port 80 is forwarded on your router"
