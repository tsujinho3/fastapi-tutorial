FROM mysql:8.0

# USER must be "mysql".
USER mysql

COPY ./my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]
