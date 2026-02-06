## Python

These settings apply only when `--python` is specified on the command line.

### Tag: package-policy-2025-03-python

These settings apply only when `--tag=package-policy-2025-03-python` is specified on the command line.

```yaml $(tag) == 'package-policy-2025-03-python'
input-file:
  - stable/2025-03-01/openapi.json
  - stable/2020-09-01/dataPolicyManifests.json

  - stable/2023-04-01/policyDefinitions.json
  - stable/2023-04-01/policyDefinitionVersions.json
  - stable/2023-04-01/policySetDefinitions.json
  - stable/2023-04-01/policySetDefinitionVersions.json
  - stable/2023-04-01/policyAssignments.json
  - preview/2022-07-01-preview/policyExemptions.json
  - preview/2022-08-01-preview/policyVariables.json
  - preview/2022-08-01-preview/policyVariableValues.json
```


``` yaml $(python)
title: PolicyClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resource-policy
package-version: 1.0.0b1
no-namespace-folders: true
reformat-next-link: false
combine-operation-files: true
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(python)
namespace: azure.mgmt.resource.policy
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource-policy/azure/mgmt/resource/policy
```
