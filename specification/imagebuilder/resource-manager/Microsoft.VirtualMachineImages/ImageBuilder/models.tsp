import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.VirtualMachineImages;

/**
 * Error handling behavior upon build failure
 */
union OnBuildError {
  string,

  /**
   * cleanup
   */
  cleanup: "cleanup",

  /**
   * abort
   */
  abort: "abort",
}

/**
 * Error code of the provisioning failure
 */
union ProvisioningErrorCode {
  string,

  /**
   * BadSourceType
   */
  BadSourceType: "BadSourceType",

  /**
   * BadPIRSource
   */
  BadPIRSource: "BadPIRSource",

  /**
   * BadManagedImageSource
   */
  BadManagedImageSource: "BadManagedImageSource",

  /**
   * BadSharedImageVersionSource
   */
  BadSharedImageVersionSource: "BadSharedImageVersionSource",

  /**
   * BadCustomizerType
   */
  BadCustomizerType: "BadCustomizerType",

  /**
   * UnsupportedCustomizerType
   */
  UnsupportedCustomizerType: "UnsupportedCustomizerType",

  /**
   * NoCustomizerScript
   */
  NoCustomizerScript: "NoCustomizerScript",

  /**
   * BadValidatorType
   */
  BadValidatorType: "BadValidatorType",

  /**
   * UnsupportedValidatorType
   */
  UnsupportedValidatorType: "UnsupportedValidatorType",

  /**
   * NoValidatorScript
   */
  NoValidatorScript: "NoValidatorScript",

  /**
   * BadDistributeType
   */
  BadDistributeType: "BadDistributeType",

  /**
   * BadSharedImageDistribute
   */
  BadSharedImageDistribute: "BadSharedImageDistribute",

  /**
   * BadStagingResourceGroup
   */
  BadStagingResourceGroup: "BadStagingResourceGroup",

  /**
   * ServerError
   */
  ServerError: "ServerError",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Specifies the storage account type to be used to store the Azure Compute Gallery image version in.
 */
union SharedImageStorageAccountType {
  string,

  /**
   * Standard_LRS
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Standard_ZRS
   */
  Standard_ZRS: "Standard_ZRS",

  /**
   * Premium_LRS
   */
  Premium_LRS: "Premium_LRS",
}

/**
 * Describes replication mode for distribution in Azure Compute Gallery. Omit to use the default (Full).
 */
union ReplicationMode {
  string,

  /**
   * Full replication mode
   */
  Full: "Full",

  /**
   * Shallow replication mode
   */
  Shallow: "Shallow",
}

/**
 * Enabling this field will improve VM boot time by optimizing the final customized image output.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum VMBootOptimizationState {
  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * Enabling this field will optimize vm images for specific workloads.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum WorkloadOptimizationState {
  /**
   * Workload optimization is enabled
   */
  Enabled,

  /**
   * Workload optimization is disabled
   */
  Disabled,
}

/**
 * Provisioning state of the resource
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ProvisioningState {
  /**
   * Creating
   */
  Creating,

  /**
   * Updating
   */
  Updating,

  /**
   * Succeeded
   */
  Succeeded,

  /**
   * Failed
   */
  Failed,

  /**
   * Deleting
   */
  Deleting,

  /**
   * Canceled
   */
  Canceled,
}

/**
 * State of the last run
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RunState {
  /**
   * Running
   */
  Running,

  /**
   * Canceling
   */
  Canceling,

  /**
   * Succeeded
   */
  Succeeded,

  /**
   * PartiallySucceeded
   */
  PartiallySucceeded,

  /**
   * Failed
   */
  Failed,

  /**
   * Canceled
   */
  Canceled,
}

/**
 * Sub-state of the last run
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RunSubState {
  /**
   * Queued
   */
  Queued,

  /**
   * Building
   */
  Building,

  /**
   * Customizing
   */
  Customizing,

  /**
   * Optimizing
   */
  Optimizing,

  /**
   * Validating
   */
  Validating,

  /**
   * Distributing
   */
  Distributing,
}

/**
 * Enabling this field will trigger an automatic build on image template creation or update.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AutoRunState {
  /**
   * Autorun is enabled
   */
  AutoRunEnabled: "Enabled",

  /**
   * Autorun is disabled
   */
  AutoRunDisabled: "Disabled",
}

/**
 * The type of identity used for the image template. The type 'None' will remove any identities from the image template.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Describes the properties of an image template
 */
model ImageTemplateProperties {
  /**
   * Specifies the properties used to describe the source image.
   */
  source: ImageTemplateSource;

  /**
   * Specifies the properties used to describe the customization steps of the image, like Image source etc
   */
  @identifiers(#[])
  customize?: ImageTemplateCustomizer[];

  /**
   * Specifies optimization to be performed on image.
   */
  optimize?: ImageTemplatePropertiesOptimize;

  /**
   * Configuration options and list of validations to be performed on the resulting image.
   */
  validate?: ImageTemplatePropertiesValidate;

  /**
   * The distribution targets where the image output needs to go to.
   */
  @identifiers(#[])
  distribute: ImageTemplateDistributor[];

  /**
   * Error handling options upon a build failure
   */
  errorHandling?: ImageTemplatePropertiesErrorHandling;

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

  /**
   * State of 'run' that is currently executing or was last executed.
   */
  @visibility(Lifecycle.Read)
  lastRunStatus?: ImageTemplateLastRunStatus;

  /**
   * Maximum duration to wait while building the image template (includes all customizations, optimization, validations, and distributions). Omit or specify 0 to use the default (4 hours).
   */
  @maxValue(960)
  @minValue(0)
  buildTimeoutInMinutes?: int32 = 0;

  /**
   * Describes how virtual machine is set up to build images
   */
  vmProfile?: ImageTemplateVmProfile;

  /**
   * Optional array of additional data disks to be added to the image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalDataDisks?: DataDisk[];

  /**
   * The staging resource group id in the same subscription as the image template that will be used to build the image. If this field is empty, a resource group with a random name will be created. If the resource group specified in this field doesn't exist, it will be created with the same name. If the resource group specified exists, it must be empty and in the same region as the image template. The resource group created will be deleted during template deletion if this field is empty or the resource group specified doesn't exist, but if the resource group specified exists the resources created in the resource group will be deleted during template deletion and the resource group itself will remain.
   */
  stagingResourceGroup?: string;

  /**
   * The staging resource group id in the same subscription as the image template that will be used to build the image. This read-only field differs from 'stagingResourceGroup' only if the value specified in the 'stagingResourceGroup' field is empty.
   */
  @visibility(Lifecycle.Read)
  exactStagingResourceGroup?: string;

  /**
   * Indicates whether or not to automatically run the image template build on template creation or update.
   */
  autoRun?: ImageTemplateAutoRun;

  /**
   * Tags that will be applied to the resource group and/or resources created by the service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedResourceTags?: Record<string>;
}

/**
 * Describes a virtual machine image source for building, customizing and distributing
 */
@discriminator("type")
model ImageTemplateSource {
  /**
   * Specifies the type of source image you want to start with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;
}

/**
 * Describes a unit of image customization
 */
@discriminator("type")
model ImageTemplateCustomizer {
  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Friendly Name to provide context on what this customization step does
   */
  name?: string;
}

/**
 * Specifies optimization to be performed on image.
 */
model ImageTemplatePropertiesOptimize {
  /**
   * Optimization is applied on the image for a faster VM boot.
   */
  vmBoot?: ImageTemplatePropertiesOptimizeVmBoot;

  /**
   * Optimization is applied on the image for specific workloads.
   */
  workload?: ImageTemplatePropertiesOptimizeWorkload;
}

/**
 * Optimization is applied on the image for a faster VM boot.
 */
model ImageTemplatePropertiesOptimizeVmBoot {
  /**
   * Enabling this field will improve VM boot time by optimizing the final customized image output.
   */
  state?: VMBootOptimizationState;
}

/**
 * Optimization is applied on the image for specific workloads.
 */
model ImageTemplatePropertiesOptimizeWorkload {
  /**
   * Enabling this field will optimize vm images for specific workloads.
   */
  state?: WorkloadOptimizationState;

  /**
   * URI of the script to be run for workload optimization. It can be a github link, SAS URI for Azure Storage, etc
   */
  scriptUri?: string;

  /**
   * SHA256 checksum of the script provided in the scriptUri field
   */
  sha256Checksum?: string = "";
}

/**
 * Configuration options and list of validations to be performed on the resulting image.
 */
model ImageTemplatePropertiesValidate {
  /**
   * If validation fails and this field is set to false, output image(s) will not be distributed. This is the default behavior. If validation fails and this field is set to true, output image(s) will still be distributed. Please use this option with caution as it may result in bad images being distributed for use. In either case (true or false), the end to end image run will be reported as having failed in case of a validation failure. [Note: This field has no effect if validation succeeds.]
   */
  continueDistributeOnFailure?: boolean = false;

  /**
   * If this field is set to true, the image specified in the 'source' section will directly be validated. No separate build will be run to generate and then validate a customized image.
   */
  sourceValidationOnly?: boolean = false;

  /**
   * List of validations to be performed.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  inVMValidations?: ImageTemplateInVMValidator[];
}

/**
 * Describes a unit of in-VM validation of image
 */
@discriminator("type")
model ImageTemplateInVMValidator {
  /**
   * The type of validation you want to use on the Image. For example, "Shell" can be shell validation
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * Friendly Name to provide context on what this validation step does
   */
  name?: string;
}

/**
 * Generic distribution object
 */
@discriminator("type")
model ImageTemplateDistributor {
  /**
   * Type of distribution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * The name to be used for the associated RunOutput.
   */
  @pattern("^[A-Za-z0-9-_.]{1,64}$")
  runOutputName: string;

  /**
   * Tags that will be applied to the artifact once it has been created/updated by the distributor.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  artifactTags?: Record<string>;
}

/**
 * Error handling options upon a build failure
 */
model ImageTemplatePropertiesErrorHandling {
  /**
   * If there is a customizer error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. This is the default behavior. If there is a customizer error and this field is set to 'abort', the build VM will be preserved.
   */
  onCustomizerError?: OnBuildError;

  /**
   * If there is a validation error and this field is set to 'cleanup', the build VM and associated network resources will be cleaned up. This is the default behavior. If there is a validation error and this field is set to 'abort', the build VM will be preserved.
   */
  onValidationError?: OnBuildError;
}

/**
 * Describes the error happened when create or update an image template
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
 * Describes the latest status of running an image template
 */
model ImageTemplateLastRunStatus {
  /**
   * Start time of the last run (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the last run (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * State of the last run
   */
  runState?: RunState;

  /**
   * Sub-state of the last run
   */
  runSubState?: RunSubState;

  /**
   * Verbose information about the last run state
   */
  message?: string;
}

/**
 * Describes the virtual machines used to build and validate images
 */
model ImageTemplateVmProfile {
  /**
   * Size of the virtual machine used to build, customize and capture images. Omit or specify empty string to use the default (Standard_D1_v2 for Gen1 images and Standard_D2ds_v4 for Gen2 images).
   */
  vmSize?: string = "";

  /**
   * Size of the OS disk in GB. Omit or specify 0 to use Azure's default OS disk size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  osDiskSizeGB?: int32 = 0;

  /**
   * Optional array of resource IDs of user assigned managed identities to be configured on the build VM and validation VM. This may include the identity of the image template.
   */
  userAssignedIdentities?: string[];

  /**
   * Optional configuration of the virtual network to use to deploy the build VM and validation VM in. Omit if no specific virtual network needs to be used.
   */
  vnetConfig?: VirtualNetworkConfig;
}

/**
 * Virtual Network configuration.
 */
model VirtualNetworkConfig {
  /**
   * Resource id of a pre-existing subnet on which the build VM and validation VM will be deployed
   */
  subnetId?: string;

  /**
   * Resource id of a pre-existing subnet on which Azure Container Instance will be deployed for Isolated Builds. This field may be specified only if `subnetId` is also specified and must be on the same Virtual Network as the subnet specified in `subnetId`.
   */
  containerInstanceSubnetId?: string;

  /**
   * Size of the proxy virtual machine used to pass traffic to the build VM and validation VM. This must not be specified if `containerInstanceSubnetId` is specified because no proxy virtual machine is deployed in that case. Omit or specify empty string to use the default (Standard_A1_v2).
   */
  proxyVmSize?: string = "";
}

/**
 * Data disk properties.
 */
model DataDisk {
  /**
   * Size of the data disk in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  sizeGB?: int32;
}

/**
 * Indicates if the image template needs to be built on create/update
 */
model ImageTemplateAutoRun {
  /**
   * Enabling this field will trigger an automatic build on image template creation or update.
   */
  state?: AutoRunState;
}

/**
 * Identity for the image template.
 */
model ImageTemplateIdentity {
  /**
   * The type of identity used for the image template. The type 'None' will remove any identities from the image template.
   */
  type?: ResourceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User assigned identity properties
 */
model UserAssignedIdentity {
  /**
   * The principal ID of the assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of the assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Parameters for updating an image template.
 */
model ImageTemplateUpdateParameters {
  /**
   * The identity of the image template, if configured.
   */
  identity?: ImageTemplateIdentity;

  /**
   * The user-specified tags associated with the image template.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Parameters for updating an image template.
   */
  properties?: ImageTemplateUpdateParametersProperties;
}

/**
 * Parameters for updating an image template.
 */
model ImageTemplateUpdateParametersProperties {
  /**
   * The distribution targets where the image output needs to go to.
   */
  @identifiers(#[])
  distribute?: ImageTemplateDistributor[];

  /**
   * Describes how virtual machine is set up to build images
   */
  vmProfile?: ImageTemplateVmProfile;
}

/**
 * The result of List run outputs operation
 */
model RunOutputCollection is Azure.Core.Page<RunOutput>;

/**
 * Describes the properties of a run output
 */
model RunOutputProperties {
  /**
   * The resource id of the artifact.
   */
  artifactId?: string;

  /**
   * The location URI of the artifact.
   */
  artifactUri?: string;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The result of List triggers operation
 */
model TriggerCollection is Azure.Core.Page<Trigger>;

/**
 * Describes the properties of a trigger
 */
@discriminator("kind")
model TriggerProperties {
  /**
   * The kind of trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: string;

  /**
   * Trigger status
   */
  @visibility(Lifecycle.Read)
  status?: TriggerStatus;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Describes the status of a trigger
 */
model TriggerStatus {
  /**
   * The status code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The time of the status.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * A REST API operation
 */
model Operation {
  /**
   * This is of the format {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that describes the operation.
   */
  display?: OperationDisplay;

  /**
   * The intended executor of the operation.
   */
  origin?: string;

  /**
   * Properties of the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;

  /**
   * The flag that indicates whether the operation applies to data plane.
   */
  isDataAction?: boolean;
}

/**
 * The object that describes the operation.
 */
model OperationDisplay {
  /**
   * Friendly name of the resource provider.
   */
  provider?: string;

  /**
   * For example: read, write, delete, or listKeys/action
   */
  operation?: string;

  /**
   * The resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * The friendly name of the operation
   */
  description?: string;
}

/**
 * Describes an image source from [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages).
 */
model ImageTemplatePlatformImageSource extends ImageTemplateSource {
  /**
   * Image Publisher in [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages).
   */
  publisher?: string;

  /**
   * Image offer from the [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages).
   */
  offer?: string;

  /**
   * Image sku from the [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages).
   */
  sku?: string;

  /**
   * Image version from the [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages). If 'latest' is specified here, the version is evaluated when the image build takes place, not when the template is submitted.
   */
  version?: string;

  /**
   * Image version from the [Azure Gallery Images](https://docs.microsoft.com/en-us/rest/api/compute/virtualmachineimages). This readonly field differs from 'version', only if the value specified in 'version' field is 'latest'.
   */
  @visibility(Lifecycle.Read)
  exactVersion?: string;

  /**
   * Optional configuration of purchase plan for platform image.
   */
  planInfo?: PlatformImagePurchasePlan;

  /**
   * Specifies the type of source image you want to start with.
   */
  type: "PlatformImage";
}

/**
 * Purchase plan configuration for platform image.
 */
model PlatformImagePurchasePlan {
  /**
   * Name of the purchase plan.
   */
  planName: string;

  /**
   * Product of the purchase plan.
   */
  planProduct: string;

  /**
   * Publisher of the purchase plan.
   */
  planPublisher: string;
}

/**
 * Describes an image source that is a managed image in customer subscription. This image must reside in the same subscription and region as the Image Builder template.
 */
model ImageTemplateManagedImageSource extends ImageTemplateSource {
  /**
   * ARM resource id of the managed image in customer subscription
   */
  imageId: string;

  /**
   * Specifies the type of source image you want to start with.
   */
  type: "ManagedImage";
}

/**
 * Describes an image source that is an image version in an Azure Compute Gallery or a Direct Shared Gallery.
 */
model ImageTemplateSharedImageVersionSource extends ImageTemplateSource {
  /**
   * ARM resource id of the image version. When image version name is 'latest', the version is evaluated when the image build takes place.
   */
  imageVersionId: string;

  /**
   * Exact ARM resource id of the image version. This readonly field differs from the image version Id in 'imageVersionId' only if the version name specified in 'imageVersionId' field is 'latest'.
   */
  @visibility(Lifecycle.Read)
  exactVersion?: string;

  /**
   * Specifies the type of source image you want to start with.
   */
  type: "SharedImageVersion";
}

/**
 * Runs the specified shell script during the validation phase (Linux). Corresponds to Packer shell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model ImageTemplateShellValidator extends ImageTemplateInVMValidator {
  /**
   * URI of the shell script to be run for validation. It can be a github link, Azure Storage URI, etc
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
   * The type of validation you want to use on the Image. For example, "Shell" can be shell validation
   */
  type: "Shell";
}

/**
 * Runs the specified PowerShell script during the validation phase (Windows). Corresponds to Packer powershell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model ImageTemplatePowerShellValidator extends ImageTemplateInVMValidator {
  /**
   * URI of the PowerShell script to be run for validation. It can be a github link, Azure Storage URI, etc
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
  runElevated?: boolean = false;

  /**
   * If specified, the PowerShell script will be run with elevated privileges using the Local System user. Can only be true when the runElevated field above is set to true.
   */
  runAsSystem?: boolean = false;

  /**
   * Valid exit codes for the PowerShell script. [Default: 0]
   */
  validExitCodes?: int32[];

  /**
   * The type of validation you want to use on the Image. For example, "Shell" can be shell validation
   */
  type: "PowerShell";
}

/**
 * Uploads files required for validation to VMs (Linux, Windows). Corresponds to Packer file provisioner
 */
model ImageTemplateFileValidator extends ImageTemplateInVMValidator {
  /**
   * The URI of the file to be uploaded to the VM for validation. It can be a github link, Azure Storage URI (authorized or SAS), etc
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
   * The type of validation you want to use on the Image. For example, "Shell" can be shell validation
   */
  type: "File";
}

/**
 * Runs a shell script during the customization phase (Linux). Corresponds to Packer shell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model ImageTemplateShellCustomizer extends ImageTemplateCustomizer {
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
  type: "Shell";
}

/**
 * Reboots a VM and waits for it to come back online (Windows). Corresponds to Packer windows-restart provisioner
 */
model ImageTemplateRestartCustomizer extends ImageTemplateCustomizer {
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
  type: "WindowsRestart";
}

/**
 * Installs Windows Updates. Corresponds to Packer Windows Update Provisioner (https://github.com/rgl/packer-provisioner-windows-update)
 */
model ImageTemplateWindowsUpdateCustomizer extends ImageTemplateCustomizer {
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
  @minValue(0)
  updateLimit?: int32 = 0;

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: "WindowsUpdate";
}

/**
 * Runs the specified PowerShell on the VM (Windows). Corresponds to Packer powershell provisioner. Exactly one of 'scriptUri' or 'inline' can be specified.
 */
model ImageTemplatePowerShellCustomizer extends ImageTemplateCustomizer {
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
  runElevated?: boolean = false;

  /**
   * If specified, the PowerShell script will be run with elevated privileges using the Local System user. Can only be true when the runElevated field above is set to true.
   */
  runAsSystem?: boolean = false;

  /**
   * Valid exit codes for the PowerShell script. [Default: 0]
   */
  validExitCodes?: int32[];

  /**
   * The type of customization tool you want to use on the Image. For example, "Shell" can be shell customizer
   */
  type: "PowerShell";
}

/**
 * Uploads files to VMs (Linux, Windows). Corresponds to Packer file provisioner
 */
model ImageTemplateFileCustomizer extends ImageTemplateCustomizer {
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
  type: "File";
}

/**
 * Distribute as a Managed Disk Image.
 */
model ImageTemplateManagedImageDistributor extends ImageTemplateDistributor {
  /**
   * Resource Id of the Managed Disk Image
   */
  imageId: string;

  /**
   * Azure location for the image, should match if image already exists
   */
  location: string;

  /**
   * Type of distribution.
   */
  type: "ManagedImage";
}

/**
 * Distribute via Azure Compute Gallery.
 */
model ImageTemplateSharedImageDistributor extends ImageTemplateDistributor {
  /**
   * Resource Id of the Azure Compute Gallery image
   */
  galleryImageId: string;

  /**
   * [Deprecated] A list of regions that the image will be replicated to. This list can be specified only if targetRegions is not specified. This field is deprecated - use targetRegions instead.
   */
  replicationRegions?: string[];

  /**
   * Flag that indicates whether created image version should be excluded from latest. Omit to use the default (false).
   */
  excludeFromLatest?: boolean = false;

  /**
   * [Deprecated] Storage account type to be used to store the shared image. Omit to use the default (Standard_LRS). This field can be specified only if replicationRegions is specified. This field is deprecated - use targetRegions instead.
   */
  storageAccountType?: SharedImageStorageAccountType;

  /**
   * The target regions where the distributed Image Version is going to be replicated to. This object supersedes replicationRegions and can be specified only if replicationRegions is not specified.
   */
  @identifiers(#[])
  targetRegions?: TargetRegion[];

  /**
   * Describes how to generate new x.y.z version number for distribution.
   */
  versioning?: DistributeVersioner;

  /**
   * Describes replication mode for distribution in Azure Compute Gallery. Omit to use the default (Full).
   */
  replicationMode?: ReplicationMode;

  /**
   * Type of distribution.
   */
  type: "SharedImage";
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
  storageAccountType?: SharedImageStorageAccountType;
}

/**
 * Describes how to generate new x.y.z version number for distribution.
 */
@discriminator("scheme")
model DistributeVersioner {
  /**
   * Version numbering scheme to be used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scheme: string;
}

/**
 * Distribute via VHD in a storage account.
 */
model ImageTemplateVhdDistributor extends ImageTemplateDistributor {
  /**
   * Optional Azure Storage URI for the distributed VHD blob. Omit to use the default (empty string) in which case VHD would be published to the storage account in the staging resource group.
   */
  uri?: string;

  /**
   * Type of distribution.
   */
  type: "VHD";
}

/**
 * Properties of SourceImage kind of trigger
 */
model SourceImageTriggerProperties extends TriggerProperties {
  /**
   * The kind of trigger.
   */
  kind: "SourceImage";
}

/**
 * Generates version number that will be latest based on existing version numbers.
 */
model DistributeVersionerLatest extends DistributeVersioner {
  /**
   * Major version for the generated version number. Determine what is "latest" based on versions with this value as the major version. -1 is equivalent to leaving it unset.
   */
  @minValue(-1)
  major?: int32 = -1;

  /**
   * Version numbering scheme to be used.
   */
  scheme: "Latest";
}

/**
 * Generates version number based on version number of source image
 */
model DistributeVersionerSource extends DistributeVersioner {
  /**
   * Version numbering scheme to be used.
   */
  scheme: "Source";
}

/**
 * Result of the request to list REST API operations. It contains a list of operations and a URL nextLink to get the next set of results.
 */
model OperationListResult {
  /**
   * The list of operations supported by the resource provider.
   */
  @identifiers(#[])
  @pageItems
  value: Operation[];

  /**
   * The URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: string;
}
