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

@@alternateType(
  SapMonitorProperties.logAnalyticsWorkspaceArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  SapMonitorProperties.monitorSubnet,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  SapMonitorProperties.logAnalyticsWorkspaceId,
  Azure.Core.uuid,
  "csharp"
);

@@clientName(ProviderInstanceProperties.type, "providerType", "csharp");

@@access(Operations.list, Access.internal, "csharp");

@@clientName(Operation, "HanaOnAzureOperationInfo", "csharp");

@@clientName(HanaProvisioningStatesEnum, "HanaProvisioningState", "csharp");

@@clientName(Display, "HanaOnAzureOperationDisplay", "csharp");
