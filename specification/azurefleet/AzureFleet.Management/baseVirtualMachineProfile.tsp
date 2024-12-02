import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace Microsoft.AzureFleet;

/**
 * Describes the base virtual machine profile for fleet
 */
model BaseVirtualMachineProfile {
  /**
   * Specifies the operating system settings for the virtual machines in the scale
   * set.
   */
  osProfile?: VirtualMachineScaleSetOSProfile;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: VirtualMachineScaleSetStorageProfile;

  /**
   * Specifies properties of the network interfaces of the virtual machines in the
   * scale set.
   */
  networkProfile?: VirtualMachineScaleSetNetworkProfile;

  /**
   * Specifies the Security related profile settings for the virtual machines in the
   * scale set.
   */
  securityProfile?: SecurityProfile;

  /**
   * Specifies the boot diagnostic settings state.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Specifies a collection of settings for extensions installed on virtual machines
   * in the scale set.
   */
  extensionProfile?: VirtualMachineScaleSetExtensionProfile;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises.
   * <br><br> Possible values for Windows Server operating system are: <br><br>
   * Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux
   * Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS
   * (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for
   * Windows
   * Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing)
   * <br><br> [Azure Hybrid Use Benefit for Linux
   * Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux)
   * <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the virtual machines in the scale set, which must be base-64
   * encoded. Customer should not pass any secrets in here. Minimum api-version:
   * 2021-03-01.
   */
  userData?: string;

  /**
   * Specifies the capacity reservation related details of a scale set. Minimum
   * api-version: 2021-04-01.
   */
  capacityReservation?: CapacityReservationProfile;

  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  applicationProfile?: ApplicationProfile;

  /**
   * Specifies the hardware profile related details of a scale set. Minimum
   * api-version: 2021-11-01.
   */
  hardwareProfile?: VirtualMachineScaleSetHardwareProfile;

  /**
   * Specifies the service artifact reference id used to set same image version for
   * all virtual machines in the scale set when using 'latest' image version.
   * Minimum api-version: 2022-11-01
   */
  serviceArtifactReference?: ServiceArtifactReference;

  /**
   * Specifies the security posture to be used for all virtual machines in the scale
   * set. Minimum api-version: 2023-03-01
   */
  securityPostureReference?: SecurityPostureReference;

  /**
   * Specifies the time in which this VM profile for the Virtual Machine Scale Set
   * was created. Minimum API version for this property is 2023-09-01. This value
   * will be added to VMSS Flex VM tags when creating/updating the VMSS VM Profile
   * with minimum api-version 2023-09-01. Examples: "2024-07-01T00:00:01.1234567+00:00"
   */
  @visibility("read")
  timeCreated?: utcDateTime;
}

/**
 * Describes a virtual machine scale set OS profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetOSProfile {
  /**
   * Specifies the computer name prefix for all of the virtual machines in the scale
   * set. Computer name prefixes must be 1 to 15 characters long.
   */
  computerNamePrefix?: string;

  /**
   * Specifies the name of the administrator account. <br><br> **Windows-only
   * restriction:** Cannot end in "." <br><br> **Disallowed values:**
   * "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3",
   * "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup",
   * "console", "david", "guest", "john", "owner", "root", "server", "sql",
   * "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5".
   * <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length
   * (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters
   */
  adminUsername?: string;

  @doc("""
    Specifies the password of the administrator account. <br><br> **Minimum-length
    (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters
    <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length
    (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4
    conditions below need to be fulfilled <br> Has lower characters <br>Has upper
    characters <br> Has a digit <br> Has a special character (Regex match [\\W_])
    <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\",
    \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\",
    \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to
    reset the Remote Desktop service or its login password in a Windows
    VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp)
    <br><br> For resetting root password, see [Manage users, SSH, and check or
    repair disks on Azure Linux VMs using the VMAccess
    Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
    """)
  @visibility("create", "update")
  @secret
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string
   * is decoded to a binary array that is saved as a file on the Virtual Machine.
   * The maximum length of the binary array is 65535 bytes. For using cloud-init for
   * your VM, see [Using cloud-init to customize a Linux VM during
   * creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init)
   */
  @visibility("create", "update")
  @secret
  customData?: string;

  /**
   * Specifies Windows operating system settings on the virtual machine.
   */
  windowsConfiguration?: WindowsConfiguration;

  /**
   * Specifies the Linux operating system settings on the virtual machine. For a
   * list of supported Linux distributions, see [Linux on Azure-Endorsed
   * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
   */
  linuxConfiguration?: LinuxConfiguration;

  /**
   * Specifies set of certificates that should be installed onto the virtual
   * machines in the scale set. To install certificates on a virtual machine it is
   * recommended to use the [Azure Key Vault virtual machine extension for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "id exists inside sourceVault"
  @OpenAPI.extension("x-ms-identifiers", ["sourceVault/id"])
  secrets?: VaultSecretGroup[];

  /**
   * Specifies whether extension operations should be allowed on the virtual machine
   * scale set. This may only be set to False when no extensions are present on the
   * virtual machine scale set.
   */
  allowExtensionOperations?: boolean;

  /**
   * Optional property which must either be set to True or omitted.
   */
  requireGuestProvisionSignal?: boolean;
}

/**
 * Specifies Windows operating system settings on the virtual machine.
 */
model WindowsConfiguration {
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, it is set to
   * true by default. This will ensure that VM Agent is installed on the VM so that
   * extensions can be added to the VM later.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  provisionVMAgent?: boolean;

  /**
   * Indicates whether Automatic Updates is enabled for the Windows virtual machine.
   * Default value is true. For virtual machine scale sets, this property can be
   * updated and updates will take effect on OS reprovisioning.
   */
  enableAutomaticUpdates?: boolean;

  /**
   * Specifies the time zone of the virtual machine. e.g. "Pacific Standard Time".
   * Possible values can be
   * [TimeZoneInfo.Id](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.id?#System_TimeZoneInfo_Id)
   * value from time zones returned by
   * [TimeZoneInfo.GetSystemTimeZones](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.getsystemtimezones).
   */
  timeZone?: string;

  /**
   * Specifies additional base-64 encoded XML formatted information that can be
   * included in the Unattend.xml file, which is used by Windows Setup.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  additionalUnattendContent?: AdditionalUnattendContent[];

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Windows.
   */
  patchSettings?: PatchSettings;

  /**
   * Specifies the Windows Remote Management listeners. This enables remote Windows
   * PowerShell.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  winRM?: WinRMConfiguration;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Windows virtual
   * machine. Default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  enableVMAgentPlatformUpdates?: boolean;
}

/**
 * Specifies additional XML formatted information that can be included in the
 * Unattend.xml file, which is used by Windows Setup. Contents are defined by
 * setting name, component name, and the pass in which the content is applied.
 */
model AdditionalUnattendContent {
  /**
   * The pass name. Currently, the only allowable value is OobeSystem.
   */
  passName?: "OobeSystem";

  /**
   * The component name. Currently, the only allowable value is
   * Microsoft-Windows-Shell-Setup.
   */
  componentName?: "Microsoft-Windows-Shell-Setup";

  /**
   * Specifies the name of the setting to which the content applies. Possible values
   * are: FirstLogonCommands and AutoLogon.
   */
  settingName?: SettingNames;

  /**
   * Specifies the XML formatted content that is added to the unattend.xml file for
   * the specified path and component. The XML must be less than 4KB and must
   * include the root element for the setting or feature that is being inserted.
   */
  @visibility("create", "update")
  @secret
  content?: string;
}

/**
 * Specifies settings related to VM Guest Patching on Windows.
 */
model PatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
   * machines associated to virtual machine scale set with OrchestrationMode as
   * Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You
   * control the application of patches to a virtual machine. You do this by
   * applying patches manually inside the VM. In this mode, automatic updates are
   * disabled; the property WindowsConfiguration.enableAutomaticUpdates must be
   * false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be
   * updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates
   * must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will
   * automatically updated by the platform. The properties provisionVMAgent and
   * WindowsConfiguration.enableAutomaticUpdates must be true
   */
  patchMode?: WindowsVMGuestPatchMode;

  /**
   * Enables customers to patch their Azure VMs without requiring a reboot. For
   * enableHotpatching, the 'provisionVMAgent' must be set to true and 'patchMode'
   * must be set to 'AutomaticByPlatform'.
   */
  enableHotpatching?: boolean;

  /**
   * Specifies the mode of VM Guest patch assessment for the IaaS virtual
   * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
   * control the timing of patch assessments on a virtual machine.<br /><br />
   * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
   * The property provisionVMAgent must be true.
   */
  assessmentMode?: WindowsPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest
   * Patching on Windows.
   */
  automaticByPlatformSettings?: WindowsVMGuestPatchAutomaticByPlatformSettings;
}

/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform
 * is selected in Windows patch settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model WindowsVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
   */
  rebootSetting?: WindowsVMGuestPatchAutomaticByPlatformRebootSetting;

  /**
   * Enables customer to schedule patching without accidental upgrades
   */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}

/**
 * Describes Windows Remote Management configuration of the VM
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model WinRMConfiguration {
  /**
   * The list of Windows Remote Management listeners
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  listeners?: WinRMListener[];
}

/**
 * Describes Protocol and thumbprint of Windows Remote Management listener
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model WinRMListener {
  /**
   * Specifies the protocol of WinRM listener. Possible values are: **http,**
   * **https.**
   */
  protocol?: ProtocolTypes;

  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a
   * secret. For adding a secret to the Key Vault, see [Add a key or secret to the
   * key
   * vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   * In this case, your certificate needs to be the Base64 encoding of the following
   * JSON Object which is encoded in UTF-8: <br><br> {<br>
   * "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>
   * "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual
   * machine it is recommended to use the [Azure Key Vault virtual machine extension
   * for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: url;
}

/**
 * Specifies the Linux operating system settings on the virtual machine. For a
 * list of supported Linux distributions, see [Linux on Azure-Endorsed
 * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
 */
model LinuxConfiguration {
  /**
   * Specifies whether password authentication should be disabled.
   */
  disablePasswordAuthentication?: boolean;

  /**
   * Specifies the ssh key configuration for a Linux OS.
   */
  ssh?: SshConfiguration;

  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, default
   * behavior is to set it to true. This will ensure that VM Agent is installed on
   * the VM so that extensions can be added to the VM later.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  provisionVMAgent?: boolean;

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Linux.
   */
  patchSettings?: LinuxPatchSettings;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Linux virtual
   * machine. Default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  enableVMAgentPlatformUpdates?: boolean;
}

/**
 * SSH configuration for Linux based VMs running on Azure
 */
model SshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with linux based VMs.
   */
  @OpenAPI.extension("x-ms-identifiers", ["path"])
  publicKeys?: SshPublicKey[];
}

/**
 * Contains information about SSH certificate public key and the path on the Linux
 * VM where the public key is placed.
 */
model SshPublicKey {
  /**
   * Specifies the full path on the created VM where ssh public key is stored. If
   * the file already exists, the specified key is appended to the file. Example:
   * /home/user/.ssh/authorized_keys
   */
  path?: string;

  /**
   * SSH public key certificate used to authenticate with the VM through ssh. The
   * key needs to be at least 2048-bit and in ssh-rsa format. For creating ssh keys,
   * see [Create SSH keys on Linux and Mac for Linux VMs in
   * Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
   */
  keyData?: string;
}

/**
 * Specifies settings related to VM Guest Patching on Linux.
 */
model LinuxPatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
   * machines associated to virtual machine scale set with OrchestrationMode as
   * Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The
   * virtual machine's default patching configuration is used. <br /><br />
   * **AutomaticByPlatform** - The virtual machine will be automatically updated by
   * the platform. The property provisionVMAgent must be true
   */
  patchMode?: LinuxVMGuestPatchMode;

  /**
   * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual
   * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
   * control the timing of patch assessments on a virtual machine. <br /><br />
   * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
   * The property provisionVMAgent must be true.
   */
  assessmentMode?: LinuxPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest
   * Patching on Linux.
   */
  automaticByPlatformSettings?: LinuxVMGuestPatchAutomaticByPlatformSettings;
}

/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform
 * is selected in Linux patch settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model LinuxVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
   */
  rebootSetting?: LinuxVMGuestPatchAutomaticByPlatformRebootSetting;

  /**
   * Enables customer to schedule patching without accidental upgrades
   */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}

/**
 * Describes a set of certificates which are all in the same Key Vault.
 */
model VaultSecretGroup {
  /**
   * The relative URL of the Key Vault containing all of the certificates in
   * VaultCertificates.
   */
  sourceVault?: SubResource;

  /**
   * The list of key vault references in SourceVault which contain certificates.
   */
  @OpenAPI.extension("x-ms-identifiers", ["certificateUrl"])
  vaultCertificates?: VaultCertificate[];
}

/**
 * Describes SubResource
 */
model SubResource {
  /**
   * Resource Id
   */
  id?: armResourceIdentifier;
}

/**
 * Describes a single certificate reference in a Key Vault, and where the
 * certificate should reside on the VM.
 */
model VaultCertificate {
  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a
   * secret. For adding a secret to the Key Vault, see [Add a key or secret to the
   * key
   * vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   * In this case, your certificate needs to be It is the Base64 encoding of the
   * following JSON Object which is encoded in UTF-8: <br><br> {<br>
   * "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>
   * "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual
   * machine it is recommended to use the [Azure Key Vault virtual machine extension
   * for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: url;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to
   * which the certificate should be added. The specified certificate store is
   * implicitly in the LocalMachine account. For Linux VMs, the certificate file is
   * placed under the /var/lib/waagent directory, with the file name
   * &lt;UppercaseThumbprint&gt;.crt for the X509 certificate file and
   * &lt;UppercaseThumbprint&gt;.prv for private key. Both of these files are .pem
   * formatted.
   */
  certificateStore?: string;
}

/**
 * Describes a virtual machine scale set storage profile.
 */
model VirtualMachineScaleSetStorageProfile {
  /**
   * Specifies information about the image to use. You can specify information about
   * platform images, marketplace images, or virtual machine images. This element is
   * required when you want to use a platform image, marketplace image, or virtual
   * machine image, but is not used in other creation operations.
   */
  imageReference?: ImageReference;

  /**
   * Specifies information about the operating system disk used by the virtual
   * machines in the scale set. For more information about disks, see [About disks
   * and VHDs for Azure virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: VirtualMachineScaleSetOSDisk;

  /**
   * Specifies the parameters that are used to add data disks to the virtual
   * machines in the scale set. For more information about disks, see [About disks
   * and VHDs for Azure virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @OpenAPI.extension("x-ms-identifiers", ["name", "lun"])
  dataDisks?: VirtualMachineScaleSetDataDisk[];

  /**
   * Specifies the disk controller type configured for the virtual machines in the scale set. Minimum api-version: 2022-08-01
   */
  diskControllerType?: DiskControllerTypes;
}

/**
 * Specifies information about the image to use. You can specify information about
 * platform images, marketplace images, or virtual machine images. This element is
 * required when you want to use a platform image, marketplace image, or virtual
 * machine image, but is not used in other creation operations. NOTE: Image
 * reference publisher and offer can only be set when you create the scale set.
 */
model ImageReference is SubResource {
  /**
   * The image publisher.
   */
  publisher?: string;

  /**
   * Specifies the offer of the platform image or marketplace image used to create
   * the virtual machine.
   */
  offer?: string;

  /**
   * The image SKU.
   */
  sku?: string;

  /**
   * Specifies the version of the platform image or marketplace image used to create
   * the virtual machine. The allowed formats are Major.Minor.Build or 'latest'.
   * Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest
   * version of an image available at deploy time. Even if you use 'latest', the VM
   * image will not automatically update after deploy time even if a new version
   * becomes available. Please do not use field 'version' for gallery image
   * deployment, gallery image should always use 'id' field for deployment, to use 'latest'
   * version of gallery image, just set
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageName}'
   * in the 'id' field without version input.
   */
  version?: string;

  /**
   * Specifies in decimal numbers, the version of platform image or marketplace
   * image used to create the virtual machine. This readonly field differs from 'version',
   * only if the value specified in 'version' field is 'latest'.
   */
  @visibility("read")
  exactVersion?: string;

  /**
   * Specified the shared gallery image unique id for vm deployment. This can be
   * fetched from shared gallery image GET call.
   */
  sharedGalleryImageId?: string;

  /**
   * Specified the community gallery image unique id for vm deployment. This can be
   * fetched from community gallery image GET call.
   */
  communityGalleryImageId?: string;
}

/**
 * Describes a virtual machine scale set operating system disk.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetOSDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies how the virtual machines in the scale set should be created. The only
   * allowed value is: **FromImage.** This value is used when you are using an image
   * to create the virtual machine. If you are using a platform image, you also use
   * the imageReference element described above. If you are using a marketplace
   * image, you  also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the ephemeral disk Settings for the operating system disk used by the
   * virtual machine scale set.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB'
   * is the number of bytes x 1024^3 for the disk and the value cannot
   * be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * This property allows you to specify the type of the OS that is included in the
   * disk if creating a VM from user-image or a specialized VHD. Possible values
   * are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;

  /**
   * Specifies information about the unmanaged user image to base the scale set on.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the container urls that are used to store operating system disks for
   * the scale set.
   */
  vhdContainers?: string[];

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VMSS Flex deletion
   * (This feature is available for VMSS with Flexible OrchestrationMode only).
   * <br><br> Possible values: <br><br> **Delete** If this value is used, the OS
   * disk is deleted when VMSS Flex VM is deleted.<br><br> **Detach** If this value
   * is used, the OS disk is retained after VMSS Flex VM is deleted. <br><br> The
   * default value is set to **Delete**. For an Ephemeral OS Disk, the default value
   * is set to **Delete**. User cannot change the delete option for Ephemeral OS
   * Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes the parameters of ephemeral disk settings that can be specified for
 * operating system disk. **Note:** The ephemeral disk settings can only be
 * specified for managed disk.
 */
model DiffDiskSettings {
  /**
   * Specifies the ephemeral disk settings for operating system disk.
   */
  option?: DiffDiskOptions;

  /**
   * Specifies the ephemeral disk placement for operating system disk. Possible
   * values are: **CacheDisk,** **ResourceDisk.** The defaulting behavior is:
   * **CacheDisk** if one is configured for the VM size otherwise **ResourceDisk**
   * is used. Refer to the VM size documentation for Windows VM at
   * https://docs.microsoft.com/azure/virtual-machines/windows/sizes and Linux VM at
   * https://docs.microsoft.com/azure/virtual-machines/linux/sizes to check which VM
   * sizes exposes a cache disk.
   */
  placement?: DiffDiskPlacement;
}

/**
 * Describes the uri of a disk.
 */
model VirtualHardDisk {
  /**
   * Specifies the virtual hard disk's uri.
   */
  uri?: url;
}

/**
 * Describes the parameters of a ScaleSet managed disk.
 */
model VirtualMachineScaleSetManagedDiskParameters {
  /**
   * Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can
   * only be used with data disks, it cannot be used with OS Disk.
   */
  storageAccountType?: StorageAccountTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed
   * disk.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;

  /**
   * Specifies the security profile for the managed disk.
   */
  securityProfile?: VMDiskSecurityProfile;
}

/**
 * Describes the parameter of customer managed disk encryption set resource id
 * that can be specified for disk. **Note:** The disk encryption set resource id
 * can only be specified for managed disk. Please refer
 * https://aka.ms/mdssewithcmkoverview for more details.
 */
model DiskEncryptionSetParameters is SubResource;

/**
 * Specifies the security profile settings for the managed disk. **Note:** It can
 * only be set for Confidential VMs.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VMDiskSecurityProfile {
  /**
   * Specifies the EncryptionType of the managed disk. It is set to
   * DiskWithVMGuestState for encryption of the managed disk along with VMGuestState
   * blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and
   * NonPersistedTPM for not persisting firmware state in the VMGuestState blob..
   * **Note:** It can be set for only Confidential VMs.
   */
  securityEncryptionType?: SecurityEncryptionTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed
   * disk that is used for Customer Managed Key encrypted ConfidentialVM OS Disk and
   * VMGuest blob.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;
}

/**
 * Describes a virtual machine scale set data disk.
 */
model VirtualMachineScaleSetDataDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the logical unit number of the data disk. This value is used to
   * identify data disks within the VM and therefore must be unique for each data
   * disk attached to a VM.
   */
  lun: int32;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * The create option.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be
   * larger than 1023.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  diskSizeGB?: int32;

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies the Read-Write IOPS for the managed disk. Should be used only when
   * StorageAccountType is UltraSSD_LRS. If not specified, a default value would be
   * assigned based on diskSizeGB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  diskIOPSReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk. Should be used
   * only when StorageAccountType is UltraSSD_LRS. If not specified, a default value
   * would be assigned based on diskSizeGB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  diskMBpsReadWrite?: int64;

  /**
   * Specifies whether data disk should be deleted or detached upon VMSS Flex
   * deletion (This feature is available for VMSS with Flexible OrchestrationMode
   * only).<br><br> Possible values: <br><br> **Delete** If this value is used, the
   * data disk is deleted when the VMSS Flex VM is deleted.<br><br> **Detach** If
   * this value is used, the data disk is retained after VMSS Flex VM is
   * deleted.<br><br> The default value is set to **Delete**.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes a virtual machine scale set network profile.
 */
model VirtualMachineScaleSetNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an
   * instance in the virtual machine scale set. The reference will be in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;

  /**
   * The list of network configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];

  /**
   * specifies the Microsoft.Network API version used when creating networking
   * resources in the Network Interface Configurations for Virtual Machine Scale Set
   * with orchestration mode 'Flexible'
   */
  networkApiVersion?: NetworkApiVersion;
}

/**
 * The API entity reference.
 */
model ApiEntityReference {
  /**
   * The ARM resource id in the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: armResourceIdentifier;
}

/**
 * Describes a virtual machine scale set network profile's network configurations.
 */
model VirtualMachineScaleSetNetworkConfiguration {
  /**
   * The network configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration.
   */
  properties?: VirtualMachineScaleSetNetworkConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration.
 */
model VirtualMachineScaleSetNetworkConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies whether the network interface is disabled for tcp state tracking.
   */
  disableTcpStateTracking?: boolean;

  /**
   * Specifies whether the network interface is FPGA networking-enabled.
   */
  enableFpga?: boolean;

  /**
   * The network security group.
   */
  networkSecurityGroup?: SubResource;

  /**
   * The dns settings to be applied on the network interfaces.
   */
  dnsSettings?: VirtualMachineScaleSetNetworkConfigurationDnsSettings;

  /**
   * Specifies the IP configurations of the network interface.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  ipConfigurations: VirtualMachineScaleSetIPConfiguration[];

  /**
   * Whether IP forwarding enabled on this NIC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  enableIPForwarding?: boolean;

  /**
   * Specify what happens to the network interface when the VM is deleted
   */
  deleteOption?: DeleteOptions;

  /**
   * Specifies whether the Auxiliary mode is enabled for the Network Interface
   * resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface
   * resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

/**
 * Describes a virtual machines scale sets network configuration's DNS settings.
 */
model VirtualMachineScaleSetNetworkConfigurationDnsSettings {
  /**
   * List of DNS servers IP addresses
   */
  dnsServers?: string[];
}

/**
 * Describes a virtual machine scale set network profile's IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetIPConfiguration {
  /**
   * The IP configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration
   * properties.
   */
  properties?: VirtualMachineScaleSetIPConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration
 * properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetIPConfigurationProperties {
  /**
   * Specifies the identifier of the subnet.
   */
  subnet?: ApiEntityReference;

  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachineScaleSetPublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersion;

  /**
   * Specifies an array of references to backend address pools of application
   * gateways. A scale set can reference backend address pools of multiple
   * application gateways. Multiple scale sets cannot use the same application
   * gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A
   * scale set can reference backend address pools of one public and one internal
   * load balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to inbound Nat pools of the load balancers. A
   * scale set can reference inbound nat pools of one public and one internal load
   * balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerInboundNatPools?: SubResource[];
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetPublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name: string;

  /**
   * Describes a virtual machines scale set IP Configuration's PublicIPAddress
   * configuration
   */
  properties?: VirtualMachineScaleSetPublicIPAddressConfigurationProperties;

  /**
   * Describes the public IP Sku. It can only be set with OrchestrationMode as
   * Flexible.
   */
  sku?: PublicIPAddressSku;
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetPublicIPAddressConfigurationProperties {
  /**
   * The idle timeout of the public IP address.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * The dns settings to be applied on the publicIP addresses .
   */
  dnsSettings?: VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings;

  /**
   * The list of IP tags associated with the public IP address.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipTags?: VirtualMachineScaleSetIpTag[];

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  publicIPAddressVersion?: IPVersion;

  /**
   * Specify what happens to the public IP when the VM is deleted
   */
  deleteOption?: DeleteOptions;
}

/**
 * Describes a virtual machines scale sets network configuration's DNS settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings {
  /**
   * The Domain name label.The concatenation of the domain name label and vm index
   * will be the domain name labels of the PublicIPAddress resources that will be
   * created
   */
  domainNameLabel: string;

  /**
   * The Domain name label scope.The concatenation of the hashed domain name label
   * that generated according to the policy from domain name label scope and vm
   * index will be the domain name labels of the PublicIPAddress resources that will
   * be created
   */
  domainNameLabelScope?: DomainNameLabelScopeTypes;
}

/**
 * Contains the IP tag associated with the public IP address.
 */
model VirtualMachineScaleSetIpTag {
  /**
   * IP tag type. Example: FirstPartyUsage.
   */
  ipTagType?: string;

  /**
   * IP tag associated with the public IP. Example: SQL, Storage etc.
   */
  tag?: string;
}

/**
 * Describes the public IP Sku. It can only be set with OrchestrationMode as
 * Flexible.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model PublicIPAddressSku {
  /**
   * Specify public IP sku name
   */
  name?: PublicIPAddressSkuName;

  /**
   * Specify public IP sku tier
   */
  tier?: PublicIPAddressSkuTier;
}

/**
 * Specifies the Security profile settings for the virtual machine or virtual
 * machine scale set.
 */
model SecurityProfile {
  /**
   * Specifies the security settings like secure boot and vTPM used while creating
   * the virtual machine. Minimum api-version: 2020-12-01.
   */
  uefiSettings?: UefiSettings;

  /**
   * This property can be used by user in the request to enable or disable the Host
   * Encryption for the virtual machine or virtual machine scale set. This will
   * enable the encryption for all the disks including Resource/Temp disk at host
   * itself. The default behavior is: The Encryption at host will be disabled unless
   * this property is set to true for the resource.
   */
  encryptionAtHost?: boolean;

  /**
   * Specifies the SecurityType of the virtual machine. It has to be set to any
   * specified value to enable UefiSettings. The default behavior is: UefiSettings
   * will not be enabled unless this property is set.
   */
  securityType?: SecurityTypes;

  /**
   * Specifies the Managed Identity used by ADE to get access token for keyvault
   * operations.
   */
  encryptionIdentity?: EncryptionIdentity;

  /**
   * Specifies ProxyAgent settings while creating the virtual machine. Minimum
   * api-version: 2023-09-01.
   */
  proxyAgentSettings?: ProxyAgentSettings;
}

/**
 * Specifies the security settings like secure boot and vTPM used while creating
 * the virtual machine. Minimum api-version: 2020-12-01.
 */
model UefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine. Minimum
   * api-version: 2020-12-01.
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether vTPM should be enabled on the virtual machine. Minimum
   * api-version: 2020-12-01.
   */
  vTpmEnabled?: boolean;
}

/**
 * Specifies the Managed Identity used by ADE to get access token for keyvault
 * operations.
 */
model EncryptionIdentity {
  /**
   * Specifies ARM Resource ID of one of the user identities associated with the VM.
   */
  userAssignedIdentityResourceId?: armResourceIdentifier;
}

/**
 * Specifies ProxyAgent settings while creating the virtual machine. Minimum
 * api-version: 2023-09-01.
 */
model ProxyAgentSettings {
  /**
   * Specifies whether ProxyAgent feature should be enabled on the virtual machine
   * or virtual machine scale set.
   */
  enabled?: boolean;

  /**
   * Specifies the mode that ProxyAgent will execute on if the feature is enabled.
   * ProxyAgent will start to audit or monitor but not enforce access control over
   * requests to host endpoints in Audit mode, while in Enforce mode it will enforce
   * access control. The default value is Enforce mode.
   */
  mode?: Mode;

  /**
   * Increase the value of this property allows user to reset the key used for
   * securing communication channel between guest and host.
   */
  keyIncarnationId?: int32;
}

/**
 * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
 */
model DiagnosticsProfile {
  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output
   * and Screenshot to diagnose VM status. **NOTE**: If storageUri is being
   * specified then ensure that the storage account is in the same region and
   * subscription as the VM. You can easily view the output of your console log.
   * Azure also enables you to see a screenshot of the VM from the hypervisor.
   */
  bootDiagnostics?: BootDiagnostics;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output
 * and Screenshot to diagnose VM status. You can easily view the output of your
 * console log. Azure also enables you to see a screenshot of the VM from the
 * hypervisor.
 */
model BootDiagnostics {
  /**
   * Whether boot diagnostics should be enabled on the Virtual Machine.
   */
  enabled?: boolean;

  /**
   * Uri of the storage account to use for placing the console output and
   * screenshot. If storageUri is not specified while enabling boot diagnostics,
   * managed storage will be used.
   */
  storageUri?: url;
}

/**
 * Describes a virtual machine scale set extension profile.
 */
model VirtualMachineScaleSetExtensionProfile {
  /**
   * The virtual machine scale set child extension resources.
   */
  extensions?: VirtualMachineScaleSetExtension[];

  /**
   * Specifies the time alloted for all extensions to start. The time duration
   * should be between 15 minutes and 120 minutes (inclusive) and should be
   * specified in ISO 8601 format. The default value is 90 minutes (PT1H30M).
   * Minimum api-version: 2020-06-01.
   */
  extensionsTimeBudget?: string;
}

/**
 * Describes a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtension is SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  properties?: VirtualMachineScaleSetExtensionProperties;
}

/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtensionProperties {
  /**
   * If a value is provided and is different from the previous value, the extension
   * handler will be forced to update even if the extension configuration has not
   * changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is
   * available at deployment time. Once deployed, however, the extension will not
   * upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the
   * platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Converted legacy object to typespec https://github.com/Azure/azure-rest-api-specs/blob/d715112415eb08572ee96cc4bd77217aa44dedf1/specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineScaleSet.json#L5002C1-L5009C11"
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or
   * protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Converted legacy object to typespec https://github.com/Azure/azure-rest-api-specs/blob/d715112415eb08572ee96cc4bd77217aa44dedf1/specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineScaleSet.json#L5002C1-L5009C11"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Legacy"
  @visibility("create", "update")
  @OpenAPI.extension("x-ms-secret", true)
  protectedSettings?: Record<unknown>;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Collection of extension names after which this extension needs to be
   * provisioned.
   */
  provisionAfterExtensions?: string[];

  /**
   * Indicates whether failures stemming from the extension will be suppressed
   * (Operational failures such as not connecting to the VM will not be suppressed
   * regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed
   * from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;
}

/**
 * Describes a reference to Key Vault Secret
 */
model KeyVaultSecretReference {
  /**
   * The URL referencing a secret in a Key Vault.
   */
  secretUrl: url;

  /**
   * The relative URL of the Key Vault containing the secret.
   */
  sourceVault: SubResource;
}

/**
 * Describes a Readonly subresource.
 */
model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: armResourceIdentifier;
}

/**
 * Specifies Scheduled Event related configurations.
 */
model ScheduledEventsProfile {
  /**
   * Specifies Terminate Scheduled Event related configurations.
   */
  terminateNotificationProfile?: TerminateNotificationProfile;

  /**
   * Specifies OS Image Scheduled Event related configurations.
   */
  osImageNotificationProfile?: OSImageNotificationProfile;
}

/**
 * Specifies Terminate Scheduled Event related configurations.
 */
model TerminateNotificationProfile {
  /**
   * Configurable length of time a Virtual Machine being deleted will have to
   * potentially approve the Terminate Scheduled Event before the event is auto
   * approved (timed out). The configuration must be specified in ISO 8601 format,
   * the default value is 5 minutes (PT5M)
   */
  notBeforeTimeout?: string;

  /**
   * Specifies whether the Terminate Scheduled event is enabled or disabled.
   */
  enable?: boolean;
}

/**
 * Specifies OS Image Scheduled Event related configurations.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model OSImageNotificationProfile {
  /**
   * Length of time a Virtual Machine being reimaged or having its OS upgraded will
   * have to potentially approve the OS Image Scheduled Event before the event is
   * auto approved (timed out). The configuration is specified in ISO 8601 format,
   * and the value must not exceed 15 minutes (PT15M)
   */
  notBeforeTimeout?: string;

  /**
   * Specifies whether the OS Image Scheduled event is enabled or disabled.
   */
  enable?: boolean;
}

/**
 * The parameters of a capacity reservation Profile.
 */
model CapacityReservationProfile {
  /**
   * Specifies the capacity reservation group resource id that should be used for
   * allocating the virtual machine or scaleset vm instances provided enough
   * capacity has been reserved. Please refer to https://aka.ms/CapacityReservation
   * for more details.
   */
  capacityReservationGroup?: SubResource;
}

/**
 * Contains the list of gallery applications that should be made available to the
 * VM/VMSS
 */
model ApplicationProfile {
  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  @OpenAPI.extension("x-ms-identifiers", ["packageReferenceId"])
  galleryApplications?: VMGalleryApplication[];
}

/**
 * Specifies the required information to reference a compute gallery application
 * version
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VMGalleryApplication {
  /**
   * Optional, Specifies a passthrough value for more generic context.
   */
  tags?: string;

  /**
   * Optional, Specifies the order in which the packages have to be installed
   */
  order?: int32;

  /**
   * Specifies the GalleryApplicationVersion resource id on the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}
   */
  packageReferenceId: armResourceIdentifier;

  /**
   * Optional, Specifies the uri to an azure blob that will replace the default
   * configuration for the package if provided
   */
  configurationReference?: string;

  /**
   * Optional, If true, any failure for any operation in the VmApplication will fail
   * the deployment
   */
  treatFailureAsDeploymentFailure?: boolean;

  /**
   * If set to true, when a new Gallery Application version is available in PIR/SIG,
   * it will be automatically updated for the VM/VMSS
   */
  enableAutomaticUpgrade?: boolean;
}

/**
 * Specifies the hardware settings for the virtual machine scale set.
 */
model VirtualMachineScaleSetHardwareProfile {
  /**
   * Specifies the properties for customizing the size of the virtual machine.
   * Minimum api-version: 2021-11-01. Please follow the instructions in [VM
   * Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
}

/**
 * Specifies VM Size Property settings on the virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model VMSizeProperties {
  /**
   * Specifies the number of vCPUs available for the VM. When this property is not
   * specified in the request body the default behavior is to set it to the value of
   * vCPUs available for that VM size exposed in api response of [List all available
   * virtual machine sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   */
  vCPUsAvailable?: int32;

  /**
   * Specifies the vCPU to physical core ratio. When this property is not specified
   * in the request body the default behavior is set to the value of vCPUsPerCore
   * for the VM Size exposed in api response of [List all available virtual machine
   * sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   * **Setting this property to 1 also means that hyper-threading is disabled.**
   */
  vCPUsPerCore?: int32;
}

/**
 * Specifies the service artifact reference id used to set same image version for
 * all virtual machines in the scale set when using 'latest' image version.
 * Minimum api-version: 2022-11-01
 */
model ServiceArtifactReference {
  /**
   * The service artifact reference id in the form of
   * /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  id?: armResourceIdentifier;
}

/**
 * Specifies the security posture to be used for all virtual machines in the scale
 * set. Minimum api-version: 2023-03-01
 */
model SecurityPostureReference {
  /**
   * The security posture reference id in the form of
   * /CommunityGalleries/{communityGalleryName}/securityPostures/{securityPostureName}/versions/{major.minor.patch}|{major.*}|latest
   */
  id?: string;

  /**
   * List of virtual machine extension names to exclude when applying the security
   * posture.
   */
  excludeExtensions?: string[];

  /**
   * Whether the security posture can be overridden by the user.
   */
  isOverridable?: boolean;
}

/**
 * Specifies the name of the setting to which the content applies. Possible values
 * are: FirstLogonCommands and AutoLogon.
 */
union SettingNames {
  string,

  /**
   * AutoLogon setting
   */
  AutoLogon: "AutoLogon",

  /**
   * FirstLogonCommands setting
   */
  FirstLogonCommands: "FirstLogonCommands",
}

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
 * machines associated to virtual machine scale set with OrchestrationMode as
 * Flexible.
 */
union WindowsVMGuestPatchMode {
  string,

  /**
   * You control the application of patches to a virtual machine.
   * You do this by applying patches manually inside the VM. In this mode,
   * automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates
   * must be false
   */
  Manual: "Manual",

  /**
   * The virtual machine will automatically be updated by the OS.
   *  The property WindowsConfiguration.enableAutomaticUpdates must be true.
   */
  AutomaticByOS: "AutomaticByOS",

  /**
   * The virtual machine will automatically updated by the platform. The properties
   * provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true.
   */
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest patch assessment for the IaaS virtual machine.
 */
union WindowsPatchAssessmentMode {
  string,

  /**
   * You control the timing of patch assessments on a virtual machine.
   */
  ImageDefault: "ImageDefault",

  /**
   * The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
   */
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
 */
union WindowsVMGuestPatchAutomaticByPlatformRebootSetting {
  string,

  /**
   * Unknown Reboot setting
   */
  Unknown: "Unknown",

  /**
   * IfRequired Reboot setting
   */
  IfRequired: "IfRequired",

  /**
   * Never Reboot setting
   */
  Never: "Never",

  /**
   * Always Reboot setting
   */
  Always: "Always",
}

/**
 * Specifies the protocol of WinRM listener. Possible values are: **http,**
 * **https.**
 */
union ProtocolTypes {
  string,

  /**
   * Http protocol
   */
  Http: "Http",

  /**
   * Https protocol
   */
  Https: "Https",
}

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
 * machines associated to virtual machine scale set with OrchestrationMode as
 * Flexible.
 */
union LinuxVMGuestPatchMode {
  string,

  /**
   * The virtual machine's default patching configuration is used.
   */
  ImageDefault: "ImageDefault",

  /**
   * The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true.
   */
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual
 * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
 * control the timing of patch assessments on a virtual machine. <br /><br />
 * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
 * The property provisionVMAgent must be true.
 */
union LinuxPatchAssessmentMode {
  string,

  /**
   * You control the timing of patch assessments on a virtual machine.
   */
  ImageDefault: "ImageDefault",

  /**
   * The platform will trigger periodic patch assessments.The property provisionVMAgent must be true.
   */
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation
 * operations.
 */
union LinuxVMGuestPatchAutomaticByPlatformRebootSetting {
  string,

  /**
   * Unknown Reboot setting
   */
  Unknown: "Unknown",

  /**
   * IfRequired Reboot setting
   */
  IfRequired: "IfRequired",

  /**
   * Never Reboot setting
   */
  Never: "Never",

  /**
   * Always Reboot setting
   */
  Always: "Always",
}

/**
 * Specifies the caching requirements.
 */
union CachingTypes {
  string,

  /**
   * 'None' is default for Standard Storage
   */
  None: "None",

  /**
   * 'ReadOnly' is default for Premium Storage
   */
  ReadOnly: "ReadOnly",

  /**
   * 'ReadWrite' is default for OS Disk
   */
  ReadWrite: "ReadWrite",
}

/**
 * This property allows you to specify the type of the OS that is included in the
 * disk if creating a VM from user-image or a specialized VHD. Possible values
 * are: **Windows,** **Linux.**
 */
union OperatingSystemTypes {
  string,

  /**
   * Windows OS type
   */
  Windows: "Windows",

  /**
   * Linux OS type
   */
  Linux: "Linux",
}

/**
 * Specifies how the virtual machine should be created.
 */
union DiskCreateOptionTypes {
  string,

  /**
   * This value is used when you are using an image to create the virtual machine.
   * If you are using a platform image, you also use the imageReference element
   * described above. If you are using a marketplace image, you also use the
   * plan element previously described.
   */
  FromImage: "FromImage",

  /**
   * This value is used when creating an empty data disk.
   */
  Empty: "Empty",

  /**
   * This value is used when you are using a specialized disk to create the virtual machine.
   */
  Attach: "Attach",

  /**
   * This value is used to create a data disk from a snapshot or another disk.
   */
  Copy: "Copy",

  /**
   * This value is used to create a data disk from a disk restore point.
   */
  Restore: "Restore",
}

/**
 * Specifies the behavior of the managed disk when the VM gets deleted, for
 * example whether the managed disk is deleted or detached. Supported values are:
 * **Delete.** If this value is used, the managed disk is deleted when VM gets
 * deleted. **Detach.** If this value is used, the managed disk is retained after
 * VM gets deleted. Minimum api-version: 2021-03-01.
 */
union DiskDeleteOptionTypes {
  string,

  /**
   * If this value is used, the managed disk is deleted when VM gets deleted.
   */
  Delete: "Delete",

  /**
   * If this value is used, the managed disk is retained after VM gets deleted.
   */
  Detach: "Detach",
}

/**
 * Specifies the ephemeral disk option for operating system disk.
 */
union DiffDiskOptions {
  string,

  /**
   * Local Option.
   */
  Local: "Local",
}

/**
 * Specifies the ephemeral disk placement for operating system disk. This property
 * can be used by user in the request to choose the location i.e, cache disk or
 * resource disk space for Ephemeral OS disk provisioning. For more information on
 * Ephemeral OS disk size requirements, please refer Ephemeral OS disk size
 * requirements for Windows VM at
 * https://docs.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements
 * and Linux VM at
 * https://docs.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements
 * Minimum api-version for NvmeDisk: 2024-03-01.
 */
union DiffDiskPlacement {
  string,

  /**
   * CacheDisk option.
   */
  CacheDisk: "CacheDisk",

  /**
   * Resource Disk option.
   */
  ResourceDisk: "ResourceDisk",

  /**
   * NvmeDisk option.
   */
  NvmeDisk: "NvmeDisk",
}

/**
 * Specifies the storage account type for the managed disk. Managed OS disk
 * storage account type can only be set when you create the scale set. NOTE:
 * UltraSSD_LRS can only be used with data disks. It cannot be used with OS Disk.
 * Standard_LRS uses Standard HDD. StandardSSD_LRS uses Standard SSD. Premium_LRS
 * uses Premium SSD. UltraSSD_LRS uses Ultra disk. Premium_ZRS uses Premium SSD
 * zone redundant storage. StandardSSD_ZRS uses Standard SSD zone redundant
 * storage. For more information regarding disks supported for Windows Virtual
 * Machines, refer to
 * https://docs.microsoft.com/azure/virtual-machines/windows/disks-types and, for
 * Linux Virtual Machines, refer to
 * https://docs.microsoft.com/azure/virtual-machines/linux/disks-types
 */
union StorageAccountTypes {
  string,

  /**
   * Standard_LRS option.
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium_LRS option.
   */
  Premium_LRS: "Premium_LRS",

  /**
   * StandardSSD_LRS option.
   */
  StandardSSD_LRS: "StandardSSD_LRS",

  /**
   * UltraSSD_LRS option.
   */
  UltraSSD_LRS: "UltraSSD_LRS",

  /**
   * Premium_ZRS option.
   */
  Premium_ZRS: "Premium_ZRS",

  /**
   * StandardSSD_ZRS option.
   */
  StandardSSD_ZRS: "StandardSSD_ZRS",

  /**
   * PremiumV2_LRS option.
   */
  PremiumV2_LRS: "PremiumV2_LRS",
}

/**
 * Specifies the EncryptionType of the managed disk.
 * **Note:** It can be set for only Confidential VMs.
 */
union SecurityEncryptionTypes {
  string,

  /**
   * EncryptionType of the managed disk is set to VMGuestStateOnly for encryption
   *  of just the VMGuestState blob.
   */
  VMGuestStateOnly: "VMGuestStateOnly",

  /**
   * EncryptionType of the managed disk is set to DiskWithVMGuestState for encryption
   * of the managed disk along with VMGuestState blob.
   */
  DiskWithVMGuestState: "DiskWithVMGuestState",

  /**
   * EncryptionType of the managed disk is set to NonPersistedTPM for not persisting
   * firmware state in the VMGuestState blob.
   */
  NonPersistedTPM: "NonPersistedTPM",
}

/**
 * specifies the Microsoft.Network API version used when creating networking
 * resources in the Network Interface Configurations for Virtual Machine Scale Set
 * with orchestration mode 'Flexible'
 */
union NetworkApiVersion {
  string,

  /**
   * Initial version supported. Later versions are supported as well.
   */
  v2020_11_01: "2020-11-01",
}

/**
 * Specify what happens to the network interface when the VM is deleted
 */
union DeleteOptions {
  string,

  /**
   * Delete Option
   */
  Delete: "Delete",

  /**
   * Detach Option
   */
  Detach: "Detach",
}

/**
 * Specifies whether the Auxiliary mode is enabled for the Network Interface
 * resource.
 */
union NetworkInterfaceAuxiliaryMode {
  string,

  /**
   * None Mode
   */
  None: "None",

  /**
   * AcceleratedConnections Mode
   */
  AcceleratedConnections: "AcceleratedConnections",

  /**
   * Floating Mode
   */
  Floating: "Floating",
}

/**
 * Specifies whether the Auxiliary sku is enabled for the Network Interface
 * resource.
 */
union NetworkInterfaceAuxiliarySku {
  string,

  /**
   * no sku
   */
  None: "None",

  /**
   * A1 sku
   */
  A1: "A1",

  /**
   * A2 sku
   */
  A2: "A2",

  /**
   * A4 sku
   */
  A4: "A4",

  /**
   * A8 sku
   */
  A8: "A8",
}

/**
 * Available from Api-Version 2017-03-30 onwards, it represents whether the
 * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
 * values are: 'IPv4' and 'IPv6'.
 */
union IPVersion {
  string,

  /**
   * IPv4 version
   */
  IPv4: "IPv4",

  /**
   * IPv6 version
   */
  IPv6: "IPv6",
}

/**
 * The Domain name label scope.The concatenation of the hashed domain name label
 * that generated according to the policy from domain name label scope and vm
 * index will be the domain name labels of the PublicIPAddress resources that will
 * be created
 */
union DomainNameLabelScopeTypes {
  string,

  /**
   * TenantReuse type
   */
  TenantReuse: "TenantReuse",

  /**
   * SubscriptionReuse type
   */
  SubscriptionReuse: "SubscriptionReuse",

  /**
   * ResourceGroupReuse type
   */
  ResourceGroupReuse: "ResourceGroupReuse",

  /**
   * NoReuse type
   */
  NoReuse: "NoReuse",
}

/**
 * Specify public IP sku name.
 */
union PublicIPAddressSkuName {
  string,

  /**
   * Basic sku name
   */
  Basic: "Basic",

  /**
   * Standard sku name
   */
  Standard: "Standard",
}

/**
 * Specify public IP sku tier
 */
union PublicIPAddressSkuTier {
  string,

  /**
   * Regional sku tier
   */
  Regional: "Regional",

  /**
   * Global sku tier
   */
  Global: "Global",
}

/**
 * Specifies the SecurityType of the virtual machine. It has to be set to any
 * specified value to enable UefiSettings. The default behavior is: UefiSettings
 * will not be enabled unless this property is set.
 */
union SecurityTypes {
  string,

  /**
   * TrustedLaunch security type
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * ConfidentialVM security type
   */
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Specifies the mode that ProxyAgent will execute on if the feature is enabled.
 * ProxyAgent will start to audit or monitor but not enforce access control over
 * requests to host endpoints in Audit mode, while in Enforce mode it will enforce
 * access control. The default value is Enforce mode.
 */
union Mode {
  string,

  /**
   * Audit Mode
   */
  Audit: "Audit",

  /**
   * Enforce Mode
   */
  Enforce: "Enforce",
}

/**
 * The level code.
 */
union StatusLevelTypes {
  string,

  /**
   * Info level
   */
  Info: "Info",

  /**
   * Warning level
   */
  Warning: "Warning",

  /**
   * Error Level
   */
  Error: "Error",
}

/**
 * Specifies the disk controller type configured for the VM and
 * VirtualMachineScaleSet. This property is only supported for virtual machines
 * whose operating system disk and VM sku supports Generation 2
 * (https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2), please
 * check the HyperVGenerations capability returned as part of VM sku capabilities
 * in the response of Microsoft.Compute SKUs api for the region contains V2
 * (https://docs.microsoft.com/rest/api/compute/resourceskus/list). For more
 * information about Disk Controller Types supported please refer to
 * https://aka.ms/azure-diskcontrollertypes.
 */
union DiskControllerTypes {
  string,

  /**
   * SCSI disk type
   */
  SCSI: "SCSI",

  /**
   * NVMe disk type
   */
  NVMe: "NVMe",
}
