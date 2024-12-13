## Docker Swarm

---
### Initialisation Docker swarm
```bash
docker swarm init
```

### Démarrer la stack Docker swarm
```bash
docker stack deploy -c docker-compose.yml my_stack
```
Cette commande :

- Crée un réseau overlay partagé entre tous les nœuds.
- Répartit les réplicas de flask-app sur plusieurs nœuds selon les contraintes.
- Démarre les autres services (Nginx, PostgreSQL, Portainer).

---

### Vérifier les services déployés
On utilise ces commandes pour surveiller l'etat de sante des services dans le cluster ``Swarm``

#### Liste des stacks :
```bash
docker stack ls
```
#### Etat des taches (instance des services) :
Verifie egalement ou les replicas sont deployes
```bash
docker service ps my_stack_flask-app
```
#### Liste des services dans la stack :
- Flask (Backend)
  - Service Flask etendu pour Docker Swarm. 
  - Répliqué sur 3 instances pour ameliorer la disponibilite. 
- PostgreSQL (Base de données)
  - Service PostgreSQL adapté pour fonctionner avec Docker Swarm. 
- Nginx (Reverse Proxy)
  - Configuration similaire à celle de la partie 2. 
- Portainer (Visualisation du cluster)
  - Outil d'administration pour gerer visuellement le cluster Docker Swarm. 
  - Port exposé : 9000

On peut les visualiser avec la commande :
```bash
docker stack services my_stack
```

---

On s'est ensuite connecte a l'adresse http://localhost:9000 afin de creer 
un compte admin

### Repartir les replicas du service Flask sur plusieurs noeuds
On a ajoute ces lignes au docker-compose afin de repartir les replicas 
sur plusieurs noeuds
```yml
deploy:
  replicas: 3

placement:
  constraints:
    - node.role == worker
```

### Ajout de ressources et limitations pour chacun des services
```yml
deploy:
  resources:
    limits:
      cpus: "0.5"  # 50% du CPU
      memory: "256M"  # 256 MB de RAM
```
