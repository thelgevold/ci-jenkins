FROM nginx

RUN mkdir -p /cache/cache/cas
RUN mkdir -p /cache/cache/ac

RUN chmod -R 777 /cache

ADD nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]