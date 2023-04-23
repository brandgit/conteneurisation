# Notre conteneur va tourner sur une image Ubuntu ( L'image de base de notre conteneur)
FROM ubuntu
# Cette commande  met à jour les dépôts de paquets
RUN apt-get update

# Cette commande installe Nginx et Git sur notre image de base Ubuntu.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx git

# Cette commande indique que le conteneur Docker écoutera sur le port 80, qui est le port par défaut pour Nginx
EXPOSE 80

# Cette commande supprime tous les fichiers et répertoires qui se trouvent dans le répertoire /var/www/html/. 
# Cela permet de s'assurer que le répertoire est vide avant de cloner le contenu du référentiel Git.
RUN rm -rf /var/www/html/*

# Cette commande clône le contenu du référentiel Gitde notre projet dans le répertoire /var/www/html/ du conteneur Docker 
# en cours de construction.
# Cela permet de copier le code source de l'application web dans l'image Docker, de sorte que l'application web soit disponible 
# dans le conteneur lorsque l'image est exécutée.
RUN git clone https://github.com/diranetafen/static-website-example.git /var/www/html/

# Cette commande  démarre le serveur Nginx lorsqu'un conteneur basé sur cette image Docker est démarré
# L'option "-g daemon off" est utilisée pour empêcher Nginx de s'exécuter en arrière-plan, car Docker 
# s'attend à ce que le processus soit exécuté en premier plan.
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]