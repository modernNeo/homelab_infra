FROM nginx:1.19.7

COPY nginx_configs/nextcloud /etc/nginx/conf.d/nextcloud.conf

COPY nginx_configs/steelbooks /etc/nginx/conf.d/steelbooks.conf

RUN apt-get update && apt-get install python-certbot-nginx

# CMD["sh"]
CMD ["nginx", "-g", "daemon off;"]