import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.AzureStackHCI, "AzureStackHCIVmClient", "python");
@@clientName(Microsoft.AzureStackHCI, "AzureStackHciVmMgmtClient", "java");
@@clientName(Microsoft.AzureStackHCI,
  "AzureStackHCIVMManagementClient",
  "javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImageVersion.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Subnet.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RouteTable.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Route.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(GalleryImageVersion.properties);

@@clientName(Microsoft.AzureStackHCI,
  "AzureStackHCIVMManagementClient",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Route,
  "AzureStackHCIVMNetworkingRoute",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Subnet,
  "AzureStackHCIVMNetworkingSubnet",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Status, "AzureStackHCIVMStatus", "csharp");
@@clientName(Microsoft.AzureStackHCI.StatusTypes,
  "AzureStackHCIVMStatusType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SecurityTypes,
  "AzureStackHCIVMSecurityType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.IPPool,
  "AzureStackHCIVMNetworkingIPPool",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ProvisioningStateEnum,
  "AzureStackHCIVMProvisioningStateEnum",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.StatusLevelTypes,
  "AzureStackHCIVMStatusLevelTypes",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PowerStateEnum,
  "AzureStackHCIVMPowerStateEnum",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ProvisioningAction,
  "AzureStackHCIVMProvisioningAction",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Identity,
  "AzureStackHCIVMIdentity",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.TagsObject,
  "AzureStackHCIVMTags",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SshConfiguration,
  "AzureStackHCIVMOsProfileSshConfiguration",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SshPublicKey,
  "AzureStackHCIVMOsProfileSshPublicKey",
  "csharp"
);
