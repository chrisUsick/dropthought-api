# README

# to deploy
```
docker-compose up -d db
docker-compose build web
docker-compose run -e WEB_CLIENT_ID=<web client id> web
```
In `dropthought-site`
```
docker build -t dropthrought-site .
```

Back in this `dropthought-api`
```
docker-compose up -d site
```
