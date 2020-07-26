From nginx:alpine
RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
         && apk update \
         && apk add --no-cache git
RUN echo "cd /usr/share/nginx/html && git pull">>run.sh
#COPY ./PS4.sh /config/start.sh
RUN chmod 777 /config/start.sh
RUN rm -rf /usr/share/nginx/html
RUN git clone https://github.com/zerofo/ps4jb.git /usr/share/nginx/html
RUN echo "0 4 * * * /config/start.sh">>/var/spool/cron/crontabs/root
EXPOSE 443
EXPOSE 80
