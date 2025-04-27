import path from "path";
import { readFileSync, writeFileSync } from "fs";

export function writeMarkdownFiles(basePath: string, filePaths: string[], componentName: string, clientName: string) {
  const apiVersions = filePaths.map((filePath) => getApiVersionFromFilePath(filePath));
  apiVersions.sort((a, b) => b.localeCompare(a));
  const latestApiVersion = apiVersions[0];

  writeReadme(basePath, 'readme.md', getMainReadme(clientName, componentName, filePaths, latestApiVersion, suppressions[componentName]).trimStart());
  writeReadme(basePath, 'readme.csharp.md', getCsharpReadme(componentName).trimStart());
  writeReadme(basePath, 'readme.go.md', getGoReadme(componentName).trimStart());
  writeReadme(basePath, 'readme.java.md', getJavaReadme(componentName, latestApiVersion).trimStart());
  writeReadme(basePath, 'readme.python.md', getPythonReadme(componentName).trimStart());
  writeReadme(basePath, 'readme.typescript.md', getTypescriptReadme(clientName, componentName).trimStart());
}

function writeReadme(basePath: string, fileName: string, readme: string) {
  // Remove leading + trailing whitespace, add a final newline
  readme = readme.trim() + '\n';

  writeFileSync(path.resolve(basePath, fileName), readme);
}

function removeMarkdownSectionMatching(readme: string, matcher: (heading: string) => boolean) {
  return readme.replace(/(##.*?\n)([\s\S]*?)(?=\n##|$)/g, (match, _) => {
    if (matcher(match.split('\n')[0])) {
      return '';
    }

    return match;
  });
}

function removeCodeblockMatching(readme: string, matcher: (heading: string) => boolean) {
  return readme.replace(/(```.*?\n)([\s\S]*?)(\n```\n\n)/g, (match, _) => {
    if (matcher(match.split('\n')[0])) {
      return '';
    }

    return match;
  });
}

function removeLinesMatching(readme: string, matcher: (line: string) => boolean) {
  return readme.split('\n').filter(x => !matcher(x)).join('\n');
}

function removeSuppressionMatching(readme: string, matcher: (body: string) => boolean) {
  return readme.replace(/([ ]*- (from|suppress): .*?\n)([\s\S]*?)(?=\n[ ]*- (from|suppress): |```)\n/g, (match, _) => {
    if (matcher(match)) {
      return '';
    }

    return match;
  });
}

function replaceFile(filePath: string, updateFunc: (content: string) => string) {
  const content = readFileSync(filePath, 'utf8');
  const updatedContent = updateFunc(content);
  writeFileSync(filePath, updatedContent);
}

export function replaceSourceReadmes(basePath: string) {
  const packagePattern = /(deploymentscripts|templatespecs|deploymentstacks|bicep)/;

  const readmes = [
    'readme.md',
    'readme.go.md',
    'readme.java.md',
    'readme.nodejs.md',
    'readme.python.md',
    'readme.ruby.md',
    'readme.terraform.md',
    'readme.typescript.md',
  ];

  for (const readme of readmes) {
    replaceFile(path.resolve(basePath, `../${readme}`), (content) => {
      content = removeMarkdownSectionMatching(content, (heading) => packagePattern.test(heading));
      content = removeCodeblockMatching(content, heading => packagePattern.test(heading));

      if (readme === 'readme.md') {
        const movedFilesPattern = /from: (deploymentScripts|templateSpecs|deploymentStacks|bicep)/;
        content = removeSuppressionMatching(content, body => movedFilesPattern.test(body));
      }

      content = removeLinesMatching(content, line => packagePattern.test(line));

      return content;
    });
  }
}

function getPackageName(apiVersion: string) {
  const year = apiVersion.split('-')[0];
  const month = apiVersion.split('-')[1];  

  return `package-deployments-${year}-${month}`;
}

function getApiVersionFromFilePath(filePath: string) {
  return filePath.replace(/^\.\//, '').split('/')[1];
}

function getMainReadme(clientName: string, componentName: string, filePaths: string[], latestApiVersion: string, suppressions: string | undefined) {
  let readme = `
# ${componentName}

> see https://aka.ms/autorest

This is the AutoRest configuration file for ${componentName}.

## Getting Started

To build the SDKs for ${componentName}, simply install AutoRest via \`npm\` (\`npm install -g autorest\`) and then run:

> \`autorest readme.md\`

To see additional help and options, run:

> \`autorest --help\`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the ${componentName} client.

\`\`\` yaml
title: ${clientName}
description: ${componentName} Client
openapi-type: arm
tag: ${getPackageName(latestApiVersion)}
\`\`\`

---
`;

  for (const filePath of filePaths) {
    const apiVersion = getApiVersionFromFilePath(filePath);
    const packageName = getPackageName(apiVersion);
    readme += `
### Tag: ${packageName}

These settings apply only when \`--tag=${packageName}\` is specified on the command line.

\`\`\` yaml $(tag) == '${packageName}'
input-file:
  - ${filePath}
\`\`\`
`;
  }

  if (suppressions) {
    readme += `
## Suppression

\`\`\` yaml
${suppressions.trim()}
\`\`\`
`;
  }

  readme += `
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

\`\`\` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-powershell
\`\`\`

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
`;
  return readme;
}

function getCsharpReadme(componentName: string) {
  return `
## C#

These settings apply only when \`--csharp\` is specified on the command line.
Please also specify \`--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>\`.

\`\`\`yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  clear-output-folder: true
  client-side-validation: false
  namespace: Microsoft.Azure.Management.Deployments.${componentName}
  output-folder: $(csharp-sdks-folder)/deployments/Microsoft.Azure.Management.Deployments/src/Generated
\`\`\`
`;
}

function getGoReadme(componentName: string) {
  return `
## Go

These settings apply only when \`--go\` is specified on the command line.


\`\`\` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/deployments/${componentName.toLowerCase()}
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
\`\`\`
`;
}

function getJavaReadme(componentName: string, latestApiVersion: string) {
  return `
## Java

These settings apply only when \`--java\` is specified on the command line.
Please also specify \`--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>\`.

### Tag: ${getPackageName(latestApiVersion)} and java

These settings apply only when \`--tag=${getPackageName(latestApiVersion)} --java\` is specified on the command line.
Please also specify \`--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>\`.

\`\`\` yaml $(tag) == '${getPackageName(latestApiVersion)}' && $(java)
java:
  namespace: com.microsoft.azure.management.deployments.${componentName.toLowerCase()}.v${latestApiVersion.replace(/-/g, '_')}
  output-folder: $(azure-libraries-for-java-folder)/sdk/deployments/mgmt-v${latestApiVersion.replace(/-/g, '_')}
  regenerate-manager: true
  generate-interface: true
\`\`\`
`;
}

function getPythonReadme(componentName: string) {
  return `
## Python

These settings apply only when \`--python\` is specified on the command line.
Please also specify \`--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>\`.

\`\`\` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-deployments-${componentName.toLowerCase()}
namespace: azure.mgmt.deployments.${componentName.toLowerCase()}
package-version: 1.0.0b1
clear-output-folder: true
\`\`\`

\`\`\` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/deployments/azure-mgmt-deployments-${componentName.toLowerCase()}/azure/mgmt/deployments/${componentName.toLowerCase()}
\`\`\`
`;
}

function getTypescriptReadme(clientName: string, componentName: string) {
  return `
## TypeScript

These settings apply only when \`--typescript\` is specified on the command line.
Please also specify \`--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>\`.

\`\`\`yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-deployments-${componentName.toLowerCase()}"
  output-folder: "$(typescript-sdks-folder)/sdk/deployments/arm-deployments-${componentName.toLowerCase()}"
  override-client-name: ${clientName}
  generate-metadata: true
\`\`\`
`;
}

const suppressions: Record<string, string> = {
  Deployments: `
directive:
  - suppress: UniqueResourcePaths
    from: deployments.json
    where: $.paths
    reason: route definitions under an extension resource with Microsoft.Management
  - suppress: BodyTopLevelProperties
    from: deployments.json
    where: $.definitions.ResourceGroup.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: deployments.json
    where: $.definitions.GenericResource.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: deployments.json
    where: $.definitions.GenericResourceExpanded.properties
    reason: 'createdTime,changedTime & provisioningState are top-level properties'
  - suppress: BodyTopLevelProperties
    from: deployments.json
    where: $.definitions.TagDetails.properties
    reason: TagDetails is a top level property
  - suppress: BodyTopLevelProperties
    from: deployments.json
    where: $.definitions.TagValue.properties
    reason: TagValue is a top level property
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.TagValue
    reason: TagValue will be deprecated soon
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.TagDetails
    reason: TagDetails will be deprecated soon
  - suppress: XmsResourceInPutResponse
    from: deployments.json
    where: '$.paths["/subscriptions/{subscriptionId}/tagNames/{tagName}"].put'
    reason: TagDetails is not an Azure resource
  - suppress: DescriptionAndTitleMissing
    where: $.definitions.AliasPathMetadata
    from: deployments.json
    reason: This was already checked in - not my code
  - from: deployments.json
    suppress: R4009
    where:
      - '$.paths["/{scope}/providers/Microsoft.Resources/tags/default"].put'
      - '$.paths["/{scope}/providers/Microsoft.Resources/tags/default"].patch'
      - '$.paths["/{scope}/providers/Microsoft.Resources/tags/default"].get'
    reason: The tags API does not support system data
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    where: $.paths
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationsApiResponseSchema
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationsApiSchemaUsesCommonTypes
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: NoDuplicatePathsForScopeParameter
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroLocationHeader
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroErrorContent
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: NoErrorCodeResponses
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PutRequestResponseSchemeArm
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PutResponseSchemaDescription
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PostOperationAsyncResponseValidation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: MissingXmsErrorResponse
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForPutOperation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathResourceProviderMatchNamespace
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ParametersOrder
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SyncPostReturn
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathContainsResourceType
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationIdNounVerb
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForResourceAction
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: UnSupportedPatchProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroPostReturn
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPut
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPatch
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SubscriptionsAndResourceGroupCasing
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ResourceNameRestriction
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ConsistentPatchProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: MissingTypeObject
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: TrackedResourcePatchOperation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: IntegerTypeMustHaveFormat
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: BodyTopLevelProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: TopLevelResourcesListBySubscription
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: XmsParameterLocation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForTrackedResourceTypes
    from: deployments.json
    reason: Not a tracked resource type. Cannot change anything due to design philosophy in ARM.
  - suppress: PostResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: TenantLevelAPIsNotAllowed
    from: deployments.json
    reason: Tenant level API's are allowed as an exception in ARM repo. It is a breaking change to modify it.
  - suppress: XmsPageableForListCalls
    from: deployments.json
    reason: Shared swagger with other teams. We cannot make changes to the API as we don't own it.
  - suppress: EvenSegmentedPathForPutOperation
    from: deployments.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: DeleteResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: PutResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: AvoidAdditionalProperties
    from: deployments.json
    reason: Breaking change in order to change the property names for multiple API's. Will fix in the future.
  - suppress: XmsExamplesRequired
    from: deployments.json
    reason: Xms Examples required is a pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: RequiredReadOnlySystemData
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future
  - suppress: TrackedExtensionResourcesAreNotAllowed
    from: deployments.json
    reason: "The deployments resource type is ProxyOnly."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.Provider
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.ProviderListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.ProviderResourceTypeListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.TagsListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.DeploymentOperation
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.DeploymentOperationsListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.OperationListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.ProviderPermissionListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
`,
  DeploymentScripts: `
directive:
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - suppress: OperationsAPIImplementation
    from: deploymentScripts.json
    where: $.paths
    reason: OperationsAPI will come from Resources
  - suppress: IntegerTypeMustHaveFormat
    from: deploymentScripts.json
    reason: Tooling issue, default is int32, explicitly mentioning the format as per doc, it still flags breaking change.
  - suppress: ResourceNameRestriction
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PropertiesTypeObjectNoDefinition
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SubscriptionsAndResourceGroupCasing
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ParametersInPointGet
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PatchIdentityProperty
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroErrorContent
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPut
    from: deploymentScripts.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - from: deploymentScripts.json
    suppress: R3006
    where:
      - $.definitions.DeploymentScript.properties
      - $.definitions.AzureCliScript.properties
      - $.definitions.AzurePowerShellScript.properties
    reason: Currently systemData is not allowed
`,
  DeploymentStacks: `
directive:
  - from: deploymentStacks.json
    suppress: OperationsAPIImplementation
    where: $.paths
    reason: OperationsAPI will come from Resources
  - from: deploymentStacks.json
    suppress: TrackedResourcePatchOperation
    where: $.definitions
    reason: Not a tracked resource.
  - suppress: PathForTrackedResourceTypes
    from: deploymentStacks.json
    reason: "A deployment stack resource is a proxy location-mapped resource type."
  - suppress: TenantLevelAPIsNotAllowed
    from: deploymentStacks.json
    reason: "Working with deployment stacks at the management group scope is supported."
  - suppress: TrackedResourcePatchOperation
    from: deploymentStacks.json
    reason: "A deployment stack resource is a proxy location-mapped resource type."
  - suppress: AvoidAdditionalProperties
    from: deploymentStacks.json
    reason: "Deployment properties such as 'parameters', 'outputs', and 'template' are dynamic types. For example, properties of the parameters object are defined by the template content."
  - suppress: PostResponseCodes
    from: deploymentStacks.json
    reason: "Validate endpoints have 200, 202, 400, and default responses. The 400 response inherits the error response."
  - suppress: LroErrorContent
    from: deploymentStacks.json
    reason: Error response is inherited via allOf on flagged response.
  - suppress: NoErrorCodeResponses
    from: deploymentStacks.json
    reason: A 400 response from the validate endpoint indicates a validation failure and should not throw an exception.
  - suppress: MissingXmsErrorResponse
    from: deploymentStacks.json
    reason: A 400 response from the validate endpoint indicates a validation failure and should not throw an exception.
  - suppress: DeleteResponseCodes
    from: deploymentStacks.json
    reason: Deployment stacks supports synchronous delete with 200 response.
  - suppress: OperationsAPIImplementation
    from: deploymentStacks.json
    reason: This comes from resources.json
`,
    TemplateSpecs: `
directive:
  - suppress: OperationsAPIImplementation
    from: templateSpecs.json
    where: $.paths
    reason: OperationsAPI will come from Resources
  - suppress: R3006
    from: templateSpecs.json
    where:
      - $.definitions.TemplateSpec.properties
      - $.definitions.TemplateSpecVersion.properties
      - $.definitions.TemplateSpecUpdateModel.properties
      - $.definitions.TemplateSpecVersionUpdateModel.properties
    reason: Currently systemData is not allowed
  - suppress: TrackedResourceListByImmediateParent
    from: templateSpecs.json
    where: $.definitions
    reason: Tooling issue
  - suppress: TrackedResourceListByResourceGroup
    from: templateSpecs.json
    where: $.definitions.TemplateSpecVersion
    reason: Tooling issue
`,
}