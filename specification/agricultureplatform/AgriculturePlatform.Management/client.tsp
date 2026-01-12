import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
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
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.cosmosDbResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AgriServiceConfig.cosmosDbResourceId,
  "cosmosDBResourceId",
  "csharp"
);
@@alternateType(AgriServiceConfig.storageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.keyVaultResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AgriServiceConfig.redisCacheResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(MoboBrokerResource.id, armResourceIdentifier, "csharp");

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}

@@alternateType(ManagedOnBehalfOfConfiguration.moboBrokerResources,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
