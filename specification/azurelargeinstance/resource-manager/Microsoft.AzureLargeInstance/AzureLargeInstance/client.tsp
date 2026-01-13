import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureLargeInstance;

@@clientName(AzureLargeStorageInstance, "LargeStorageInstance", "csharp");
@@clientName(AzureLargeInstance, "LargeInstance", "csharp");
@@clientName(AzureLargeInstanceForcePowerState,
  "LargeInstanceForcePowerState",
  "csharp"
);
@@clientName(AzureLargeInstanceHardwareTypeNamesEnum,
  "LargeInstanceHardwareTypeName",
  "csharp"
);
@@clientName(AzureLargeInstanceHardwareTypeNamesEnum.Cisco_UCS,
  "CiscoUcs",
  "csharp"
);
@@clientName(AzureLargeInstanceHardwareTypeNamesEnum.HPE, "Hpe", "csharp");
@@clientName(AzureLargeInstanceHardwareTypeNamesEnum.SDFLEX,
  "Sdflex",
  "csharp"
);
@@clientName(AzureLargeInstancePowerStateEnum,
  "LargeInstancePowerState",
  "csharp"
);
@@clientName(AzureLargeInstanceProvisioningStatesEnum,
  "LargeInstanceProvisioningState",
  "csharp"
);
@@clientName(AzureLargeInstanceSizeNamesEnum,
  "LargeInstanceSizeName",
  "csharp"
);
@@clientName(Disk, "LargeInstanceDisk", "csharp");
@@clientName(ForceState, "LargeInstanceForceState", "csharp");
@@clientName(HardwareProfile, "LargeInstanceHardwareProfile", "csharp");
@@clientName(IpAddress, "LargeInstanceIPAddress", "csharp");
@@clientName(NetworkProfile, "LargeInstanceNetworkProfile", "csharp");
@@clientName(OsProfile, "LargeInstanceOSProfile", "csharp");
@@clientName(StorageBillingProperties,
  "LargeInstanceStorageBillingProperties",
  "csharp"
);
@@clientName(StorageProfile, "LargeInstanceStorageProfile", "csharp");
@@clientName(StorageProperties, "LargeInstanceStorageProperties", "csharp");
@@clientName(ProvisioningState,
  "LargeStorageInstanceProvisioningState",
  "csharp"
);
@@clientName(AzureLargeStorageInstanceTagsUpdate.tags, "Tags", "csharp");
@@clientName(ForceState.forceState, "ForceState ", "csharp");
