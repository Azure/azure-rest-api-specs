import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

/**
 * The List Galleries operation response.
 */
model GalleryList is Azure.Core.Page<Gallery>;

/**
 * The List Community Gallery Images operation response.
 */
model CommunityGalleryImageList is Azure.Core.Page<CommunityGalleryImage>;

/**
 * The List Community Gallery Image versions operation response.
 */
model CommunityGalleryImageVersionList
  is Azure.Core.Page<CommunityGalleryImageVersion>;

/**
 * The List Shared Galleries operation response.
 */
model SharedGalleryList is Azure.Core.Page<SharedGallery>;

/**
 * The List Shared Gallery Images operation response.
 */
model SharedGalleryImageList is Azure.Core.Page<SharedGalleryImage>;

/**
 * The List Shared Gallery Image versions operation response.
 */
model SharedGalleryImageVersionList
  is Azure.Core.Page<SharedGalleryImageVersion>;

/**
 * The List Gallery Images operation response.
 */
model GalleryImageList is Azure.Core.Page<GalleryImage>;

/**
 * The List Gallery Image version operation response.
 */
model GalleryImageVersionList is Azure.Core.Page<GalleryImageVersion>;

/**
 * The List Gallery Applications operation response.
 */
model GalleryApplicationList is Azure.Core.Page<GalleryApplication>;

/**
 * The List Gallery Application version operation response.
 */
model GalleryApplicationVersionList
  is Azure.Core.Page<GalleryApplicationVersion>;

/**
 * The provisioning state, which only appears in the response.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union GalleryProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Migrating: "Migrating",
}

/**
 * This property allows you to specify the permission of sharing gallery. Possible values are: **Private,** **Groups,** **Community.**
 */
union GallerySharingPermissionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Private: "Private",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Groups: "Groups",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Community: "Community",
}

/**
 * This property allows you to specify the type of sharing group. Possible values are: **Subscriptions,** **AADTenants.**
 */
union SharingProfileGroupTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Subscriptions: "Subscriptions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AADTenants: "AADTenants",
}

/**
 * The sharing state of the gallery, which only appears in the response.
 */
union SharingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SelectPermissions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Permissions: "Permissions",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union GalleryExpandParams {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SharingProfile/Groups`: "SharingProfile/Groups",
}

/**
 * Specifies the storage account type to be used to store the image. This property is not updatable.
 */
union StorageAccountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_LRS: "Standard_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ZRS: "Standard_ZRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_LRS: "Premium_LRS",
}

/**
 * confidential VM encryption types
 */
union ConfidentialVMEncryptionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncryptedVMGuestStateOnlyWithPmk: "EncryptedVMGuestStateOnlyWithPmk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncryptedWithPmk: "EncryptedWithPmk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncryptedWithCmk: "EncryptedWithCmk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonPersistedTPM: "NonPersistedTPM",
}

/**
 * Optional parameter which specifies the mode to be used for replication. This property is not updatable.
 */
union ReplicationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Full: "Full",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Shallow: "Shallow",
}

/**
 * It is type of the extended location.
 */
union GalleryExtendedLocationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZone: "EdgeZone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * Specifies the storage account type to be used to store the image. This property is not updatable.
 */
union EdgeZoneStorageAccountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_LRS: "Standard_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ZRS: "Standard_ZRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardSSD_LRS: "StandardSSD_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_LRS: "Premium_LRS",
}

/**
 * This is the aggregated replication status based on all the regional replication status flags.
 */
union AggregatedReplicationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * This is the regional replication state.
 */
union ReplicationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replicating: "Replicating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ReplicationStatusTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReplicationStatus: "ReplicationStatus",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UefiSettings: "UefiSettings",
}

/**
 * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
 */
union HyperVGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * The architecture of the image. Applicable to OS disks only.
 */
union Architecture {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x64: "x64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Arm64: "Arm64",
}

/**
 * Describes the nature of the policy violation.
 */
union PolicyViolationCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Other: "Other",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageFlaggedUnsafe: "ImageFlaggedUnsafe",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CopyrightValidation: "CopyrightValidation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IpTheft: "IpTheft",
}

/**
 * The name of the signature template that contains default UEFI keys.
 */
union UefiSignatureTemplateName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoSignatureTemplate: "NoSignatureTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftUefiCertificateAuthorityTemplate: "MicrosoftUefiCertificateAuthorityTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MicrosoftWindowsTemplate: "MicrosoftWindowsTemplate",
}

/**
 * The type of key signature.
 */
union UefiKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sha256: "sha256",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x509: "x509",
}

/**
 * This property allows you to specify the operation type of gallery sharing update. Possible values are: **Add,** **Remove,** **Reset.**
 */
union SharingUpdateOperationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Add: "Add",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Remove: "Remove",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reset: "Reset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnableCommunity: "EnableCommunity",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SharedToValues {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  tenant: "tenant",
}

/**
 * The host caching of the disk. Valid values are 'None', 'ReadOnly', and 'ReadWrite'
 */
union SharedGalleryHostCaching {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadWrite: "ReadWrite",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZone: "EdgeZone",
}

/**
 * This property allows you to specify the supported type of the OS that application is built for. Possible values are: **Windows,** **Linux.**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * Specifies the type of the custom action parameter. Possible values are: String, ConfigurationDataBlob or LogOutputBlob
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum GalleryApplicationCustomActionParameterType {
  String,
  ConfigurationDataBlob,
  LogOutputBlob,
}

/**
 * This property allows the user to specify whether the virtual machines created under this image are 'Generalized' or 'Specialized'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemStateTypes {
  Generalized,
  Specialized,
}

/**
 * The host caching of the disk. Valid values are 'None', 'ReadOnly', and 'ReadWrite'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum HostCaching {
  None,
  ReadOnly,
  ReadWrite,
}

/**
 * Describes the properties of a Shared Image Gallery.
 */
model GalleryProperties {
  /**
   * The description of this Shared Image Gallery resource. This property is updatable.
   */
  description?: string;

  /**
   * Describes the gallery unique name.
   */
  identifier?: GalleryIdentifier;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: GalleryProvisioningState;

  /**
   * Profile for gallery sharing to subscription or tenant
   */
  sharingProfile?: SharingProfile;

  /**
   * Contains information about the soft deletion policy of the gallery.
   */
  softDeletePolicy?: SoftDeletePolicy;

  /**
   * Sharing status of current gallery.
   */
  @visibility("read")
  sharingStatus?: SharingStatus;
}

/**
 * Describes the gallery unique name.
 */
model GalleryIdentifier {
  /**
   * The unique name of the Shared Image Gallery. This name is generated automatically by Azure.
   */
  @visibility("read")
  uniqueName?: string;
}

/**
 * Profile for gallery sharing to subscription or tenant
 */
model SharingProfile {
  /**
   * This property allows you to specify the permission of sharing gallery. Possible values are: **Private,** **Groups,** **Community.**
   */
  permissions?: GallerySharingPermissionTypes;

  /**
   * A list of sharing profile groups.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  groups?: SharingProfileGroup[];

  /**
   * Information of community gallery if current gallery is shared to community.
   */
  communityGalleryInfo?: CommunityGalleryInfo;
}

/**
 * Group of the gallery sharing profile
 */
model SharingProfileGroup {
  /**
   * This property allows you to specify the type of sharing group. Possible values are: **Subscriptions,** **AADTenants.**
   */
  type?: SharingProfileGroupTypes;

  /**
   * A list of subscription/tenant ids the gallery is aimed to be shared to.
   */
  ids?: string[];
}

/**
 * Information of community gallery if current gallery is shared to community
 */
model CommunityGalleryInfo {
  /**
   * The link to the publisher website. Visible to all users.
   */
  publisherUri?: string;

  /**
   * Community gallery publisher support email. The email address of the publisher. Visible to all users.
   */
  publisherContact?: string;

  /**
   * End-user license agreement for community gallery image.
   */
  eula?: string;

  /**
   * The prefix of the gallery name that will be displayed publicly. Visible to all users.
   */
  publicNamePrefix?: string;

  /**
   * Contains info about whether community gallery sharing is enabled.
   */
  @visibility("read")
  communityGalleryEnabled?: boolean;

  /**
   * Community gallery public name list.
   */
  @visibility("read")
  publicNames?: string[];
}

/**
 * Contains information about the soft deletion policy of the gallery.
 */
model SoftDeletePolicy {
  /**
   * Enables soft-deletion for resources in this gallery, allowing them to be recovered within retention time.
   */
  isSoftDeleteEnabled?: boolean;
}

/**
 * Sharing status of current gallery.
 */
model SharingStatus {
  /**
   * Aggregated sharing state of current gallery.
   */
  @visibility("read")
  aggregatedState?: SharingState;

  /**
   * Summary of all regional sharing status.
   */
  @OpenAPI.extension("x-ms-identifiers", ["region"])
  summary?: RegionalSharingStatus[];
}

/**
 * Gallery regional sharing status
 */
model RegionalSharingStatus {
  /**
   * Region name
   */
  region?: string;

  /**
   * Gallery sharing state in current region
   */
  @visibility("read")
  state?: SharingState;

  /**
   * Details of gallery regional sharing failure.
   */
  details?: string;
}

/**
 * The Resource model definition.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * An error response from the Compute service.
 */
@error
model CloudError {
  /**
   * Api error.
   */
  error?: ApiError;
}

/**
 * Api error.
 */
model ApiError {
  /**
   * The Api error details
   */
  @OpenAPI.extension("x-ms-identifiers", ["message", "target"])
  details?: ApiErrorBase[];

  /**
   * The Api inner error
   */
  innererror?: InnerError;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Api error base.
 */
model ApiErrorBase {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Inner error details.
 */
model InnerError {
  /**
   * The exception type.
   */
  exceptiontype?: string;

  /**
   * The internal error message or exception dump.
   */
  errordetail?: string;
}

/**
 * Specifies information about the Shared Image Gallery that you want to update.
 */
model GalleryUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a Shared Image Gallery.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryProperties;
}

/**
 * The Update Resource model definition.
 */
model UpdateResourceDefinition {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Describes the properties of a gallery Application Definition.
 */
model GalleryApplicationProperties {
  /**
   * The description of this gallery Application Definition resource. This property is updatable.
   */
  description?: string;

  /**
   * The Eula agreement for the gallery Application Definition.
   */
  eula?: string;

  /**
   * The privacy statement uri.
   */
  privacyStatementUri?: string;

  /**
   * The release note uri.
   */
  releaseNoteUri?: string;

  /**
   * The end of life date of the gallery Application Definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * This property allows you to specify the supported type of the OS that application is built for. Possible values are: **Windows,** **Linux.**
   */
  supportedOSType: OperatingSystemTypes;

  /**
   * A list of custom actions that can be performed with all of the Gallery Application Versions within this Gallery Application.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  customActions?: GalleryApplicationCustomAction[];
}

/**
 * A custom action that can be performed with a Gallery Application Version.
 */
model GalleryApplicationCustomAction {
  /**
   * The name of the custom action.  Must be unique within the Gallery Application Version.
   */
  name: string;

  /**
   * The script to run when executing this custom action.
   */
  script: string;

  /**
   * Description to help the users understand what this custom action does.
   */
  description?: string;

  /**
   * The parameters that this custom action uses
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters?: GalleryApplicationCustomActionParameter[];
}

/**
 * The definition of a parameter that can be passed to a custom action of a Gallery Application Version.
 */
model GalleryApplicationCustomActionParameter {
  /**
   * The name of the custom action.  Must be unique within the Gallery Application Version.
   */
  name: string;

  /**
   * Indicates whether this parameter must be passed when running the custom action.
   */
  required?: boolean;

  /**
   * Specifies the type of the custom action parameter. Possible values are: String, ConfigurationDataBlob or LogOutputBlob
   */
  type?: GalleryApplicationCustomActionParameterType;

  /**
   * The default value of the parameter.  Only applies to string types
   */
  defaultValue?: string;

  /**
   * A description to help users understand what this parameter means
   */
  description?: string;
}

/**
 * Specifies information about the gallery Application Definition that you want to update.
 */
model GalleryApplicationUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery Application Definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryApplicationProperties;
}

/**
 * Describes the properties of a gallery image version.
 */
model GalleryApplicationVersionProperties {
  /**
   * The publishing profile of a gallery image version.
   */
  publishingProfile: GalleryApplicationVersionPublishingProfile;

  /**
   * The safety profile of the Gallery Application Version.
   */
  safetyProfile?: GalleryApplicationVersionSafetyProfile;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: GalleryProvisioningState;

  /**
   * This is the replication status of the gallery image version.
   */
  @visibility("read")
  replicationStatus?: ReplicationStatus;
}

/**
 * The publishing profile of a gallery image version.
 */
model GalleryApplicationVersionPublishingProfile
  extends GalleryArtifactPublishingProfileBase {
  /**
   * The source image from which the Image Version is going to be created.
   */
  source: UserArtifactSource;

  manageActions?: UserArtifactManage;

  /**
   * Additional settings for the VM app that contains the target package and config file name when it is deployed to target VM or VM scale set.
   */
  settings?: UserArtifactSettings;

  /**
   * Optional. Additional settings to pass to the vm-application-manager extension. For advanced use only.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  advancedSettings?: Record<string>;

  /**
   * Optional. Whether or not this application reports health.
   */
  enableHealthCheck?: boolean;

  /**
   * A list of custom actions that can be performed with this Gallery Application Version.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  customActions?: GalleryApplicationCustomAction[];
}

/**
 * The source image from which the Image Version is going to be created.
 */
model UserArtifactSource {
  /**
   * Required. The mediaLink of the artifact, must be a readable storage page blob.
   */
  mediaLink: string;

  /**
   * Optional. The defaultConfigurationLink of the artifact, must be a readable storage page blob.
   */
  defaultConfigurationLink?: string;
}

model UserArtifactManage {
  /**
   * Required. The path and arguments to install the gallery application. This is limited to 4096 characters.
   */
  install: string;

  /**
   * Required. The path and arguments to remove the gallery application. This is limited to 4096 characters.
   */
  remove: string;

  /**
   * Optional. The path and arguments to update the gallery application. If not present, then update operation will invoke remove command on the previous version and install command on the current version of the gallery application. This is limited to 4096 characters.
   */
  update?: string;
}

/**
 * Additional settings for the VM app that contains the target package and config file name when it is deployed to target VM or VM scale set.
 */
model UserArtifactSettings {
  /**
   * Optional. The name to assign the downloaded package file on the VM. This is limited to 4096 characters. If not specified, the package file will be named the same as the Gallery Application name.
   */
  packageFileName?: string;

  /**
   * Optional. The name to assign the downloaded config file on the VM. This is limited to 4096 characters. If not specified, the config file will be named the Gallery Application name appended with "_config".
   */
  configFileName?: string;
}

/**
 * Describes the basic gallery artifact publishing profile.
 */
model GalleryArtifactPublishingProfileBase {
  /**
   * The target regions where the Image Version is going to be replicated to. This property is updatable.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  targetRegions?: TargetRegion[];

  /**
   * The number of replicas of the Image Version to be created per region. This property would take effect for a region when regionalReplicaCount is not specified. This property is updatable.
   */
  replicaCount?: int32;

  /**
   * If set to true, Virtual Machines deployed from the latest version of the Image Definition won't use this Image Version.
   */
  excludeFromLatest?: boolean;

  /**
   * The timestamp for when the gallery image version is published.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * The end of life date of the gallery image version. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * Specifies the storage account type to be used to store the image. This property is not updatable.
   */
  storageAccountType?: StorageAccountType;

  /**
   * Optional parameter which specifies the mode to be used for replication. This property is not updatable.
   */
  replicationMode?: ReplicationMode;

  /**
   * The target extended locations where the Image Version is going to be replicated to. This property is updatable.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name", "extendedLocation/name"])
  targetExtendedLocations?: GalleryTargetExtendedLocation[];
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
   * The number of replicas of the Image Version to be created per region. This property is updatable.
   */
  regionalReplicaCount?: int32;

  /**
   * Specifies the storage account type to be used to store the image. This property is not updatable.
   */
  storageAccountType?: StorageAccountType;

  /**
   * Optional. Allows users to provide customer managed keys for encrypting the OS and data disks in the gallery artifact.
   */
  encryption?: EncryptionImages;

  /**
   * Contains the flag setting to hide an image when users specify version='latest'
   */
  excludeFromLatest?: boolean;
}

/**
 * Optional. Allows users to provide customer managed keys for encrypting the OS and data disks in the gallery artifact.
 */
model EncryptionImages {
  /**
   * Contains encryption settings for an OS disk image.
   */
  osDiskImage?: OSDiskImageEncryption;

  /**
   * A list of encryption specifications for data disk images.
   */
  @OpenAPI.extension("x-ms-identifiers", ["lun"])
  dataDiskImages?: DataDiskImageEncryption[];
}

/**
 * Contains encryption settings for an OS disk image.
 */
model OSDiskImageEncryption extends DiskImageEncryption {
  /**
   * This property specifies the security profile of an OS disk image.
   */
  securityProfile?: OSDiskImageSecurityProfile;
}

/**
 * Contains security profile for an OS disk image.
 */
model OSDiskImageSecurityProfile {
  /**
   * confidential VM encryption types
   */
  confidentialVMEncryptionType?: ConfidentialVMEncryptionType;

  /**
   * secure VM disk encryption set id
   */
  secureVMDiskEncryptionSetId?: string;
}

/**
 * This is the disk image encryption base class.
 */
model DiskImageEncryption {
  /**
   * A relative URI containing the resource ID of the disk encryption set.
   */
  diskEncryptionSetId?: string;
}

/**
 * Contains encryption settings for a data disk image.
 */
model DataDiskImageEncryption extends DiskImageEncryption {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

model GalleryTargetExtendedLocation {
  /**
   * The name of the region.
   */
  name?: string;

  /**
   * The name of the extended location.
   */
  extendedLocation?: GalleryExtendedLocation;

  /**
   * The number of replicas of the Image Version to be created per extended location. This property is updatable.
   */
  extendedLocationReplicaCount?: int32;

  /**
   * Specifies the storage account type to be used to store the image. This property is not updatable.
   */
  storageAccountType?: EdgeZoneStorageAccountType;

  /**
   * Optional. Allows users to provide customer managed keys for encrypting the OS and data disks in the gallery artifact.
   */
  encryption?: EncryptionImages;
}

/**
 * The name of the extended location.
 */
model GalleryExtendedLocation {
  name?: string;

  /**
   * It is type of the extended location.
   */
  type?: GalleryExtendedLocationType;
}

/**
 * The safety profile of the Gallery Application Version.
 */
model GalleryApplicationVersionSafetyProfile
  extends GalleryArtifactSafetyProfileBase {}

/**
 * This is the safety profile of the Gallery Artifact Version.
 */
model GalleryArtifactSafetyProfileBase {
  /**
   * Indicates whether or not removing this Gallery Image Version from replicated regions is allowed.
   */
  allowDeletionOfReplicatedLocations?: boolean;
}

/**
 * This is the replication status of the gallery image version.
 */
model ReplicationStatus {
  /**
   * This is the aggregated replication status based on all the regional replication status flags.
   */
  @visibility("read")
  aggregatedState?: AggregatedReplicationState;

  /**
   * This is a summary of replication status for each region.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["region"])
  summary?: RegionalReplicationStatus[];
}

/**
 * This is the regional replication status.
 */
model RegionalReplicationStatus {
  /**
   * The region to which the gallery image version is being replicated to.
   */
  @visibility("read")
  region?: string;

  /**
   * This is the regional replication state.
   */
  @visibility("read")
  state?: ReplicationState;

  /**
   * The details of the replication status.
   */
  @visibility("read")
  details?: string;

  /**
   * It indicates progress of the replication job.
   */
  @visibility("read")
  progress?: int32;
}

/**
 * Specifies information about the gallery Application Version that you want to update.
 */
model GalleryApplicationVersionUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image version.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryApplicationVersionProperties;
}

/**
 * Describes the properties of a gallery image definition.
 */
model GalleryImageProperties {
  /**
   * The description of this gallery image definition resource. This property is updatable.
   */
  description?: string;

  /**
   * The Eula agreement for the gallery image definition.
   */
  eula?: string;

  /**
   * The privacy statement uri.
   */
  privacyStatementUri?: string;

  /**
   * The release note uri.
   */
  releaseNoteUri?: string;

  /**
   * This property allows you to specify the type of the OS that is included in the disk when creating a VM from a managed image. Possible values are: **Windows,** **Linux.**
   */
  osType: OperatingSystemTypes;

  /**
   * This property allows the user to specify whether the virtual machines created under this image are 'Generalized' or 'Specialized'.
   */
  osState: OperatingSystemStateTypes;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * The end of life date of the gallery image definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * This is the gallery image definition identifier.
   */
  identifier: GalleryImageIdentifier;

  /**
   * The properties describe the recommended machine configuration for this Image Definition. These properties are updatable.
   */
  recommended?: RecommendedMachineConfiguration;

  /**
   * Describes the disallowed disk types.
   */
  disallowed?: Disallowed;

  /**
   * Describes the gallery image definition purchase plan. This is used by marketplace images.
   */
  purchasePlan?: ImagePurchasePlan;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: GalleryProvisioningState;

  /**
   * A list of gallery image features.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  features?: GalleryImageFeature[];

  /**
   * The architecture of the image. Applicable to OS disks only.
   */
  architecture?: Architecture;
}

/**
 * This is the gallery image definition identifier.
 */
model GalleryImageIdentifier {
  /**
   * The name of the gallery image definition publisher.
   */
  publisher: string;

  /**
   * The name of the gallery image definition offer.
   */
  offer: string;

  /**
   * The name of the gallery image definition SKU.
   */
  sku: string;
}

/**
 * The properties describe the recommended machine configuration for this Image Definition. These properties are updatable.
 */
model RecommendedMachineConfiguration {
  /**
   * Describes the resource range.
   */
  vCPUs?: ResourceRange;

  /**
   * Describes the resource range.
   */
  memory?: ResourceRange;
}

/**
 * Describes the resource range.
 */
model ResourceRange {
  /**
   * The minimum number of the resource.
   */
  min?: int32;

  /**
   * The maximum number of the resource.
   */
  max?: int32;
}

/**
 * Describes the disallowed disk types.
 */
model Disallowed {
  /**
   * A list of disk types.
   */
  diskTypes?: string[];
}

/**
 * Describes the gallery image definition purchase plan. This is used by marketplace images.
 */
model ImagePurchasePlan {
  /**
   * The plan ID.
   */
  name?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;

  /**
   * The product ID.
   */
  product?: string;
}

/**
 * A feature for gallery image.
 */
model GalleryImageFeature {
  /**
   * The name of the gallery image feature.
   */
  name?: string;

  /**
   * The value of the gallery image feature.
   */
  value?: string;
}

/**
 * Specifies information about the gallery image definition that you want to update.
 */
model GalleryImageUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryImageProperties;
}

/**
 * Describes the properties of a gallery image version.
 */
model GalleryImageVersionProperties {
  /**
   * The publishing profile of a gallery image Version.
   */
  publishingProfile?: GalleryImageVersionPublishingProfile;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: GalleryProvisioningState;

  /**
   * This is the storage profile of a Gallery Image Version.
   */
  storageProfile: GalleryImageVersionStorageProfile;

  /**
   * This is the safety profile of the Gallery Image Version.
   */
  safetyProfile?: GalleryImageVersionSafetyProfile;

  /**
   * This is the replication status of the gallery image version.
   */
  @visibility("read")
  replicationStatus?: ReplicationStatus;

  /**
   * The security profile of a gallery image version
   */
  securityProfile?: ImageVersionSecurityProfile;
}

/**
 * The publishing profile of a gallery image Version.
 */
model GalleryImageVersionPublishingProfile
  extends GalleryArtifactPublishingProfileBase {}

/**
 * This is the storage profile of a Gallery Image Version.
 */
model GalleryImageVersionStorageProfile {
  /**
   * The source of the gallery artifact version.
   */
  source?: GalleryArtifactVersionFullSource;

  /**
   * This is the OS disk image.
   */
  osDiskImage?: GalleryOSDiskImage;

  /**
   * A list of data disk images.
   */
  @OpenAPI.extension("x-ms-identifiers", ["lun"])
  dataDiskImages?: GalleryDataDiskImage[];
}

/**
 * The source of the gallery artifact version.
 */
model GalleryArtifactVersionFullSource extends GalleryArtifactVersionSource {
  /**
   * The resource Id of the source Community Gallery Image.  Only required when using Community Gallery Image as a source.
   */
  communityGalleryImageId?: string;

  /**
   * The resource Id of the source virtual machine.  Only required when capturing a virtual machine to source this Gallery Image Version.
   */
  virtualMachineId?: string;
}

/**
 * The gallery artifact version source.
 */
model GalleryArtifactVersionSource {
  /**
   * The id of the gallery artifact version source.
   */
  id?: string;
}

/**
 * This is the OS disk image.
 */
model GalleryOSDiskImage extends GalleryDiskImage {}

/**
 * This is the disk image base class.
 */
model GalleryDiskImage {
  /**
   * This property indicates the size of the VHD to be created.
   */
  @visibility("read")
  sizeInGB?: int32;

  /**
   * The host caching of the disk. Valid values are 'None', 'ReadOnly', and 'ReadWrite'
   */
  hostCaching?: HostCaching;

  /**
   * The source for the disk image.
   */
  source?: GalleryDiskImageSource;
}

/**
 * The source for the disk image.
 */
model GalleryDiskImageSource extends GalleryArtifactVersionSource {
  /**
   * The uri of the gallery artifact version source. Currently used to specify vhd/blob source.
   */
  uri?: string;

  /**
   * The Storage Account Id that contains the vhd blob being used as a source for this artifact version.
   */
  storageAccountId?: string;
}

/**
 * This is the data disk image.
 */
model GalleryDataDiskImage extends GalleryDiskImage {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

/**
 * This is the safety profile of the Gallery Image Version.
 */
model GalleryImageVersionSafetyProfile
  extends GalleryArtifactSafetyProfileBase {
  /**
   * Indicates whether this image has been reported as violating Microsoft's policies.
   */
  @visibility("read")
  reportedForPolicyViolation?: boolean;

  /**
   * A list of Policy Violations that have been reported for this Gallery Image Version.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  policyViolations?: PolicyViolation[];
}

/**
 * A policy violation reported against a gallery artifact.
 */
model PolicyViolation {
  /**
   * Describes the nature of the policy violation.
   */
  category?: PolicyViolationCategory;

  /**
   * Describes specific details about why this policy violation was reported.
   */
  details?: string;
}

/**
 * The security profile of a gallery image version
 */
model ImageVersionSecurityProfile {
  /**
   * Contains UEFI settings for the image version.
   */
  uefiSettings?: GalleryImageVersionUefiSettings;
}

/**
 * Contains UEFI settings for the image version.
 */
model GalleryImageVersionUefiSettings {
  /**
   * The name of the template(s) that contains default UEFI key signatures that will be added to the image.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  signatureTemplateNames?: UefiSignatureTemplateName[];

  /**
   * Additional UEFI key signatures that will be added to the image in addition to the signature templates
   */
  additionalSignatures?: UefiKeySignatures;
}

/**
 * Additional UEFI key signatures that will be added to the image in addition to the signature templates
 */
model UefiKeySignatures {
  /**
   * The Platform Key of this image version.
   */
  pk?: UefiKey;

  /**
   * The Key Encryption Keys of this image version.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  kek?: UefiKey[];

  /**
   * The database of UEFI keys for this image version.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  db?: UefiKey[];

  /**
   * The database of revoked UEFI keys for this image version.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  dbx?: UefiKey[];
}

/**
 * A UEFI key signature.
 */
model UefiKey {
  /**
   * The type of key signature.
   */
  type?: UefiKeyType;

  /**
   * The value of the key signature.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  value?: string[];
}

/**
 * Specifies information about the gallery image version that you want to update.
 */
model GalleryImageVersionUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image version.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryImageVersionProperties;
}

/**
 * Specifies information about the gallery sharing profile update.
 */
model SharingUpdate {
  /**
   * This property allows you to specify the operation type of gallery sharing update. Possible values are: **Add,** **Remove,** **Reset.**
   */
  operationType: SharingUpdateOperationTypes;

  /**
   * A list of sharing profile groups.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  groups?: SharingProfileGroup[];
}

/**
 * Specifies the properties of a shared gallery
 */
model SharedGalleryProperties {
  /**
   * The artifact tags of a shared gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility("read")
  artifactTags?: Record<string>;
}

/**
 * Base information about the shared gallery resource in pir.
 */
model PirSharedGalleryResource extends PirResource {
  /**
   * The identifier information of shared gallery.
   */
  @extension("x-ms-client-flatten", true)
  identifier?: SharedGalleryIdentifier;
}

/**
 * The identifier information of shared gallery.
 */
model SharedGalleryIdentifier {
  /**
   * The unique id of this shared gallery.
   */
  uniqueId?: string;
}

/**
 * The Resource model definition.
 */
model PirResource {
  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource location
   */
  @visibility("read")
  location?: string;
}

/**
 * Describes the properties of a gallery image definition.
 */
model SharedGalleryImageProperties {
  /**
   * This property allows you to specify the type of the OS that is included in the disk when creating a VM from a managed image. Possible values are: **Windows,** **Linux.**
   */
  osType: OperatingSystemTypes;

  /**
   * This property allows the user to specify whether the virtual machines created under this image are 'Generalized' or 'Specialized'.
   */
  osState: OperatingSystemStateTypes;

  /**
   * The end of life date of the gallery image definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * This is the gallery image definition identifier.
   */
  identifier: GalleryImageIdentifier;

  /**
   * The properties describe the recommended machine configuration for this Image Definition. These properties are updatable.
   */
  recommended?: RecommendedMachineConfiguration;

  /**
   * Describes the disallowed disk types.
   */
  disallowed?: Disallowed;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * A list of gallery image features.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  features?: GalleryImageFeature[];

  /**
   * Describes the gallery image definition purchase plan. This is used by marketplace images.
   */
  purchasePlan?: ImagePurchasePlan;

  /**
   * The architecture of the image. Applicable to OS disks only.
   */
  architecture?: Architecture;

  /**
   * Privacy statement uri for the current community gallery image.
   */
  privacyStatementUri?: string;

  /**
   * End-user license agreement for the current community gallery image.
   */
  eula?: string;

  /**
   * The artifact tags of a shared gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  artifactTags?: Record<string>;
}

/**
 * Describes the properties of a gallery image version.
 */
model SharedGalleryImageVersionProperties {
  /**
   * The published date of the gallery image version Definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * The end of life date of the gallery image version Definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * If set to true, Virtual Machines deployed from the latest version of the Image Definition won't use this Image Version.
   */
  excludeFromLatest?: boolean;

  /**
   * Describes the storage profile of the image version.
   */
  storageProfile?: SharedGalleryImageVersionStorageProfile;

  /**
   * The artifact tags of a shared gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  artifactTags?: Record<string>;
}

/**
 * This is the storage profile of a Gallery Image Version.
 */
model SharedGalleryImageVersionStorageProfile {
  /**
   * This is the OS disk image.
   */
  osDiskImage?: SharedGalleryOSDiskImage;

  /**
   * A list of data disk images.
   */
  @OpenAPI.extension("x-ms-identifiers", ["lun"])
  dataDiskImages?: SharedGalleryDataDiskImage[];
}

/**
 * This is the OS disk image.
 */
model SharedGalleryOSDiskImage extends SharedGalleryDiskImage {}

/**
 * This is the disk image base class.
 */
model SharedGalleryDiskImage {
  /**
   * This property indicates the size of the VHD to be created.
   */
  @visibility("read")
  diskSizeGB?: int32;

  /**
   * The host caching of the disk. Valid values are 'None', 'ReadOnly', and 'ReadWrite'
   */
  hostCaching?: SharedGalleryHostCaching;
}

/**
 * This is the data disk image.
 */
model SharedGalleryDataDiskImage extends SharedGalleryDiskImage {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

/**
 * Describes the properties of a community gallery.
 */
model CommunityGalleryProperties {
  /**
   * The disclaimer for a community gallery resource.
   */
  disclaimer?: string;

  /**
   * The artifact tags of a community gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  artifactTags?: Record<string>;

  /**
   * The metadata of community gallery.
   */
  communityMetadata?: CommunityGalleryMetadata;
}

/**
 * The metadata of community gallery.
 */
model CommunityGalleryMetadata {
  /**
   * The publisher URI of this community gallery.
   */
  publisherUri?: url;

  /**
   * The publisher email id of this community gallery.
   */
  publisherContact: string;

  /**
   * The end-user license agreement for this community gallery.
   */
  eula?: string;

  /**
   * A list of public names the gallery has.
   */
  publicNames: string[];

  /**
   * The link for the privacy statement of this community gallery from the gallery publisher.
   */
  privacyStatementUri?: url;
}

/**
 * Base information about the community gallery resource in azure compute gallery.
 */
model PirCommunityGalleryResource {
  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource location
   */
  @visibility("read")
  location?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * The identifier information of community gallery.
   */
  @extension("x-ms-client-flatten", true)
  identifier?: CommunityGalleryIdentifier;
}

/**
 * The identifier information of community gallery.
 */
model CommunityGalleryIdentifier {
  /**
   * The unique id of this community gallery.
   */
  uniqueId?: string;
}

/**
 * Describes the properties of a gallery image definition.
 */
model CommunityGalleryImageProperties {
  /**
   * This property allows you to specify the type of the OS that is included in the disk when creating a VM from a managed image. Possible values are: **Windows,** **Linux.**
   */
  osType: OperatingSystemTypes;

  /**
   * This property allows the user to specify whether the virtual machines created under this image are 'Generalized' or 'Specialized'.
   */
  osState: OperatingSystemStateTypes;

  /**
   * The end of life date of the gallery image definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * This is the community gallery image definition identifier.
   */
  identifier: CommunityGalleryImageIdentifier;

  /**
   * The properties describe the recommended machine configuration for this Image Definition. These properties are updatable.
   */
  recommended?: RecommendedMachineConfiguration;

  /**
   * Describes the disallowed disk types.
   */
  disallowed?: Disallowed;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * A list of gallery image features.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  features?: GalleryImageFeature[];

  /**
   * Describes the gallery image definition purchase plan. This is used by marketplace images.
   */
  purchasePlan?: ImagePurchasePlan;

  /**
   * The architecture of the image. Applicable to OS disks only.
   */
  architecture?: Architecture;

  /**
   * Privacy statement URI for the current community gallery image.
   */
  privacyStatementUri?: string;

  /**
   * The end-user license agreement for the current community gallery image.
   */
  eula?: string;

  /**
   * The disclaimer for a community gallery resource.
   */
  disclaimer?: string;

  /**
   * The artifact tags of a community gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  artifactTags?: Record<string>;
}

/**
 * This is the community gallery image definition identifier.
 */
model CommunityGalleryImageIdentifier {
  /**
   * The name of the gallery image definition publisher.
   */
  publisher?: string;

  /**
   * The name of the gallery image definition offer.
   */
  offer?: string;

  /**
   * The name of the gallery image definition SKU.
   */
  sku?: string;
}

/**
 * Describes the properties of a gallery image version.
 */
model CommunityGalleryImageVersionProperties {
  /**
   * The published date of the gallery image version Definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * The end of life date of the gallery image version Definition. This property can be used for decommissioning purposes. This property is updatable.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOfLifeDate?: utcDateTime;

  /**
   * If set to true, Virtual Machines deployed from the latest version of the Image Definition won't use this Image Version.
   */
  excludeFromLatest?: boolean;

  /**
   * Describes the storage profile of the image version.
   */
  storageProfile?: SharedGalleryImageVersionStorageProfile;

  /**
   * The disclaimer for a community gallery resource.
   */
  disclaimer?: string;

  /**
   * The artifact tags of a community gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  artifactTags?: Record<string>;
}

model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}

model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;
}

/**
 * The Resource model definition with location property as optional.
 */
model ResourceWithOptionalLocation {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The source image from which the Image Version is going to be created.
 */
model GalleryArtifactSource {
  /**
   * The managed artifact.
   */
  managedImage: ManagedArtifact;
}

/**
 * The managed artifact.
 */
model ManagedArtifact {
  /**
   * The managed artifact id.
   */
  id: string;
}

/**
 * The gallery image version with latest version in a particular region.
 */
model LatestGalleryImageVersion {
  /**
   * The name of the latest version in the region.
   */
  latestVersionName?: string;

  /**
   * region of the Gallery Image Version.
   */
  location?: string;
}
