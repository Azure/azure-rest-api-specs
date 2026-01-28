import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Cdn;

// Change the interface name to avoid naming conflicts for CSharp CodeGen, issue tracked here: https://github.com/Azure/azure-sdk-for-net/issues/54327
@@clientName(EdgeActions, "EdgeActionsMgmtClient", "csharp");

@@clientName(EdgeActionExecutionFilterProperties.lastUpdateTime,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(EdgeActionVersionProperties.lastPackageUpdateTime,
  "LastPackageUpdatedOn",
  "csharp"
);
@@clientName(ProvisioningState, "EdgeActionProvisioningState", "csharp");
@@clientName(SkuType, "EdgeActionSkuType", "csharp");
@@clientName(VersionCode, "EdgeActionVersionCode", "csharp");
@@clientName(EdgeActions.addAttachment::parameters.body, "content", "csharp");
@@clientName(EdgeActions.deleteAttachment::parameters.body,
  "content",
  "csharp"
);
@@clientName(EdgeActionVersions.deployVersionCode::parameters.body,
  "content",
  "csharp"
);

@@clientName(Microsoft.Cdn, "EdgeActionsMgmtClient", "python");
