# Azure Deployment Manager APIs
> see https://aka.ms/autorest

### Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    reason:  The boolean properties in the specification are actually boolean value in the Deployment Manager application model.
  - suppress: TrackedResourceListByImmediateParent
    reason: Functionality to be added later, before GA.
```

## Python
       
``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.deploymentmanager
  package-name: azure-deploymentmanager
  package-version: 1.0.0
  add-credentials: true
  output-folder: $(python-sdks-folder)/azure-mgmt-deploymentmanager/azure/mgmt/deploymentmanager
  clear-output-folder: true    
```

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.DeploymentManager
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/DeploymentManager/Management.DeploymentManager/Generated
  clear-output-folder: true  
``` 

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: deploymentmanager
  clear-output-folder: true
```