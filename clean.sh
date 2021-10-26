docker-compose down
pushd fabric-ca-server
shopt -s extglob
sudo rm !("fabric-ca-server-config.yaml") -rf
popd
sudo rm postgres-certs -rf
docker volume prune