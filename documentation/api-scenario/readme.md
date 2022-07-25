# API Scenario Documentation

API Scenario is a YAML file defining RESTful API usage scenarios of your service with a sequence of API calls. API scenario can be used for service API functional test, API quality validation and SDK/CLIs test generation.

## Features

- Simple to use: Intuitive step definition based on Swagger operations or examples, describing parameters and expected responses with scoped variables.
- ARM Template integration: Support creating external Azure resources with ARM Template and executing Azure Powershell or Azure CLI scripts with ARM Template deployment script.
- Implementation independent: [oav](https://github.com/Azure/oav) is the default API scenario runner. More runners will be supported, like SDKs in different languages.

### Demo gif

![demo](./how-to/runApiTest.gif)

## Quick start

- [Example: Write and run your first API scenario file](./how-to/QuickStart.md)
- [Example: Generate a basic API scenario file](./how-to/generateABasicApiScenario.md)
- [Example: Integrate with ARM Template](./how-to/integrateWithArmTemplate.md)
- [API scenario file sample](../samplefiles/Microsoft.YourServiceName/stable/YYYY-MM-DD/scenarios/quickStart.yaml)

## References

- [API Scenario Definition Reference](./references/ApiScenarioDefinition.md)
- [API Scenario Variable Definition Reference](./references/Variables.md)
- [API Scenario Runner Reference](./references/Runner.md)
- [API Scenario JSON Schema](./references/v1.1/schema.json)
