echo "CREATE DATABASE IF NOT EXISTS db5;" | mysql --host="biznes-db" --port=3306 --user "user_5" --password "ach ten projekt"
mysql --host="biznes-db" --port=3306 --user "user_5" --password "ach ten projekt" 'db_5' < /var/www/html/dump.sql
