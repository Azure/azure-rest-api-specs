# Test Definition Reference

## Test Definition File

See [Test Definition File Schema](./TestDefinitionFileSchema.json#1)

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

See [Test Scenario Schema](./TestDefinitionFileSchema.json#307).

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

See [Test Step Schema](./TestDefinitionFileSchema.json#49).

Defines one test step in test scenario.

Should be on of the following:
- [Test Step Rest Call](#test-step-rest-call)
- [Test Step Arm Template Deployment](#test-step-arm-template-deployment)
- [Test Step Raw Call](#test-step-raw-call)

All of the above definitions share the following fields:
- **variables**
  - **Type:** Optional, Map of Strings
  - See [Variables](./Variables.md)
- **step**
  - **Type:** Required, String
  - Step name. Must be unique in the same file.

## Test Step Arm Template Deployment

See [Test Step Arm Template Deployment Schema](./TestDefinitionFileSchema.json#77).

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

See [Test Step Rest Call Schema](./TestDefinitionFileSchema.json#96)

Step to run a swagger operation defined rest call. This may not be just one http call.

- If the operation is a long running operation (LRO), then follow the LRO polling strategy.
  - Response statusCode must be 200 if the LRO succeeded, no matter what code the initial response is.
  - If the LRO is PUT/PATCH, the runner should automatically insert a GET after the polling to verify the resource update result.
- If the operation is DELETE, then after the operation, the runner should automatically insert a GET to verify resource cannot be found.

Rest call step could be defined either by an example file, or by resourceName tracking and update.

Rest call will have computed **requestParameter** and **responseExpected** after parsing and loading:
- **requestParameter** 

### Rest Call by Example File

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
  - **Type:** Required, String
  - Path to example file. Should be in format of "x-ms-example" files.
- **operationId**
  - **Type:** Optional, String
  - OperationId defined in swagger operation. It could be skipped if the example file is referenced by only one operation so we could detect the operationId.
- **statusCode:**
  - **Type:** Optional, Number
  - **Default:** 200
  - Expected response code.
  - For LRO it must be 200 to indicate succeeded result, and must be 400 to indicate failed result.
