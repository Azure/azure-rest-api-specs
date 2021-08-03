# Test Scenario Documentation

Test Scenario is a YAML file describing a series of RESTful API calls that form usage scenario for your service. The test scenario can be run via [oav](https://github.com/Azure/oav) to validate if the REST API behavior is consistent with API definition in Swagger and examples.
## Features

`oav` support run test scenario file. [oav：openapi validation tool](https://github.com/Azure/oav)

- Very easy to use and run.
- Support postman collection format. Debug easily.
- Request response validation. `oav` implement a powerful validation algorithm and help developer to detect service issue in the early phase.
- Validation result report. After each run test scenario, developer will get a validation report which contains detect issue in api test.
- Integrate everywhere. Easily integrate with azure-pipeline, cloud-test.

#### Demo gif

![](./how-to/runApiTest.gif)

## Quick start

- [Example: Write and run your first test scenario file](./how-to/QuickStart.md)
- [Example: Generate a basic test scenario file](./how-to/generateABasicTestScenario.md)
- [Example: use armTemplate to generate unique resourceName](./how-to/testScenarioWithARMTemplate.md)
- [Test scenario file sample](../samplefiles/Microsoft.YourServiceName/stable/YYYY-MM-DD/scenarios/testYourService.yaml)

## References
- [Test Scenario Definition Reference](./references/TestDefinitionReference.md)
- [Test Scenario Variable Definition Reference](./references/Variables.md)
- [Test Scenario Runner Reference](./references/Runner.md)
- [Test Scenario Schema Reference](./references/TestDefinitionFileSchema.json)
