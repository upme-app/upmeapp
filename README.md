A UpMe! é uma plataforma que integra universidade e empresas conectando os assuntos de cada disciplina com projetos de mercado.

Nosso site: https://www.upmeapp.com.br

# GETTING STARTED

## DEPENDENCIES

* Ruby 2.3.0
* Rails 5.1.3
* PostgreSQL 9.4 
* Redis

## SETUP


### Local setup
* create development postgres user
* bundle install
* rake db:create db:migrate
* rails server

### Docker compose infrastructure setup

Requirements 
* You should have docker installed in your computer
* You should have `docker-compose` installed in your machine

Usage
* In the root project, you should run `docker-compose build`

Then, all steps of `docker build` will appear in your terminal

* When the build finished, is possible run some commands. Then you need run `docker-compose run webapp rake db:create db:migrate` to create and migrate your database. This command will instantiate a postgres and a redis container automatically don't needing create any additional container

Now all migrations will be done
```
$ docker-compose run webapp rake db:create db:migrate
Starting upmeapp_db_1 ...
Starting upmeapp_db_1
Creating upmeapp_redis_1 ...
Creating upmeapp_redis_1 ... done
Database 'upmeapp_development' already exists
Database 'upmeapp_test' already exists
(...)
```

* Now you can start the server using the command `docker-compose up`, it will use the containers created before(redis and postgres) and will create the rails server container

```
$ docker-compose up
Removing upmeapp_webapp_1
upmeapp_redis_1 is up-to-date
upmeapp_db_1 is up-to-date
Recreating 77afa1f38825_upmeapp_webapp_1 ...
Recreating 77afa1f38825_upmeapp_webapp_1 ... done
Attaching to upmeapp_redis_1, upmeapp_db_1, upmeapp_webapp_1
redis_1   | 1:C 23 Nov 07:24:02.929 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
redis_1   | 1:C 23 Nov 07:24:02.929 # Redis version=4.0.2, bits=64, commit=00000000, modified=0, pid=1, just started
redis_1   | 1:C 23 Nov 07:24:02.929 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
redis_1   | 1:M 23 Nov 07:24:02.931 * Running mode=standalone, port=6379.
redis_1   | 1:M 23 Nov 07:24:02.931 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
redis_1   | 1:M 23 Nov 07:24:02.931 # Server initialized
redis_1   | 1:M 23 Nov 07:24:02.931 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
redis_1   | 1:M 23 Nov 07:24:02.931 * Ready to accept connections
db_1      | 2017-11-23 03:30:01.583 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
db_1      | 2017-11-23 03:30:01.583 UTC [1] LOG:  listening on IPv6 address "::", port 5432
(...)
```

After that you'll be able to open the system in brower. By default, you should use `localhost:3000`, for use it in a different port, you should edit the `docker-compose.yaml` file, to change the it. If you change the redis port or postgres port in the `docker-compose.yaml`, is necessary change the `config/database.yml` and `config/cable.yml` to ensure that all configurations are matching.

### Pure docker infrastructure setup

This environment could be used if you don't want use a compose environment. Is possible reproduce it in production, once you can push your project to the dockerhub, you will be able to use this image in a container orquestration system(e.g. kubernetes, docker swarm, etc...)

Requrements

* You should have the `docker` tool installed in your computer
* You should have the `make` tool to use the Makefile properly
* You should have a postgres running in your computer natively or in a container, but it should be configured as your `config/database.yml` is. You can run the following container to be consistent with the default configuration
`$ docker run --name postgres-upmeapp -e POSTGRES_USER=upmeapp -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=upmeapp_development -p 5432:5432 -d postgres:9.5`
* You should have a redis runing in your computer natively or in a container, consistent with the `config/cable.yml`. You can run the command below to have a container consistent with the redis default configuration
`$ docker run --name redis -p 6379:6379 redis`

Usage

* If you want only build an image locally, you just need run `make build`, then it will do all steps of the `Makefile` to ensure you will build it properly
```
$ make build
/Library/Developer/CommandLineTools/usr/bin/make build_image clean || /Library/Developer/CommandLineTools/usr/bin/make clean
cp Dockerfile _Dockerfile
echo "RUN sed -i 's/host:.*/host: databases/' /upmeapp/config/database.yml" >> _Dockerfile
echo "RUN sed -i 's/url:.*/url: redis:\/\/databases:6379\/1/' /upmeapp/config/cable.yml" >> _Dockerfile
echo "CMD [\"sh\", \"start.sh\", \"3000\"]" >> _Dockerfile
echo "EXPOSE 3000" >> _Dockerfile
docker build -t upmeapp:v0.0.1 -f _Dockerfile . || /Library/Developer/CommandLineTools/usr/bin/make clean
Sending build context to Docker daemon  57.57MB
Step 1/12 : FROM ruby:2.3.1
 ---> ffe8239a147c
Step 2/12 : MAINTAINER Walter Alves <walter.arruda.alves@gmail.com>
 ---> Using cache
 ---> a06bb53b334a
Step 3/12 : RUN apt-get update -qq && apt-get install -y libpq-dev nodejs
 ---> Using cache
 ---> 8383ef6dd8a6
Step 4/12 : RUN mkdir /upmeapp
 ---> Using cache
 ---> c3e705c2e00f
Step 5/12 : WORKDIR /upmeapp
 ---> Using cache
 ---> 357799cc41e9
Step 6/12 : COPY . /upmeapp
 ---> 2fbd5bdbbdd9
Step 7/12 : RUN rm /upmeapp/Gemfile.lock & touch /upmeapp/Gemfile.lock
 ---> Running in b79e82ab30a1
 ---> dfb25ad77b77
Removing intermediate container b79e82ab30a1
Step 8/12 : RUN bundle install
 ---> Running in 7604530ea951
```

* Now you can run your container normally using `docker run -d --name upmeapp -p 3000:3000 upmeapp:v0.0.1` and access `localhost:3000` from your browser

> Is important making clear that by default the image name is upmeapp and the default TAG version is v0.0.1, but you can change it using environment variables
> e.g export IMAGE_NAME=your_image_name
> You are able to change the IMAGE_NAME, IMAGE_TAG and the PORT, which is respectively the image name, the image version tag and the port which the application will run.

* If you would like to run  it directly, you should run the command `make run`, it will call the previous routine to build the image and run a container named `upmeapp_web`

* If you would like push your image to an online repository, you could use the command `make push`. Is important know that is mandatory set at least the `IMAGE_NAME` and `IMAGE_TAG` to push it to the dockerhub. For example:
```
$ export IMAGE_NAME=walteraa/upmeapp IMAGE_TAG=v0.0.3
$ make push
/Library/Developer/CommandLineTools/usr/bin/make build_image clean || /Library/Developer/CommandLineTools/usr/bin/make clean
cp Dockerfile _Dockerfile
echo "RUN sed -i 's/host:.*/host: databases/' /upmeapp/config/database.yml" >> _Dockerfile
echo "RUN sed -i 's/url:.*/url: redis:\/\/databases:6379\/1/' /upmeapp/config/cable.yml" >> _Dockerfile
echo "CMD [\"sh\", \"start.sh\", \"3000\"]" >> _Dockerfile
echo "EXPOSE 3000" >> _Dockerfile
docker build -t walteraa/upmeapp:v0.0.3 -f _Dockerfile . || /Library/Developer/CommandLineTools/usr/bin/make clean
Sending build context to Docker daemon  57.57MB
Step 1/12 : FROM ruby:2.3.1
 ---> ffe8239a147c
Step 2/12 : MAINTAINER Walter Alves <walter.arruda.alves@gmail.com>
 ---> Using cache
 ---> a06bb53b334a
Step 3/12 : RUN apt-get update -qq && apt-get install -y libpq-dev nodejs
 ---> Using cache
 ---> 8383ef6dd8a6
Step 4/12 : RUN mkdir /upmeapp
 ---> Using cache
 ---> c3e705c2e00f
Step 5/12 : WORKDIR /upmeapp
 ---> Using cache
 ---> 357799cc41e9
Step 6/12 : COPY . /upmeapp
 ---> Using cache
 ---> 2fbd5bdbbdd9
Step 7/12 : RUN rm /upmeapp/Gemfile.lock & touch /upmeapp/Gemfile.lock
 ---> Using cache
 ---> dfb25ad77b77
Step 8/12 : RUN bundle install
 ---> Using cache
 ---> cb3c79948541
Step 9/12 : RUN sed -i 's/host:.*/host: databases/' /upmeapp/config/database.yml
 ---> Using cache
 ---> fe6e8a3e6211
Step 10/12 : RUN sed -i 's/url:.*/url: redis:\/\/databases:6379\/1/' /upmeapp/config/cable.yml
 ---> Using cache
 ---> 3bb45bd559d5
Step 11/12 : CMD sh start.sh 3000
 ---> Using cache
 ---> 81ff2ecd3937
Step 12/12 : EXPOSE 3000
 ---> Using cache
 ---> 240804370bab
Successfully built 240804370bab
Successfully tagged walteraa/upmeapp:v0.0.3
rm -rf _Dockerfile
docker push walteraa/upmeapp:v0.0.3
The push refers to a repository [docker.io/walteraa/upmeapp]
53ca6df2f586: Pushed
0fd6eab00562: Pushed
82c8ed08a457: Pushing [=>                                                 ]  4.337MB/189MB
90312d9cb793: Pushed
b2c965f58f10: Pushing [=>                                                 ]  1.112MB/55.52MB
ccd67a362386: Pushed
3e8d5f8d5d7d: Pushing [=====>                                             ]  2.217MB/19.77MB
fc98ec9ef836: Mounted from library/ruby
f6037664e1ff: Mounted from library/ruby
7dc82d1c0c9f: Waiting
96e14acce2fd: Waiting
787c930753b4: Waiting
9f17712cba0b: Waiting
223c0d04a137: Waiting
fe4c16cbf7a4: Waiting
```

After push it, you can use this image in whatever computer having docker and the postgres/redis containers only pulling it. :)


<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/80x15.png" /></a><br />O trabalho <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Upme</span> de <a xmlns:cc="http://creativecommons.org/ns#" href="https://upmeapp.com.br/" property="cc:attributionName" rel="cc:attributionURL">Amanda Busato</a> está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons - Atribuição-NãoComercial-SemDerivações 4.0 Internacional</a>.<br />Baseado no trabalho disponível em <a xmlns:dct="http://purl.org/dc/terms/" href="https://upmeapp.com.br/" rel="dct:source">https://upmeapp.com.br/</a>.<br />Podem estar disponíveis autorizações adicionais às concedidas no âmbito desta licença em <a xmlns:cc="http://creativecommons.org/ns#" href="https://upmeapp.com.br/" rel="cc:morePermissions">https://upmeapp.com.br/</a>.
