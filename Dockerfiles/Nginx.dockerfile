FROM nginx

RUN mkdir -p /etc/nginx/sites-available/
RUN mkdir -p /etc/nginx/sites-enabled/

COPY nginx_configs/nextcloud /etc/nginx/sites-available/nextcloud
RUN ln -s /etc/nginx/sites-available/nextcloud /etc/nginx/sites-enabled/

COPY nginx_configs/steelbooks /etc/nginx/sites-available/steelbooks
RUN ln -s /etc/nginx/sites-available/steelbooks /etc/nginx/sites-enabled/

# CMD["sh"]
CMD ["nginx", "-g", "daemon off;"]