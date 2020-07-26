From nginx:alpine
#RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories 
RUN  apk update \
     && apk add --no-cache git
RUN touch /start.sh
RUN echo "cd /usr/share/nginx/html && git pull">>/start.sh
RUN chmod 777 /start.sh
RUN rm -rf /usr/share/nginx/html
RUN git clone https://github.com/zerofo/ps4jb.git /usr/share/nginx/html
RUN echo "0 4 * * * /start.sh">>/var/spool/cron/crontabs/root
EXPOSE 443
EXPOSE 80
