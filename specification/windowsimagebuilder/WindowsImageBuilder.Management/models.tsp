import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.WindowsImageBuilder;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Specifies the storage account type to be used to store the Azure Compute Gallery image version in.
 */
union StorageAccountType {
  string,

  /** Standard locally redundant storage */
  Standard_LRS: "Standard_LRS",

  /** Standard  Zone-Redundant storage */
  Standard_ZRS: "Standard_ZRS",

  /** Premium locally redundant storage */
  Premium_LRS: "Premium_LRS",
}

/**
 * Error handling behavior upon build failure
 */
union MediaBuildError {
  string,

  /** Error in media creation */
  OnCreation: "OnCreation",

  /** Error in media validation */
  Validation: "Validation",

  /** Error in media publishing */
  Publishing: "Publishing",
}

/**
 * Error code of the provisioning failure
 */
union ProvisioningErrorCode {
  string,

  /** ProvisioningError BadSourceType */
  BadSourceType: "BadSourceType",

  /** ProvisioningError BadManagedImageSource */
  BadManagedImageSource: "BadManagedImageSource",

  /** ProvisioningError BadSharedImageVersionSource */
  BadSharedImageVersionSource: "BadSharedImageVersionSource",

  /** ProvisioningError BadCustomizerType */
  BadCustomizerType: "BadCustomizerType",

  /** ProvisioningError UnsupportedCustomizerType */
  UnsupportedCustomizerType: "UnsupportedCustomizerType",

  /** ProvisioningError NoCustomizerScript */
  NoCustomizerScript: "NoCustomizerScript",

  /** ProvisioningError  BadValidatorType */
  BadValidatorType: "BadValidatorType",

  /** ProvisioningError UnsupportedValidatorType */
  UnsupportedValidatorType: "UnsupportedValidatorType",

  /** ProvisioningError NoValidatorScript */
  NoValidatorScript: "NoValidatorScript",

  /** ProvisioningError BadDistributeType */
  BadDistributeType: "BadDistributeType",

  /** ProvisioningError BadSharedImageDistribute */
  BadSharedImageDistribute: "BadSharedImageDistribute",

  /** ProvisioningError ServerError */
  ServerError: "ServerError",

  /** ProvisioningError Other */
  Other: "Other",
}

/**
 * Provisioning state of the resource
 */
union ProvisioningState {
  /** The resource is being created */
  Creating: "Creating",

  /** The resource is being updated */
  Updating: "Updating",

  /** The resource provisioning succeeded */
  Succeeded: "Succeeded",

  /** The resource provisioning failed */
  Failed: "Failed",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource provisioning was canceled */
  Canceled: "Canceled",

  /** Extensible enum to allow future states */
  string,
}

/**
 * The type of identity used for the windows image. The type 'None' will remove any identities from the image
 */
union WindowsResourceIdentityType {
  /** User assigned identity */
  UserAssigned: "UserAssigned",

  /** No identity */
  None: "None",

  /** Extensible enum to allow future identity types */
  string,
}

/**
 * The type of customization available for windows image
 */
union WindowsImageCustomizerType {
  /** Shell customization */
  Shell: "Shell",

  /** WindowsRestart customization */
  WindowsRestart: "WindowsRestart",

  /** WindowsUpdate customization */
  WindowsUpdate: "WindowsUpdate",

  /** PowerShell customization */
  PowerShell: "PowerShell",

  /** File customization */
  File: "File",

  /** Extensible enum to allow future customization types */
  string,
}

/**
 * Describes the properties of a windows image.
 */
model WindowsImageProperties {
  /**
   * Specifies the properties used to describe the source image.
   */
  source: WindowsImageSource;

  /**
   * Specifies the properties used to describe the customization steps of the image, like Image source etc
   */
  @Azure.ResourceManager.identifiers(#[])
  customize?: WindowsImageCustomizer[];

  /**
   * The distribution targets where the image output needs to go to.
   */
  @Azure.ResourceManager.identifiers(#[])
  distribute: WindowsImageDistributor[];

  /**
   * Error handling options upon a build failure
   */
  errorHandling?: MediaBuildError;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Provisioning error, if any
   */
  @visibility(Lifecycle.Read)
  provisioningError?: ProvisioningError;
}

/**
 * Describes a windows image source for building, customizing and distributing
 */
model WindowsImageSource {
  /**
   * Name of OS
   */
  os: string;

  /**
   * Name of edition
   */
  edition: string;

  /**
   * Architecture value
   */
  arch: string;

  /**
   * Language value
   */
  language: string;

  /**
   * Size value
   */
  size: int64;

  /**
   * Generation value
   */
  generation: string;

  /**
   * set trigger
   */
  trigger: boolean;

  /**
   * type of image
   */
  type: string;
}

/**
 * Describes a unit of image customization
 */
@discriminator("type")
model WindowsImageCustomizer {
  /**
   * type of customization
   */
  type: WindowsImageCustomizerType;

  /**
   * Friendly Name to provide context on what this customization step does
   */
  name?: string;
}

/**
 * Generic distribution object
 */
model WindowsImageDistributor {
  /**
   * Type of distribution.
   */
  type: string;

  /**
   * resource ID
   */
  galleryImageId: string;

  /**
   * The name to be used for the associated RunOutput.
   */
  @pattern("^[A-Za-z0-9-_.]{1,64}$")
  runOutputName: string;

  /**
   * Tags that will be applied to the artifact once it has been created/updated by the distributor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "New private RP"
  artifactTags?: Record<string>;

  /**
   * The target regions where the distributed Image Version is going to be replicated to. This object supersedes replicationRegions and can be specified only if replicationRegions is not specified.
   */
  @Azure.ResourceManager.identifiers(#[])
  targetRegions?: TargetRegion[];
}

/**
 * Describes the target region information.
 */
model TargetRegion {
  /**
   * The name of the region.
   */
  name: string;

  /**
   * The number of replicas of the Image Version to be created in this region. Omit to use the default (1).
   */
  @minValue(1)
  replicaCount?: int32 = 1;

  /**
   * Specifies the storage account type to be used to store the image in this region. Omit to use the default (Standard_LRS).
   */
  storageAccountType?: StorageAccountType;
}

/**
 * Describes the error happened when create or update a image
 */
model ProvisioningError {
  /**
   * Error code of the provisioning failure
   */
  provisioningErrorCode?: ProvisioningErrorCode;

  /**
   * Verbose error message about the provisioning failure
   */
  message?: string;
}

/**
 * Identity for the  windows image.
 */
model WindowsImageIdentity {
  /**
   * The type of identity used for the windows image. The type 'None' will remove any identities from the windows image .
   */
  type?: WindowsResourceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "New private RP"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Parameters for updating a Windows image.
 */
model WindowsImageTagUpdateParameters {
  /**
   * The identity of the  windows image configured.
   */
  identity?: WindowsImageIdentity;

  /**
   * The user-specified tags associated with the windows image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "New private RP"
  tags?: Record<string>;

  /**
   * Parameters for updating a Windows image.
   */
  properties?: WindowsImageTagUpdateParametersProperties;
}

/**
 * Parameters for updating a Windows image.
 */
model WindowsImageTagUpdateParametersProperties {
  /**
   * The distribution targets where the image output needs to go to.
   */
  @Azure.ResourceManager.identifiers(#[])
  distribute?: WindowsImageDistributor[];
}

/**
 * Runs a shell script during the customization phase (Linux). Corresponds to Packer shell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model WindowsImageShellCustomizer extends WindowsImageCustomizer {
  /**
   * URI of the shell script to be run for customizing. It can be a github link, SAS URI for Azure Storage, etc
   */
  scriptUri?: string;

  /**
   * SHA256 checksum of the shell script provided in the scriptUri field
   */
  sha256Checksum?: string = "";

  /**
   * Array of shell commands to execute
   */
  inline?: string[];

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: WindowsImageCustomizerType.Shell;
}

/**
 * Reboots a VM and waits for it to come back online (Windows). Corresponds to Packer windows-restart provisioner
 */
model WindowsImageRestartCustomizer extends WindowsImageCustomizer {
  /**
   * Command to execute the restart [Default: 'shutdown /r /f /t 0 /c "packer restart"']
   */
  restartCommand?: string;

  /**
   * Command to check if restart succeeded [Default: '']
   */
  restartCheckCommand?: string;

  /**
   * Restart timeout specified as a string of magnitude and unit, e.g. '5m' (5 minutes) or '2h' (2 hours) [Default: '5m']
   */
  restartTimeout?: string;

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: WindowsImageCustomizerType.WindowsRestart;
}

/**
 * Installs Windows Updates. Corresponds to Packer Windows Update Provisioner (https://github.com/rgl/packer-provisioner-windows-update)
 */
model WindowsUpdateCustomizer extends WindowsImageCustomizer {
  /**
   * Criteria to search updates. Omit or specify empty string to use the default (search all). Refer to above link for examples and detailed description of this field.
   */
  searchCriteria?: string;

  /**
   * Array of filters to select updates to apply. Omit or specify empty array to use the default (no filter). Refer to above link for examples and detailed description of this field.
   */
  filters?: string[];

  /**
   * Maximum number of updates to apply at a time. Omit or specify 0 to use the default (1000)
   */
  updateLimit?: int32;

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: WindowsImageCustomizerType.WindowsUpdate;
}

/**
 * Runs the specified PowerShell on the VM (Windows). Corresponds to Packer powershell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model WindowsImagePowerShellCustomizer extends WindowsImageCustomizer {
  /**
   * URI of the PowerShell script to be run for customizing. It can be a github link, SAS URI for Azure Storage, etc
   */
  scriptUri?: string;

  /**
   * SHA256 checksum of the power shell script provided in the scriptUri field above
   */
  sha256Checksum?: string = "";

  /**
   * Array of PowerShell commands to execute
   */
  inline?: string[];

  /**
   * If specified, the PowerShell script will be run with elevated privileges
   */
  runElevated?: boolean;

  /**
   * If specified, the PowerShell script will be run with elevated privileges using the Local System user. Can only be true when the runElevated field above is set to true.
   */
  runAsSystem?: boolean;

  /**
   * Valid exit codes for the PowerShell script. [Default: 0]
   */
  validExitCodes?: int32[];

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: WindowsImageCustomizerType.PowerShell;
}

/**
 * Uploads files to VMs (Linux, Windows). Corresponds to Packer file provisioner
 */
model WindowsImageFileCustomizer extends WindowsImageCustomizer {
  /**
   * The URI of the file to be uploaded for customizing the VM. It can be a github link, SAS URI for Azure Storage, etc
   */
  sourceUri?: string;

  /**
   * SHA256 checksum of the file provided in the sourceUri field above
   */
  sha256Checksum?: string = "";

  /**
   * The absolute path to a file (with nested directory structures already created) where the file (from sourceUri) will be uploaded to in the VM
   */
  destination?: string;

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: WindowsImageCustomizerType.File;
}
