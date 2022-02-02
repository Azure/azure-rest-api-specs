# API Scenario Documentation

API Scenario is a YAML file defining RESTful API usage scenarios of your service with a series of API calls. API scenario can be used for service functional test, API quality validation and SDK/CLIs test generation.

_**Caution**: This project is in early preview phase, hence breaking changes should be expected._

## Features

- Simple to use: Intuitive step definition based on Swagger examples and raw REST call.
- ARM Template integration: Support creating external Azure resources with ARM Template and executing Azure Powershell or Azure CLI scripts with ARM Template deployment script.
- Implementation independent: [oav](https://github.com/Azure/oav) is the default API scenario runner, and more runners will be supported, like SDKs in different languages.

### Demo gif

![demo](./how-to/runApiTest.gif)

## Quick start

- [Example: Write and run your first API scenario file](./how-to/QuickStart.md)
- [Example: Generate a basic API scenario file](./how-to/generateABasicApiScenario.md)
- [Example: use armTemplate to generate unique resourceName](./how-to/apiScenarioWithARMTemplate.md)
- [API scenario file sample](../samplefiles/Microsoft.YourServiceName/stable/YYYY-MM-DD/scenarios/quickStart.yaml)

## References

- [API Scenario Definition Reference](./references/ApiScenarioDefinition.md)
- [API Scenario Variable Definition Reference](./references/Variables.md)
- [API Scenario Runner Reference](./references/Runner.md)
- [API Scenario JSON Schema](./references/v1.1/schema.json)
