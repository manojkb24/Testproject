FROM python:2.7-alpine
MAINTAINER Sam Gabrail

RUN RUN echo '172.20.17.242 \t btpproxy.mphasis.com' >> /etc/hosts ; export http_proxy="http://blockchain.mphasis:hl1.4March5@btpproxy.mphasis.com:8080" ; echo $http_proxy ;

RUN apk update && pip install bottle \
    && mkdir /app
WORKDIR /app
COPY . .
#EXPOSE 22
CMD ["python", "-u", "sysdigCool.py"]
