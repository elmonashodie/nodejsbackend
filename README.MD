# hodie-pod

# Installation prerequisite
* docker
* docker-compose

### Prerequisites
* docker
* docker-compose

### Get started production
```console
git clone https://github.com/elmonashodie/nodejsbackend.git
cd server
chmod +x ./createConfigs.sh && ./createConfigs.sh prod
docker-compose up -d
```
  
### Get started development
```console
git clone https://github.com/elmonashodie/nodejsbackend.git
cd server
chmod +x ./createConfigs.sh && ./createConfigs.sh dev
docker-compose up
```

`creatConfigs.sh` will generate a `.env` file with random credentials in production and easy to type in development. In development, it will start node with `nodemon`.