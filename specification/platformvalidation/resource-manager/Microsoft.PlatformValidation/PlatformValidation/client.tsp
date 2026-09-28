import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.PlatformValidation,
  "PlatformValidationMgmtClient",
  "python"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.MoboBrokerResource,
  "PlatformValidationMoboBrokerResourceInfo",
  "csharp"
);
