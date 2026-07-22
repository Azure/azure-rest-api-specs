import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
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
  armResourceIdentifier,
  "csharp"
);

@@alternateType(
  SapMonitorProperties.logAnalyticsWorkspaceArmId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(
  SapMonitorProperties.monitorSubnet,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(SapMonitorProperties.logAnalyticsWorkspaceId, uuid, "csharp");

@@clientName(ProviderInstanceProperties.type, "providerType", "csharp");

@@access(Operations.list, Access.internal, "csharp");

@@clientName(Operation, "HanaOnAzureOperationInfo", "csharp");

@@clientName(HanaProvisioningStatesEnum, "HanaProvisioningState", "csharp");

@@clientName(Display, "HanaOnAzureOperationDisplay", "csharp");
