# exports

This folder is where any MySQL table dumps will be exported.

You will most likely need to be the root user to export, so connect directly to the database container to do this and use the password that was generated during the creation of the database container (it should appear in the logs).

You can do things like this to get exports:

    SELECT nid, title, FROM node
    INTO OUTFILE '/var/lib/mysql-files/nodes.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

