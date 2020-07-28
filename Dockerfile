From nginx:alpine
#RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories 
RUN  apk update \
     && apk add --no-cache git
RUN touch /start.sh
RUN git config --global user.name hclasmn && git config --global user.email hclasmn@qq.com
RUN echo "git fetch --all && git reset --hard origin/master && git pull -f">>/start.sh
RUN chmod 777 /start.sh
RUN rm -rf /usr/share/nginx/html
RUN git clone https://github.com/zerofo/ps4jb.git /usr/share/nginx/html
RUN echo "0 */1 * * * /start.sh">>/var/spool/cron/crontabs/root
EXPOSE 443
EXPOSE 80
