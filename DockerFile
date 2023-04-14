FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y && apt install nginx -y

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
