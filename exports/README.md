# exports

This folder is where any MySQL table dumps will be exported.

You can do things like this to get exports:

    SELECT nid, title, FROM node
    INTO OUTFILE '/var/lib/mysql-files/nodes.csv'
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

