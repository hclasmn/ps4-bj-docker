From nginx:alpine
#RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories 
RUN  apk add --no-cache git bash
RUN touch /start.sh
RUN git config --global user.name scjtqs && git config --global user.email scjtqs@qq.com
RUN echo "cd /usr/share/nginx/html && git fetch --all && git reset --hard origin/master && git pull -f">>/start.sh
RUN chmod 777 /start.sh
RUN rm -rf /usr/share/nginx/html
RUN git clone https://github.com/zerofo/BW.git /usr/share/nginx/html
RUN echo "0 */2 * * * /start.sh">>/var/spool/cron/crontabs/root
RUN touch /crond.sh
RUN echo "crond && nginx -g 'daemon off;'">>/crond.sh
RUN chmod 777 /crond.sh
EXPOSE 443
EXPOSE 80
ENTRYPOINT ["/bin/bash","/crond.sh"]
