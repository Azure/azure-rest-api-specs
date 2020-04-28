# FAQ in Swagger PR Review

This page is intended to answer questions frequently asked during Azure Swagger PR review.

1. [I am new to Swagger/OpenAPI, How should I start?](#Onboard)
2. [How to fix validation failure?](#validation)
3. [How to generate SDK from Swagger?](#SDK)
4. [How to generate document](#doc)
5. [If need further help, who can we contact?](#contact)

## How to onboard PR review Process?<a name="Onboard"></a>
If you are new to Swagger/OpenAPI, you can refer to this [document](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/80/Getting-started-with-OpenAPI-specifications)

If you are new to Swagger PR review process, you can refer to this [flowchart](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/212/Swagger-PR-Review)

You can refer to this [document](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/49/Request-Access-to-Azure-SDK-repos) to get read permission to submit PR.

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
If you are working in the public repository,SDK generation is triggered as soon as your OpenAPI specification (a.k.a swagger) PR is created/committed/merged in to the azure-rest-api-specs repository.

If you are working in the private repository, please refer to this [document](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/81/Management-Plane-SDK-generation) to manually generate SDKs of different languages, including Python, Java, Go, C#, Js etc.


## How to generate Document from Swagger?<a name="doc"></a>
Refer to [document](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/79/Generation-of-docs-on-docs.microsoft.com)

## If need further help, who can we contact?<a name="contact"></a>
If any other help need, Please send a mail to vscswagger@microsoft.com