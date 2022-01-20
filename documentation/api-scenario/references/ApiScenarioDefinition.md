# API Scenario Definition Reference

## API Scenario Definition File

See [API Scenario Definition File Schema](./v1.1/schema.json#L1)

File should be in format of yaml.

**Example:**

```yaml
scope: ResourceGroup
variables:
  publicIpAddressName: pubipdns
prepareSteps:
  - step: prepare_resources
    armTemplateDeployment: ./dep-something.json
scenarios:
  - description: test_network_public_ip
    steps:
      - step: Create_publicIPAddresses_pubipdns
        resourceName: publicIPAddresses_pubipdns
        exampleFile: ../examples/Create_publicIPAddresses_pubipdns_Generated.json
        operationId: PublicIPAddresses_CreateOrUpdate
    variables:
      publicIpAddressName: pubipdns
```

**Fields:**

- **scope**
  - **Type:** Required, Enum
  - **Enum:** ResourceGroup
  - Now only "ResourceGroup" is supported.
    - **ResourceGroup:** All of the following API scenario and steps should be under some resourceGroup. It means:
      - The consumer (API scenario runner or anything consumes API scenario) SHOULD maintain the resource group itself. Usually it requires user to input the subscriptionId/location, then it creates the resource group before test running, and deletes the resource group after running
      - The consumer SHOULD set the following variables:
        - **subscriptionId**
        - **resourceGroupName**
        - **location**
      - For details of how variables works please see [Variables](./Variables.md)
- **variables**
  - **Type:** Optional, Map of strings
  - See [Variables](./Variables.md)
- **prepareSteps**
  - **Type:** Optional, Array of [Step](#step)
  - Steps that should run before every API scenario steps.
- **scenarios**
  - **Type:** Required, Array of [Scenario](#scenario)

## Scenario

See [Scenario Schema](./v1.1/schema.json#L83).

It defines one API scenario that could go through on its own.

**Example:**

```yaml
description: test_network_public_ip
shareScope: true
steps:
  - step: Create_publicIPAddresses_pubipdns
    resourceName: publicIPAddresses_pubipdns
    exampleFile: ../examples/Create_publicIPAddresses_pubipdns_Generated.json
    operationId: PublicIPAddresses_CreateOrUpdate
variables:
  publicIpAddressName: pubipdns
```

**Fields:**

- **description**
  - **Type:** Required, String
  - Description for this API scenario.
- **shareScope**
  - **Type:** Optional, Boolean or String
  - **Default:** true
  - Describe how the scope (ResourceGroup if scope is ResourceGroup) could be shared with other tests. If it's true or it's the same string setting for different API scenario, then they share the same scope, which means:
    - These tests will run under the same scope (e.g. ResourceGroup). They may launch in parallel.
    - **prepareSteps** will only run once in the scope. The variables will be shared.
  - By default all the API scenario in one definition file will be launched in the same scope. If shareScope is false then it will not share anything with other API scenarios in the same file.
- **variables**
  - **Type:** Optional, Map of strings
  - See [Variables](./Variables.md)
- **steps**
  - **Type:** Required, Array of [Step](#step)
  - Steps in this API scenario

## Step

See [Step Schema](./v1.1/schema.json#L114).

Defines one step in API scenario.

Should be one of the following:

- [Step REST Call](#step-rest-call)
  - [REST Call](#rest-call)
  - [REST Call by ResourceName Tracking and Update](#rest-call-by-resourcename-tracking-and-update)
- [Step ARM Template Deployment](#step-arm-template-deployment)

All of the above definitions share the following fields:

- **variables**
  - **Type:** Optional, Map of Strings
  - See [Variables](./Variables.md)
- **step**
  - **Type:** Required, String
  - Step name. Must be unique in the same file.

## Step ARM Template Deployment

See [Step ARM Template Deployment Schema](./v1.1/schema.json#L247).

Step to deploy ARM template to the scope. Template parameters and outputs will also interact with variables automatically, see [Variables](./Variables.md).

**Example:**

```yaml
step: prepare_resources
armTemplateDeployment: ./dep-storage-account.json
```

**Fields:**

- **armTemplateDeployment**
  - **Type:** Required, String
  - Path to ARM template json file. See [ARM Template](https://docs.microsoft.com/azure/templates/).

## Step REST Call

See [Step REST Call Schema](./v1.1/schema.json#L205)

Step to run a swagger operation defined rest call. This may not be just one http call.

- If the operation is a long running operation (LRO), then follow the LRO polling strategy.
  - Response statusCode must be 200 if the LRO succeeded, no matter what code the initial response is.
  - If the LRO is PUT/PATCH, the runner should automatically insert a GET after the polling to verify the resource update result.
- If the operation is DELETE, then after the operation, the runner should automatically insert a GET to verify resource cannot be found.

Rest call step could be defined either by an example file, or by resourceName tracking and update.

Rest call will have computed **requestParameter** and **responseExpected** after parsing and loading:

- **requestParameter**

### REST Call

**Example:**

```yaml
step: Create_publicIPAddresses_pubipdns
resourceName: publicIPAddresses_pubipdns
exampleFile: ../examples/Create_publicIPAddresses_pubipdns_Generated.json
operationId: PublicIPAddresses_CreateOrUpdate
statusCode: 200
```

**Fields:**

- **exampleFile**
  - **Type:** Optional, String
  - Path to example file. Should be in format of "x-ms-example" files.
- **operationId**
  - **Type:** Optional, String
  - OperationId defined in swagger operation. It could be skipped if the example file is referenced by only one operation so we could detect the operationId.
- **statusCode:**
  - **Type:** Optional, Number
  - **Default:** 200
  - Expected response code.
  - For LRO it must be 200 to indicate succeeded result, and must be 400 to indicate failed result.
- **requestUpdate**
  - **Type:** Optional, Array of [JsonPatchOp](#jsonpatchop)
  - Updates that applied to the requestParameters before sending it.
- **responseUpdate**
  - **Type:** Optional, Array of [JsonPatchOp](#jsonpatchop)
  - Updates that applied to the responseExpected.
- **outputVariables**
  - **Type:** Optional, Map from variable name to object with property:
    - **fromResponse**
      - **Type:** Required, String
      - Path to the response field to be used as variable.

### Rest Call by ResourceName Tracking and Update

**Example**

```yaml
- step: Create_publicIPAddresses_pubipdns
  resourceName: publicIPAddresses_pubipdns
  exampleFile: ../examples/Create_publicIPAddresses_pubipdns_Generated.json
  operationId: PublicIPAddresses_CreateOrUpdate
  statusCode: 200

- step: Update_publicIPAddresses
  resourceName: publicIPAddresses_pubipdns
  resourceUpdate:
    - replace: /properties/location
      value: westus
```

Different steps with the same resourceName will be tracked by the API scenario. It knows that you are trying to update the same resource. You can use the first request with example to specify the request and resource id, then the following step with the same resourceName will use the same resource id to update the resource. For the

**Fields:**

- **resourceName**
  - **Type:** Required, String
  - The user-defined resource name of the resource to be tracked. It's only used as a name of that resource and do not need to be same as the actual resource name.
- **resourceUpdate**
  - **Type:** Optional, Array of [JsonPatchOp](#jsonpatchop)
  - Array of changes to be applied to the resource.

resourceUpdate will help to automate compute the request body and the expected response body. The algorithm will be:

- Get the expected response body from previous step with same `resourceName`, or from current step with example loaded.
- For each change in `resourceUpdate`, apply the change to the expected response body, mark as `computedAllProperties`.
- Let new request body parameter value to be: `computedAllProperties` without `readOnly` fields and `x-ms-mutability` fields that don't contains `update`.
- Let new response expected to be: `computedAllProperties` without `x-ms-secrets` fields and `x-ms-mutability` fields that don't contain `read`.
- Let the operationId to be: resource PUT operationId.

### JsonPatchOp

JsonPatchOp is used to define the update operation on json. You could add, remove, replace, move, copy and merge on json path.
All the json path used in JsonPatchOp is in format of [JsonPointer](https://datatracker.ietf.org/doc/html/rfc6901).

- [JsonPatchOp](#jsonpatchop)
  - [JsonPatchOpAdd](#jsonpatchopadd)
  - [JsonPatchOpRemove](#jsonpatchopremove)
  - [JsonPatchOpReplace](#jsonpatchopreplace)
  - [JsonPatchOpCopy](#jsonpatchopcopy)
  - [JsonPatchOpMove](#jsonpatchopmove)
  - [JsonPatchOpTest](#jsonpatchoptest)

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

#### JsonPatchOpTest

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
