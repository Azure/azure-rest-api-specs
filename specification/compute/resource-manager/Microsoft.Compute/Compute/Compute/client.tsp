import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Compute;

@@clientName(
  NetworkApiVersion.`2020-11-01`,
  "TwoThousandTwenty1101",
  "go, javascript"
);
@@clientName(
  NetworkApiVersion.`2022-11-01`,
  "TwoThousandTwentyTwo1101",
  "go, javascript"
);

@@alternateType(
  VirtualMachineScaleSetStorageProfile.diskControllerType,
  string,
  "go"
);
@@alternateType(
  VirtualMachineScaleSetUpdateStorageProfile.diskControllerType,
  string,
  "go"
);

@@clientName(VirtualMachineSizeTypes.Standard_B1ms, "StandardB1Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B2ms, "StandardB2Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B4ms, "StandardB4Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B8ms, "StandardB8Ms", "go");
@@clientName(
  VirtualMachineSizeTypes.`Standard_M128-32ms`,
  "StandardM12832Ms",
  "go"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_M128-64ms`,
  "StandardM12864Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M128ms, "StandardM128Ms", "go");
@@clientName(
  VirtualMachineSizeTypes.`Standard_M64-16ms`,
  "StandardM6416Ms",
  "go"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_M64-32ms`,
  "StandardM6432Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M64ms, "StandardM64Ms", "go");

@@alternateType(AdditionalUnattendContent.passName, "OobeSystem", "go");
@@alternateType(
  AdditionalUnattendContent.componentName,
  "Microsoft-Windows-Shell-Setup",
  "go"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.Operation,
  "OperationValue",
  "go"
);

// Property case changes: diskIOPSReadWrite -> diskIopsReadWrite (retain old Java name)
@@clientName(
  VirtualMachineScaleSetDataDisk.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DataDisk.diskIOPSReadWrite, "diskIopsReadWrite", "java");

// Property case changes: enableIPForwarding -> enableIpForwarding (retain old Java name)
@@clientName(
  VirtualMachineScaleSetNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(
  VirtualMachineScaleSetUpdateNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.enableIPForwarding,
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
@@clientName(
  VirtualMachineScaleSetPublicIPAddressConfiguration,
  "VirtualMachineScaleSetPublicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings,
  "VirtualMachineScaleSetPublicIpAddressConfigurationDnsSettings",
  "java"
);
@@clientName(
  VirtualMachineScaleSetIPConfiguration,
  "VirtualMachineScaleSetIpConfiguration",
  "java"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfiguration,
  "VirtualMachineScaleSetUpdateIpConfiguration",
  "java"
);
@@clientName(
  VirtualMachineScaleSetUpdatePublicIPAddressConfiguration,
  "VirtualMachineScaleSetUpdatePublicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfiguration,
  "VirtualMachineNetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(
  VirtualMachinePublicIPAddressConfiguration,
  "VirtualMachinePublicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachinePublicIPAddressDnsSettingsConfiguration,
  "VirtualMachinePublicIpAddressDnsSettingsConfiguration",
  "java"
);
@@clientName(RestorePointSourceVMOSDisk, "RestorePointSourceVmosDisk", "java");

// Property case changes in VM size properties: vCPUs* -> vCpus*
@@clientName(VMSizeProperties.vCPUsAvailable, "vCpusAvailable", "java");
@@clientName(VMSizeProperties.vCPUsPerCore, "vCpusPerCore", "java");

// Property case change: ultraSSDEnabled -> ultraSsdEnabled
@@clientName(AdditionalCapabilities.ultraSSDEnabled, "ultraSsdEnabled", "java");
@@clientName(
  DedicatedHostGroupPropertiesAdditionalCapabilities.ultraSSDEnabled,
  "ultraSsdEnabled",
  "java"
);

// Scale set IP configuration properties
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// Scale set public IP configuration properties
@@clientName(
  VirtualMachineScaleSetPublicIPAddressConfigurationProperties.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(
  VirtualMachineScaleSetPublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);

// Scale set UPDATE IP configuration properties
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// Scale set UPDATE public IP configuration properties
@@clientName(
  VirtualMachineScaleSetUpdatePublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);

// Network interface IP configuration properties
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// VM-level public IP address configuration properties
@@clientName(
  VirtualMachinePublicIPAddressConfigurationProperties.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(
  VirtualMachinePublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);
@@clientName(
  VirtualMachinePublicIPAddressConfigurationProperties.publicIPAllocationMethod,
  "publicIpAllocationMethod",
  "java"
);

@@clientName(
  VirtualMachineScaleSets.getOSUpgradeHistory,
  "listOSUpgradeHistory",
  "javascript"
);

// =====================================================================
// Fix: Python emits the `\W` in `(Regex match [\W_])` directly into the
// generated docstring, producing a SyntaxWarning on Python 3.12+
// ("invalid escape sequence '\W'"). Escape `\W` to `\\W` in the Python
// client doc only so the generated docstring contains a valid escape.
// See https://github.com/Azure/azure-sdk-for-python/issues/47011
// =====================================================================
const adminPasswordPythonDoc = "Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)";
@@clientDoc(OSProfile.adminPassword,
  adminPasswordPythonDoc,
  DocumentationMode.replace,
  "python"
);
@@clientDoc(VirtualMachineScaleSetOSProfile.adminPassword,
  adminPasswordPythonDoc,
  DocumentationMode.replace,
  "python"
);
@@clientDoc(OSProfileProvisioningData.adminPassword,
  adminPasswordPythonDoc,
  DocumentationMode.replace,
  "python"
);
