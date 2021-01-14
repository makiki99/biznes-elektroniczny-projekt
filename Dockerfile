FROM centos:8

RUN yum -y install httpd php git mod_ssl; git clone https://github.com/makiki99/biznes-elektroniczny-projekt.git /var/www/html; cp /var/www/html/extra_stuff/server.crt /etc/pki/tls/certs/localhost.crt; cp /var/www/html/extra_stuff/server.key /etc/pki/tls/private/localhost.key; yum -y remove git

CMD apachectl

CMD bash 
