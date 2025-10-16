import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(NetworkApiVersion.`2020-11-01`, "TwoThousandTwenty1101", "go");
@@clientName(NetworkApiVersion.`2022-11-01`, "TwoThousandTwentyTwo1101", "go");

@@alternateType(VirtualMachineScaleSetStorageProfile.diskControllerType,
  string,
  "go"
);
@@alternateType(VirtualMachineScaleSetUpdateStorageProfile.diskControllerType,
  string,
  "go"
);

@@clientName(VirtualMachineSizeTypes.Standard_B1ms, "StandardB1Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B2ms, "StandardB2Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B4ms, "StandardB4Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B8ms, "StandardB8Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M128-32ms`,
  "StandardM12832Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M128-64ms`,
  "StandardM12864Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M128ms, "StandardM128Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M64-16ms`,
  "StandardM6416Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M64-32ms`,
  "StandardM6432Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M64ms, "StandardM64Ms", "go");

// Property case changes: diskIOPSReadWrite -> diskIopsReadWrite (retain old Java name)
@@clientName(VirtualMachineScaleSetDataDisk.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DataDisk.diskIOPSReadWrite, "diskIopsReadWrite", "java");

// Property case changes: enableIPForwarding -> enableIpForwarding (retain old Java name)
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdateNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);

// Model name capitalization changes (retain previous Java model names)
@@clientName(PublicIPAddressSku, "PublicIpAddressSku", "java");

@@clientName(PublicIPAddressSkuName, "PublicIpAddressSkuName", "java");
@@clientName(PublicIPAddressSkuTier, "PublicIpAddressSkuTier", "java");
@@clientName(PublicIPAllocationMethod, "PublicIpAllocationMethod", "java");
@@clientName(IPVersion, "IpVersion", "java");
@@clientName(IPVersions, "IpVersions", "java");
@@clientName(VirtualMachineScaleSetPublicIPAddressConfiguration,
  "VirtualMachineScaleSetPublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings,
  "VirtualMachineScaleSetPublicIpAddressConfigurationDnsSettings",
  "java"
);
@@clientName(VirtualMachineScaleSetIPConfiguration,
  "VirtualMachineScaleSetIpConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdateIPConfiguration,
  "VirtualMachineScaleSetUpdateIpConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdatePublicIPAddressConfiguration,
  "VirtualMachineScaleSetUpdatePublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineNetworkInterfaceIPConfiguration,
  "VirtualMachineNetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressConfiguration,
  "VirtualMachinePublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressDnsSettingsConfiguration,
  "VirtualMachinePublicIpAddressDnsSettingsConfiguration",
  "java"
);
@@clientName(RestorePointSourceVMOSDisk, "RestorePointSourceVmosDisk", "java");

// Property case changes in VM size properties: vCPUs* -> vCpus*
@@clientName(VMSizeProperties.vCPUsAvailable, "vCpusAvailable", "java");
@@clientName(VMSizeProperties.vCPUsPerCore, "vCpusPerCore", "java");

// Property case change: ultraSSDEnabled -> ultraSsdEnabled
@@clientName(AdditionalCapabilities.ultraSSDEnabled, "ultraSsdEnabled", "java");
@@clientName(DedicatedHostGroupPropertiesAdditionalCapabilities.ultraSSDEnabled,
  "ultraSsdEnabled",
  "java"
);
