# Contributing to Azure Quantum TypeSpec REST API Specification

This file contains instructions to make it easier to maintain and test the *TypeSpec REST API specifications for the **Azure Quantum** service.

1. How to maintain this folder.
2. Setup your dev environment.
3. Build and validate the *TypeSpec*.
4. Generate *OpenAPI/Swagger specs*.
5. Generate *Azure Quantum SDK clients*.

## Pre-requisites

1. Make sure you familiar with and follow the [Contributing guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/CONTRIBUTING.md) of this repo.
2. [Install TypeSpec](https://microsoft.github.io/typespec/introduction/installation) and its pre-reqs.
   - `./eng/setup-dev.ps1` contains the commands to do that if you have [NVM - Node Version Manager](https://github.com/nvm-sh/nvm).

## Known issues & limitations

The following are known issues & limitations that were found during the development of the TypeSpec specification for Azure Quantum.

1. **`Quantum` as the service name.**<br/>
   Ideally, the service name should have been something more specific than simply `Quantum`, according to conversations with the Azure SDK team. `Quantum` is technically the service-group and we could potentially have several services inside it. However for historical reasons and a strategic decision to keep everything inside the same service, we are sticking to just use `Quantum` as the service name.
2. **Use of namespaces.**<br/>
   Ideally, we could have leveraged the namespace language feature of TypeSpec, but in order to be backward compatible with the previous OpenAPI/Swagger specs, we are not using namespace for the models as they create breaking changes in the type names.

## Build

As you make changes, constantly run the `./eng/build.ps1` script. The script will:

1. Format the TypeSpec files, ensuring good linting;
2. Compile the TypeSpec files, and
   - Generate the OpenAPI/Swagger definition (as part of the compilation step).
3. Generate a local Swagger Preview UI (see [View section](#view) below).
4. (optionally) Generate samples.
5. Locally run most, if not all, CI tools as described in [CI-Fix](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/ci-fix.md).

### Outputs

The output files are defined in the `tspconfig.yaml` file.

## View

After you build, you can nicely visualize the OpenAPI/Swagger definition by running the `./eng/view.ps1` script.
