#!/usr/bin/env bash
set -e

function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

info ""
info "Skrypt instalujący Nginx w Docker"
info "Na VPS Mikrus"
info ""
info "https://github.com/damianeroo/Nginx-Docker-Mikrus"
info ""

sleep 10

if [[ $EUID -ne 0 ]]; then
   echo -e "W celu instalacji tego pakietu potrzebujesz wyzszych uprawnien! Uzyj polecenia \033[1;31msudo ./chce_dockera.sh\033[0m lub zaloguj sie na konto roota i wywolaj skrypt ponownie."
   exit 1
fi


MISSING_DOCKER=""
MISSING_PORTAINER=""
VOL1=""
VOL2=""

# Check env
command -v docker > /dev/null 2>&1 || MISSING_DOCKER=("docker")

# Parse command line parameters
while [[ $# -gt 0 ]]; do
    arg="$1"

    case $arg in
        -a|--all)
            ALL="yes"
            shift
            ;;  
        -p|--port)
            PORT=$2
            shift
            ;;
        -n|--name)
            NAME=$2
            shift
            ;;
        *)
            error "Unrecognized option $1"
            ;;
    esac
    shift
done

if [ "" = ${NAME} ]; then
    NAME="nginx"
fi
if [ "yes" = "${ALL}" ]; then
   if [ "" = ${PORT} ]; then
       error "Brak numeru portu dla Portainer ( -p 12345 )"
    fi
fi
### Main

##
# Install Docker
info "Install NGINX"
if [ "docker" = "${MISSING_DOCKER}" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/unkn0w/noobs/main/scripts/chce_dockera.sh)" > /dev/null
fi

if [ "yes" = "${ALL}" ]; then
    ##
    # Install Portainer
    info "Install Portainer"
    docker container ls | grep -e portainer || MISSING_PORTAINER=("portainer")
    if [ "portainer" = "${MISSING_PORTAINER}" ]; then
    docker run -d -p ${PORT}:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest  > /dev/null
    fi
fi
##
# Install NGINX
info "Install NGINX"

VOL1=$(docker volume create)
VOL2=$(docker volume create)

docker run -d -p 80:80 -p 443:443 --name ${NAME} --restart always -v ${VOL1}:/etc/nginx -v ${VOL2}:/usr/share/nginx/html nginx:latest  > /dev/null

sleep 10

info
info "Nginx gotowy"
if [ "yes" = "${ALL}" ]; then
    info "Adres twojego Portainera"
    info "{adres mikrusa}:${PORT}"
fi
info 
info "Katalog twojej stony:"
info " /var/lib/docker/volumes/${VOL2}/_data"
info
