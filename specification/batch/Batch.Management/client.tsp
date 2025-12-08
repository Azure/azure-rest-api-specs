import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Batch, "BatchManagementClient", "javascript");

// Java compat renames for existing management SDK surface
@@clientName(Microsoft.Batch.IPAddressProvisioningType,
  "IpAddressProvisioningType",
  "java"
);
@@clientName(Microsoft.Batch.PublicIPAddressConfiguration,
  "PublicIpAddressConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.IPRule, "IpRule", "java");
@@clientName(Microsoft.Batch.IPRuleAction, "IpRuleAction", "java");
@@clientName(Microsoft.Batch.NFSMountConfiguration,
  "NfsMountConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.CifsMountConfiguration,
  "CifsMountConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.NetworkConfiguration.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.CifsMountConfiguration.userName,
  "username",
  "java"
);
@@clientName(Microsoft.Batch.AccessRulePropertiesSubscriptionsItem,
  "AccessRulePropertiesSubscriptionsItem"
);
@@clientName(Microsoft.Batch.ContainerRegistry.username, "username", "java");
@@clientName(Microsoft.Batch.UserIdentity.userName, "username", "java");
