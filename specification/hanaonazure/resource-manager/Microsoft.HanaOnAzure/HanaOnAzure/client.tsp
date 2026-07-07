import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HanaOnAzure;

@@clientName(
  Microsoft.HanaOnAzure,
  "HanaManagementClient",
  "javascript,python"
);

@@clientName(
  ProviderInstanceProperties.properties,
  "ProviderProperties",
  "csharp"
);

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(Operation, "HanaOnAzureOperationInfo", "csharp");

@@clientName(HanaProvisioningStatesEnum, "HanaProvisioningState", "csharp");

@@clientName(Display, "HanaOnAzureOperationDisplay", "csharp");
