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
  "SDFlex",
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
@@clientName(Disk.diskSizeGB, "DiskSizeInGB", "csharp");
@@clientName(ForceState, "LargeInstanceForceState", "csharp");
@@clientName(HardwareProfile, "LargeInstanceHardwareProfile", "csharp");
@@clientName(HardwareProfile.azureLargeInstanceSize,
  "LargeInstanceSize",
  "csharp"
);
@@clientName(IpAddress, "LargeInstanceIPAddress", "csharp");
@@clientName(NetworkProfile, "LargeInstanceNetworkProfile", "csharp");
@@clientName(OsProfile, "LargeInstanceOSProfile", "csharp");
@@clientName(OsProfile.osType, "OSType", "csharp");
@@clientName(StorageBillingProperties,
  "LargeInstanceStorageBillingProperties",
  "csharp"
);
@@clientName(StorageProfile, "LargeInstanceStorageProfile", "csharp");
@@clientName(StorageProfile.nfsIpAddress, "NfsIPAddress", "csharp");
@@clientName(StorageProfile.osDisks, "OSDisk", "csharp");
@@clientName(StorageProperties, "LargeInstanceStorageProperties", "csharp");
@@clientName(ProvisioningState,
  "LargeStorageInstanceProvisioningState",
  "csharp"
);
@@clientName(AzureLargeStorageInstanceProperties,
  "LargeStorageInstanceProperties",
  "csharp"
);
@@clientName(AzureLargeInstanceProperties, "LargeInstanceProperties", "csharp");
@@clientName(AzureLargeInstanceProperties.hwRevision,
  "HardwareRevision",
  "csharp"
);
@@clientName(AzureLargeInstanceProperties.azureLargeInstanceId,
  "LargeInstanceId",
  "csharp"
);
@@clientName(AzureLargeInstanceProperties.osProfile, "OSProfile", "csharp");
@@clientName(AzureLargeStorageInstanceTagsUpdate.tags, "Tags", "csharp");
@@clientName(ForceState.forceState, "ForceState", "csharp");
@@clientName(IpAddress.ipAddress, "IPAddress", "csharp");
