import * as coreClient from "@azure/core-client";

/** A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results. */
export interface OperationListResult {
  /**
   * List of operations supported by the resource provider
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly value?: Operation[];
  /**
   * URL to get the next set of operation list results (if there are any).
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly nextLink?: string;
}

/** Details of a REST API operation, returned from the Resource Provider Operations API */
export interface Operation {
  /**
   * The name of the operation, as per Resource-Based Access Control (RBAC). Examples: "Microsoft.Compute/virtualMachines/write", "Microsoft.Compute/virtualMachines/capture/action"
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * Whether the operation applies to data-plane. This is "true" for data-plane operations and "false" for ARM/control-plane operations.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly isDataAction?: boolean;
  /** Localized display information for this particular operation. */
  display?: OperationDisplay;
  /**
   * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly origin?: Origin;
  /**
   * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly actionType?: ActionType;
}

/** Localized display information for this particular operation. */
export interface OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provider?: string;
  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly resource?: string;
  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly operation?: string;
  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly description?: string;
}

/** Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.). */
export interface ErrorResponse {
  /** The error object. */
  error?: ErrorDetail;
}

/** The error detail. */
export interface ErrorDetail {
  /**
   * The error code.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly code?: string;
  /**
   * The error message.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly message?: string;
  /**
   * The error target.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly target?: string;
  /**
   * The error details.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly details?: ErrorDetail[];
  /**
   * The error additional info.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly additionalInfo?: ErrorAdditionalInfo[];
}

/** The resource management error additional info. */
export interface ErrorAdditionalInfo {
  /**
   * The additional info type.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * The additional info.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly info?: Record<string, unknown>;
}

/** The response of a Fleet list operation. */
export interface FleetListResult {
  /** The Fleet items on this page */
  value: Fleet[];
  /** The link to the next page of items */
  nextLink?: string;
}

/** Details of the Compute Fleet. */
export interface FleetProperties {
  /**
   * The status of the last operation.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Configuration Options for Spot instances in Compute Fleet. */
  spotPriorityProfile?: SpotPriorityProfile;
  /** Configuration Options for Regular instances in Compute Fleet. */
  regularPriorityProfile?: RegularPriorityProfile;
  /** List of VM sizes supported for Compute Fleet */
  vmSizesProfile: VmSizeProfile[];
  /** Attribute based Fleet. */
  vmAttributes?: VMAttributes;
  /** Represents the configuration for additional locations where Fleet resources may be deployed. */
  additionalLocationsProfile?: AdditionalLocationsProfile;
  /** Compute Profile to use for running user's workloads. */
  computeProfile: ComputeProfile;
  /**
   * Specifies the time at which the Compute Fleet is created.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly timeCreated?: Date;
  /**
   * Specifies the ID which uniquely identifies a Compute Fleet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly uniqueId?: string;
}

/** Configuration Options for Spot instances in Compute Fleet. */
export interface SpotPriorityProfile {
  /** Total capacity to achieve. It is currently in terms of number of VMs. */
  capacity?: number;
  /** Minimum capacity to achieve which cannot be updated. If we will not be able to "guarantee" minimum capacity, we will reject the request in the sync path itself. */
  minCapacity?: number;
  /** Price per hour of each Spot VM will never exceed this. */
  maxPricePerVM?: number;
  /** Eviction Policy to follow when evicting Spot VMs. */
  evictionPolicy?: EvictionPolicy;
  /** Allocation strategy to follow when determining the VM sizes distribution for Spot VMs. */
  allocationStrategy?: SpotAllocationStrategy;
  /**
   * Flag to enable/disable continuous goal seeking for the desired capacity and restoration of evicted Spot VMs.
   * If maintain is enabled, AzureFleetRP will use all VM sizes in vmSizesProfile to create new VMs (if VMs are evicted deleted)
   * or update existing VMs with new VM sizes (if VMs are evicted deallocated or failed to allocate due to capacity constraint) in order to achieve the desired capacity.
   * Maintain is enabled by default.
   */
  maintain?: boolean;
}

/** Configuration Options for Regular instances in Compute Fleet. */
export interface RegularPriorityProfile {
  /** Total capacity to achieve. It is currently in terms of number of VMs. */
  capacity?: number;
  /** Minimum capacity to achieve which cannot be updated. If we will not be able to "guarantee" minimum capacity, we will reject the request in the sync path itself. */
  minCapacity?: number;
  /** Allocation strategy to follow when determining the VM sizes distribution for Regular VMs. */
  allocationStrategy?: RegularPriorityAllocationStrategy;
}

/** Specifications about a VM Size. This will also contain the corresponding rank and weight in future. */
export interface VmSizeProfile {
  /** The Sku name (e.g. 'Standard_DS1_v2') */
  name: string;
  /**
   * The rank of the VM size. This is used with 'RegularPriorityAllocationStrategy.Prioritized'
   * The lower the number, the higher the priority. Starting with 0.
   */
  rank?: number;
}

/** VMAttributes that will be used to filter VMSizes which will be used to build Fleet. */
export interface VMAttributes {
  /** The range of vCpuCount specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified. */
  vCpuCount: VMAttributeMinMax;
  /** The range of memory specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified. */
  memoryInMiB: VMAttributeMinMax;
  /** Specifies whether the VMSize supporting local storage should be used to build Fleet or not. */
  localStorageSupport?: VMAttributeSupport;
  /** The local storage disk types specified as a list. If gpuSupport is Excluded, this VMAttribute can not be used. */
  localStorageDiskType: LocalStorageDiskType[];
  /** The range of local storage in GB specified from Min to Max. */
  localStorageInGB: VMAttributeMinMax;
  /** The local storage disk types specified as a list. */
  localStorageDiskTypes: LocalStorageDiskType[];
  /** The range of data disk count specified from Min to Max. Optional parameter. Either Min or Max is required if specified. */
  dataDiskCount: VMAttributeMinMax;
  /** The range of network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified. */
  networkInterfaceCount: VMAttributeMinMax;
  /** The range of network bandwidth in Mbps specified from Min to Max. Optional parameter. Either Min or Max is required if specified. */
  networkBandwidthInMbps: VMAttributeMinMax;
  /** Specifies whether the VMSize supporting RDMA (Remote Direct Memory Access) should be used to build Fleet or not. */
  rdmaSupport?: VMAttributeSupport;
  /** The range of RDMA (Remote Direct Memory Access) network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified. */
  rdmaNetworkInterfaceCount: VMAttributeMinMax;
  /** Specifies whether the VMSize supporting GPU should be used to build Fleet or not. */
  gpuSupport?: VMAttributeSupport;
  /** The GPU manufacturers specified as a list. gpuSupport should be set to Included or Required to use this VMAttribute. Default GPU manufacturers if not specified are ANY of the valid values. */
  gpuManufacturers: GpuManufacturer[];
  /** The VM category specified as a list. Optional parameter. */
  vmCategories: VMCategory[];
  /** The VM architecture types specified as a list. Optional parameter. */
  architectureTypes: ArchitectureType[];
  /** The VM CPU manufacturers specified as a list. Optional parameter. */
  cpuManufacturers: CpuManufacturer[];
  /** Specifies whether the VMSize supporting burstable capability should be used to build Fleet or not. */
  burstableSupport?: VMAttributeSupport;
  /** Specifies which VMSizes should be excluded while building Fleet. Optional parameter. */
  excludedVMSizes: string[];
}

/** While retrieving VMSizes from CRS, Min = 0 (uint.MinValue) if not specified, Max = 4294967295 (uint.MaxValue) if not specified. This allows to filter VMAttributes on all available VMSizes. */
export interface VMAttributeMinMax {
  /** Min VMSize from CRS, Min = 0 (uint.MinValue) if not specified. */
  min?: number;
  /** Maz VMSize from CRS, Max = 4294967295 (uint.MaxValue) if not specified. */
  max?: number;
}

/** Represents the configuration for additional locations where Fleet resources may be deployed. */
export interface AdditionalLocationsProfile {
  /** The list of location profiles. */
  locationProfiles: LocationProfile[];
}

/** Represents the profile for a single additional location in the Fleet. The location and the (optional). */
export interface LocationProfile {
  /** The ARM location name of the additional region. */
  location: string;
  /** Base Virtual Machine Profile Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile" */
  virtualMachineProfileOverride: BaseVirtualMachineProfile;
}

/** Describes the base virtual machine profile for fleet */
export interface BaseVirtualMachineProfile {
  /**
   * Specifies the operating system settings for the virtual machines in the scale
   * set.
   */
  osProfile?: VirtualMachineScaleSetOSProfile;
  /** Specifies the storage settings for the virtual machine disks. */
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
  /** Specifies the boot diagnostic settings state. */
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
  /** Specifies Scheduled Event related configurations. */
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
  /** Specifies the gallery applications that should be made available to the VM/VMSS */
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
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly timeCreated?: Date;
}

/** Describes a virtual machine scale set OS profile. */
export interface VirtualMachineScaleSetOSProfile {
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
  /**
   * Specifies the password of the administrator account. <br><br> **Minimum-length
   * (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters
   * <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length
   * (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4
   * conditions below need to be fulfilled <br> Has lower characters <br>Has upper
   * characters <br> Has a digit <br> Has a special character (Regex match [\W_])
   * <br><br> **Disallowed values:** "abc@123", "P@$$w0rd", "P@ssw0rd",
   * "P@ssword123", "Pa$$word", "pass@word1", "Password!", "Password1",
   * "Password22", "iloveyou!" <br><br> For resetting the password, see [How to
   * reset the Remote Desktop service or its login password in a Windows
   * VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp)
   * <br><br> For resetting root password, see [Manage users, SSH, and check or
   * repair disks on Azure Linux VMs using the VMAccess
   * Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
   * This value contains a credential. Consider obscuring before showing to users
   */
  adminPassword?: string;
  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string
   * is decoded to a binary array that is saved as a file on the Virtual Machine.
   * The maximum length of the binary array is 65535 bytes. For using cloud-init for
   * your VM, see [Using cloud-init to customize a Linux VM during
   * creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init)
   * This value contains a credential. Consider obscuring before showing to users
   */
  customData?: string;
  /** Specifies Windows operating system settings on the virtual machine. */
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
  secrets?: VaultSecretGroup[];
  /**
   * Specifies whether extension operations should be allowed on the virtual machine
   * scale set. This may only be set to False when no extensions are present on the
   * virtual machine scale set.
   */
  allowExtensionOperations?: boolean;
  /** Optional property which must either be set to True or omitted. */
  requireGuestProvisionSignal?: boolean;
}

/** Specifies Windows operating system settings on the virtual machine. */
export interface WindowsConfiguration {
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, it is set to
   * true by default. This will ensure that VM Agent is installed on the VM so that
   * extensions can be added to the VM later.
   */
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
  additionalUnattendContent?: AdditionalUnattendContent[];
  /** [Preview Feature] Specifies settings related to VM Guest Patching on Windows. */
  patchSettings?: PatchSettings;
  /**
   * Specifies the Windows Remote Management listeners. This enables remote Windows
   * PowerShell.
   */
  winRM?: WinRMConfiguration;
  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Windows virtual
   * machine. Default value is false.
   */
  enableVMAgentPlatformUpdates?: boolean;
}

/**
 * Specifies additional XML formatted information that can be included in the
 * Unattend.xml file, which is used by Windows Setup. Contents are defined by
 * setting name, component name, and the pass in which the content is applied.
 */
export interface AdditionalUnattendContent {
  /** The pass name. Currently, the only allowable value is OobeSystem. */
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
   * This value contains a credential. Consider obscuring before showing to users
   */
  content?: string;
}

/** Specifies settings related to VM Guest Patching on Windows. */
export interface PatchSettings {
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
export interface WindowsVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
   */
  rebootSetting?: WindowsVMGuestPatchAutomaticByPlatformRebootSetting;
  /** Enables customer to schedule patching without accidental upgrades */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}

/** Describes Windows Remote Management configuration of the VM */
export interface WinRMConfiguration {
  /** The list of Windows Remote Management listeners */
  listeners?: WinRMListener[];
}

/** Describes Protocol and thumbprint of Windows Remote Management listener */
export interface WinRMListener {
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
  certificateUrl?: string;
}

/**
 * Specifies the Linux operating system settings on the virtual machine. For a
 * list of supported Linux distributions, see [Linux on Azure-Endorsed
 * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
 */
export interface LinuxConfiguration {
  /** Specifies whether password authentication should be disabled. */
  disablePasswordAuthentication?: boolean;
  /** Specifies the ssh key configuration for a Linux OS. */
  ssh?: SshConfiguration;
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, default
   * behavior is to set it to true. This will ensure that VM Agent is installed on
   * the VM so that extensions can be added to the VM later.
   */
  provisionVMAgent?: boolean;
  /** [Preview Feature] Specifies settings related to VM Guest Patching on Linux. */
  patchSettings?: LinuxPatchSettings;
  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Linux virtual
   * machine. Default value is false.
   */
  enableVMAgentPlatformUpdates?: boolean;
}

/** SSH configuration for Linux based VMs running on Azure */
export interface SshConfiguration {
  /** The list of SSH public keys used to authenticate with linux based VMs. */
  publicKeys?: SshPublicKey[];
}

/**
 * Contains information about SSH certificate public key and the path on the Linux
 * VM where the public key is placed.
 */
export interface SshPublicKey {
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

/** Specifies settings related to VM Guest Patching on Linux. */
export interface LinuxPatchSettings {
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
export interface LinuxVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
   */
  rebootSetting?: LinuxVMGuestPatchAutomaticByPlatformRebootSetting;
  /** Enables customer to schedule patching without accidental upgrades */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}

/** Describes a set of certificates which are all in the same Key Vault. */
export interface VaultSecretGroup {
  /**
   * The relative URL of the Key Vault containing all of the certificates in
   * VaultCertificates.
   */
  sourceVault?: SubResource;
  /** The list of key vault references in SourceVault which contain certificates. */
  vaultCertificates?: VaultCertificate[];
}

/** Describes SubResource */
export interface SubResource {
  /** Resource Id */
  id?: string;
}

/**
 * Describes a single certificate reference in a Key Vault, and where the
 * certificate should reside on the VM.
 */
export interface VaultCertificate {
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
  certificateUrl?: string;
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

/** Describes a virtual machine scale set storage profile. */
export interface VirtualMachineScaleSetStorageProfile {
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
  dataDisks?: VirtualMachineScaleSetDataDisk[];
  /** Specifies the disk controller type configured for the virtual machines in the scale set. Minimum api-version: 2022-08-01 */
  diskControllerType?: DiskControllerTypes;
}

/**
 * Specifies information about the image to use. You can specify information about
 * platform images, marketplace images, or virtual machine images. This element is
 * required when you want to use a platform image, marketplace image, or virtual
 * machine image, but is not used in other creation operations. NOTE: Image
 * reference publisher and offer can only be set when you create the scale set.
 */
export interface ImageReference {
  /** Resource Id */
  id?: string;
  /** The image publisher. */
  publisher?: string;
  /**
   * Specifies the offer of the platform image or marketplace image used to create
   * the virtual machine.
   */
  offer?: string;
  /** The image SKU. */
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
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly exactVersion?: string;
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

/** Describes a virtual machine scale set operating system disk. */
export interface VirtualMachineScaleSetOSDisk {
  /** The disk name. */
  name?: string;
  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;
  /** Specifies whether writeAccelerator should be enabled or disabled on the disk. */
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
  diskSizeGB?: number;
  /**
   * This property allows you to specify the type of the OS that is included in the
   * disk if creating a VM from user-image or a specialized VHD. Possible values
   * are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;
  /** Specifies information about the unmanaged user image to base the scale set on. */
  image?: VirtualHardDisk;
  /**
   * Specifies the container urls that are used to store operating system disks for
   * the scale set.
   */
  vhdContainers?: string[];
  /** The managed disk parameters. */
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
export interface DiffDiskSettings {
  /** Specifies the ephemeral disk settings for operating system disk. */
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

/** Describes the uri of a disk. */
export interface VirtualHardDisk {
  /** Specifies the virtual hard disk's uri. */
  uri?: string;
}

/** Describes the parameters of a ScaleSet managed disk. */
export interface VirtualMachineScaleSetManagedDiskParameters {
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
  /** Specifies the security profile for the managed disk. */
  securityProfile?: VMDiskSecurityProfile;
}

/**
 * Describes the parameter of customer managed disk encryption set resource id
 * that can be specified for disk. **Note:** The disk encryption set resource id
 * can only be specified for managed disk. Please refer
 * https://aka.ms/mdssewithcmkoverview for more details.
 */
export interface DiskEncryptionSetParameters {
  /** Resource Id */
  id?: string;
}

/**
 * Specifies the security profile settings for the managed disk. **Note:** It can
 * only be set for Confidential VMs.
 */
export interface VMDiskSecurityProfile {
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

/** Describes a virtual machine scale set data disk. */
export interface VirtualMachineScaleSetDataDisk {
  /** The disk name. */
  name?: string;
  /**
   * Specifies the logical unit number of the data disk. This value is used to
   * identify data disks within the VM and therefore must be unique for each data
   * disk attached to a VM.
   */
  lun: number;
  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;
  /** Specifies whether writeAccelerator should be enabled or disabled on the disk. */
  writeAcceleratorEnabled?: boolean;
  /** The create option. */
  createOption: DiskCreateOptionTypes;
  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be
   * larger than 1023.
   */
  diskSizeGB?: number;
  /** The managed disk parameters. */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;
  /**
   * Specifies the Read-Write IOPS for the managed disk. Should be used only when
   * StorageAccountType is UltraSSD_LRS. If not specified, a default value would be
   * assigned based on diskSizeGB.
   */
  diskIopsReadWrite?: number;
  /**
   * Specifies the bandwidth in MB per second for the managed disk. Should be used
   * only when StorageAccountType is UltraSSD_LRS. If not specified, a default value
   * would be assigned based on diskSizeGB.
   */
  diskMBpsReadWrite?: number;
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

/** Describes a virtual machine scale set network profile. */
export interface VirtualMachineScaleSetNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an
   * instance in the virtual machine scale set. The reference will be in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;
  /** The list of network configurations. */
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];
  /**
   * specifies the Microsoft.Network API version used when creating networking
   * resources in the Network Interface Configurations for Virtual Machine Scale Set
   * with orchestration mode 'Flexible'
   */
  networkApiVersion?: NetworkApiVersion;
}

/** The API entity reference. */
export interface ApiEntityReference {
  /**
   * The ARM resource id in the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: string;
}

/** Describes a virtual machine scale set network profile's network configurations. */
export interface VirtualMachineScaleSetNetworkConfiguration {
  /** The network configuration name. */
  name: string;
  /** Describes a virtual machine scale set network profile's IP configuration. */
  properties?: VirtualMachineScaleSetNetworkConfigurationProperties;
}

/** Describes a virtual machine scale set network profile's IP configuration. */
export interface VirtualMachineScaleSetNetworkConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;
  /** Specifies whether the network interface is accelerated networking-enabled. */
  enableAcceleratedNetworking?: boolean;
  /** Specifies whether the network interface is disabled for tcp state tracking. */
  disableTcpStateTracking?: boolean;
  /** Specifies whether the network interface is FPGA networking-enabled. */
  enableFpga?: boolean;
  /** The network security group. */
  networkSecurityGroup?: SubResource;
  /** The dns settings to be applied on the network interfaces. */
  dnsSettings?: VirtualMachineScaleSetNetworkConfigurationDnsSettings;
  /** Specifies the IP configurations of the network interface. */
  ipConfigurations: VirtualMachineScaleSetIPConfiguration[];
  /** Whether IP forwarding enabled on this NIC. */
  enableIPForwarding?: boolean;
  /** Specify what happens to the network interface when the VM is deleted */
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

/** Describes a virtual machines scale sets network configuration's DNS settings. */
export interface VirtualMachineScaleSetNetworkConfigurationDnsSettings {
  /** List of DNS servers IP addresses */
  dnsServers?: string[];
}

/** Describes a virtual machine scale set network profile's IP configuration. */
export interface VirtualMachineScaleSetIPConfiguration {
  /** The IP configuration name. */
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
export interface VirtualMachineScaleSetIPConfigurationProperties {
  /** Specifies the identifier of the subnet. */
  subnet?: ApiEntityReference;
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;
  /** The publicIPAddressConfiguration. */
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
  /** Specifies an array of references to application security group. */
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
export interface VirtualMachineScaleSetPublicIPAddressConfiguration {
  /** The publicIP address configuration name. */
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
export interface VirtualMachineScaleSetPublicIPAddressConfigurationProperties {
  /** The idle timeout of the public IP address. */
  idleTimeoutInMinutes?: number;
  /** The dns settings to be applied on the publicIP addresses . */
  dnsSettings?: VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings;
  /** The list of IP tags associated with the public IP address. */
  ipTags?: VirtualMachineScaleSetIpTag[];
  /** The PublicIPPrefix from which to allocate publicIP addresses. */
  publicIPPrefix?: SubResource;
  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  publicIPAddressVersion?: IPVersion;
  /** Specify what happens to the public IP when the VM is deleted */
  deleteOption?: DeleteOptions;
}

/** Describes a virtual machines scale sets network configuration's DNS settings. */
export interface VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings {
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

/** Contains the IP tag associated with the public IP address. */
export interface VirtualMachineScaleSetIpTag {
  /** IP tag type. Example: FirstPartyUsage. */
  ipTagType?: string;
  /** IP tag associated with the public IP. Example: SQL, Storage etc. */
  tag?: string;
}

/**
 * Describes the public IP Sku. It can only be set with OrchestrationMode as
 * Flexible.
 */
export interface PublicIPAddressSku {
  /** Specify public IP sku name */
  name?: PublicIPAddressSkuName;
  /** Specify public IP sku tier */
  tier?: PublicIPAddressSkuTier;
}

/**
 * Specifies the Security profile settings for the virtual machine or virtual
 * machine scale set.
 */
export interface SecurityProfile {
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
export interface UefiSettings {
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
export interface EncryptionIdentity {
  /** Specifies ARM Resource ID of one of the user identities associated with the VM. */
  userAssignedIdentityResourceId?: string;
}

/**
 * Specifies ProxyAgent settings while creating the virtual machine. Minimum
 * api-version: 2023-09-01.
 */
export interface ProxyAgentSettings {
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
  keyIncarnationId?: number;
}

/** Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15. */
export interface DiagnosticsProfile {
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
export interface BootDiagnostics {
  /** Whether boot diagnostics should be enabled on the Virtual Machine. */
  enabled?: boolean;
  /**
   * Uri of the storage account to use for placing the console output and
   * screenshot. If storageUri is not specified while enabling boot diagnostics,
   * managed storage will be used.
   */
  storageUri?: string;
}

/** Describes a virtual machine scale set extension profile. */
export interface VirtualMachineScaleSetExtensionProfile {
  /** The virtual machine scale set child extension resources. */
  extensions?: VirtualMachineScaleSetExtension[];
  /**
   * Specifies the time alloted for all extensions to start. The time duration
   * should be between 15 minutes and 120 minutes (inclusive) and should be
   * specified in ISO 8601 format. The default value is 90 minutes (PT1H30M).
   * Minimum api-version: 2020-06-01.
   */
  extensionsTimeBudget?: string;
}

/** Describes a Virtual Machine Scale Set Extension. */
export interface VirtualMachineScaleSetExtension {
  /**
   * Resource Id
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /** The name of the extension. */
  name?: string;
  /**
   * Resource type
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /** Describes the properties of a Virtual Machine Scale Set Extension. */
  properties?: VirtualMachineScaleSetExtensionProperties;
}

/** Describes the properties of a Virtual Machine Scale Set Extension. */
export interface VirtualMachineScaleSetExtensionProperties {
  /**
   * If a value is provided and is different from the previous value, the extension
   * handler will be forced to update even if the extension configuration has not
   * changed.
   */
  forceUpdateTag?: string;
  /** The name of the extension handler publisher. */
  publisher?: string;
  /** Specifies the type of the extension; an example is "CustomScriptExtension". */
  type?: string;
  /** Specifies the version of the script handler. */
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
  /** Json formatted public settings for the extension. */
  settings?: { [propertyName: string]: any };
  /**
   * The extension can contain either protectedSettings or
   * protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: { [propertyName: string]: any };
  /**
   * The provisioning state, which only appears in the response.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: string;
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

/** Describes a reference to Key Vault Secret */
export interface KeyVaultSecretReference {
  /** The URL referencing a secret in a Key Vault. */
  secretUrl: string;
  /** The relative URL of the Key Vault containing the secret. */
  sourceVault: SubResource;
}

/** Specifies Scheduled Event related configurations. */
export interface ScheduledEventsProfile {
  /** Specifies Terminate Scheduled Event related configurations. */
  terminateNotificationProfile?: TerminateNotificationProfile;
  /** Specifies OS Image Scheduled Event related configurations. */
  osImageNotificationProfile?: OSImageNotificationProfile;
}

/** Specifies Terminate Scheduled Event related configurations. */
export interface TerminateNotificationProfile {
  /**
   * Configurable length of time a Virtual Machine being deleted will have to
   * potentially approve the Terminate Scheduled Event before the event is auto
   * approved (timed out). The configuration must be specified in ISO 8601 format,
   * the default value is 5 minutes (PT5M)
   */
  notBeforeTimeout?: string;
  /** Specifies whether the Terminate Scheduled event is enabled or disabled. */
  enable?: boolean;
}

/** Specifies OS Image Scheduled Event related configurations. */
export interface OSImageNotificationProfile {
  /**
   * Length of time a Virtual Machine being reimaged or having its OS upgraded will
   * have to potentially approve the OS Image Scheduled Event before the event is
   * auto approved (timed out). The configuration is specified in ISO 8601 format,
   * and the value must not exceed 15 minutes (PT15M)
   */
  notBeforeTimeout?: string;
  /** Specifies whether the OS Image Scheduled event is enabled or disabled. */
  enable?: boolean;
}

/** The parameters of a capacity reservation Profile. */
export interface CapacityReservationProfile {
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
export interface ApplicationProfile {
  /** Specifies the gallery applications that should be made available to the VM/VMSS */
  galleryApplications?: VMGalleryApplication[];
}

/**
 * Specifies the required information to reference a compute gallery application
 * version
 */
export interface VMGalleryApplication {
  /** Optional, Specifies a passthrough value for more generic context. */
  tags?: string;
  /** Optional, Specifies the order in which the packages have to be installed */
  order?: number;
  /**
   * Specifies the GalleryApplicationVersion resource id on the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}
   */
  packageReferenceId: string;
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

/** Specifies the hardware settings for the virtual machine scale set. */
export interface VirtualMachineScaleSetHardwareProfile {
  /**
   * Specifies the properties for customizing the size of the virtual machine.
   * Minimum api-version: 2021-11-01. Please follow the instructions in [VM
   * Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
}

/** Specifies VM Size Property settings on the virtual machine. */
export interface VMSizeProperties {
  /**
   * Specifies the number of vCPUs available for the VM. When this property is not
   * specified in the request body the default behavior is to set it to the value of
   * vCPUs available for that VM size exposed in api response of [List all available
   * virtual machine sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   */
  vCPUsAvailable?: number;
  /**
   * Specifies the vCPU to physical core ratio. When this property is not specified
   * in the request body the default behavior is set to the value of vCPUsPerCore
   * for the VM Size exposed in api response of [List all available virtual machine
   * sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   * **Setting this property to 1 also means that hyper-threading is disabled.**
   */
  vCPUsPerCore?: number;
}

/**
 * Specifies the service artifact reference id used to set same image version for
 * all virtual machines in the scale set when using 'latest' image version.
 * Minimum api-version: 2022-11-01
 */
export interface ServiceArtifactReference {
  /**
   * The service artifact reference id in the form of
   * /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  id?: string;
}

/**
 * Specifies the security posture to be used for all virtual machines in the scale
 * set. Minimum api-version: 2023-03-01
 */
export interface SecurityPostureReference {
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
  /** Whether the security posture can be overridden by the user. */
  isOverridable?: boolean;
}

/** Compute Profile to use for running user's workloads. */
export interface ComputeProfile {
  /** Base Virtual Machine Profile Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile" */
  baseVirtualMachineProfile: BaseVirtualMachineProfile;
  /**
   * Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machine scale sets and Virtual Machines.
   * The default value will be the latest supported computeApiVersion by Compute Fleet.
   */
  computeApiVersion?: string;
  /**
   * Specifies the number of fault domains to use when creating the underlying VMSS.
   * A fault domain is a logical group of hardware within an Azure datacenter.
   * VMs in the same fault domain share a common power source and network switch.
   * If not specified, defaults to 1, which represents "Max Spreading" (using as many fault domains as possible).
   * This property cannot be updated.
   */
  platformFaultDomainCount?: number;
  /**
   * Specifies VMSS and VM API entity models support two additional capabilities as of today: ultraSSDEnabled and hibernationEnabled.
   * ultraSSDEnabled: Enables UltraSSD_LRS storage account type on the VMSS VMs.
   * hibernationEnabled: Enables the hibernation capability on the VMSS VMs.
   * Default value is null if not specified. This property cannot be updated once set.
   */
  additionalVirtualMachineCapabilities?: AdditionalCapabilities;
}

/** AdditionalCapabilities for VM. */
export interface AdditionalCapabilities {
  /**
   * The flag that enables or disables a capability to have one or more managed data disks with UltraSSD_LRS storage account type on the VM or VMSS.
   * Managed disks with storage account type UltraSSD_LRS can be added to a virtual machine or virtual machine scale set only if this property is enabled.
   */
  ultraSSDEnabled?: boolean;
  /** The flag that enables or disables hibernation capability on the VM. */
  hibernationEnabled?: boolean;
}

/** Managed service identity (system assigned and/or user assigned identities) */
export interface ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly principalId?: string;
  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly tenantId?: string;
  /** Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed). */
  type: ManagedServiceIdentityType;
  /** The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests. */
  userAssignedIdentities?: {
    [propertyName: string]: UserAssignedIdentity | null;
  };
}

/** User assigned identity properties */
export interface UserAssignedIdentity {
  /**
   * The principal ID of the assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly principalId?: string;
  /**
   * The client ID of the assigned identity.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly clientId?: string;
}

/** Plan for the resource. */
export interface Plan {
  /** A user defined name of the 3rd Party Artifact that is being procured. */
  name: string;
  /** The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic */
  publisher: string;
  /** The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding. */
  product: string;
  /** A publisher provided promotion code as provisioned in Data Market for the said product/artifact. */
  promotionCode?: string;
  /** The version of the desired product/artifact. */
  version?: string;
}

/** Common fields that are returned in the response for all Azure Resource Manager resources */
export interface Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
  /**
   * The name of the resource
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name?: string;
  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly systemData?: SystemData;
}

/** Metadata pertaining to creation and last modification of the resource. */
export interface SystemData {
  /** The identity that created the resource. */
  createdBy?: string;
  /** The type of identity that created the resource. */
  createdByType?: CreatedByType;
  /** The timestamp of resource creation (UTC). */
  createdAt?: Date;
  /** The identity that last modified the resource. */
  lastModifiedBy?: string;
  /** The type of identity that last modified the resource. */
  lastModifiedByType?: CreatedByType;
  /** The timestamp of resource last modification (UTC) */
  lastModifiedAt?: Date;
}

/** Fleet Update Model */
export interface FleetUpdate {
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;
  /** Updatable resource plan */
  plan?: ResourcePlanUpdate;
  /** RP-specific updatable properties */
  properties?: FleetProperties;
}

/** The template for adding optional properties. */
export interface ManagedServiceIdentityUpdate {
  /** The type of managed identity assigned to this resource. */
  type?: ManagedServiceIdentityType;
  /** The identities assigned to this resource by the user. */
  userAssignedIdentities?: {
    [
      propertyName: string
    ]: ComponentsQjfoe3SchemasManagedserviceidentityupdatePropertiesUserassignedidentitiesAdditionalproperties | null;
  };
}

/** The template for adding optional properties. */
export interface ResourcePlanUpdate {
  /** A user defined name of the 3rd Party Artifact that is being procured. */
  name?: string;
  /** The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic */
  publisher?: string;
  /** The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding. */
  product?: string;
  /** A publisher provided promotion code as provisioned in Data Market for the said product/artifact. */
  promotionCode?: string;
  /** The version of the desired product/artifact. */
  version?: string;
}

/** The response of a VirtualMachineScaleSet list operation. */
export interface VirtualMachineScaleSetListResult {
  /** The VirtualMachineScaleSet items on this page */
  value: VirtualMachineScaleSet[];
  /** The link to the next page of items */
  nextLink?: string;
}

/** An AzureFleet's virtualMachineScaleSet */
export interface VirtualMachineScaleSet {
  /**
   * The name of the virtualMachineScaleSet
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly name: string;
  /**
   * The compute RP resource id of the virtualMachineScaleSet
   * "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}"
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id: string;
  /**
   * Type of the virtualMachineScaleSet
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly type?: string;
  /**
   * This represents the operationStatus of the VMSS in response to the last operation that was performed on it by Azure Fleet resource.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly operationStatus: ProvisioningState;
  /**
   * Error Information when `operationStatus` is `Failed`
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly error?: ApiError;
}

/** ApiError for Fleet */
export interface ApiError {
  /** The error code. */
  code?: string;
  /** The target of the particular error. */
  target?: string;
  /** The error message. */
  message?: string;
  /** The API error details */
  details?: ApiErrorBase[];
  /** The API inner error */
  innererror?: InnerError;
}

/** API error base. */
export interface ApiErrorBase {
  /** The error code. */
  code?: string;
  /** The target of the particular error. */
  target?: string;
  /** The error message. */
  message?: string;
}

/** Inner error details. */
export interface InnerError {
  /** The exception type. */
  exceptionType?: string;
  /** The internal error message or exception dump. */
  errorDetail?: string;
}

/** Contains common properties that are applicable to both Spot and Regular. */
export interface BasePriorityProfile {
  /** Total capacity to achieve. It is currently in terms of number of VMs. */
  capacity?: number;
  /** Minimum capacity to achieve which cannot be updated. If we will not be able to "guarantee" minimum capacity, we will reject the request in the sync path itself. */
  minCapacity?: number;
}

/** Describes a Readonly subresource. */
export interface SubResourceReadOnly {
  /**
   * Resource Id
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly id?: string;
}

/** List of VMAttributes that will be used to filter VMSizes which will be used to build Fleet. */
export interface VMAttributesList {
  /** List of VMAttributes that will be used to filter VMSizes which will be used to build Fleet. */
  vmAttributes: VMAttributes[];
}

export interface ComponentsQjfoe3SchemasManagedserviceidentityupdatePropertiesUserassignedidentitiesAdditionalproperties
  extends UserAssignedIdentity {}

/** The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location' */
export interface TrackedResource extends Resource {
  /** Resource tags. */
  tags?: { [propertyName: string]: string };
  /** The geo-location where the resource lives */
  location: string;
}

/** An Compute Fleet resource */
export interface Fleet extends TrackedResource {
  /** Zones in which the Compute Fleet is available */
  zones?: string[];
  /** The managed service identities assigned to this resource. */
  identity?: ManagedServiceIdentity;
  /** Details of the resource plan. */
  plan?: Plan;
  /**
   * The status of the last operation.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly provisioningState?: ProvisioningState;
  /** Configuration Options for Spot instances in Compute Fleet. */
  spotPriorityProfile?: SpotPriorityProfile;
  /** Configuration Options for Regular instances in Compute Fleet. */
  regularPriorityProfile?: RegularPriorityProfile;
  /** List of VM sizes supported for Compute Fleet */
  vmSizesProfile?: VmSizeProfile[];
  /** Attribute based Fleet. */
  vmAttributes?: VMAttributes;
  /** Represents the configuration for additional locations where Fleet resources may be deployed. */
  additionalLocationsProfile?: AdditionalLocationsProfile;
  /** Compute Profile to use for running user's workloads. */
  computeProfile?: ComputeProfile;
  /**
   * Specifies the time at which the Compute Fleet is created.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly timeCreated?: Date;
  /**
   * Specifies the ID which uniquely identifies a Compute Fleet.
   * NOTE: This property will not be serialized. It can only be populated by the server.
   */
  readonly uniqueId?: string;
}

/** Defines headers for Fleets_createOrUpdate operation. */
export interface FleetsCreateOrUpdateHeaders {
  /** The Retry-After header can indicate how long the client should wait before polling the operation status. */
  retryAfter?: number;
}

/** Defines headers for Fleets_update operation. */
export interface FleetsUpdateHeaders {
  /** The Location header contains the URL where the status of the long running operation can be checked. */
  location?: string;
  /** The Retry-After header can indicate how long the client should wait before polling the operation status. */
  retryAfter?: number;
}

/** Defines headers for Fleets_delete operation. */
export interface FleetsDeleteHeaders {
  /** The Location header contains the URL where the status of the long running operation can be checked. */
  location?: string;
  /** The Retry-After header can indicate how long the client should wait before polling the operation status. */
  retryAfter?: number;
}

/** Known values of {@link Origin} that the service accepts. */
export enum KnownOrigin {
  /** User */
  User = "user",
  /** System */
  System = "system",
  /** UserSystem */
  UserSystem = "user,system",
}

/**
 * Defines values for Origin. \
 * {@link KnownOrigin} can be used interchangeably with Origin,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **user** \
 * **system** \
 * **user,system**
 */
export type Origin = string;

/** Known values of {@link ActionType} that the service accepts. */
export enum KnownActionType {
  /** Internal */
  Internal = "Internal",
}

/**
 * Defines values for ActionType. \
 * {@link KnownActionType} can be used interchangeably with ActionType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Internal**
 */
export type ActionType = string;

/** Known values of {@link ProvisioningState} that the service accepts. */
export enum KnownProvisioningState {
  /** Resource has been created. */
  Succeeded = "Succeeded",
  /** Resource creation failed. */
  Failed = "Failed",
  /** Resource creation was canceled. */
  Canceled = "Canceled",
  /** Initial creation in progress. */
  Creating = "Creating",
  /** Update in progress. */
  Updating = "Updating",
  /** Deletion in progress. */
  Deleting = "Deleting",
  /** Resource is being migrated from one subscription or resource group to another. */
  Migrating = "Migrating",
}

/**
 * Defines values for ProvisioningState. \
 * {@link KnownProvisioningState} can be used interchangeably with ProvisioningState,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Succeeded**: Resource has been created. \
 * **Failed**: Resource creation failed. \
 * **Canceled**: Resource creation was canceled. \
 * **Creating**: Initial creation in progress. \
 * **Updating**: Update in progress. \
 * **Deleting**: Deletion in progress. \
 * **Migrating**: Resource is being migrated from one subscription or resource group to another.
 */
export type ProvisioningState = string;

/** Known values of {@link EvictionPolicy} that the service accepts. */
export enum KnownEvictionPolicy {
  /** When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this. */
  Delete = "Delete",
  /** When evicted, the Spot VM will be deallocated\/stopped */
  Deallocate = "Deallocate",
}

/**
 * Defines values for EvictionPolicy. \
 * {@link KnownEvictionPolicy} can be used interchangeably with EvictionPolicy,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Delete**: When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this. \
 * **Deallocate**: When evicted, the Spot VM will be deallocated\/stopped
 */
export type EvictionPolicy = string;

/** Known values of {@link SpotAllocationStrategy} that the service accepts. */
export enum KnownSpotAllocationStrategy {
  /** Default. VM sizes distribution will be determined to optimize for both price and capacity. */
  PriceCapacityOptimized = "PriceCapacityOptimized",
  /** VM sizes distribution will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight. */
  LowestPrice = "LowestPrice",
  /** VM sizes distribution will be determined to optimize for capacity. */
  CapacityOptimized = "CapacityOptimized",
}

/**
 * Defines values for SpotAllocationStrategy. \
 * {@link KnownSpotAllocationStrategy} can be used interchangeably with SpotAllocationStrategy,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **PriceCapacityOptimized**: Default. VM sizes distribution will be determined to optimize for both price and capacity. \
 * **LowestPrice**: VM sizes distribution will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight. \
 * **CapacityOptimized**: VM sizes distribution will be determined to optimize for capacity.
 */
export type SpotAllocationStrategy = string;

/** Known values of {@link RegularPriorityAllocationStrategy} that the service accepts. */
export enum KnownRegularPriorityAllocationStrategy {
  /** Default. VM sizes distribution will be determined to optimize for price. */
  LowestPrice = "LowestPrice",
  /** VM sizes distribution will be determined to optimize for the 'priority' as specified for each vm size. */
  Prioritized = "Prioritized",
}

/**
 * Defines values for RegularPriorityAllocationStrategy. \
 * {@link KnownRegularPriorityAllocationStrategy} can be used interchangeably with RegularPriorityAllocationStrategy,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **LowestPrice**: Default. VM sizes distribution will be determined to optimize for price. \
 * **Prioritized**: VM sizes distribution will be determined to optimize for the 'priority' as specified for each vm size.
 */
export type RegularPriorityAllocationStrategy = string;

/** Known values of {@link VMAttributeSupport} that the service accepts. */
export enum KnownVMAttributeSupport {
  /** All VMSizes having the feature support will be excluded. */
  Excluded = "Excluded",
  /** SDD DiskType. */
  Included = "Included",
  /** VMSizes that have the feature support and that do not have the feature support will be used. */
  Required = "Required",
}

/**
 * Defines values for VMAttributeSupport. \
 * {@link KnownVMAttributeSupport} can be used interchangeably with VMAttributeSupport,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Excluded**: All VMSizes having the feature support will be excluded. \
 * **Included**: SDD DiskType. \
 * **Required**: VMSizes that have the feature support and that do not have the feature support will be used.
 */
export type VMAttributeSupport = string;

/** Known values of {@link LocalStorageDiskType} that the service accepts. */
export enum KnownLocalStorageDiskType {
  /** HDD DiskType. */
  HDD = "HDD",
  /** SDD DiskType. */
  SSD = "SSD",
}

/**
 * Defines values for LocalStorageDiskType. \
 * {@link KnownLocalStorageDiskType} can be used interchangeably with LocalStorageDiskType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **HDD**: HDD DiskType. \
 * **SSD**: SDD DiskType.
 */
export type LocalStorageDiskType = string;

/** Known values of {@link GpuManufacturer} that the service accepts. */
export enum KnownGpuManufacturer {
  /** Intel GpuType */
  Intel = "Intel",
  /** AMD GpuType */
  AMD = "AMD",
  /** Nvidia GpuType */
  Nvidia = "Nvidia",
}

/**
 * Defines values for GpuManufacturer. \
 * {@link KnownGpuManufacturer} can be used interchangeably with GpuManufacturer,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Intel**: Intel GpuType \
 * **AMD**: AMD GpuType \
 * **Nvidia**: Nvidia GpuType
 */
export type GpuManufacturer = string;

/** Known values of {@link VMCategory} that the service accepts. */
export enum KnownVMCategory {
  /** GeneralPurpose VM. */
  GeneralPurpose = "GeneralPurpose",
  /** ComputeOptimized VM. */
  ComputeOptimized = "ComputeOptimized",
  /** MemoryOptimized VM. */
  MemoryOptimized = "MemoryOptimized",
  /** StorageOptimized VM. */
  StorageOptimized = "StorageOptimized",
  /** GpuAccelerated VM. */
  GpuAccelerated = "GpuAccelerated",
  /** FpgaAccelerated VM. */
  FpgaAccelerated = "FpgaAccelerated",
}

/**
 * Defines values for VMCategory. \
 * {@link KnownVMCategory} can be used interchangeably with VMCategory,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **GeneralPurpose**: GeneralPurpose VM. \
 * **ComputeOptimized**: ComputeOptimized VM. \
 * **MemoryOptimized**: MemoryOptimized VM. \
 * **StorageOptimized**: StorageOptimized VM. \
 * **GpuAccelerated**: GpuAccelerated VM. \
 * **FpgaAccelerated**: FpgaAccelerated VM.
 */
export type VMCategory = string;

/** Known values of {@link ArchitectureType} that the service accepts. */
export enum KnownArchitectureType {
  /** Intel Architecture */
  Intel = "Intel",
  /** AMD Architecture */
  AMD = "AMD",
}

/**
 * Defines values for ArchitectureType. \
 * {@link KnownArchitectureType} can be used interchangeably with ArchitectureType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Intel**: Intel Architecture \
 * **AMD**: AMD Architecture
 */
export type ArchitectureType = string;

/** Known values of {@link CpuManufacturer} that the service accepts. */
export enum KnownCpuManufacturer {
  /** Intel CPU. */
  Intel = "Intel",
  /** AMD CPU. */
  AMD = "AMD",
}

/**
 * Defines values for CpuManufacturer. \
 * {@link KnownCpuManufacturer} can be used interchangeably with CpuManufacturer,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Intel**: Intel CPU. \
 * **AMD**: AMD CPU.
 */
export type CpuManufacturer = string;

/** Known values of {@link SettingNames} that the service accepts. */
export enum KnownSettingNames {
  /** AutoLogon setting */
  AutoLogon = "AutoLogon",
  /** FirstLogonCommands setting */
  FirstLogonCommands = "FirstLogonCommands",
}

/**
 * Defines values for SettingNames. \
 * {@link KnownSettingNames} can be used interchangeably with SettingNames,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **AutoLogon**: AutoLogon setting \
 * **FirstLogonCommands**: FirstLogonCommands setting
 */
export type SettingNames = string;

/** Known values of {@link WindowsVMGuestPatchMode} that the service accepts. */
export enum KnownWindowsVMGuestPatchMode {
  /**
   * You control the application of patches to a virtual machine.
   * You do this by applying patches manually inside the VM. In this mode,
   * automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates
   * must be false
   */
  Manual = "Manual",
  /**
   * The virtual machine will automatically be updated by the OS.
   * The property WindowsConfiguration.enableAutomaticUpdates must be true.
   */
  AutomaticByOS = "AutomaticByOS",
  /**
   * The virtual machine will automatically updated by the platform. The properties
   * provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true.
   */
  AutomaticByPlatform = "AutomaticByPlatform",
}

/**
 * Defines values for WindowsVMGuestPatchMode. \
 * {@link KnownWindowsVMGuestPatchMode} can be used interchangeably with WindowsVMGuestPatchMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Manual**: You control the application of patches to a virtual machine.
 * You do this by applying patches manually inside the VM. In this mode,
 * automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates
 * must be false \
 * **AutomaticByOS**: The virtual machine will automatically be updated by the OS.
 * The property WindowsConfiguration.enableAutomaticUpdates must be true. \
 * **AutomaticByPlatform**: The virtual machine will automatically updated by the platform. The properties
 * provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true.
 */
export type WindowsVMGuestPatchMode = string;

/** Known values of {@link WindowsPatchAssessmentMode} that the service accepts. */
export enum KnownWindowsPatchAssessmentMode {
  /** You control the timing of patch assessments on a virtual machine. */
  ImageDefault = "ImageDefault",
  /** The platform will trigger periodic patch assessments. The property provisionVMAgent must be true. */
  AutomaticByPlatform = "AutomaticByPlatform",
}

/**
 * Defines values for WindowsPatchAssessmentMode. \
 * {@link KnownWindowsPatchAssessmentMode} can be used interchangeably with WindowsPatchAssessmentMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ImageDefault**: You control the timing of patch assessments on a virtual machine. \
 * **AutomaticByPlatform**: The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
 */
export type WindowsPatchAssessmentMode = string;

/** Known values of {@link WindowsVMGuestPatchAutomaticByPlatformRebootSetting} that the service accepts. */
export enum KnownWindowsVMGuestPatchAutomaticByPlatformRebootSetting {
  /** Unknown Reboot setting */
  Unknown = "Unknown",
  /** IfRequired Reboot setting */
  IfRequired = "IfRequired",
  /** Never Reboot setting */
  Never = "Never",
  /** Always Reboot setting */
  Always = "Always",
}

/**
 * Defines values for WindowsVMGuestPatchAutomaticByPlatformRebootSetting. \
 * {@link KnownWindowsVMGuestPatchAutomaticByPlatformRebootSetting} can be used interchangeably with WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown**: Unknown Reboot setting \
 * **IfRequired**: IfRequired Reboot setting \
 * **Never**: Never Reboot setting \
 * **Always**: Always Reboot setting
 */
export type WindowsVMGuestPatchAutomaticByPlatformRebootSetting = string;

/** Known values of {@link ProtocolTypes} that the service accepts. */
export enum KnownProtocolTypes {
  /** Http protocol */
  Http = "Http",
  /** Https protocol */
  Https = "Https",
}

/**
 * Defines values for ProtocolTypes. \
 * {@link KnownProtocolTypes} can be used interchangeably with ProtocolTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Http**: Http protocol \
 * **Https**: Https protocol
 */
export type ProtocolTypes = string;

/** Known values of {@link LinuxVMGuestPatchMode} that the service accepts. */
export enum KnownLinuxVMGuestPatchMode {
  /** The virtual machine's default patching configuration is used. */
  ImageDefault = "ImageDefault",
  /** The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true. */
  AutomaticByPlatform = "AutomaticByPlatform",
}

/**
 * Defines values for LinuxVMGuestPatchMode. \
 * {@link KnownLinuxVMGuestPatchMode} can be used interchangeably with LinuxVMGuestPatchMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ImageDefault**: The virtual machine's default patching configuration is used. \
 * **AutomaticByPlatform**: The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true.
 */
export type LinuxVMGuestPatchMode = string;

/** Known values of {@link LinuxPatchAssessmentMode} that the service accepts. */
export enum KnownLinuxPatchAssessmentMode {
  /** You control the timing of patch assessments on a virtual machine. */
  ImageDefault = "ImageDefault",
  /** The platform will trigger periodic patch assessments.The property provisionVMAgent must be true. */
  AutomaticByPlatform = "AutomaticByPlatform",
}

/**
 * Defines values for LinuxPatchAssessmentMode. \
 * {@link KnownLinuxPatchAssessmentMode} can be used interchangeably with LinuxPatchAssessmentMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **ImageDefault**: You control the timing of patch assessments on a virtual machine. \
 * **AutomaticByPlatform**: The platform will trigger periodic patch assessments.The property provisionVMAgent must be true.
 */
export type LinuxPatchAssessmentMode = string;

/** Known values of {@link LinuxVMGuestPatchAutomaticByPlatformRebootSetting} that the service accepts. */
export enum KnownLinuxVMGuestPatchAutomaticByPlatformRebootSetting {
  /** Unknown Reboot setting */
  Unknown = "Unknown",
  /** IfRequired Reboot setting */
  IfRequired = "IfRequired",
  /** Never Reboot setting */
  Never = "Never",
  /** Always Reboot setting */
  Always = "Always",
}

/**
 * Defines values for LinuxVMGuestPatchAutomaticByPlatformRebootSetting. \
 * {@link KnownLinuxVMGuestPatchAutomaticByPlatformRebootSetting} can be used interchangeably with LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Unknown**: Unknown Reboot setting \
 * **IfRequired**: IfRequired Reboot setting \
 * **Never**: Never Reboot setting \
 * **Always**: Always Reboot setting
 */
export type LinuxVMGuestPatchAutomaticByPlatformRebootSetting = string;

/** Known values of {@link CachingTypes} that the service accepts. */
export enum KnownCachingTypes {
  /** 'None' is default for Standard Storage */
  None = "None",
  /** 'ReadOnly' is default for Premium Storage */
  ReadOnly = "ReadOnly",
  /** 'ReadWrite' is default for OS Disk */
  ReadWrite = "ReadWrite",
}

/**
 * Defines values for CachingTypes. \
 * {@link KnownCachingTypes} can be used interchangeably with CachingTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None**: 'None' is default for Standard Storage \
 * **ReadOnly**: 'ReadOnly' is default for Premium Storage \
 * **ReadWrite**: 'ReadWrite' is default for OS Disk
 */
export type CachingTypes = string;

/** Known values of {@link DiskCreateOptionTypes} that the service accepts. */
export enum KnownDiskCreateOptionTypes {
  /**
   * This value is used when you are using an image to create the virtual machine.
   * If you are using a platform image, you also use the imageReference element
   * described above. If you are using a marketplace image, you also use the
   * plan element previously described.
   */
  FromImage = "FromImage",
  /** This value is used when creating an empty data disk. */
  Empty = "Empty",
  /** This value is used when you are using a specialized disk to create the virtual machine. */
  Attach = "Attach",
  /** This value is used to create a data disk from a snapshot or another disk. */
  Copy = "Copy",
  /** This value is used to create a data disk from a disk restore point. */
  Restore = "Restore",
}

/**
 * Defines values for DiskCreateOptionTypes. \
 * {@link KnownDiskCreateOptionTypes} can be used interchangeably with DiskCreateOptionTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **FromImage**: This value is used when you are using an image to create the virtual machine.
 * If you are using a platform image, you also use the imageReference element
 * described above. If you are using a marketplace image, you also use the
 * plan element previously described. \
 * **Empty**: This value is used when creating an empty data disk. \
 * **Attach**: This value is used when you are using a specialized disk to create the virtual machine. \
 * **Copy**: This value is used to create a data disk from a snapshot or another disk. \
 * **Restore**: This value is used to create a data disk from a disk restore point.
 */
export type DiskCreateOptionTypes = string;

/** Known values of {@link DiffDiskOptions} that the service accepts. */
export enum KnownDiffDiskOptions {
  /** Local Option. */
  Local = "Local",
}

/**
 * Defines values for DiffDiskOptions. \
 * {@link KnownDiffDiskOptions} can be used interchangeably with DiffDiskOptions,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Local**: Local Option.
 */
export type DiffDiskOptions = string;

/** Known values of {@link DiffDiskPlacement} that the service accepts. */
export enum KnownDiffDiskPlacement {
  /** CacheDisk option. */
  CacheDisk = "CacheDisk",
  /** Resource Disk option. */
  ResourceDisk = "ResourceDisk",
  /** NvmeDisk option. */
  NvmeDisk = "NvmeDisk",
}

/**
 * Defines values for DiffDiskPlacement. \
 * {@link KnownDiffDiskPlacement} can be used interchangeably with DiffDiskPlacement,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **CacheDisk**: CacheDisk option. \
 * **ResourceDisk**: Resource Disk option. \
 * **NvmeDisk**: NvmeDisk option.
 */
export type DiffDiskPlacement = string;

/** Known values of {@link OperatingSystemTypes} that the service accepts. */
export enum KnownOperatingSystemTypes {
  /** Windows OS type */
  Windows = "Windows",
  /** Linux OS type */
  Linux = "Linux",
}

/**
 * Defines values for OperatingSystemTypes. \
 * {@link KnownOperatingSystemTypes} can be used interchangeably with OperatingSystemTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Windows**: Windows OS type \
 * **Linux**: Linux OS type
 */
export type OperatingSystemTypes = string;

/** Known values of {@link StorageAccountTypes} that the service accepts. */
export enum KnownStorageAccountTypes {
  /** Standard_LRS option. */
  StandardLRS = "Standard_LRS",
  /** Premium_LRS option. */
  PremiumLRS = "Premium_LRS",
  /** StandardSSD_LRS option. */
  StandardSSDLRS = "StandardSSD_LRS",
  /** UltraSSD_LRS option. */
  UltraSSDLRS = "UltraSSD_LRS",
  /** Premium_ZRS option. */
  PremiumZRS = "Premium_ZRS",
  /** StandardSSD_ZRS option. */
  StandardSSDZRS = "StandardSSD_ZRS",
  /** PremiumV2_LRS option. */
  PremiumV2LRS = "PremiumV2_LRS",
}

/**
 * Defines values for StorageAccountTypes. \
 * {@link KnownStorageAccountTypes} can be used interchangeably with StorageAccountTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Standard_LRS**: Standard_LRS option. \
 * **Premium_LRS**: Premium_LRS option. \
 * **StandardSSD_LRS**: StandardSSD_LRS option. \
 * **UltraSSD_LRS**: UltraSSD_LRS option. \
 * **Premium_ZRS**: Premium_ZRS option. \
 * **StandardSSD_ZRS**: StandardSSD_ZRS option. \
 * **PremiumV2_LRS**: PremiumV2_LRS option.
 */
export type StorageAccountTypes = string;

/** Known values of {@link SecurityEncryptionTypes} that the service accepts. */
export enum KnownSecurityEncryptionTypes {
  /**
   * EncryptionType of the managed disk is set to VMGuestStateOnly for encryption
   * of just the VMGuestState blob.
   */
  VMGuestStateOnly = "VMGuestStateOnly",
  /**
   * EncryptionType of the managed disk is set to DiskWithVMGuestState for encryption
   * of the managed disk along with VMGuestState blob.
   */
  DiskWithVMGuestState = "DiskWithVMGuestState",
  /**
   * EncryptionType of the managed disk is set to NonPersistedTPM for not persisting
   * firmware state in the VMGuestState blob.
   */
  NonPersistedTPM = "NonPersistedTPM",
}

/**
 * Defines values for SecurityEncryptionTypes. \
 * {@link KnownSecurityEncryptionTypes} can be used interchangeably with SecurityEncryptionTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **VMGuestStateOnly**: EncryptionType of the managed disk is set to VMGuestStateOnly for encryption
 * of just the VMGuestState blob. \
 * **DiskWithVMGuestState**: EncryptionType of the managed disk is set to DiskWithVMGuestState for encryption
 * of the managed disk along with VMGuestState blob. \
 * **NonPersistedTPM**: EncryptionType of the managed disk is set to NonPersistedTPM for not persisting
 * firmware state in the VMGuestState blob.
 */
export type SecurityEncryptionTypes = string;

/** Known values of {@link DiskDeleteOptionTypes} that the service accepts. */
export enum KnownDiskDeleteOptionTypes {
  /** If this value is used, the managed disk is deleted when VM gets deleted. */
  Delete = "Delete",
  /** If this value is used, the managed disk is retained after VM gets deleted. */
  Detach = "Detach",
}

/**
 * Defines values for DiskDeleteOptionTypes. \
 * {@link KnownDiskDeleteOptionTypes} can be used interchangeably with DiskDeleteOptionTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Delete**: If this value is used, the managed disk is deleted when VM gets deleted. \
 * **Detach**: If this value is used, the managed disk is retained after VM gets deleted.
 */
export type DiskDeleteOptionTypes = string;

/** Known values of {@link DiskControllerTypes} that the service accepts. */
export enum KnownDiskControllerTypes {
  /** SCSI disk type */
  Scsi = "SCSI",
  /** NVMe disk type */
  NVMe = "NVMe",
}

/**
 * Defines values for DiskControllerTypes. \
 * {@link KnownDiskControllerTypes} can be used interchangeably with DiskControllerTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **SCSI**: SCSI disk type \
 * **NVMe**: NVMe disk type
 */
export type DiskControllerTypes = string;

/** Known values of {@link DomainNameLabelScopeTypes} that the service accepts. */
export enum KnownDomainNameLabelScopeTypes {
  /** TenantReuse type */
  TenantReuse = "TenantReuse",
  /** SubscriptionReuse type */
  SubscriptionReuse = "SubscriptionReuse",
  /** ResourceGroupReuse type */
  ResourceGroupReuse = "ResourceGroupReuse",
  /** NoReuse type */
  NoReuse = "NoReuse",
}

/**
 * Defines values for DomainNameLabelScopeTypes. \
 * {@link KnownDomainNameLabelScopeTypes} can be used interchangeably with DomainNameLabelScopeTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TenantReuse**: TenantReuse type \
 * **SubscriptionReuse**: SubscriptionReuse type \
 * **ResourceGroupReuse**: ResourceGroupReuse type \
 * **NoReuse**: NoReuse type
 */
export type DomainNameLabelScopeTypes = string;

/** Known values of {@link IPVersion} that the service accepts. */
export enum KnownIPVersion {
  /** IPv4 version */
  IPv4 = "IPv4",
  /** IPv6 version */
  IPv6 = "IPv6",
}

/**
 * Defines values for IPVersion. \
 * {@link KnownIPVersion} can be used interchangeably with IPVersion,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **IPv4**: IPv4 version \
 * **IPv6**: IPv6 version
 */
export type IPVersion = string;

/** Known values of {@link DeleteOptions} that the service accepts. */
export enum KnownDeleteOptions {
  /** Delete Option */
  Delete = "Delete",
  /** Detach Option */
  Detach = "Detach",
}

/**
 * Defines values for DeleteOptions. \
 * {@link KnownDeleteOptions} can be used interchangeably with DeleteOptions,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Delete**: Delete Option \
 * **Detach**: Detach Option
 */
export type DeleteOptions = string;

/** Known values of {@link PublicIPAddressSkuName} that the service accepts. */
export enum KnownPublicIPAddressSkuName {
  /** Basic sku name */
  Basic = "Basic",
  /** Standard sku name */
  Standard = "Standard",
}

/**
 * Defines values for PublicIPAddressSkuName. \
 * {@link KnownPublicIPAddressSkuName} can be used interchangeably with PublicIPAddressSkuName,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Basic**: Basic sku name \
 * **Standard**: Standard sku name
 */
export type PublicIPAddressSkuName = string;

/** Known values of {@link PublicIPAddressSkuTier} that the service accepts. */
export enum KnownPublicIPAddressSkuTier {
  /** Regional sku tier */
  Regional = "Regional",
  /** Global sku tier */
  Global = "Global",
}

/**
 * Defines values for PublicIPAddressSkuTier. \
 * {@link KnownPublicIPAddressSkuTier} can be used interchangeably with PublicIPAddressSkuTier,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Regional**: Regional sku tier \
 * **Global**: Global sku tier
 */
export type PublicIPAddressSkuTier = string;

/** Known values of {@link NetworkInterfaceAuxiliaryMode} that the service accepts. */
export enum KnownNetworkInterfaceAuxiliaryMode {
  /** None Mode */
  None = "None",
  /** AcceleratedConnections Mode */
  AcceleratedConnections = "AcceleratedConnections",
  /** Floating Mode */
  Floating = "Floating",
}

/**
 * Defines values for NetworkInterfaceAuxiliaryMode. \
 * {@link KnownNetworkInterfaceAuxiliaryMode} can be used interchangeably with NetworkInterfaceAuxiliaryMode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None**: None Mode \
 * **AcceleratedConnections**: AcceleratedConnections Mode \
 * **Floating**: Floating Mode
 */
export type NetworkInterfaceAuxiliaryMode = string;

/** Known values of {@link NetworkInterfaceAuxiliarySku} that the service accepts. */
export enum KnownNetworkInterfaceAuxiliarySku {
  /** no sku */
  None = "None",
  /** A1 sku */
  A1 = "A1",
  /** A2 sku */
  A2 = "A2",
  /** A4 sku */
  A4 = "A4",
  /** A8 sku */
  A8 = "A8",
}

/**
 * Defines values for NetworkInterfaceAuxiliarySku. \
 * {@link KnownNetworkInterfaceAuxiliarySku} can be used interchangeably with NetworkInterfaceAuxiliarySku,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None**: no sku \
 * **A1**: A1 sku \
 * **A2**: A2 sku \
 * **A4**: A4 sku \
 * **A8**: A8 sku
 */
export type NetworkInterfaceAuxiliarySku = string;

/** Known values of {@link NetworkApiVersion} that the service accepts. */
export enum KnownNetworkApiVersion {
  /** Initial version supported. Later versions are supported as well. */
  V20201101 = "2020-11-01",
}

/**
 * Defines values for NetworkApiVersion. \
 * {@link KnownNetworkApiVersion} can be used interchangeably with NetworkApiVersion,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **2020-11-01**: Initial version supported. Later versions are supported as well.
 */
export type NetworkApiVersion = string;

/** Known values of {@link SecurityTypes} that the service accepts. */
export enum KnownSecurityTypes {
  /** TrustedLaunch security type */
  TrustedLaunch = "TrustedLaunch",
  /** ConfidentialVM security type */
  ConfidentialVM = "ConfidentialVM",
}

/**
 * Defines values for SecurityTypes. \
 * {@link KnownSecurityTypes} can be used interchangeably with SecurityTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **TrustedLaunch**: TrustedLaunch security type \
 * **ConfidentialVM**: ConfidentialVM security type
 */
export type SecurityTypes = string;

/** Known values of {@link Mode} that the service accepts. */
export enum KnownMode {
  /** Audit Mode */
  Audit = "Audit",
  /** Enforce Mode */
  Enforce = "Enforce",
}

/**
 * Defines values for Mode. \
 * {@link KnownMode} can be used interchangeably with Mode,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Audit**: Audit Mode \
 * **Enforce**: Enforce Mode
 */
export type Mode = string;

/** Known values of {@link ManagedServiceIdentityType} that the service accepts. */
export enum KnownManagedServiceIdentityType {
  /** None */
  None = "None",
  /** SystemAssigned */
  SystemAssigned = "SystemAssigned",
  /** UserAssigned */
  UserAssigned = "UserAssigned",
  /** SystemAssignedUserAssigned */
  SystemAssignedUserAssigned = "SystemAssigned,UserAssigned",
}

/**
 * Defines values for ManagedServiceIdentityType. \
 * {@link KnownManagedServiceIdentityType} can be used interchangeably with ManagedServiceIdentityType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **None** \
 * **SystemAssigned** \
 * **UserAssigned** \
 * **SystemAssigned,UserAssigned**
 */
export type ManagedServiceIdentityType = string;

/** Known values of {@link CreatedByType} that the service accepts. */
export enum KnownCreatedByType {
  /** User */
  User = "User",
  /** Application */
  Application = "Application",
  /** ManagedIdentity */
  ManagedIdentity = "ManagedIdentity",
  /** Key */
  Key = "Key",
}

/**
 * Defines values for CreatedByType. \
 * {@link KnownCreatedByType} can be used interchangeably with CreatedByType,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **User** \
 * **Application** \
 * **ManagedIdentity** \
 * **Key**
 */
export type CreatedByType = string;

/** Known values of {@link StatusLevelTypes} that the service accepts. */
export enum KnownStatusLevelTypes {
  /** Info level */
  Info = "Info",
  /** Warning level */
  Warning = "Warning",
  /** Error Level */
  Error = "Error",
}

/**
 * Defines values for StatusLevelTypes. \
 * {@link KnownStatusLevelTypes} can be used interchangeably with StatusLevelTypes,
 *  this enum contains the known values that the service supports.
 * ### Known values supported by the service
 * **Info**: Info level \
 * **Warning**: Warning level \
 * **Error**: Error Level
 */
export type StatusLevelTypes = string;

/** Optional parameters. */
export interface OperationsListOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the list operation. */
export type OperationsListResponse = OperationListResult;

/** Optional parameters. */
export interface OperationsListNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listNext operation. */
export type OperationsListNextResponse = OperationListResult;

/** Optional parameters. */
export interface FleetsListBySubscriptionOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscription operation. */
export type FleetsListBySubscriptionResponse = FleetListResult;

/** Optional parameters. */
export interface FleetsListByResourceGroupOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroup operation. */
export type FleetsListByResourceGroupResponse = FleetListResult;

/** Optional parameters. */
export interface FleetsGetOptionalParams extends coreClient.OperationOptions {}

/** Contains response data for the get operation. */
export type FleetsGetResponse = Fleet;

/** Optional parameters. */
export interface FleetsCreateOrUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the createOrUpdate operation. */
export type FleetsCreateOrUpdateResponse = Fleet;

/** Optional parameters. */
export interface FleetsUpdateOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the update operation. */
export type FleetsUpdateResponse = Fleet;

/** Optional parameters. */
export interface FleetsDeleteOptionalParams
  extends coreClient.OperationOptions {
  /** Delay to wait until next poll, in milliseconds. */
  updateIntervalInMs?: number;
  /** A serialized poller which can be used to resume an existing paused Long-Running-Operation. */
  resumeFrom?: string;
}

/** Contains response data for the delete operation. */
export type FleetsDeleteResponse = FleetsDeleteHeaders;

/** Optional parameters. */
export interface FleetsListVirtualMachineScaleSetsOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSets operation. */
export type FleetsListVirtualMachineScaleSetsResponse =
  VirtualMachineScaleSetListResult;

/** Optional parameters. */
export interface FleetsListBySubscriptionNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listBySubscriptionNext operation. */
export type FleetsListBySubscriptionNextResponse = FleetListResult;

/** Optional parameters. */
export interface FleetsListByResourceGroupNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listByResourceGroupNext operation. */
export type FleetsListByResourceGroupNextResponse = FleetListResult;

/** Optional parameters. */
export interface FleetsListVirtualMachineScaleSetsNextOptionalParams
  extends coreClient.OperationOptions {}

/** Contains response data for the listVirtualMachineScaleSetsNext operation. */
export type FleetsListVirtualMachineScaleSetsNextResponse =
  VirtualMachineScaleSetListResult;

/** Optional parameters. */
export interface MicrosoftAzureFleetOptionalParams
  extends coreClient.ServiceClientOptions {
  /** server parameter */
  $host?: string;
  /** Api Version */
  apiVersion?: string;
  /** Overrides client endpoint. */
  endpoint?: string;
}
