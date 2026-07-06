import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.HanaOnAzure,
  "HanaManagementClient",
  "javascript,python"
);

@@clientName(Microsoft.HanaOnAzure.ProviderInstanceProperties.properties,
  "ProviderProperties",
  "csharp"
);

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(Microsoft.HanaOnAzure.Operation,
  "HanaOnAzureOperationInfo",
  "csharp"
);
