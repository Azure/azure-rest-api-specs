# Add TypeSpec Configuration for Java SDK

See [Use SDK Automation from REST API specifications](https://github.com/Azure/azure-sdk-for-java/wiki/TypeSpec-Java-Quickstart#use-sdk-automation-from-rest-api-specifications) in TypeSpec Java QuickStart.

`flavor` is always `azure` for Azure SDK.

## Example for Java data-plane SDK

`namespace` always starts with `com.azure` for Azure Java data-plane SDK. [Review process](https://azure.github.io/azure-sdk/policies_reviewprocess.html).

```yaml
  "@azure-tools/typespec-java":
    emitter-output-dir: "{output-dir}/{service-dir}/azure-ai-openai"
    flavor: azure
    namespace: "com.azure.ai.openai"
```

## Example for Java management-plane SDK

`namespace` always starts with `com.azure.resourcemanager` for Azure Java management-plane SDK. [Review process](https://eng.ms/docs/products/azure-developer-experience/develop/namespace-review).

`service-name` is the name of the service. It is used for SDK class name and documentations.

```yaml
  "@azure-tools/typespec-java":
    emitter-output-dir: "{output-dir}/{service-dir}/azure-resourcemanager-standbypool"
    flavor: "azure"
    namespace: "com.azure.resourcemanager.standbypool"
    service-name: "Standby Pool"
```

# Add AutoRest Configuration for Java SDK 

AutoRest configuration should only be used for management-plane SDK, when there is no TypeSpec on your resource provider.

One can copy the [sample readme.java.md file](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/samplefiles/readme.java.md).

It is recommended to add a `service-name` to the readme.java.md file.

Service does not need to configure the namespace in readme.java.md. The namespace is configured in [api-specs.yaml in SDK repository](https://github.com/Azure/azure-sdk-for-java/blob/main/eng/mgmt/automation/api-specs.yaml) that would be automatically updated upon SDK pull request. 
