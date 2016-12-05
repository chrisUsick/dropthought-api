# README

# to deploy
```
docker-compose up -d db
docker-compose build web
WEB_CLIENT_ID=<web client id> STRIPE_PUBLISHABLE_KEY=<stripe public key> STRIPE_SECRET_KEY=<stipe secret key> docker-compose up -d web
```
In `dropthought-site`
```
docker build -t dropthrought-site .
```

Back in this `dropthought-api`
```
docker-compose up -d site
```
