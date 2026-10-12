import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ManufacturingPlatform;

@@clientName(MdsResource, "ManufacturingDataService", "csharp");
@@clientName(
  MdsResourceProperties,
  "ManufacturingDataServiceProperties",
  "csharp"
);
@@clientName(
  ApplicationVersion,
  "ManufacturingDataServiceApplicationVersion",
  "csharp"
);
@@clientName(
  AvailableVersionListResult,
  "ManufacturingDataServiceAvailableVersionListResult",
  "csharp"
);
@@clientName(
  ProvisioningState,
  "ManufacturingPlatformProvisioningState",
  "csharp"
);
@@clientName(ResourceState, "ManufacturingPlatformResourceState", "csharp");
@@clientName(RedundancyState, "ManufacturingPlatformRedundancyState", "csharp");
@@clientName(
  MoboBrokerResource,
  "ManagedOnBehalfOfBrokerResourceInfo",
  "csharp"
);
@@clientName(
  ManagedOnBehalfOfConfiguration.moboBrokerResources,
  "BrokerResources",
  "csharp"
);

@@alternateType(AksProfile.id, armResourceIdentifier, "csharp");
@@alternateType(StorageProfile.id, armResourceIdentifier, "csharp");
@@alternateType(DatabaseProfile.cosmosId, armResourceIdentifier, "csharp");
@@alternateType(AdxProfile.id, armResourceIdentifier, "csharp");
@@alternateType(RedisProfile.id, armResourceIdentifier, "csharp");
@@alternateType(MonitoringProfile.id, armResourceIdentifier, "csharp");
@@alternateType(EventHubProfile.adxInstanceId, armResourceIdentifier, "csharp");
@@alternateType(FunctionAppProfile.id, armResourceIdentifier, "csharp");
@@alternateType(OpenAIProfile.id, armResourceIdentifier, "csharp");
@@alternateType(MoboBrokerResource.id, armResourceIdentifier, "csharp");
@@alternateType(UserManagedOpenAIProfile.id, armResourceIdentifier, "csharp");

@@alternateType(MdsResourceProperties.aadApplicationId, uuid, "csharp");
@@alternateType(MdsResourceProperties.aksAdminGroupId, uuid, "csharp");
