# Utilisation de l'image de base nginx
FROM nginx:latest

# Mettre à jour les paquets et installer git et nano
RUN apt-get update && \
    apt-get install -y git nano && \
    rm -rf /var/lib/apt/lists/*

# Supprimer le répertoire racine par défaut d'nginx
RUN rm -rf /usr/share/nginx/html
RUN mkdir /usr/share/nginx/html
# Cloner le dépôt Git dans le répertoire racine d'nginx
RUN git clone https://github.com/firstruner/tinyshop_demo.git /usr/share/nginx/html

# Exposer le port 80 pour le serveur nginx
EXPOSE 80

# Nginx est configuré pour démarrer automatiquement, donc il n'est pas nécessaire de spécifier CMD ou ENTRYPOINT

