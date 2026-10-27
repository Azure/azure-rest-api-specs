# Table of Contents
- [Running Locally](#running-locally)
- [Examples Source and Destination](#examples-source-and-destination)
- [Validation Rule Suppression](#validation-rule-suppression)
- [Rules](#rules)
  - [MultipleNewApiVersions](#multiplenewapiversions)
  - [StaleApiVersionPin](#staleapiversionpin)
  - [Behavior shared by the API-version rules](#behavior-shared-by-the-api-version-rules)
  - [SdkTspConfigValidation](#sdktspconfigvalidation)
    - [JavaScript](#javascript-sub-rules)
    - [Python](#python-sub-rules)
    - [Go](#go-sub-rules)
    - [Java](#java-sub-rules)
    - [.Net](#net-sub-rules)

# Running Locally
Complete the Node.js and pnpm setup in [Contributing](../contributing/toolchain-setup.md) first. Run the following commands from the **repository root**.

To ensure you see the same results from TypeSpecValidation in your PR check and `tsv` on your local machine:

1. Merge latest from parent (e.g. `main` or `RPSaaSMaster`) to your PR branch
2. Run locally
   1. `git clean -xdf` (may revert any local changes)
   2. `git pull`
   3. `pnpm ci`
   4. `pnpm tsv specification/contosowidgetmanager/Contoso.Management`
   5. `git status`
   6. If any changes, `git add`, `git commit`, `git push` to update your PR.
3. If you are still having problems, try cloning your branch to a new folder, or try on another machine.
4. If the problem can be reproduced on a clean machine, request assistance from the [TypeSpec Discussion](https://teams.microsoft.com/l/channel/19%3A906c1efbbec54dc8949ac736633e6bdf%40thread.skype/TypeSpec%20Discussion?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47) teams channel.

# Examples Source and Destination
If you are having problems with diffs from "tsp compile" related to examples, ensure you understand how examples flow from source to destination.

The **source** of examples is under your TypeSpec source code folder, and the **destination** of examples is under the Swagger folder.  The TypeSpec compiler copies from source to destination.  In our sample:

* source
  * https://github.com/Azure/azure-rest-api-specs/tree/main/specification/contosowidgetmanager/Contoso.Management/examples/2021-10-01-preview
* destination
  * https://github.com/Azure/azure-rest-api-specs/tree/main/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/examples

If you are changing examples, you must **first** change the copy under your TypeSpec folder, and then run `pnpm tsp compile .` from that folder (or `pnpm tsv <folder>` from the repository root, which calls `compile`) to update the copies in your Swagger folder.

# Validation Rule Suppression

You can suppress specific validation rules within `TypeSpecValidation` by creating or modifying a `suppressions.yaml` file in the root directory of your service specification.

> **Note:** The `SdkTspConfigValidation` rule supports both whole-rule and sub-rule suppression. The
> `MultipleNewApiVersions` and `StaleApiVersionPin` rules support whole-rule suppression only.

## Suppressing the API-version Rules

`MultipleNewApiVersions` and `StaleApiVersionPin` are suppressed independently, so silencing one
leaves the other enforced:

```yaml
- tool: TypeSpecValidation
  paths:
    # Path to the TypeSpec project folder the suppression applies to
    - /path/to/typespec/project
  rules:
    - StaleApiVersionPin
  reason: the-reason-you-want-to-suppress # Explain why this suppression is necessary
```

## Suppressing SdkTspConfigValidation Rules

The `SdkTspConfigValidation` rule is responsible for validating emitter options and parameters defined in your `tspconfig.yaml` file. You have the flexibility to suppress this rule entirely or target specific sub-rules within it.

### Suppress the Entire SdkTspConfigValidation Rule

If you need to skip **all** validation checks for emitter options and parameters within a particular `tspconfig.yaml` file, you can suppress the entire `SdkTspConfigValidation` rule.

To do this, add or update the `suppressions.yaml` file in your service's root folder with the following content:

```yaml
- tool: TypeSpecValidation
  paths:
    # Specify the path to the tspconfig.yaml file where suppression should apply
    - /path/to/tspconfig.yaml
  rules:
    - SdkTspConfigValidation
  reason: the-reason-you-want-to-suppress # Explain why this suppression is necessary
```

### Suppress Specific Sub-rules within SdkTspConfigValidation

If you only need to bypass validation for **specific** emitter options or parameters, you can suppress individual sub-rules.
Add or update your `suppressions.yaml` file with the following structure, specifying the sub-rules to ignore:
Sub-rule Syntax:

- For parameters: `parameters.<parameter-key>.default`
- For emitter options: `options.<emitter-name>.<option-key>`
- For nested options (e.g., `package-details: name: "xxx"`), use dot notation: `options.<emitter-name>.package-details.name`

```yaml
- tool: TypeSpecValidation
  paths:
    # Specify the path to the tspconfig.yaml file where suppression should apply
    - /path/to/tspconfig.yaml
  rules:
    - SdkTspConfigValidation
  sub-rules:
    # Example: Suppress validation for a specific parameter's default value
    - parameters.<key-to-validate>.default
    # Example: Suppress validation for a specific emitter option
    - options.<emitter-name>.<key-to-validate>
    # Example: Suppress validation for a nested emitter option
    - options.<emitter-name>.package-details.name
  reason: the-reason-you-want-to-suppress # Explain why this suppression is necessary
```

# Rules
## MultipleNewApiVersions

The `MultipleNewApiVersions` rule fails when a pull request adds **more than one** TypeSpec API version and the SDK language emitters do not all target the oldest newly added version. Adding multiple API versions at once makes it ambiguous which API version should be used to generate and release the SDKs.

### Recommended approach: one API version per pull request

Whenever possible, add only one API version in each pull request. This keeps API review, SDK generation, and release-plan automation focused on a single version and avoids temporary emitter configuration.

### Adding multiple API versions in one pull request

If adding multiple API versions in the same pull request is more convenient, temporarily pin every language emitter in `tspconfig.yaml` to the **older API version introduced by the pull request**. This ensures that the SDKs are generated from and released for the older API version first instead of automatically selecting the newer version.

For example, suppose a management-plane pull request introduces both `2026-09-01` and the newer `2026-09-02-preview` API version. To target the older `2026-09-01` version, add the same `api-version` setting to all five management-plane language emitters: C#, Java, JavaScript/TypeScript, Python, and Go.

```yaml
options:
  "@azure-tools/typespec-python":
    api-version: "2026-09-01"
  "@azure-tools/typespec-java":
    api-version: "2026-09-01"
  "@azure-tools/typespec-ts":
    api-version: "2026-09-01"
  "@azure-tools/typespec-go":
    api-version: "2026-09-01"
  "@azure-typespec/http-client-csharp-mgmt":
    api-version: "2026-09-01"
```

Keep each emitter's other existing options unchanged; only add or update `api-version` under the corresponding emitter block.

### Releasing the newer API version

After the pull request containing both API versions is merged and the SDKs for the older API version have been generated and released, create a follow-up pull request that removes the temporary `api-version` settings from all five language emitters. Removing the pins allows the SDKs to be generated from and released for the newer API version.

Do not remove the settings in the original pull request. The two-step workflow is required to generate and release the SDKs for the older API version before moving to the newer API version.

## StaleApiVersionPin

The `StaleApiVersionPin` rule fails when a pull request adds **exactly one** TypeSpec API version while an SDK language emitter is still pinned to an older `api-version` in `tspconfig.yaml`. The pin would cause the SDKs to be generated from the outdated version instead of the version the pull request adds.

This usually means a temporary pin from an earlier multi-version pull request was never removed. Delete the `api-version` setting from each emitter listed in the error so the SDKs are generated from the newly added version:

```yaml
options:
  "@azure-tools/typespec-python":
    # Remove the stale pin below; keep the emitter's other options unchanged.
    api-version: "2026-09-01"
```

An emitter with no `api-version` setting never triggers this rule, because it already targets the latest version.

## Behavior shared by the API-version rules

Both rules compare `service.yaml` between the pull request's base and head commits to find newly added `source: typespec` versions, then read each emitter's resolved `apiVersion` from `typespec-metadata.json`. Because the rules apply to different version counts, only one of them can report a problem in any given pull request.

They currently evaluate the five management-plane SDK emitters listed above. Both are skipped when:

- The project configures no SDK language emitters.
- The project is a multiple-service project, because the metadata emitter reports `multiple-versions` for every language emitter instead of the API version each emitter is configured with.
- The pull request adds no new TypeSpec API version.

### Running the rules locally

The rules only run when the caller supplies the two commits to compare, so `pnpm tsv <folder>` on its own skips them. The pull request check and `TypeSpec-Validation.ps1` always supply them.

They compare `service.yaml` between those commits, so they only see **committed** changes. If a new API version is still uncommitted, the rules report that no new API versions were added.

To run them locally from the repository root, pass the commitishes in the context argument, substituting the commit SHA of `main` and of your local branch:

```sh
pnpm tsv specification/contosowidgetmanager/Contoso.Management '{"baseCommitish":"{commitShaOfMain}","headCommitish":"{headShaOfLocalBranch}"}'
```

The validation script accepts the same commitishes and forwards them to the rules:

```
./eng/scripts/TypeSpec-Validation.ps1 -BaseCommitish main -HeadCommitish HEAD
```

## SdkTspConfigValidation
### Parameters
- **`parameters.default.service-dir`**
  - Allowed values: strings that matches the regex `/^sdk\/.*$/`
  - example: `sdk/aaa`

### JavaScript Sub Rules
> Please follow the below steps to configure. If you encounter any issues, please seek help in the <a href="https://teams.microsoft.com/l/channel/19%3A408c5f1322ee4303b02b5da9c5ff6137%40thread.skype/Language%20-%20JavaScript%20-%20Reviews?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" rel="noreferrer noopener" title="https://teams.microsoft.com/l/channel/19%3a408c5f1322ee4303b02b5da9c5ff6137%40thread.skype/language%20-%20javascript%20-%20reviews?groupid=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantid=72f988bf-86f1-41af-91ab-2d7cd011db47" target="_blank">JS channel</a>
#### Management Plane
- [**`@azure-tools/typespec-ts.options.experimental-extensible-enums`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L32)
  - Allowed values: `true`

- [**`@azure-tools/typespec-ts.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L30)
  - Allowed values: strings that matches the regex `/^arm-[^\/]+$/`
  - example: `arm-aaa-bbb`

- [**`@azure-tools/typespec-ts.options.package-details.name`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L34)
  - Allowed values: strings that matches the regex `/^\@azure\/arm(?:-[a-z]+)+$/`
  - example: `@azure/arm-aaa-bbb`

#### Data Plane
- [**`@azure-tools/typespec-ts.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L33)
  - Allowed values: strings that matches the regex `/^(?:[a-z]+-)+rest$/`
  - example: `arm-aaa-rest`

- [**`@azure-tools/typespec-ts.options.package-details.name`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L35)
  - Allowed values: strings that matches the regex `/^\@azure-rest\/[a-z]+(?:-[a-z]+)*$/`
  - example: `@azure-rest/aaa-bbb`

### Python Sub Rules
> Please follow the below steps to configure. If you encounter any issues, please seek help in the <a href="https://teams.microsoft.com/l/channel/19%3A4175567f1e154a80ab5b88cbd22ea92f%40thread.skype/Language%20-%20Python%20-%20Reviews?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" rel="noreferrer noopener" title="https://teams.microsoft.com/l/channel/19%3A4175567f1e154a80ab5b88cbd22ea92f%40thread.skype/Language%20-%20Python%20-%20Reviews?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" target="_blank">python channel</a>
#### Management Plane
- [**`@azure-tools/typespec-python.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L19)
  - Allowed values: strings that matches the regex `/^azure-mgmt(-[a-z]+){1,2}$/`
  - example: `azure-mgmt-aaa`

- [**`@azure-tools/typespec-python.options.namespace`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L20)
  - Allowed values: strings that matches the regex `/^azure\.mgmt(\.[a-z]+){1,2}$/`
  - example: `azure.mgmt.aaa`

- [**`@azure-tools/typespec-python.options.generate-test`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L21)
  - Allowed values: `true`

- [**`@azure-tools/typespec-python.options.generate-sample`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L22)
  - Allowed values: `true`

#### Data Plane
- [**`@azure-tools/typespec-python.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L18)
  - Allowed values: strings that matches the regex `/^azure(-[a-z]+){1,3}$/`
  - example: `azure-aaa-bbb-ccc`

### Go Sub Rules
> Please follow the below steps to configure. If you encounter any issues, please seek help in the <a href="https://teams.microsoft.com/l/channel/19%3A104f00188bb64ef48d1b4d94ccb7a361%40thread.skype/Language%20-%20Go?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" rel="noreferrer noopener" title="https://teams.microsoft.com/l/channel/19%3A104f00188bb64ef48d1b4d94ccb7a361%40thread.skype/Language%20-%20Go?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" target="_blank">go channel</a>
#### Management Plane
- [**`@azure-tools/typespec-go.options.service-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L36)
  - Allowed values: strings that matches the regex `/^(\{output-dir\}\/)?sdk\/resourcemanager\/[^\/]*$/` or `undefined`
  - example: `{output-dir}/sdk/resourcemanager/contoso`, `undefined`

- [**`@azure-tools/typespec-go.options.emitter-output-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L37)
  - Allowed values: strings that matches the regex `/^(\{output-dir\}\/)?(\{service-dir\}|sdk\/resourcemanager\/)[^\/]*\/arm.*/`
  - example: `{service-dir}/armcontoso`

- [**`@azure-tools/typespec-go.options.module`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L38)
  - Allowed values: strings that matches the regex `/^github.com\/Azure\/azure-sdk-for-go\/.*$/` or `undefined`
  - example: `github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/contoso/armcontoso`, `undefined`

- [**`@azure-tools/typespec-go.options.containing-module`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L38)
  - Allowed values: strings that matches the regex `/^github.com\/Azure\/azure-sdk-for-go\/.*$/` or `undefined`
  - example: `github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/contoso/armcontoso`, `undefined`

- [**`@azure-tools/typespec-go.options.generate-samples`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L41)
  - Allowed values: `true`

- [**`@azure-tools/typespec-go.options.generate-fakes`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L42)
  - Allowed values: `true`

- [**`@azure-tools/typespec-go.options.head-as-boolean`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L43)
  - Allowed values: `true`

- [**`@azure-tools/typespec-go.options.inject-spans`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L44)
  - Allowed values: `true`

#### Data Plane
- [**`@azure-tools/typespec-go.options.emitter-output-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L45)
  - Allowed values: strings that matches the regex `/^(\{output-dir\}\/)?(\{service-dir\}|sdk\/).*\/az.*/`
  - example: `{service-dir}/azmanager`

- [**`@azure-tools/typespec-go.options.service-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L44)
  - Allowed values: strings that matches the regex `/^(\{output-dir\}\/)?sdk\/.*$/` or `undefined`
  - example: `{output-dir}/sdk/contosowidget`, `undefined`

- [**`@azure-tools/typespec-go.options.module`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L43)
  - Allowed values: strings that matches the regex `/^github.com\/Azure\/azure-sdk-for-go\/.*$/` or `undefined`
  - example: `github.com/Azure/azure-sdk-for-go/sdk/contosowidget/azmanager`, `undefined`

- [**`@azure-tools/typespec-go.options.containing-module`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L43)
  - Allowed values: strings that matches the regex `/^github.com\/Azure\/azure-sdk-for-go\/.*$/` or `undefined`
  - example: `github.com/Azure/azure-sdk-for-go/sdk/contosowidget/azmanager`, `undefined`

### Java Sub Rules

> Please follow the below steps to configure. If you encounter any issues, please seek help in the <a href="https://teams.microsoft.com/l/channel/19%3A5e673e41085f4a7eaaf20823b85b2b53%40thread.skype/Language%20-%20Java?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" rel="noreferrer noopener" title="https://teams.microsoft.com/l/channel/19%3A5e673e41085f4a7eaaf20823b85b2b53%40thread.skype/Language%20-%20Java?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" target="_blank">java channel</a>

#### Management Plane

- [**`@azure-tools/typespec-java.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L25)
  - Allowed values: strings that matches the regex `/^azure-resourcemanager-[^\/]+$/`
  - example: `azure-resourcemanager-servicename`

- [**`@azure-tools/typespec-java.options.namespace`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L26)
  - Allowed values: strings that matches the regex `/^com\.azure\.resourcemanager\.[^\.]+$/`
  - example: `com.azure.resourcemanager.servicename`

#### Data Plane

- [**`@azure-tools/typespec-java.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L38)
  - Allowed values: strings that matches the regex `/^azure(-\w+)+$/`
  - example: `azure-aaa`

### .Net Sub Rules

> Please follow the below steps to configure. If you encounter any issues, please seek help in the <a href="https://teams.microsoft.com/l/channel/19%3A7b87fb348f224b37b6206fa9d89a105b%40thread.skype/Language%20-%20DotNet?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" rel="noreferrer noopener" title="https://teams.microsoft.com/l/channel/19%3A7b87fb348f224b37b6206fa9d89a105b%40thread.skype/Language%20-%20DotNet?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47" target="_blank">.Net channel</a>

#### Management Plane

- [**`@azure-tools/typespec-csharp.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L14)
  - Allowed values: strings that matches the regex `/^Azure\.ResourceManager\./`
  - example: `Azure.ResourceManager.AAA`
- [**`@azure-tools/typespec-csharp.options.namespace`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L17)
  - Allowed values: `package-dir` or `{package-dir}`
  - example: `package-dir`, `Azure.ResourceManager.AAA`
- [**`@azure-tools/typespec-csharp.options.clear-output-folder`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.Management/tspconfig.yaml#L15)
  - Allowed values: `true`

#### Data Plane

- [**`@azure-tools/typespec-csharp.options.package-dir`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L24)
  - Allowed values: strings that start with `Azure.`
  - example: `Azure.aaa`
- [**`@azure-tools/typespec-csharp.options.namespace`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L26)
  - Allowed values: `package-dir` or `{package-dir}`
  - example: `package-dir`, `Azure.aaa`
- [**`@azure-tools/typespec-csharp.options.clear-output-folder`**](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml#L25)
  - Allowed values: `true`
