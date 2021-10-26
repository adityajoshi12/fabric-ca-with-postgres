# Fabric CA with Postgres

```
 db:
   type: postgres
   datasource: host=postgres port=5432 user=postgres password=postgres dbname=postgres sslmode=verify-full sslrootcert=/certs/client/root.crt sslcert=/certs/client/postgresql.crt sslkey=/certs/client/postgresql.key
   tls:
     enabled: false
     certfiles:
     client:
       certfile:
       keyfile:
```

```
 docker run \
   --rm \
   -e POSTGRES_PASSWORD=password \
   postgres \
   -c ssl=on \
   -c ssl_cert_file=/etc/postgres/server.crt \
   -c ssl_key_file=/etc/postgres/server.key \
   -c ssl_ca_file=/etc/postgres/root.crt

```

```
   psql "sslmode=verify-full sslrootcert=/etc/postgres/root.crt sslcert=/etc/postgres/client/postgresql.crt sslkey=/etc/postgres/client/postgresql.key host=localhost port=5432 user=postgres dbname=postgres password=postgres"
```

```
   psql "sslmode=verify-full sslrootcert=/etc/postgres/root.crt sslcert=/etc/postgres/client/postgresql.crt sslkey=/etc/postgres/client/postgresql.key host=postgres port=5432 user=postgres dbname=postgres"

```
