import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AgriculturePlatform;

@@clientName(Microsoft.AgriculturePlatform,
  "AgriculturePlatformMgmtClient",
  "python,java"
);

@@clientNamespace(Microsoft.AgriculturePlatform,
  "com.azure.resourcemanager.agricultureplatform",
  "java"
);

// csharp
@@clientName(AgriServiceResource, "AgricultureService", "csharp");
@@clientName(AgriServiceResourceProperties,
  "AgricultureServiceProperties",
  "csharp"
);
@@clientName(ProvisioningState,
  "AgriculturePlatformProvisioningState",
  "csharp"
);
@@clientName(Solution, "AgricultureSolution", "csharp");
@@clientName(AgriServiceConfig, "AgricultureServiceConfig", "csharp");
@@alternateType(AgriServiceConfig.appServiceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.cosmosDbResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AgriServiceConfig.cosmosDbResourceId,
  "cosmosDBResourceId",
  "csharp"
);
@@alternateType(AgriServiceConfig.storageAccountResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.keyVaultResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.redisCacheResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(MoboBrokerResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
