#The variables below could be defined using environment variables
IMAGE_NAME ?= upmeapp
IMAGE_TAG ?= v0.0.1
PORT ?= 3000

#Constant
TEST = $$
create_env:
	cp Dockerfile _Dockerfile

#The steps below are responsable to make possible this container connect to postgres and redis which is running in the host or other containers running in the same host which ports exposed
sed_host:
	echo "RUN sed -i 's/host:.*/host: databases/' /upmeapp/config/database.yml" >> _Dockerfile
	echo "RUN sed -i 's/url:.*/url: redis:\/\/databases:6379\/1/' /upmeapp/config/cable.yml" >> _Dockerfile


#Run server and expose the port 
run_server:
	echo "CMD [\"sh\", \"start.sh\", \"$(PORT)\"]" >> _Dockerfile
expose_server:
	echo "EXPOSE $(PORT)" >> _Dockerfile

#Prepare the dockerfile calling the procedures before and build the image
build_image: create_env  sed_host run_server expose_server
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f _Dockerfile . || ${MAKE} clean

clean:
	rm -rf _Dockerfile
#Ensure cleaning up after build or when an error happens
build: 
	${MAKE} build_image clean || ${MAKE} clean

#Build the image and push to repository
push: build 
	docker push $(IMAGE_NAME):$(IMAGE_TAG)

#run the image
run: build
	docker run --name upmeapp_web -p $(PORT):$(PORT) $(IMAGE_NAME):$(IMAGE_TAG)


