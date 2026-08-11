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
