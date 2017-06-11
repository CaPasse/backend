# Ca passe

## Start app and containers

### selenium

1. Start a hub:

```sh
docker run --rm -it --name selenium -p 4444:4444 selenium/hub
```

2. Then multiple nodes:

```sh
docker run --rm -it --link selenium:hub selenium/node-chrome
```

### ElasticSearch

```sh
docker run --name elasticsearch -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" -e "xpack.security.enabled=false" -e "http.cors.enabled=true" -e "http.cors.allow-origin=*" docker.elastic.co/elasticsearch/elasticsearch:5.4.1
```

### Postgres

```sh
docker run --rm -it --name postgres -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres
```

### Backend

```sh
cd apps/backend
mix ecto.setup
cd ../backend_web
iex --name backend@127.0.0.1 -S mix
```
