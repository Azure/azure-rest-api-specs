# Service Fabric Client REST API 

> see https://aka.ms/autorest

[Service Fabric](http://aka.ms/ServiceFabric) is a distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable micro-services. 

Service Fabric Client APIs allows deploying and managing micro-services based applications and containers in a Service Fabric cluster on Azure, on-premise, on local development machine or in other cloud.

This folder provides the Swagger specification for Service Fabric Client APIs.

## Configuration
Following are the settings for using this specification with [AutoRest](https://aka.ms/autorest) tool to validation and optionally generate SDK.

### Azure Validator Suppressions
Service Fabric Client APIs allows deploying and managing micro-services based applications and containers in a Service Fabric cluster on Azure, on-premise, on local development machine or in other cloud. As a result the following azure validator rules do not apply to these APIs.

Suppressed Rule | Reason
----------------|--------
R1001 OperationIdNounVerb | The operation names follow the Service Fabric Client API operation names from the existing .NET SDK
R1003 ListInOperationName | The operation names follow the Service Fabric Client API operation names from the existing .NET SDK
R1005 GetInOperationName | The operation names follow the Service Fabric Client API operation names from the existing .NET SDK
R1006 PutInOperationName | The operation names follow the Service Fabric Client API operation names from the existing .NET SDK
R1011 HttpsSupportedScheme | Service Fabric clusters are owned by the users and they can be configured to have a secure or un-secure client connection endpoint. 
R2007 LongRunningOperationsWithLongRunningExtension | Service Fabric platform has already established pattern for paged responses based on ContinuationToken parameter. 
R2054 SecurityDefinitionsStructure | Service Fabric clusters support various security mechanism for the REST endpoint, this includes certificate, Kerberos, AD, AAD and others. The documentation for the REST API includes information on how to authenticate to the cluster endpoint secured with different mechanisms. 
R2064 LROStatusCodesReturnTypeSchema | Service Fabric platform uses query based mechanism for some of the long running operations.
R2066 PostOperationIdContainsUrlVerb | The URL scheme for Service Fabric does not follow Azure Service rules. Service Fabric supports various functions on different entities that are modeled using POST.
R3012 APIVersionPattern | The URL scheme for Service Fabric does not follow Azure Service rules. Service Fabric supports various functions on different entities that are modeled using POST.
R3016 DefinitionsPropertiesNamesCamelCase | The property names for Service Fabric follow the naming scheme of existing property names in our client SDK and concepts. 
R3017 GuidUsage | The IDs of the service partition in Service Fabric are GUIDs. 
R3018 EnumInsteadOfBoolean | The boolean properties are actually boolean value in the Service Fabric's application model.
R3023 OperationsAPIImplementation | Service Fabric client API is not an ARM based API and hence this rule is not applicable.
R2022 XmsExamplesRequired  | There are a lot of APIs that does not have the example. While it is being worked upon disabling this to ensure that we catch and fix other violations
OV108 Example Validations | There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.
OV109 Example Validations | There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off.

```yaml
model-validator: true 
semantic-validator: true
azure-validator: true
directive:
  suppress:
    - R1001
    - R1003
    - R1005
    - R1006
    - R1011
    - R2007
    - R2054 
    - R2064
    - R2066
    - R3012
    - R3016
    - R3017
    - R3018
    - R3023
    - R2022
    - OAV108
    - OAV109
```
