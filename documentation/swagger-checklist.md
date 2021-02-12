# Swagger Checklist for Microsoft Azure #

## Introduction ##

This checklist is a current snapshot of requirements for developing Swagger specifications. The checklist will be continuously updated to reflect issues uncovered during Swagger specification reviews.

## Checklist ##
- [Automated Rules of Checklist](openapi-authoring-automated-guidelines.md) - Azure developer experience team is continuously working on automating as many rules as possible. Running the [validation tools](#validation-tools-for-swagger-checklist) will give you these validation errors.
- [Manual Rules of Checklist](openapi-authoring-manual-guidelines.md) - These rules cannot be automated. They must be verified by service team and code reviewers manually.

## Validation Tools for Swagger Checklist ##

Today, there are tools available for validating a sizable portion of this checklist. Please install these tools on your development machine and use them to validate your Swaggers as you build them. 

- [AutoRest OpenAPI Validator](https://github.com/Azure/autorest/blob/master/docs/user/command-line-interface.md#validation) – The OpenAPI validator (activated with `--azure-validator`) statically analyzes a Swagger for errors and violations of requirements outlined in the automated rules checklist. The validator should be run when Swaggers are created or updated. It will be continuously updated to validate newer requirements.
  **NOTE**: This checkmark ( :white_check_mark: ) indicates that rule is covered by AutoRest validation tool.

- [Swagger Model Validator](https://github.com/Azure/openapi-validation-tools) - Model Validator validates models defined for body parameters and responses, and matches them against the expected input and output of an operation. To make this real, test examples are required to be specified in a Swagger for every operation defined in a Swagger. Test examples are integrated into a Swagger using the ["x-ms-examples"](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md) extension, which will be used to test against the defined models. Sample test examples for this extension can be found in the [Redis Cache Swagger](https://github.com/Azure/azure-rest-api-specs/blob/master/arm-redis/2016-04-01/swagger/redis.json ). 

The Azure Developer Experience team will continue to deliver rich tools to validate this checklist.



