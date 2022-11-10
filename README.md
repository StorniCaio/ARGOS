# ARGOS
Projeto de Conlusão de Curso para um Sistema de Monitoramento de Abastecimento de Embarcações

PostGreSQL (Usuário/senha):

argosadmin/argosAdmin
grafana/grafanaUser
nodered/noderedUser

Node-RED (Usuário/senha):

Página de administração:
argosAdmin/argosAdmin

BrokeMQTT
argos/@rg0sSens0r

docker run --rm -p 3001:3000 --name=grafana -v server/src/grafana/temp:/etc/grafana  grafana/grafana-enterprise

docker run --rm --network argos_argos -p 80:80 -v $PWD/server/src/nginx:/etc/nginx/ --name nginx nginx:1.21.6 
