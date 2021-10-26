# set -euo pipefail

mkdir postgres-certs
cd postgres-certs



openssl genrsa -des3 -out server.key 2048

openssl rsa -in server.key -out server.key

chmod 400 server.key
chown postgres.postgres server.key



openssl req -new -key server.key -days 3650 -out server.crt -x509 -subj '/C=CA/ST=British Columbia/L=Comox/O=postgres/CN=postgres'




echo "Client cert"
cp server.crt root.crt

mkdir client

openssl genrsa -des3 -out client/postgresql.key 2048

openssl rsa -in client/postgresql.key -out client/postgresql.key


openssl req -new -key client/postgresql.key -out client/postgresql.csr -subj '/C=CA/ST=British Columbia/L=Comox/O=TheBrain.ca/CN=postgres'


openssl x509 -req -in client/postgresql.csr -CA root.crt -CAkey server.key -out client/postgresql.crt -CAcreateserial




# sudo chown postgres server.*    
# sudo chmod 0640 server.*

# sudo chown postgres root.*                         
# sudo chmod 0640 root.*

# db:
#   type: postgres
#   # datasource: host=172.17.0.1 port=5432 user=postgres password=test dbname=postgres sslmode=verify-full sslrootcert=/certs/client/root.crt sslcert=/scerts/client/postgresql.crt sslkey=/certs/client/postgresql.key
#   datasource: host=caserver.cskjnznhqfom.ap-south-1.rds.amazonaws.com user=postgres password=postgres dbname=caserver sslmode=verify-full sslrootcert=/certs/client/root1.pem
#   tls:
#     enabled: false
#     certfiles:
#     client:
#       certfile:
#       keyfile:

# psql "sslmode=verify-full sslrootcert=/home/aditya/fabric-ca-playground/postgres-certs/root.crt sslcert=/home/aditya/fabric-ca-playground/postgres-certs/client/postgresql.crt sslkey=/home/aditya/fabric-ca-playground/postgres-certs/client/postgresql.key host=localhost port=5432 user=postgres dbname=postgres password=test"


# docker run \
#   --rm \
#   -e POSTGRES_PASSWORD=password \
#   postgres \
#   -c ssl=on \
#   -c ssl_cert_file=/etc/postgres/server.crt \
#   -c ssl_key_file=/etc/postgres/server.key \
#   -c ssl_ca_file=/etc/postgres/root.crt



#   psql "sslmode=verify-full sslrootcert=/etc/postgres/root.crt sslcert=/etc/postgres/client/postgresql.crt sslkey=/etc/postgres/client/postgresql.key host=localhost port=5432 user=postgres dbname=postgres password=test"

# psql "sslmode=verify-full sslrootcert=/etc/postgres/root.crt sslcert=/etc/postgres/client/postgresql.crt sslkey=/etc/postgres/client/postgresql.key host=postgres port=5432 user=postgres dbname=postgres"