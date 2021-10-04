# Test Definition Reference

## Test Definition File

See [Test Definition File Schema](./v1.0/schema.json#L1)

File should be in format of yaml.

**Example:**
```yaml
scope: ResourceGroup
requiredVariables:
  - subscriptionId
variables:
  publicIpAddressName: pubipdns
prepareSteps:
  - step: prepare_resources
    armTemplateDeployment: ./dep-something.json
testScenarios:
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
    - **ResourceGroup:** All of the following test scenario and steps should be under some resourceGroup. It means:
      - The consumer (test scenario runner or anything consumes test scenario) SHOULD maintain the resource group itself. Usually it requires user to input the subscriptionId/location, then it creates the resource group before test running, and deletes the resource group after running
      - The consumer SHOULD set the following variables:
        - **subscriptionId**
        - **resourceGroupName**
        - **location**
      - For details of how variables works please see [Variables](./Variables.md)
- **variables**
  - **Type:** Optional, Map of strings
  - See [Variables](./Variables.md)
- **requiredVariables**
  - **Type:** Optional, Array of string
  - Variables that must be defined by user. By default, **subscriptionId** and **location** are required.
- **prepareSteps**
  - **Type:** Optional, Array of [Test Step](#test-step)
  - Steps that should run before every test scenario steps.
- **testScenarios**
  - **Type:** Required, Array of [Test Scenario](#test-scenario)

## Test Scenario

See [Test Scenario Schema](./v1.0/schema.json#L331).

It defines one test scenario that could go through on its own.

**Example:**
```yaml
description: test_network_public_ip
shareTestScope: true
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
  - Description for this test scenario.
- **shareTestScope**
  - **Type:** Optional, Boolean or String
  - **Default:** true
  - Describe how the testScope (ResourceGroup if scope is ResourceGroup) could be shared with other tests. If it's true or it's the same string setting for different test scenario, then they share the same test scope, which means:
    - These tests will run under the same test scope (e.g. ResourceGroup). They may launch in parallel.
    - **prepareSteps** will only run once in the testScope. The variables will be shared.
  - By default all the test scenario in one test definition file will be launched in the same test scope. If shareTestScope is false then it will not share anything with other test scenarios in the same file.
- **variables**
  - **Type:** Optional, Map of strings
  - See [Variables](./Variables.md)
- **steps**
  - **Type:** Required, Array of [Test Step](#test-step)
  - Steps in this test scenario

## Test Step

See [Test Step Schema](./v1.0/schema.json#L50).

Defines one test step in test scenario.

Should be one of the following:
- [Test Step](#test-step)
- [Test Step ARM Template Deployment](#test-step-arm-template-deployment)
- [Test Step Rest Call](#test-step-rest-call)
  - [Rest Call](#rest-call)
  - [Rest Call by ResourceName Tracking and Update](#rest-call-by-resourcename-tracking-and-update)

All of the above definitions share the following fields:
- **variables**
  - **Type:** Optional, Map of Strings
  - See [Variables](./Variables.md)
- **step**
  - **Type:** Required, String
  - Step name. Must be unique in the same file.

## Test Step ARM Template Deployment

See [Test Step ARM Template Deployment Schema](./v1.0/schema.json#L78).

Step to deploy ARM template to the test scope. Template parameters and outputs will also interact with variables automatically, see [Variables](./Variables.md).

**Example:**
```yaml
step: prepare_resources
armTemplateDeployment: ./dep-storage-account.json
armTemplateParameters: ./dep-storage-account-params.json
```

**Fields:**
- **armTemplateDeployment**
  - **Type:** Required, String
  - Path to ARM template json file. See [ARM Template](https://docs.microsoft.com/azure/templates/).
- **armTemplateParameters**
  - **Type:** Optional, String
  - Path to ARM template parameter file. See [ARM Template Parameter File](https://docs.microsoft.com/azure/azure-resource-manager/templates/parameter-files).

## Test Step Rest Call

See [Test Step Rest Call Schema](./v1.0/schema.json#L97)

Step to run a swagger operation defined rest call. This may not be just one http call.

- If the operation is a long running operation (LRO), then follow the LRO polling strategy.
  - Response statusCode must be 200 if the LRO succeeded, no matter what code the initial response is.
  - If the LRO is PUT/PATCH, the runner should automatically insert a GET after the polling to verify the resource update result.
- If the operation is DELETE, then after the operation, the runner should automatically insert a GET to verify resource cannot be found.

Rest call step could be defined either by an example file, or by resourceName tracking and update.

Rest call will have computed **requestParameter** and **responseExpected** after parsing and loading:
- **requestParameter** 

### Rest Call

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

Different steps with the same resourceName will be tracked by the test scenario. It knows that you are trying to update the same resource. You can use the first request with example to specify the request and resource id, then the following step with the same resourceName will use the same resource id to update the resource. For the 

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
    - [JsonPatchOpMove](#jsonpatchopmove)
    - [JsonPatchOpCopy](#jsonpatchopcopy)
    - [JsonPatchOpMerge](#jsonpatchopmerge)
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

#### JsonPatchOpMove

**Example**
```yaml
move: /properties/items
path: /properties/items2
```

**Fields:**
- **move**
  - **Type:** Required, JsonPointer
- **path**
  - **Type:** Required, JsonPointer

Move json property at specified path to another path. It works as a combination of remove followed by add. Array index is also supported and works as add/remove does.

**Example of move**
```
apply:
- move: /properties/items
  path: /properties/items2

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items2": [1, 2, 3] } }
```
#### JsonPatchOpCopy

**Example**
```yaml
copy: /properties/items
path: /properties/items2
```

**Fields:**
- **copy**
  - **Type:** Required, JsonPointer
- **path**
  - **Type:** Required, JsonPointer

Copy json property at specified path to another path. Array index is also supported and works as add/remove does.

**Example of copy**
```
apply:
- copy: /properties/items
  path: /properties/items2

on data:
- { "properties": { "items": [1, 2, 3] } }

result:
- { "properties": { "items": [1, 2, 3] }, "items2": [1, 2, 3] } }
```
#### JsonPatchOpMerge

**Example**
```yaml
merge: /properties/item
value:
  a: 1
  b: 2
```

**Fields:**
- **merge**
  - **Type:** Required, JsonPointer
- **value**
  - **Type:** Required, Object

Merge values into the object at specified path.
1. Property value at the specified path must be an object.
2. Properties with same key will be overwritten.

**Example of merge**
```
apply:
- merge: /properties
  value:
    a: 1
    b: 2

on data:
- { "properties": { "b": 0, "c": 0} }

result:
- { "properties": { "a": 1, "b": 2, "c": 0 } }
```