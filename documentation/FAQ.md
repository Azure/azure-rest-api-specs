# FAQ in Swagger PR Review

This page is intended to answer questions frequently asked during Azure API spec PR review.

1. [I am new to API specs, where should I start?](#Onboard)
2. [How to fix validation failure?](#validation)
3. [How to generate SDK from API specs?](#SDK)
4. [How to generate document](#doc)
5. [How to generate swagger examples](#examplegen)

## How to onboard to API spec PR review Process?<a name="Onboard"></a>
If you are new to API spec, you can refer to this [document](https://eng.ms/docs/products/azure-developer-experience/design/api-specs/api-specs#create-your-rest-api-definition)

You can refer to this [document](https://eng.ms/docs/products/azure-developer-experience/onboard/access) to get read permission to submit PR.

## How to fix validation failure?<a name="validation"></a>
| Validation | Description | How to fix |
| --- | --- | --- |
| [Model Validation](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/Semantic-and-Model-Violations-Reference.md) | Model validation enforces correctness between example and swagger. It checks whether definitions for request parameters and responses, match an expected input/output payload of the service. | [Here](https://aka.ms/ci-fix#model-validation) |
| [Lint diff](https://github.com/Azure/azure-openapi-validator) | A tool to check whether changes in PR are satisfied with certain kind of rules outlined in the [automated rules checklist](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/openapi-authoring-automated-guidelines.md) |  [Here](https://aka.ms/ci-fix#linter-validation) |
| [Breaking Change](https://github.com/Azure/openapi-diff) | A tool to check what a swagger PR has changed and whether these changes violate [breaking changes rules](https://github.com/Azure/openapi-diff/blob/master/docs/README.md).| [Here](https://aka.ms/ci-fix#breaking-change-check)|
| [Avocado](https://github.com/Azure/avocado/blob/master/README.md) | Avocado validates folder structure and configuration.  | [Here](https://aka.ms/ci-fix#avocado) |
| [Semantic](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/Semantic-and-Model-Violations-Reference.md) | Semantic validation enforces correctness on the swagger specific elements. Such as paths and operations. Ensure the element definition meet the OpenApi 2.0 specification. | [Here](https://aka.ms/ci-fix#semantic-validation) |
| Prettier  | Code formatter for Swagger | [Here](https://aka.ms/ci-fix#prettier-check) |
| BranchProtectionForPrivateRepo | BranchProtectionForPrivateRepo is designed to always fail to prevent from merging PR into master which is not allow in private swagger repo as it will cause issue to sync up from public repo.  | You can ignore this failure |

Refer to [Document](https://aka.ms/ci-fix) for how to run these tools locally

## How to generate SDK from Swagger?<a name="SDK"></a>
Refer to this [document](https://eng.ms/docs/products/azure-developer-experience/develop/sdk-generate).


## How to generate Document from Swagger?<a name="doc"></a>
Refer to [document](https://eng.ms/docs/products/azure-developer-experience/design/api-docs)

## How to generate examples from Swagger?<a name="examplegen"></a>
Refer to [Swagger-Example-Generation](https://github.com/Azure/oav/blob/develop/documentation/example-generation.md)