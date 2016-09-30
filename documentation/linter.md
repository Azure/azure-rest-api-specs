# Linting
For a large number of rules, we can automatically detect issues in a spec file. In the review process, we first start by using the VS Code extension to flag these problems. You can fix these ahead of time by using the VS Code extension when writing your spec.

### Download
Get the VS Code extension here: [https://github.com/Azure/openapi-lint-extension](https://github.com/Azure/openapi-lint-extension). It helps you see each validation rule in situ, as well as providing other useful quality-of-life features for writing OpenAPI specs.

### Current list of rules
These pages describe each rule in detail and how to fix the issue. They also show the effect that each issue has on the generated code, to make it easier to understand the rational behind the rule.

**Note there currently an exception to many of these rules for existing specs, since they were written before guidance for these rules. If you are updating an existing spec with a small change (e.g. adding a feature), make sure to mention this in your PR. We will work with your team to get your existing spec to follow all of these rules in the future, as this exception is temporary.** 

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