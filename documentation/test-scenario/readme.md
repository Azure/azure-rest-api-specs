# Test Scenario Documentation

Test Scenario is a YAML file defining RESTful API usage scenarios of your service with a series of API calls. Test scenario can be used for service functional test, API quality validation and SDK/CLIs test generation.

_**Caution**: This project is in early preview phase, hence breaking changes should be expected._
## Features
- Simple to use: Intuitive test step definition based on Swagger examples and raw REST call.
- ARM Template integration: Support creating external Azure resources with ARM Template and executing Azure Powershell or Azure CLI scripts with ARM Template deployment script.
- Implementation independent: [oav](https://github.com/Azure/oav) is the default test scenario runner, and more runners will be supported, like SDKs in different languages.

### Demo gif

![demo](./how-to/runApiTest.gif)

## Quick start

- [Example: Write and run your first test scenario file](./how-to/QuickStart.md)
- [Example: Generate a basic test scenario file](./how-to/generateABasicTestScenario.md)
- [Example: use armTemplate to generate unique resourceName](./how-to/testScenarioWithARMTemplate.md)
- [Test scenario file sample](../samplefiles/Microsoft.YourServiceName/stable/YYYY-MM-DD/scenarios/testYourService.yaml)

## References
- [Test Scenario Definition Reference](./references/TestDefinitionReference.md)
- [Test Scenario Variable Definition Reference](./references/Variables.md)
- [Test Scenario Runner Reference](./references/Runner.md)
- [Test Scenario Schema Reference](./references/v1.0/schema.json)
