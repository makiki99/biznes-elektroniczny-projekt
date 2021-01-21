mysql --host="biznes-db" --port=3306 --user "root" -pdev < /var/www/html/user.sql
mysql --host="biznes-db" --port=3306 --user "root" -pdev < /var/www/html/create.sql
mysql --host="biznes-db" --port=3306 --user "user_5" -p"ach ten projekt" 'db_5' < /var/www/html/dump.sql
