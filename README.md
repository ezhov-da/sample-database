# sample-database

This sample database **H2DB** for test.

Data for DB from [www.dofactory.com](http://www.dofactory.com/sql/sample-database).

Use DB file **sample.mv.db** for work.

Use connection string: **jdbc:h2:tcp://localhost/~/sample** for connect as server.  

And authorization:     
username: **sa**  
password: **sa**  

For detail info about H2DB go to [www.h2database.com](http://www.h2database.com/html/advanced.html)

Schema DB:  
![schema](https://github.com/ezhov-da/sample-database/blob/master/diagram.png?raw=true)

## Docker usage

### Build
```
docker build -t sample-db:v1 .
```

### Run
```
docker run --rm -p 8082:8082 --name sample-db sample-db:v1
```

### Access

[http://localhost:8082/](http://localhost:8082/)

### Stop

```
docker stop sample-db
```


Please, if you find error in script or data, give me know.
Thanks.