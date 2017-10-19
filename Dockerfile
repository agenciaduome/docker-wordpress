FROM wordpress:php5.6-apache

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		mysql-client \
		sudo \
	; \
	rm -rf /var/lib/apt/lists/*;

# install wp-cli
RUN curl -o /usr/local/bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp
RUN chmod 777 /usr/local/bin/wp-cli.phar

# allow wp-cli to regenerate .htaccess files
RUN { \
		echo 'apache_modules:'; \
		echo '  - mod_rewrite'; \
	} > /var/www/wp-cli.yml

COPY docker-entrypoint.sh /entrypoint.sh

WORKDIR /var/www/html
VOLUME /var/www/html

EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
