FROM nginx

COPY nginx_configs/nextcloud /etc/nginx/conf.d/nextcloud.conf

COPY nginx_configs/steelbooks /etc/nginx/conf.d/steelbooks.conf

# CMD["sh"]
CMD ["nginx", "-g", "daemon off;"]
