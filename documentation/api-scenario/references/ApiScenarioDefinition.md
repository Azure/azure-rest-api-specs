# API Scenario Definition Reference

## API Scenario Definition File

See [API Scenario Definition File Schema](./v1.2/schema.json#L1)

File should be in format of yaml.

**Example:**

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/documentation/api-scenario/references/v1.2/schema.json

scope: ResourceGroup
variables:
  configStoreName:
    type: string
    prefix: configstor

scenarios:
  - scenario: quickStart
    description: Quick start with AppConfiguration ConfigurationStores
    steps:
      - step: Operations_CheckNameAvailability
        operationId: Operations_CheckNameAvailability
        parameters:
          checkNameAvailabilityParameters:
            name: $(configStoreName)
            type: Microsoft.AppConfiguration/configurationStores
      - step: ConfigurationStores_Create
        operationId: ConfigurationStores_Create
        parameters:
          configStoreCreationParameters:
            location: $(location)
            sku:
              name: Standard
            tags:
              myTag: myTagValue
      - step: ConfigurationStores_Get
        operationId: ConfigurationStores_Get
```

**Fields:**

- **scope**
  - **Type:** Required, Enum
  - **Enum:** ResourceGroup, Subscription, Tenant, None
    - **ResourceGroup:** All scenarios and steps should be executed under some resourceGroup. It means:
      - The consumer (API scenario runner or anything consumes API scenario) SHOULD maintain the resource group itself. Usually it requires user to input the subscriptionId/location, then it creates the resource group before test running, and deletes the resource group after running
      - The consumer SHOULD set the following variables:
        - **subscriptionId**
        - **resourceGroupName**
        - **location**
      - For details of how variables work please see [Variables](./Variables.md)
    - **Subscription:** All scenarios and steps will be executed under some subscription. It means:
      - No resource group need to be created.
      - The consumer SHOULD set the following variables:
        - **subscriptionId**
    - **Tenant:** All scenarios and steps will be executed under tenant scope.
    - **None:** None of the assumptions above will be made. Use this if the scenario is for data-plane APIs.
- **variables**
  - **Type:** Optional, Map of Strings or Variables
  - See [Variables](./Variables.md)
- **prepareSteps**
  - **Type:** Optional, Array of [Step](#step)
  - Steps that should run before each scenario.
- **scenarios**
  - **Type:** Required, Array of [Scenario](#scenario)
- **cleanUpSteps**
  - **Type:** Optional, Array of [Step](#step)
  - Steps that should run after each scenario.

## Scenario

See [Scenario Schema](./v1.2/schema.json#L353).

It defines one API scenario that could go through on its own.

**Example:**

```yaml
scenario: quickStart
description: Quick start with AppConfiguration ConfigurationStores
steps:
  - step: Operations_CheckNameAvailability
    operationId: Operations_CheckNameAvailability
    parameters:
      checkNameAvailabilityParameters:
        name: $(configStoreName)
        type: Microsoft.AppConfiguration/configurationStores
variables:
  configStoreName: $(configStoreName)-test
```

**Fields:**

- **scenario**
  - **Type:** Optional, String
  - Name of the scenario that uniquely identifies it in the API scenario file.
- **description**
  - **Type:** Optional, String
  - Description for this API scenario.
- **variables**
  - **Type:** Optional, Map of Strings or Variables
  - See [Variables](./Variables.md)
- **steps**
  - **Type:** Required, Array of [Step](#step)
  - Steps in this API scenario

## Step

See [Step Schema](./v1.2/schema.json#L383).

Defines one step in API scenario.

Should be one of the following:

- [Step REST Call](#step-rest-call)
  - [REST Operation](#rest-operation)
  - [REST Example](#rest-example)
- [Step ARM Template](#step-arm-template)
- [Step ARM Deployment Script](#step-arm-deployment-script)
- [Step Role Assignment](#step-role-assignment)

All of the above definitions share the following fields:

- **step**
  - **Type:** Required, String
  - Step name. Must be unique in the same file.
- **description**
  - **Type:** Optional, String
  - A brief explanation about the step
- **variables**
  - **Type:** Optional, Map of Strings or variables
  - See [Variables](./Variables.md)

### Step REST Call

Step to run a rest call defined in swagger operation. This may not be just one http call.

- If the operation is a long running operation (LRO), then follow the LRO polling strategy:
  - Response statusCode must be 200 if the LRO succeeded, no matter what code the initial response is.
  - If the LRO is PUT/PATCH, the runner should automatically insert a GET after the polling to verify the resource update result.
- If the operation is DELETE, then after the operation, the runner should automatically insert a GET to verify resource cannot be found.

REST call step could be defined either by an operation, or by an example file. REST call will have computed **requestParameter** and **responseExpected** after parsing and loading.

#### Operation based step

See [Step Operation Schema](./v1.2/schema.json#L450)

**Example:**
```yaml
- step: Operations_CheckNameAvailability
  operationId: Operations_CheckNameAvailability
  parameters:
    checkNameAvailabilityParameters:
      name: $(configStoreName)
      type: Microsoft.AppConfiguration/configurationStores
  responses:
    200:
      body:
        nameAvailable: true
```

**Fields:**

- **operationId:**
  - **Type:** Required, String
  - OperationId defined in Swagger.
- **parameters:**
  - **Type:** Optional, Map from parameter name to parameter value
- **responses:**
  - **Type:** Optional, Map from expected response code to response headers and body or array of [JsonPatchOpTest](#jsonpatchoptest).
- **outputVariables**
  - **Type:** Optional, Map from variable name to object with property:
    - **type**: Required, String
    - **fromRequest**
      - **Type:** Required, String
      - Path to the request field to be used as variable.
    - **fromResponse**
      - **Type:** Required, String
      - Path to the response field to be used as variable.

#### ExampleFile based step

See [Step Example Schema](./v1.2/schema.json#L520)

**Example:**

```yaml
- step: Operations_CheckNameAvailability
  exampleFile: ../examples/CheckNameAvailable.json
```

**Fields:**

- **exampleFile**
  - **Type:** Required, String
  - Path to example file. Should be in format of "x-ms-example" files.
- **requestUpdate**
  - **Type:** Optional, Array of [JsonPatchOp](#jsonpatchop)
  - Updates that apply to the **requestParameters** before sending it, with `/parameters` in example as root of Json path.
- **responseUpdate**
  - **Type:** Optional, Array of [JsonPatchOp](#jsonpatchop)
  - Updates that apply to the **responseExpected**, with `/responses` in example as root of Json path.
- **outputVariables**
  - **Type:** Optional, Map from variable name to object with property:
    - **type**: Required, String
    - **fromRequest**
      - **Type:** Required, String
      - Path to the request field to be used as variable.
    - **fromResponse**
      - **Type:** Required, String
      - Path to the response field to be used as variable.

**Conventions:**

When the scope is `ResourceGroup` and the request is a PUT/PATCH, the **requestUpdate** JsonPatchOp items starting with body parameter name SHOULD be applied to the response body (if any) for all successful status codes, excluding writeOnly properties - `x-ms-secret: true` or `x-ms-mutability` doesn't contain `read`.

The **responseUpdate** SHOULD be applied after the **requestUpdate**, providing option to override the behavior by convention.

The behavior of applying **requestUpdate** to the response body should follow JSON merge-patch ([RFC 7396](https://tools.ietf.org/html/rfc7396)).

The whole process is illustrated as below pseudo-code:
```
if (scope is 'ResourceGroup' && operation.verb in ('PUT', 'PATCH')) {
  updatedRequestBody = apply_JsonPatchOp(initialRequestBody, requestUpdate.body);
  mergePatch = generate_JsonMergePatch(initialRequestBody, updatedRequestBody);
  for (each successful status code) {
    if (response.body is not empty) {
      updatedResponseBody = apply_JsonMergePatch(initialResponseBody, mergePatch);
      updatedResponseBody = exclude_WriteOnly_Properties(updatedResponseBody);
      updatedResponseBody = apply_JsonPatchOp(updatedResponseBody, responseUpdate.body);
    }
  }
}
```

### Step ARM Template

See [Step ARM Template Schema](./v1.2/schema.json#L566).

Step to deploy ARM template to the scope. Template parameters and outputs will also interact with variables automatically, see [Variables](./Variables.md).

**Example:**

```yaml
- step: prepare_resources
  armTemplate: ./dep-storage-account.json
```

**Fields:**

- **armTemplate**
  - **Type:** Required, String
  - Path to ARM template json file. See [ARM Template](https://learn.microsoft.com/azure/templates/).

### Step ARM Deployment Script

See [Step ARM Deployment Script Schema](./v1.2/schema.json#L587).

Step to deploy ARM deployment script to the scope. Template parameters and outputs will also interact with variables automatically, see [Variables](./Variables.md).

**Example:**

```yaml
- step: Add_Dns_Cname_Record
  armDeploymentScript: ./templates/create_cname_record.ps1
  environmentVariables:
    - name: resourceGroupName
      value: $(dnsResourceGroup)
    - name: dnsZoneName
      value: $(customDomainName)
    - name: dnsCname
      value: $(dnsCname)
    - name: dnsCnameAlias
      value: $(serviceName).somedomain.com
```

**Fields:**

- **armDeploymentScript**
  - **Type:** Required, String
  - Path to script file. See [ARM Deployment Script Template](https://learn.microsoft.com/azure/azure-resource-manager/templates/deployment-script-template).
- **arguments**
  - **Type:** Optional, String
  - Arguments for the script. Same as arguments in ARM Template. See [ARM Deployment Script Template](https://learn.microsoft.com/azure/azure-resource-manager/templates/deployment-script-template).
- **environmentVariables**
  - **Type:** Optional, Array of [EnvironmentVariable](#EnvironmentVariable)
  - Specify the environment variables to pass over to the script.

### Step Role Assignment

See [Step Role Assignment Schema](./v1.2/schema.json#L629).

Step to assign an Azure role to the scope.

**Example:**

```yaml
- step: AssignDataOwnerRole
  roleAssignment:
    scope: $(configStoreId)
    principalId: a0b840b5-a7b4-4bb4-b125-ae0acf68cf16
    roleName: App Configuration Data Owner
```

**Fields:**

- **scope**
  - **Type:** Required, String
  - The scope of the operation or resource. Valid scopes are: subscription (format: '/subscriptions/{subscriptionId}'), resource group (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}', or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'.
- **principalId**
  - **Type:** Required, String, GUID
  - The principal ID.
- **principalType**
  - **Type:** Optional, Enum
  - **Enum:** User, Group, ServicePrincipal, ForeignGroup, Device
  - **Default:** ServicePrincipal
- **OneOf**:
  - **roleName**
    - **Type:** Required, String
    - The built-in role name. [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
  - **roleDefinitionId**
    - **Type:** Required, String, GUID
    - The role definition ID. For example: 5ae67dd6-50cb-40e7-96ff-dc2bfa4b606b

#### EnvironmentVariable

**Example:**

```yaml
- name: dnsCname
  value: asc
- name: dnsCnameAlias
  value: $(serviceName).somedomain.com
```

**Fields:**

- **name**
  - **Type:** Required, String
  - Name of Variable.
- **value**
  - **Type:** Required, String
  - See [Variables](./Variables.md).

## Json Operations

### JsonPatchOp

See [Json Patch Operation Schema](./v1.2/schema.json#L674)

JsonPatchOp is used to define the update operation on json. You could add, remove, replace, copy, and move on json path.
All the json path used in JsonPatchOp is in format of [JsonPointer](https://datatracker.ietf.org/doc/html/rfc6901).

- [JsonPatchOp](#jsonpatchop)
  - [JsonPatchOpAdd](#jsonpatchopadd)
  - [JsonPatchOpRemove](#jsonpatchopremove)
  - [JsonPatchOpReplace](#jsonpatchopreplace)
  - [JsonPatchOpCopy](#jsonpatchopcopy)
  - [JsonPatchOpMove](#jsonpatchopmove)

#### JsonPatchOpAdd

**Example**

```yaml
add: /properties/items
value: 1
```

**Fields:**

- **add**
  - **Type:** Required, JsonPointer
- **value**
  - **Type:** Required, Any

Add json property at specified path.

1. If any segment of path does not exist, then it will be created.
2. If any value already exists on the path, then it will be overwritten.
3. If the parent of the destination is array, then the value will be inserted at the specified index.

**Example of add**

```
apply:
- add: /properties/location
  value: "eastus"

on data:
- { "properties": { } }

result:
- { "properties": { "location": "eastus" } } }

---
apply:
- add: /properties/items/1
  value: 4

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items": [1, 4, 2, 3] } }
```

#### JsonPatchOpRemove

**Example**

```yaml
remove: /properties/items/1
```

**Fields:**

- **remove**
  - **Type:** Required, JsonPointer

Remove element at specified path.

1. If any segment of path does not exist, then error will be thrown.
2. If parent of the specified path is array, then the element will be removed from the array.

**Example of remove**

```
apply:
- remove: /properties/items

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { } }

---
apply:
- remove: /properties/items/1

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items": [1, 3] } }
```

#### JsonPatchOpReplace

**Example**

```yaml
replace: /properties/items
value: 1
```

**Fields:**

- **replace**
  - **Type:** Required, JsonPointer
- **value**
  - **Type:** Required, Any

Replace json property at specified path.

1. If any segment of path does not exist, error will be thrown.
2. If any value already exists on the path, then it will be overwritten.

**Example of replace**

```
apply:
- replace: /properties/location
  value: "eastus"

on data:
- { "properties": { "location": "westus" } }

result:
- { "properties": { "location": "eastus" } } }
```

#### JsonPatchOpCopy

**Example**

```yaml
copy: /properties/items2
from: /properties/items
```

**Fields:**

- **copy**
  - **Type:** Required, JsonPointer
- **from**
  - **Type:** Required, JsonPointer

Copy json property from specified path to another path. Array index is also supported and works as add/remove does.

**Example of copy**

```
apply:
- copy: /properties/items2
  from: /properties/items

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items": [1, 2, 3] }, "items2": [1, 2, 3] } }
```

#### JsonPatchOpMove

**Example**

```yaml
move: /properties/items2
from: /properties/items
```

**Fields:**

- **move**
  - **Type:** Required, JsonPointer
- **from**
  - **Type:** Required, JsonPointer

Move json property from specified path to another path. It works as a combination of remove followed by add. Array index is also supported and works as add/remove does.

**Example of move**

```
apply:
- move: /properties/items2
  from: /properties/items

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items2": [1, 2, 3] } }
```

### JsonTestOp

See [Json Test Operation schema](./v1.2/schema.json#L767)

JsonTestOp is used to define the test operation on json. You could test if the json path is expected.
The json path used in JsonPatchOp is in format of [JsonPointer](https://datatracker.ietf.org/doc/html/rfc6901).

- [JsonTestOp](#jsontestop)
  - [JsonTestOpEqual](#jsontestopequal)
  - [JsonTestOpExpression](#jsontestopexpression)

#### JsonTestOpEqual

**Example**

```yaml
test: /properties/item
value: a
```

**Fields:**

- **test**
  - **Type:** Required, JsonPointer
- **value**
  - **Type:** Required, Object

Test that a value at the target location is equal to a specified value.

**Example of test**

```
apply:
- test: /properties/a
  value: 1

on data:
- { "properties": { "a": 0, "b": 1} }

result:
- throws error
```

#### JsonTestOpExpression

**Example**

```yaml
test: /headers/location
expression: to.not.be.undefined
```

**Fields:**

- **test**
  - **Type:** Required, JsonPointer
- **expression**
  - **Type:** Required, String
  - [ChaiJS BDD Expression](https://www.chaijs.com/api/bdd/)

Test that a value at the target location is expected as expression.

**Example of test**

```
apply:
- test: /properties/a
  expression: to.be.null

on data:
- { "properties": { "a": 0, "b": 1} }

result:
- throws error
```
