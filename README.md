# Local Balancing with Docker Compose
It's create the Local Balancing with Webservers and Database using the Docker Compose.

## What does it do?
It creates a SQL server, I used PostgreSQL.
There are three web servers with a simple SQL query program which is deployed in tomcat by can be used to query from the SQL database .
It has a Load Balancer for the web servers with Round-Robin method in nginx.
All of the docker-compose services run on one machine.

It tested in Ubuntu and used these programs too: Docker, Docker Compose, PostgreSQL, pgAdmin, Nginx, Tomcat, Firefox.

## How?
First step is to install the Dockers. In terminal:
```
curl -fsSL https://get.docker.com | sudo sh
sudo apt-get install -y docker-compose
```

### The database
- The db service is with postgres:11 image.
- The sql database file is bind mounted.
- The port 5432 is open so we can check that it is working properly.
- And some more environmental variables have been set.

When the db service runs it can be checked by pgAdmin.

### The webservers
- It builds these services from a Dockerfile.
- The tomcat:9.0.41-jdk11 image is used for it.
- With a Dockerfile it copies the web.war file into every /usr/local/tomcat/webapps/ container's directory.
- All of them has a unique service name to see where we are now.
- The webs connected to the db service and it's database location: jdbc:postgresql://db:5432/chinook
- There is a port opened to check it's works. (web1 has 8086, web2 has 8087 and web3 has 8088 port is opened)

An example of how to check it in the browser:
```
[http://localhost:8086/](http://localhost:8086/)
```
or you can try with the curl in terminal:
```
curl localhost:8086
```

An example to query something in the web app:
```
SELECT * FROM Artist
```

This web.war uses port 8080, so this is what is configured in the nginx config file.

### The Load Balancer
- It uses the latest nginx image.
- The default.conf file is bind mounted into /etc/nginx/conf.d/default.conf place.
- In the config file has the upstream and the proxy pass.
- In the upstream there are the three web service name and the port.
- The proxy pass name is http://app; which is the upstream's name.

To see if it works properly, there is a port 80 open in the lb service.

In the browser:
```
[http://localhost/](http://localhost/)
```

Finally it chooses one of the web servers, when the page will refresh.

## Epilogue

Run the docker-compose file:
```
sudo docker-compose up -d --build
```

So this project was created to demonstrate how to use a solution for load balancing on the same web program running on different servers.

___________
I thank them:
The SQL database from @lerocha: [https://github.com/lerocha/chinook-database](https://github.com/lerocha/chinook-database)
The web.war app is made by @rkohanyi
