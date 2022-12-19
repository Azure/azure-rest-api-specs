# CADL Generation 

Modeled after cadl generation steps [here](https://github.com/Azure/cadl-azure#readme)


1) Clone azure-rest-api-specs repo, create a new branch and pull this code. 

2) Under ../cadl folder run `npm install @azure-tools/cadl-autorest @azure-tools/cadl-azure-core @azure-tools/cadl-csharp @azure-tools/cadl-providerhub @cadl-lang/compiler @cadl-lang/rest @cadl-lang/versioning`
    - You should now have a package.json, and package-lock.json
3) Run `cadl compile main.cadl --emit YourEmitterName` with the emitter of your choice. To generate the swagger file (includes everything into one file) use @azure-tools/cadl-autorest, to generate the CSharp SDK use @azure-tools/cadl-csharp. Output will appear under `cadl-output/YourEmitterName/`