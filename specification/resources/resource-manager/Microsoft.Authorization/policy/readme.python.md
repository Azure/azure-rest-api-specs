## Python

These settings apply only when `--python` is specified on the command line.

### Tag: package-policy-2025-03-python

These settings apply only when `--tag=package-policy-2025-03-python` is specified on the command line.

```yaml $(tag) == 'package-policy-2025-03-python'
input-file:
  - stable/2025-03-01/openapi.json
  - stable/2020-09-01/dataPolicyManifests.json
  - preview/2022-07-01-preview/policyExemptions.json
  - preview/2022-08-01-preview/policyVariables.json
  - preview/2022-08-01-preview/policyVariableValues.json

directive:
  # Add missing PolicyAssignments "ById" operations from 2023-04-01 that are not in openapi.json to keep compatibility for Python SDK
  - from: openapi.json
    where: $.paths
    transform: |
      $["/{policyAssignmentId}"] = {
        "delete": {
          "tags": ["PolicyAssignments"],
          "operationId": "PolicyAssignments_DeleteById",
          "summary": "Deletes a policy assignment.",
          "description": "This operation deletes the policy with the given ID. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid formats for {scope} are: '/providers/Microsoft.Management/managementGroups/{managementGroup}' (management group), '/subscriptions/{subscriptionId}' (subscription), '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' (resource group), or '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}' (resource).",
          "parameters": [
            {
              "name": "policyAssignmentId",
              "in": "path",
              "required": true,
              "type": "string",
              "description": "The ID of the policy assignment to delete. Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.",
              "x-ms-skip-url-encoding": true
            },
            {
              "$ref": "../../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
            }
          ],
          "responses": {
            "200": {
              "description": "OK - Returns information about the policy assignment.",
              "schema": { "$ref": "#/definitions/PolicyAssignment" }
            },
            "204": { "description": "No Content - the policy assignment doesn't exist." },
            "default": {
              "description": "Error response describing why the operation failed.",
              "schema": { "$ref": "../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse" }
            }
          }
        },
        "put": {
          "tags": ["PolicyAssignments"],
          "operationId": "PolicyAssignments_CreateById",
          "summary": "Creates or updates a policy assignment.",
          "description": "This operation creates or updates the policy assignment with the given ID. Policy assignments made on a scope apply to all resources contained in that scope. For example, when you assign a policy to a resource group that policy applies to all resources in the group. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.",
          "parameters": [
            {
              "name": "policyAssignmentId",
              "in": "path",
              "required": true,
              "type": "string",
              "description": "The ID of the policy assignment to create. Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.",
              "x-ms-skip-url-encoding": true
            },
            {
              "name": "parameters",
              "in": "body",
              "required": true,
              "schema": { "$ref": "#/definitions/PolicyAssignment" },
              "description": "Parameters for policy assignment."
            },
            {
              "$ref": "../../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
            }
          ],
          "responses": {
            "201": {
              "description": "Created - Returns information about the policy assignment.",
              "schema": { "$ref": "#/definitions/PolicyAssignment" }
            },
            "default": {
              "description": "Error response describing why the operation failed.",
              "schema": { "$ref": "../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse" }
            }
          }
        },
        "get": {
          "tags": ["PolicyAssignments"],
          "operationId": "PolicyAssignments_GetById",
          "summary": "Retrieves the policy assignment with the given ID.",
          "description": "The operation retrieves the policy assignment with the given ID. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.",
          "parameters": [
            {
              "name": "policyAssignmentId",
              "in": "path",
              "required": true,
              "type": "string",
              "description": "The ID of the policy assignment to get. Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.",
              "x-ms-skip-url-encoding": true
            },
            {
              "name": "$expand",
              "in": "query",
              "required": false,
              "type": "string",
              "description": "Comma-separated list of additional properties to be included in the response. Supported values are 'LatestDefinitionVersion, EffectiveDefinitionVersion'."
            },
            {
              "$ref": "../../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
            }
          ],
          "responses": {
            "200": {
              "description": "OK - Returns information about the policy assignment.",
              "schema": { "$ref": "#/definitions/PolicyAssignment" }
            },
            "default": {
              "description": "Error response describing why the operation failed.",
              "schema": { "$ref": "../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse" }
            }
          }
        },
        "patch": {
          "tags": ["PolicyAssignments"],
          "operationId": "PolicyAssignments_UpdateById",
          "summary": "Updates a policy assignment.",
          "description": "This operation updates the policy assignment with the given ID. Policy assignments made on a scope apply to all resources contained in that scope. For example, when you assign a policy to a resource group that policy applies to all resources in the group. Policy assignment IDs have this format: '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'. Valid scopes are: management group (format: '/providers/Microsoft.Management/managementGroups/{managementGroup}'), subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.",
          "parameters": [
            {
              "name": "policyAssignmentId",
              "in": "path",
              "required": true,
              "type": "string",
              "description": "The ID of the policy assignment to update. Use the format '{scope}/providers/Microsoft.Authorization/policyAssignments/{policyAssignmentName}'.",
              "x-ms-skip-url-encoding": true
            },
            {
              "name": "parameters",
              "in": "body",
              "required": true,
              "schema": { "$ref": "#/definitions/PolicyAssignmentUpdate" },
              "description": "Parameters for policy assignment patch request."
            },
            {
              "$ref": "../../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParameter"
            }
          ],
          "responses": {
            "200": {
              "description": "OK - Returns information about the policy assignment.",
              "schema": { "$ref": "#/definitions/PolicyAssignment" }
            },
            "default": {
              "description": "Error response describing why the operation failed.",
              "schema": { "$ref": "../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse" }
            }
          }
        }
      };
      return $;
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
