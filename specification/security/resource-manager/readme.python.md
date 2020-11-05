## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.security
  package-name: azure-mgmt-security
  package-version: 0.1.0
  clear-output-folder: true
```

``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.security
package-name: azure-mgmt-security
package-version: 1.0.0b1
clear-output-folder: true

directive:
  - from: jitNetworkAccessPolicies.json
    where: $.definitions.JitNetworkAccessPortRule.properties
    transform: >
      return {
        "number": {
          "$ref": "#/definitions/PortNumber"
        },
        "protocol": {
          "type": "string",
          "enum": [
            "TCP",
            "UDP",
            "*"
          ],
          "x-ms-enum": {
            "name": "protocolEnum",
            "modelAsString": true,
            "values": [
              {
                "value": "TCP"
              },
              {
                "value": "UDP"
              },
              {
                "value": "*",
                "name": "All"
              }
            ]
          }
        },
        "allowedSourceAddressPrefix": {
          "type": "string",
          "description": "Mutually exclusive with the \"allowedSourceAddressPrefixes\" parameter. Should be an IP address or CIDR, for example \"192.168.0.3\" or \"192.168.0.0/16\"."
        },
        "allowedSourceAddressPrefixes": {
          "type": "array",
          "description": "Mutually exclusive with the \"allowedSourceAddressPrefix\" parameter.",
          "items": {
            "type": "string",
            "description": "IP address or CIDR, for example \"192.168.0.3\" or \"192.168.0.0/16\"."
          }
        },
        "maxRequestAccessDuration": {
          "type": "string",
          "description": "Maximum duration requests can be made for. In ISO 8601 duration format. Minimum 5 minutes, maximum 1 day"
        }
      }

  - from: externalSecuritySolutions.json
    where: $.definitions.ExternalSecuritySolutionKind.properties
    transform: >
      return {
        "kind": {
          "type": "string",
          "description": "The kind of the external solution",
          "enum": [
            "CEF",
            "ATA",
            "AAD"
          ],
          "x-ms-enum": {
            "name": "ExternalSecuritySolutionKindEnum",
            "modelAsString": true,
            "values": [
              {
                "value": "CEF"
              },
              {
                "value": "ATA"
              },
              {
                "value": "AAD"
              }
            ]
          }
        }
      }

  - from: externalSecuritySolutions.json
    where: $.definitions.AadConnectivityState.properties
    transform: >
      return {
        "connectivityState": {
          "type": "string",
          "title": "The connectivity state of the external AAD solution ",
          "enum": [
            "Discovered",
            "NotLicensed",
            "Connected"
          ],
          "x-ms-enum": {
            "name": "AadConnectivityStateEnum",
            "modelAsString": true,
            "values": [
              {
                "value": "Discovered"
              },
              {
                "value": "NotLicensed"
              },
              {
                "value": "Connected"
              }
            ]
          }
        }
      }
```

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/security/azure-mgmt-security
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/security/azure-mgmt-security
```
