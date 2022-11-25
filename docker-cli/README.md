## run an attached container
```sh
docker run -e POSTGRES_PASSWORD=changeme -d postgres:13|tail -1 > /container_id
```

## get ip addr of attached container 
```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(head -n +1 /container_id)
```

## remove an attached container
```sh
docker rm -f $(head -n +1 /container_id)
```

## run command in attached container
```sh
docker exec $(head -n +1 /container_id) psql -U postgres 
```
