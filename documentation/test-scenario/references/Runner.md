# Runner Behavior

This document explains the expected behavior of runner. The word "runner" here references to any customer that consume the test scenario, including the runner that send out requests defined by test scenario, code generator that generate code that executes steps defined by test scenario, and any other consumer that need to understand the content of test scenario.

## Load Test Scenario via OAV

You could load the test scenario file via oav. It would be resolved as a simple object.

```typescript
  const readmeMd: string =
    "/home/username/azure-rest-api-specs/specification/containerservice/resource-manager/readme.md";
  const argv = {
    ["try-require"]: "readme.test.md",
    tag: "package-2020-12",
  };

  // Get input-file config in readme.md
  const autorestConfig = await getAutorestConfig(argv, readmeMd);
  const swaggerFilePaths: string[] = autorestConfig["input-file"];
  const fileRoot = dirname(readmeMd);

  console.log("input-file:");
  console.log(swaggerFilePaths);

  // Create the loader from OAV
  const loader = TestResourceLoader.create({
    useJsonParser: false,
    checkUnderFileRoot: false,
    fileRoot,
    swaggerFilePaths,
  });

  // Load the test scenario file. File list could also be specified in readme.test.md
  const testDef = await loader.load(
    "Microsoft.ContainerService/stable/2020-12-01/test-scenarios/containerService.yaml"
  );

  console.log(testDef.testScenarios[0].steps);

  // Setup initial variable env
  const env = new VariableEnv();
  env.setBatch({
    subscriptionId: "__your_subs_id_",
    location: "westus",
    SSH_PUBLIC_KEY: "__public_key_ssh__",
  });

  // Reference runner implementation in OAV. You need to implement your own runner.
  const runner = new TestScenarioRunner({
    jsonLoader: loader.jsonLoader,
    env,
    client: new TestScenarioRestClient(getDefaultAzureCredential(), {}),
  });

  try {
    for (const scenario of testDef.testScenarios) {
      await runner.executeScenario(scenario);
    }
  } catch (e) {
    console.log(e.message, e.stack);
  } finally {
    console.timeLog("TestLoad");
    await runner.cleanAllTestScope();
  }
```

After the test scenario is loaded, the test step will be slightly different from the file content. Every rest step will have the following resolved fields:

- requestParameters
  - Type: `object`, map of resolved parameter name and value.
- responseExpected
  - Type: `any`
  - The expected response body from the request.

## Procedure of runner

### Input

Let's assume the following things as input of runner:

- Test scenario definition that loaded via OAV.
- The scenario id of the test scenario. Test scenario definition file could contains multiple test scenarios, runner need to run one of them.
- Extra environment variables that required by test scenario, defined in `requiredVariables`.

### Scope

It's the `scope` field defined at top level of test scenario file. Now only `ResourceGroup` is supported, it means that the test scenario will:

- Run under specified resource group.
- Runner would manage the resource group, it could create the resource group (defined by variable `subscriptionId`, `resourceGroup`, `location`) or use predefined resource group, it could also delete the resource group after the test scenario is done. Runner itself is responsible for managing the resource group, the behavior is not defined by this spec.
- Runner would run all the arm template deployment under the specified resource group.

The scope is a convention, however it would not be enforced by test scenario. User could override the variable `resourceGroup` in any step to run that step in another resource group for example.

### Variables

See [Variables](./Variables.md) for variable spec. The runner must follow the variable definition in test scenario. Runner do not need to care about the variable conventions as it's already resolved by OAV. The runner must:

- Load variables layer by layer as defined in the variable spec.
- Resolve variables like `$(variableName)` step by step in:
  - requestParameter
  - responseExpected (if it's used by runner)
  - armTemplate payload

### Procedure

- Load definition via OAV, load required variables' value (runner need to specify how to load it).
- Manage the test scope, runner could create/reuse the scope as user defined in input.
- Run top level prepareSteps if it has not run. it's a list of steps defined in test scenario.
- Pass the variables from prepareSteps to the following main steps.
- For each steps defined in the test scenario array:
  - If `type` field is `restCall`:
    - Replace variables in `requestParameters`.
    - Fill the request via parameter definition in swagger and parameter value in `requestParameters`.
    - Send out the request.
    - If the request is long running request, runner need to poll for the response.
      - If the response's long running poll's final call is operation status, and the step itself is resource PUT/PATCH/DELETE, runner could run another GET against the resource to check. For DELETE, the final GET is expected to return 404. For PUT/PATCH, the final GET is expected to return 200, and it should represent the final response of the step.
    - Check if the response status code is the same as the expected `statusCode` field defined in step. Optional.
    - Check if the response body is the same as the expected `responseExpected` field defined in step. Optional.
    - If `outputVariables` is defined, runner need to extract and define the variable from specified path in response body.
  - If `type` field is `armTemplateDeployment`:
    - Use the convention to replace arm template parameters if the parameter name matches the variable name and the parameter type is string.
    - Send arm template deployment request under the resource group.
    - Wait for the deployment to finish.
    - Get the output variables from the deployment. Define the variables from the output variables.
  - Else `type` is unsupported in runner.

### Compare the response with expectedResponse

It's hard for service team to make sure every field in expectedResponse is the same as the response, so here test scenario suggest to compare properties that are not `readOnly` and are not `x-ms-secret`. The detail should be defined by the runner, not this spec.
