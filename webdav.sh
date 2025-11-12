

# Install lighttpd and WebDAV
apt-get update && \
apt-get install -y lighttpd lighttpd-mod-webdav apache2-utils && 

# Create WebDAV directory
mkdir -p /var/www/webdav && \
chown -R www-data:www-data /var/www/webdav && \
chmod -R 755 /var/www/webdav

# Create basic auth user (admin / admin)
htpasswd -bc /etc/lighttpd/webdav.passwd admin admin

# Enable modules
lighty-enable-mod webdav auth

# Configure Lighttpd for WebDAV (use port 10000 or $PORT)
    echo 'server.document-root = "/var/www"' > /etc/lighttpd/lighttpd.conf && \
    echo 'server.port = 10000' >> /etc/lighttpd/lighttpd.conf && \
    echo 'dir-listing.activate = "enable"' >> /etc/lighttpd/lighttpd.conf && \
    echo 'server.modules += ( "mod_auth", "mod_webdav" )' >> /etc/lighttpd/lighttpd.conf && \
    echo '$HTTP["url"] =~ "^/webdav($|/)" {' >> /etc/lighttpd/lighttpd.conf && \
    echo '    webdav.activate = "enable"' >> /etc/lighttpd/lighttpd.conf && \
    echo '    webdav.is-readonly = "disable"' >> /etc/lighttpd/lighttpd.conf && \
    echo '    webdav.sqlite-db-name = "/var/www/webdav/webdav.db"' >> /etc/lighttpd/lighttpd.conf && \
    echo '    auth.backend = "htpasswd"' >> /etc/lighttpd/lighttpd.conf && \
    echo '    auth.backend.htpasswd.userfile = "/etc/lighttpd/webdav.passwd"' >> /etc/lighttpd/lighttpd.conf && \
    echo '    auth.require = ( "" => ( "method" => "basic", "realm" => "WebDAV", "require" => "valid-user" ) )' >> /etc/lighttpd/lighttpd.conf && \
    echo '}' >> /etc/lighttpd/lighttpd.conf
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared
chmod +x /usr/bin/cloudflared



    


# Use $PORT environment variable if Render provides it


