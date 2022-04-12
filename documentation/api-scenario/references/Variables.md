# Variables in API scenario

## Variable types

Variables could be of different types:
- `array`
- `bool`
- `int`
- `object`
- `secureString`
- `secureObject`
- `string`

## Variable definition

Variables could be defined in different level of API scenario:

- `runtime`: Variables specified at runtime. Only `string` or `secureString` type is allowed in runtime level.
- `global`: API scenario file level variable definition.
- `scope`: Scope level variable. If the scope of API scenario is `ResourceGroup`, variable `resourceGroupName` will be available in scope level.
- `scenario`: API scenario level variable definition.
- `step`: Step level variable definition.

Variable could be referenced by `$(variableName)`. For example, in the following API scenario:

```yaml
variables:
  resourceName: level-1

scenarios:
  - description: Create some resource
    variables:
      resourceName: level-2
    steps:
      - step: Create resource
        variables:
          resourceName: level-3
        exampleFile: ../examples/ResourceCreate.json
```

If in `../examples/ResourceCreate.json` there is `$(resourceName)` in some string, it would be replaced with `level-3`.

Variables could also be defined on test running. For example you could set `subscriptionId` or `resourceGroupName` on the global scope. How to set global env is based on the API scenario consumer.

Variables could be replaced recursively. For example if we have the following variables:

```yaml
variables:
  resourceName: abc
  resourceId: Microsoft.Contoso/$(resourceName)
```

Then `$(resourceId)` would be resolved to `Microsoft.Contoso/abc`. Note that variables referencing `secureString` should be regarded as `secureString` in API Scenario runner.

## Convention: parameter name in example

In one rest call step, if we have any parameter, for example it's named `param`, in the step requestParameters, with value `paramValue`, and API scenario has variable `param`, then by default, API scenario loader will:

- replace the parameter value of `param` to `$(param)` so that it will reference the variable value.
- replace `paramValue` to `$(param)` in every string in request body (in requestParameter) and in responseExpected.

For example, for the following step with loaded requestParameter and responseExpected

```yaml
requestParameters:
  subscriptionId: 00000000-0000-0000-0000-000000000000
  resourceGroupName: testGroup
  resourceName: abc
  api-version: 2021-01-01
  parameters:
    properties:
      a: abc
responseExpected:
  id: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testGroup/providers/Microsoft.Contoso/SomeResource/abc
  name: abc
  type: Microsoft.Contoso/SomeResource
  properties:
    a: abc
```

And when we are on this step, we already have `subscriptionId`, `resourceGroupName` and `resourceName` in variables, then the step will be replaced with:

```yaml
requestParameters:
  subscriptionId: $(subscriptionId)
  resourceGroupName: $(resourceGroupName)
  resourceName: $(resourceName)
  api-version: 2021-01-01
  parameters:
    properties:
      a: abc
responseExpected:
  id: /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Contoso/SomeResource/$(resourceName)
  name: $(resourceName)
  type: Microsoft.Contoso/SomeResource
  properties:
    a: $(resourceName)
```

With this convention, you could control most of the parameters with variables.

## Convention: location

In one rest call step, if we have variable `location` (exact match) in the API scenario, and we have `location` as top level property defined in request body (`requestParameters[bodyParamName]`) and response body (responseExpected), then the top level location property will be replaced with variable value of location.

For example,

```yaml
requestParameters:
  parameters:
    id: someId
    location: westus
responseExpected:
  id: someId
  location: westus
```

When we have `location` variable defined, this step will be transformed to:

```yaml
requestParameters:
  parameters:
    id: someId
    location: $(location)
responseExpected:
  id: someId
  location: $(location)
```

## Convention: Arm Template Deployment

When you deploy arm template in API scenario, you could define template parameters and outputs. By default if the parameter name matches the variable exists and the parameter type is string, then the parameter value would use the variable value. If the template has output which is string type, the variables will be set with output values.

For example, given the following arm template:

```json
{
  "parameters": {
    "userName": {
      "type": "string"
    }
  },
  "resources": [],
  "outputs": {
    "nameResult": {
      "type": "string",
      "value": "[concat('prefix/', parameters['userName'])]"
    }
  }
}
```

If we have variable `userName` defined with `abc`, then we will have variable `nameResult` defined with value `prefix/abc` so that following steps in the API scenario could use variable `nameResult`.
