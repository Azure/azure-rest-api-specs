# Linting

There are a number of validation messages that [AutoRest](https://github.com/Azure/autorest/blob/master/Documentation/cli.md) will output when deserializing the spec file.

## Running linter (command line options)
Simply run AutoRest.exe against your spec file. Any errors will be in the console output.

If you want to see any other messages (e.g. Warnings or Info messages), use the `-Verbose` flag.

If you want AutoRest.exe to fail with an error code if any Warnings are found, use the `-ValidationLevel Warning` flag.

If you want to simply see that validation messages output, use `-CodeGenerator None` to suppress outputting code.

## Using linting in VS Code
Download the VS Code extension here: [https://github.com/Azure/openapi-lint-extension](https://github.com/Azure/openapi-lint-extension). The extension helps see each validation rule in situ, as well as providing other useful quality-of-life features for writing OpenAPI specs.

## Current list of rules displayed by the VS Code extension
These pages describe each rule in detail and how to fix the issue. They also show the effect that each issue has on the generated code, to make it easier to understand the rational behind the rule.
- [AnonymousParameterTypes](https://github.com/Azure/autorest/wiki/anonymous-parameter-types)
- [AvoidNestedProperties](https://github.com/Azure/autorest/wiki/avoid-nested-properties)
- [DefaultInEnum](https://github.com/Azure/autorest/wiki/default-in-enum)
- [DescriptiveDescriptionRequired](https://github.com/Azure/autorest/wiki/descriptive-description-required)
- [ModelTypeIncomplete](https://github.com/Azure/autorest/wiki/model-type-incomplete)
- [NonEmptyClientName](https://github.com/Azure/autorest/wiki/non-empty-client-name)
- [OperationDescriptionRequired](https://github.com/Azure/autorest/wiki/operation-description-required)
- [OperationIdNounInVerb](https://github.com/Azure/autorest/wiki/operation-id-noun-in-verb)
- [OperationIdSingleUnderscore](https://github.com/Azure/autorest/wiki/operation-id-single-underscore)
- [ParameterDescriptionRequired](https://github.com/Azure/autorest/wiki/parameter-description-required)
- [RequiredPropertiesMustExist](https://github.com/Azure/autorest/wiki/required-properties-must-exist)
- [ResponseRequired](https://github.com/Azure/autorest/wiki/response-required)
- [ValidFormats](https://github.com/Azure/autorest/wiki/valid-formats)
- [XmsPathsInPath](https://github.com/Azure/autorest/wiki/xms-paths-in-path)
