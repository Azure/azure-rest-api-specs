# CADL Generation 

Modeled after cadl generation steps [here](https://github.com/Azure/cadl-azure#readme)

## Initial Steps:
1) Fork and clone the azure-rest-api-specs repository, create a new branch and pull this code. Ensure that `npm` is installed. 

## Generate Code:
1) Under the `./cadl` folder run: 
```
npm i @azure-tools/cadl-autorest @azure-tools/cadl-azure-core @azure-tools/cadl-csharp @azure-tools/cadl-providerhub @cadl-lang/compiler @cadl-lang/rest @cadl-lang/versioning
```
- You should now have a package.json, and package-lock.json


2) Run: `cadl compile main.cadl --emit YourEmitterName` with the emitter of your choice. To generate the swagger file (includes everything into one file) use @azure-tools/cadl-autorest, to generate the CSharp SDK use @azure-tools/cadl-csharp. Output will appear under `cadl-output/YourEmitterName/`