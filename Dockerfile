FROM prestashop/prestashop

ENV PS_INSTALL_AUTO=0
ENV DB_SERVER=biznes-db:3306
ENV DB_USER=user_5
ENV DB_PASSWD="ach ten projekt"
ENV DB_NAME=db_5
ENV PS_ENABLE_SSL=1

RUN rm -rf /var/www/html
COPY ./html /var/www/html

COPY ./dump.sql /root/dump.sql
COPY ./create.sql /root/create.sql
COPY ./user.sql /root/user.sql
COPY ./importdump.sh /root/importdump.sh
