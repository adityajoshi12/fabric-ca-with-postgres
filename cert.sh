# set -euo pipefail

mkdir postgres-certs
cd postgres-certs


echo "Generating Server Key and Server Certificate \n\n"
openssl req  -nodes -new -x509  -keyout server.key -out server.crt -subj '/C=IN/ST=HR/L=FBD/O=postgres/CN=postgres'

# openssl genrsa -des3 -out server.key 2048

# openssl rsa -in server.key -out server.key



# openssl req -new -key server.key -days 3650 -out server.crt -x509 -subj '/C=IN/ST=HR/L=FBD/O=postgres/CN=postgres'

cp server.crt root.crt



echo "Creating Client certificate \n\n"

mkdir client

openssl genrsa -des3 -out client/postgresql.key 2048

openssl rsa -in client/postgresql.key -out client/postgresql.key


openssl req -new -key client/postgresql.key -out client/postgresql.csr -subj '/C=IN/ST=HR/L=FB/O=postgres/CN=postgres'


openssl x509 -req -in client/postgresql.csr -CA root.crt -CAkey server.key -out client/postgresql.crt -CAcreateserial



cp root.crt client
