# Add TypeSpec Configuration for Java SDK

See [Use SDK Automation from REST API specifications](https://github.com/Azure/azure-sdk-for-java/wiki/TypeSpec-Java-Quickstart#use-sdk-automation-from-rest-api-specifications) in TypeSpec Java QuickStart.

`flavor` is always `azure` for Azure SDK.
`examples-directory` is same as that in e.g. typespec-autorest emitter.

## Example for Java data-plane SDK

`namespace` always starts with `com.azure` for Azure Java data-plane SDK.

`package-dir` should follow the pattern of the `namespace`.

```yaml
  "@azure-tools/typespec-java":
    package-dir: "azure-ai-openai"
    flavor: azure
    namespace: "com.azure.ai.openai"
    examples-directory: "examples"
```

## Example for Java management-plane SDK

`namespace` always starts with `com.azure.resourcemanager` for Azure Java management-plane SDK.

`package-dir` should follow the pattern of the `namespace`.

```yaml
  "@azure-tools/typespec-java":
    package-dir: "azure-resourcemanager-standbypool"
    flavor: "azure"
    namespace: "com.azure.resourcemanager.standbypool"
    service-name: "Standby Pool"
    examples-directory: "examples"
```

# Add AutoRest Configuration of Java SDK 

AutoRest configuration should only be used for management-plane SDK, when there is no TypeSpec on your resource provider.

Typically, one does not need to configure a "readme.java.md" for Azure Java management-plane SDK.
Particularly, the configure on namespace is in [api-specs.yaml in SDK repository](https://github.com/Azure/azure-sdk-for-java/blob/main/eng/mgmt/automation/api-specs.yaml) that would be automatically updated upon SDK pull request. 
