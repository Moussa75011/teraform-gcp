# teraform-gcp

Pour ne pas utiliser la console de GCP on peut installer le sdk cloud ( client ) sur notre pc et lancer la commande suivante : gcloud



## 1– GCP : Premiere methode ( methode interface )

Nous allons creer UNE VM SUR GCP (un site web)

   – Compute engine :  cet sera effectué sur la l'option gratute de GCP 

   ![option GCP gratuite](/pictures/VM-options-gratuit.png)

     - creer un projet
     - puis machine virtuelles (VM)
     - creer une instance  et suivre les options de VM disponiblent
     - Après les réglages , on crée l’instance
     - Ensuite on se connecte en SSH

   ![connexion ssh](/pictures/ssh-connexion.png)

     - Dans la fenetre affichée faire Ouvrir dans une fenêtre du navigateur

     - Attention :  comme on peut le constater,  lorsqu’on exécute la commande gcloud compute ssh --zone "us-east1-b" "stream-1" --project "stream-projet" dans la console GCP, il se produit l’erreur suivante (voir image)

   ![cmd shell error](/pictures/CMD_SHELL_error.png)

     - Pour resoudre le probleme il faut lancer la commande dans un shell en local comme dit dans ce lien :[Solution cmd gcloud](https://www.googlecloudcommunity.com/gc/Infrastructure-Compute-Storage/Any-gcloud-compute-command-results-in-Error-quot-Request-had/m-p/496808#M1930).

     Avec la solution proposée dans ce lien ci-dessus, l'on trouve une solution a notre probleme en utilisant un shell different de celui de GCP. 


   ![ssh shell solution](/pictures/SSH_SHELL_Solution.png)



   ### QUELQUES MANULATIONS DANS LE SHELL POUR JOINDRE L4ADRESSE DE LA VM CREER


➜  ~ git:(main) ✗ gcloud compute ssh --zone "us-east1-b" "stream-1" --project "stream-projet"

USERNAME@stream-1:~$ curl -k https://ottertelcom
curl: (6) Could not resolve host: ottertelcom
USERNAME@stream-1:~$ curl -k https://ottertelecom.com/ip // pour afficher l'IP de la VM
USERNAME@stream-1:~$ sudo apt update
USERNAME@stream-1:~$ cat /etc/debian_version // Pour voir la version de debian
USERNAME@stream-1:~$ apt list --upgradable
USERNAME@stream-1:~$ uname -a
USERNAME@stream-1:~$ sudo apt install nginx // Pour installer nginx pour la page web
USERNAME@stream-1:~$ ls -hl /var/log/ngnix
USERNAME@stream-1:~$ ls -hl /var/log/nginx
USERNAME@stream-1:~$ cd /etc/nginx/
USERNAME@stream-1:/etc/nginx$ cd sites-enabled/
USERNAME@stream-1:/etc/nginx/sites-enabled$ ls
default
USERNAME@stream-1:/etc/nginx/sites-enabled$ cd default
USERNAME@stream-1:/etc/nginx/sites-enabled$ ls -hl
USERNAME@stream-1:/etc/nginx/sites-enabled$ cat default
USERNAME@stream-1:/etc/nginx/sites-enabled$ cd /var/www/html
USERNAME@stream-1:/var/www/html$ ls -hl
USERNAME@stream-1:/var/www/html$ sudo yolo.html
USERNAME@stream-1:/var/www/html$ sudo apt -y install htop
USERNAME@stream-1:/var/www/html$ df -hl
USERNAME@stream-1:/var/www/html$ sudo fdisk -l
sudo: fdisk: command not found
USERNAME@stream-1:/var/www/html$ htop
USERNAME@stream-1:/var/www/html$ exit
     

## 2– TERRAFORM & GCP (methode construciton via fichier terraform)

Dans cette partie, nous créerons et déploierons des infrastructures (réseau et machines virtuelles privées … par exemple) sur la plateforme GCP comme l’on le ferait directement en faisant des manipulations sur GCP. 

- Objectif : 
Utiliserez Terraform pour provisionner, mettre à jour et détruire un ensemble simple d'infrastructures


- Prérequis 

  . créer un compte Google Cloud Platform
  . Installer terraform en local


- Configurer GCP

  => Créer un projet GCP sur la plateforme GCP
  => Activer Google Compute Engine pour votre projet
  => Créer une clé de compte service GCP pour permettre à terraform d'accéder à votre projet. Pour cela, suivre les étapes suivantes: 


     . Sélectionnez le projet que vous avez créé à l'étape précédente
     . Cliquez sur "Créer un compte de service
     . Donnez-lui le nom de votre choix et cliquez sur "Créer".
     . Pour le rôle, choisissez « Projet -> Éditeur », puis cliquez sur « Continuer »
     . Ignorez l'octroi de l'accès aux utilisateurs supplémentaires et cliquez sur Terminé".

     Après avoir créé votre compte de service, téléchargez votre clé de compte de service.


     . Sélectionnez votre compte de service dans la liste.
     . Sélectionnez l'onglet "Clés".
     . Dans le menu déroulant, sélectionnez "Créer une nouvelle clé".
     . Laissez le "Type de clé" sur JSON.
     . Cliquez sur "Créer" pour créer la clé et enregistrer le fichier de clé sur votre système




- Ecrire la configuration (RÉSEAU VPC)
Nous allons écrire notre première configuration pour créer notre réseau (VPC)

 . mkdir terraform-gcp    // Pour créer un dossier
 . cd terraform-gcp	// Pour accéder dans le dossier créer
 . touch main.tf    // Pour créer un fichier main.tf

Dans le fichier main.tf, y ajouter ce bout de code 
   
   ![VPN-NETWORK1](/pictures/VPN-network1.png)


- Initialiser le répertoire
Tout d’abord, initialiser le répertoire avec cette commande : 

 . terraform init

- Formater et valider la configuration

 . terraformer fmt  // pour mettre à jour notre les configurations dans dans le dossier
 . terraform validate  // Pour valider les configurations

- Créer une infrastructure

 . terraform plan // Nous propose un plan à suivre pour notre infrastructure 
 . terraform plan (optionnel(-out plan.out)) // pour sauvegarder le plan proposer dans 1 fichier plan.out
 . terraform apply 
 . terraform apply 
 

## Changer d'infrastructure

- Créer une nouvelle ressource

Rajoutons la configuration suivante pour une ressource d'instance de calcul Google à main.tf

![new config](/pictures/new-config.png)


- Modifier la configuration

On va juste rajoute la ligne suivante : tags = ["web", "dev"] dans  resource "google_compute_instance" "vm_instance" 


![new config](/pictures/modif-tag.png)

![new config](/pictures/modif-image.png)

## Destruction d'infrastructure
- Destruction

Pour mettre fin aux ressources gérées
  . terraform destroy
