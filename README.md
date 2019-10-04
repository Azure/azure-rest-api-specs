# Spécifications de l'API REST Azure

## La description

Ce référentiel est la source canonique des spécifications de l'API REST pour Microsoft Azure.

## Commencer
Si vous êtes un auteur de spécification et que vous recherchez des informations sur tous les référentiels et les étapes du pipeline, accédez à notre référentiel [documentation] (https://github.com/Azure/adx-documentation-pr/wiki). Assurez-vous de [rejoindre l’organisation Github Azure] (http://aka.ms/azuregithub) pour avoir accès à ce référentiel.

<b> Dernière amélioration: </ b> <i> Les employés de Microsoft peuvent essayer notre nouvelle expérience sur [OpenAPI Hub] (https://aka.ms/openapihub) - une expérience en ligne permettant d’utiliser nos outils de validation et de rechercher votre flux de travail. </ i>

Veuillez vérifier la [page des annonces] (https://github.com/Azure/azure-rest-api-specs/wiki/Announcements) pour connaître les nouvelles mises à jour depuis votre dernière visite.

## Structure du répertoire

La structure du répertoire doit strictement respecter ces règles:

1. ** Profil **: le titulaire du profil contient les fichiers MD de définition des profils. ces fichiers contiendront des informations et des références aux instantanés des types de ressources des RPs ou des versions de l'API de plan de données qui représentent un profil spécifique.

1. ** Specification **: Ce dossier est le dossier racine de tous les documents liés à Specs (Management and Dataplane).

1. ** {{RP-Name} Folders ** - chaque RP aura un dossier séparé

1. ** Dossiers 'gestionnaire de ressources' et 'plan de données' **: les RP peuvent définir des spécifications dans l'une des deux catégories suivantes: `gestionnaire de ressources` (pour les ressources ARM) et` plan de données '(pour tout le reste) ). Le fichier de configuration autorest (`readme.md`) du RP doit se trouver dans ce dossier

1. ** Dossiers 'prévisualisation' et 'stable' **: notre référentiel contient des niveaux de stabilité variables. Chaque dossier de la version de l'API doit être classé comme acceptant toujours les modifications les plus récentes ou ne plus en accepter. Ce n'est pas un analogue direct, qu'une version de l'API ait ou non le suffixe "-preview". Les kits SDK générés à partir des éléments du dossier 'preview' doivent indiquer à leurs clients de la manière la plus idiomatique que des modifications radicales pourraient encore être apportées.

1. ** versions de l'API **: ce dossier sera l'enfant direct du dossier de la catégorie. il y aura un tel dossier par type de ressource ou version de service de plan de données. Ce dossier contiendra les spécifications de validation OpenAPI (Swaggers précédemment) et le dossier des exemples.

1. ** Exemples **: le dossier des exemples contiendra les fichiers x-ms-examples. il se trouvera dans les dossiers de version des API ou des ressources, car les versions de différents API ou types de ressources peuvent avoir différents exemples.

1. ** Notes **:
    - Les noms de dossier doivent être singuliers (c'est-à-dire que 'profil' n'est pas 'profils').
    - les noms de dossiers génériques doivent être en minuscules
    - les dossiers nom-proprement / nom produit / espace-noms peuvent être en PascalCased ("KeyVault")
    - Les fichiers sont ce que vous pensez être bon pour votre âme.


La structure devrait ressembler à ceci:
```bash
.
\---specification
|    +---automation
|    |   \---resource-manager
|    |       \---Microsoft.Automation
|    |           \---stable
|    |               \---2015-10-31
|    |                   \---examples
|    +---batch
|    |   +---data-plane
|    |   |   \---Microsoft.Batch
|    |   |       +---stable
|    |   |       |   +---2015-12-01.2.2
|    |   |       |   +---2016-02-01.3.0
|    |   |       |   +---2016-07-01.3.1
|    |   |       |   +---2017-01-01.4.0
|    |   |       |       \---examples
|    |   |       \---preview
|    |   |           \---2017-05-01.5.0
|    |   \---resource-manager
|    |       \---Microsoft.Batch
|    |           +---stable
|    |           |   +---2015-12-01
|    |           |   +---2017-01-01
|    |           |       \---examples
|    |           \---2017-05-01
|    |               \---examples
|    +---billing
|        \---resource-manager
|            \---Microsoft.Billing
|                \---stable
|                |   +---2017-02-27-preview
|                |       \---examples
|                +---preview
|                    \---2017-04-24-preview
|                        \---examples
\--- readme.md
```

Actuellement, les spécifications devraient être au format Swagger JSON

## Prochaines étapes
L’étape suivante du processus après l’achèvement d’une spécification consiste à générer le SDK et la documentation de référence de l’API. Accédez au [Guide de l'expérience de développeur Azure] (https://github.com/Azure/adx-documentation-pr) pour plus d'informations.

---
_Ce projet a adopté le [code de conduite Microsoft en source ouverte] (https://opensource.microsoft.com/codeofconduct/). Pour plus d'informations, consultez la [FAQ sur le code de conduite] (https://opensource.microsoft.com/codeofconduct/faq/) ou contactez [opencode@microsoft.com] (mailto: opencode@microsoft.com). commentaires._
