# API Scenario Documentation

API Scenario is a YAML file defining RESTful API usage scenarios of your
service with a sequence of API calls. API scenario can be used for service
API functional test, API quality validation and SDK/CLIs test generation.

API scenario is implemented in the [Azure/aov](https://github.com/Azure/oav)
repository.

## Features

- Simple to use: Intuitive step definition based on Swagger operations or examples, describing parameters and expected responses with scoped variables.
- ARM Template integration: Support creating external Azure resources with ARM Template and executing Azure Powershell or Azure CLI scripts with ARM Template deployment script.
- Implementation independent: [oav](https://github.com/Azure/oav) is the default API scenario runner. More runners will be supported, like SDKs in different languages.

### Demo gif

![demo](./how-to/runApiTest.gif)

## Quick starts

- [Example: Write and run your first API scenario file](./how-to/QuickStart.md)
- [Example: Generate a basic API scenario file](./how-to/GenerateABasicApiScenario.md)
- [Example: Resolve external dependencies](./how-to/ResolveDependencies.md)
- [Example: Make traffic recording with test-proxy](./how-to/MakeTestProxyRecording.md)
- [API scenario file sample](../samplefiles/Microsoft.YourServiceName/stable/YYYY-MM-DD/scenarios/quickStart.yaml)

## References

- [API Scenario Definition Reference](./references/ApiScenarioDefinition.md)
- [API Scenario Variable Definition Reference](./references/Variables.md)
- [API Scenario Runner Reference](./references/Runner.md)
- [API Scenario JSON Schema](./references/v1.2/schema.json)

## Getting help

If you have any question or need support, reach out via
[aka.ms/azsdk/support](https://aka.ms/azsdk/support) (Microsoft-internal only) 
