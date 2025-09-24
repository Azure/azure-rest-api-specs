import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PremiumV2_LRS: "PremiumV2_LRS",
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
 * This property specifies the status of the validationProfile of the image version.
 */
union ValidationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
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
 * Optional. The action to be taken with regards to install/update/remove of the gallery application in the event of a reboot.
 */
union GalleryApplicationScriptRebootBehavior {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rerun: "Rerun",
}

/**
 * artifact type of the soft-deleted resource
 */
union SoftDeletedArtifactTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Images: "Images",
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

/**
 * This property allows you to specify whether the access control rules are in Audit mode, in Enforce mode or Disabled. Possible values are: 'Audit', 'Enforce' or 'Disabled'.
 */
union AccessControlRulesMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audit: "Audit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enforce: "Enforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * This property allows you to specify if the requests will be allowed to access the host endpoints. Possible values are: 'Allow', 'Deny'.
 */
union EndpointAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
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
 * The type of identity used for the gallery. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove all identities from the gallery.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
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
 * Specifies the type of the custom action parameter. Possible values are: String, ConfigurationDataBlob or LogOutputBlob
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum GalleryApplicationCustomActionParameterType {
  String,
  ConfigurationDataBlob,
  LogOutputBlob,
}

/**
 * This property allows you to specify the Endpoint type for which this profile is defining the access control for. Possible values are: 'WireServer' or 'IMDS'
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EndpointTypes {
  WireServer,
  IMDS,
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  sharingStatus?: SharingStatus;
}

/**
 * Describes the gallery unique name.
 */
model GalleryIdentifier {
  /**
   * The unique name of the Shared Image Gallery. This name is generated automatically by Azure.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  communityGalleryEnabled?: boolean;

  /**
   * Community gallery public name list.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  aggregatedState?: SharingState;

  /**
   * Summary of all regional sharing status.
   */
  @identifiers(#["region"])
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
  @visibility(Lifecycle.Read)
  state?: SharingState;

  /**
   * Details of gallery regional sharing failure.
   */
  details?: string;
}

/**
 * Identity for the virtual machine.
 */
model GalleryIdentity {
  /**
   * The principal id of the gallery identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The AAD tenant id of the gallery identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the gallery. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove all identities from the gallery.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the gallery. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Specifies information about the Shared Image Gallery that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a Shared Image Gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GalleryProperties;

  /**
   * The identity of the gallery, if configured.
   */
  identity?: GalleryIdentity;
}

/**
 * The Update Resource model definition.
 */
model UpdateResourceDefinition {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
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
  @visibility(Lifecycle.Read)
  provisioningState?: GalleryProvisioningState;

  /**
   * A list of gallery image features.
   */
  @identifiers(#["name"])
  features?: GalleryImageFeature[];

  /**
   * The architecture of the image. Applicable to OS disks only.
   */
  architecture?: Architecture;

  /**
   * Optional. Must be set to true if the gallery image features are being updated.
   */
  allowUpdateImage?: boolean;
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

  /**
   * The minimum gallery image version which supports this feature.
   */
  startsAtVersion?: string;
}

/**
 * Specifies information about the gallery image definition that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryImageUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  replicationStatus?: ReplicationStatus;

  /**
   * The security profile of a gallery image version
   */
  securityProfile?: ImageVersionSecurityProfile;

  /**
   * Indicates if this is a soft-delete resource restoration request.
   */
  restore?: boolean;

  /**
   * This is the validations profile of a Gallery Image Version.
   */
  @visibility(Lifecycle.Read)
  validationsProfile?: ValidationsProfile;
}

/**
 * The publishing profile of a gallery image Version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model GalleryImageVersionPublishingProfile
  extends GalleryArtifactPublishingProfileBase {}

/**
 * Describes the basic gallery artifact publishing profile.
 */
model GalleryArtifactPublishingProfileBase {
  /**
   * The target regions where the Image Version is going to be replicated to. This property is updatable.
   */
  @identifiers(#["name"])
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
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name", "extendedLocation/name"])
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

  /**
   * List of storage sku with replica count to create direct drive replicas.
   */
  @identifiers(#[])
  additionalReplicaSets?: AdditionalReplicaSet[];
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
  @identifiers(#["lun"])
  dataDiskImages?: DataDiskImageEncryption[];
}

/**
 * Contains encryption settings for an OS disk image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DataDiskImageEncryption extends DiskImageEncryption {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

/**
 * Describes the additional replica set information.
 */
model AdditionalReplicaSet {
  /**
   * Specifies the storage account type to be used to create the direct drive replicas
   */
  storageAccountType?: StorageAccountType;

  /**
   * The number of direct drive replicas of the Image Version to be created.This Property is updatable
   */
  regionalReplicaCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;

  /**
   * It is type of the extended location.
   */
  type?: GalleryExtendedLocationType;
}

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
  @identifiers(#["lun"])
  dataDiskImages?: GalleryDataDiskImage[];
}

/**
 * The source of the gallery artifact version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model GalleryOSDiskImage extends GalleryDiskImage {}

/**
 * This is the disk image base class.
 */
model GalleryDiskImage {
  /**
   * This property indicates the size of the VHD to be created.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryDataDiskImage extends GalleryDiskImage {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

/**
 * This is the safety profile of the Gallery Image Version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryImageVersionSafetyProfile
  extends GalleryArtifactSafetyProfileBase {
  /**
   * Indicates whether this image has been reported as violating Microsoft's policies.
   */
  @visibility(Lifecycle.Read)
  reportedForPolicyViolation?: boolean;

  /**
   * A list of Policy Violations that have been reported for this Gallery Image Version.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  policyViolations?: PolicyViolation[];

  /**
   * Indicates whether or not the deletion is blocked for this Gallery Image Version if its End Of Life has not expired.
   */
  blockDeletionBeforeEndOfLife?: boolean;
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
  @visibility(Lifecycle.Read)
  aggregatedState?: AggregatedReplicationState;

  /**
   * This is a summary of replication status for each region.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["region"])
  summary?: RegionalReplicationStatus[];
}

/**
 * This is the regional replication status.
 */
model RegionalReplicationStatus {
  /**
   * The region to which the gallery image version is being replicated to.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * This is the regional replication state.
   */
  @visibility(Lifecycle.Read)
  state?: ReplicationState;

  /**
   * The details of the replication status.
   */
  @visibility(Lifecycle.Read)
  details?: string;

  /**
   * It indicates progress of the replication job.
   */
  @visibility(Lifecycle.Read)
  progress?: int32;
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
  @identifiers(#[])
  kek?: UefiKey[];

  /**
   * The database of UEFI keys for this image version.
   */
  @identifiers(#[])
  db?: UefiKey[];

  /**
   * The database of revoked UEFI keys for this image version.
   */
  @identifiers(#[])
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
  value?: string[];
}

/**
 * This is the validations profile of a Gallery Image Version.
 */
model ValidationsProfile {
  /**
   * The published time of the image version
   */
  validationEtag?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
  executedValidations?: ExecutedValidation[];

  /**
   * This specifies the pub, offer, sku and version of the image version metadata
   */
  @identifiers(#["name"])
  platformAttributes?: PlatformAttribute[];
}

/**
 * This is the executed Validation.
 */
model ExecutedValidation {
  /**
   * This property specifies the type of image version validation.
   */
  type?: string;

  /**
   * This property specifies the status of the validationProfile of the image version.
   */
  status?: ValidationStatus;

  /**
   * This property specifies the valid version of the validation.
   */
  version?: string;

  /**
   * This property specifies the starting timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionTime?: utcDateTime;
}

/**
 * This is the platform attribute of the image version.
 */
model PlatformAttribute {
  /**
   * This property specifies the name of the platformAttribute. It is read-only.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * This property specifies the value of the corresponding name property. It is read-only.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Specifies information about the gallery image version that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryImageVersionUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GalleryImageVersionProperties;
}

/**
 * Describes the properties of a gallery Application Definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryApplicationUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery Application Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  provisioningState?: GalleryProvisioningState;

  /**
   * This is the replication status of the gallery image version.
   */
  @visibility(Lifecycle.Read)
  replicationStatus?: ReplicationStatus;
}

/**
 * The publishing profile of a gallery image version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryApplicationVersionPublishingProfile
  extends GalleryArtifactPublishingProfileBase {
  /**
   * The source image from which the Image Version is going to be created.
   */
  source: UserArtifactSource;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @identifiers(#["name"])
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  /**
   * Optional. The action to be taken with regards to install/update/remove of the gallery application in the event of a reboot.
   */
  scriptBehaviorAfterReboot?: GalleryApplicationScriptRebootBehavior;
}

/**
 * The safety profile of the Gallery Application Version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model GalleryApplicationVersionSafetyProfile
  extends GalleryArtifactSafetyProfileBase {}

/**
 * Specifies information about the gallery Application Version that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryApplicationVersionUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery image version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GalleryApplicationVersionProperties;
}

/**
 * The List Galleries operation response.
 */
model GalleryList is Azure.Core.Page<Gallery> {
  /**
   * The security profile of a gallery image version
   */
  securityProfile?: ImageVersionSecurityProfile;
}

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
 * The List Soft-deleted Resources operation response.
 */
model GallerySoftDeletedResourceList
  is Azure.Core.Page<GallerySoftDeletedResource>;

/**
 * The details information of soft-deleted resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GallerySoftDeletedResource
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Describes the properties of a soft-deleted resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GallerySoftDeletedResourceProperties;
}

/**
 * Describes the properties of a soft-deleted resource.
 */
model GallerySoftDeletedResourceProperties {
  /**
   * arm id of the soft-deleted resource
   */
  resourceArmId?: Azure.Core.armResourceIdentifier;

  /**
   * artifact type of the soft-deleted resource
   */
  softDeletedArtifactType?: SoftDeletedArtifactTypes;

  /**
   * The timestamp for when the resource is soft-deleted. In dateTime offset format.
   */
  softDeletedTime?: string;
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
  @identifiers(#[])
  groups?: SharingProfileGroup[];
}

/**
 * Describes the properties of a gallery inVMAccessControlProfile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GalleryInVMAccessControlProfileProperties
  extends GalleryResourceProfilePropertiesBase {
  /**
   * The description of this gallery inVMAccessControlProfile resources. This property is updatable.
   */
  description?: string;

  /**
   * This property allows you to specify the OS type of the VMs/VMSS for which this profile can be used against. Possible values are: 'Windows' or 'Linux'
   */
  osType: OperatingSystemTypes;

  /**
   * This property allows you to specify the Endpoint type for which this profile is defining the access control for. Possible values are: 'WireServer' or 'IMDS'
   */
  applicableHostEndpoint: EndpointTypes;
}

/**
 * The properties of a gallery ResourceProfile.
 */
model GalleryResourceProfilePropertiesBase {
  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: GalleryProvisioningState;
}

/**
 * Specifies information about the gallery inVMAccessControlProfile that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryInVMAccessControlProfileUpdate extends UpdateResourceDefinition {
  /**
   * Describes the properties of a gallery inVMAccessControlProfile.
   */
  properties?: GalleryInVMAccessControlProfileProperties;
}

/**
 * Describes the properties of an inVMAccessControlProfile version.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GalleryInVMAccessControlProfileVersionProperties
  extends GalleryResourceProfileVersionPropertiesBase {
  /**
   * This property allows you to specify whether the access control rules are in Audit mode, in Enforce mode or Disabled. Possible values are: 'Audit', 'Enforce' or 'Disabled'.
   */
  mode: AccessControlRulesMode;

  /**
   * This property allows you to specify if the requests will be allowed to access the host endpoints. Possible values are: 'Allow', 'Deny'.
   */
  defaultAccess: EndpointAccess;

  /**
   * This is the Access Control Rules specification for an inVMAccessControlProfile version.
   */
  rules?: AccessControlRules;
}

/**
 * This is the Access Control Rules specification for an inVMAccessControlProfile version.
 */
model AccessControlRules {
  /**
   * A list of privileges.
   */
  @identifiers(#["name"])
  privileges?: AccessControlRulesPrivilege[];

  /**
   * A list of roles.
   */
  @identifiers(#["name"])
  roles?: AccessControlRulesRole[];

  /**
   * A list of identities.
   */
  @identifiers(#["name"])
  identities?: AccessControlRulesIdentity[];

  /**
   * A list of role assignments.
   */
  @identifiers(#["role"])
  roleAssignments?: AccessControlRulesRoleAssignment[];
}

/**
 * The properties of an Access Control Rule Privilege.
 */
model AccessControlRulesPrivilege {
  /**
   * The name of the privilege.
   */
  name: string;

  /**
   * The HTTP path corresponding to the privilege.
   */
  path: string;

  /**
   * The query parameters to match in the path.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  queryParameters?: Record<string>;
}

/**
 * The properties of an Access Control Rule Role.
 */
model AccessControlRulesRole {
  /**
   * The name of the role.
   */
  name: string;

  /**
   * A list of privileges needed by this role.
   */
  privileges: string[];
}

/**
 * The properties of an Access Control Rule Identity.
 */
model AccessControlRulesIdentity {
  /**
   * The name of the identity.
   */
  name: string;

  /**
   * The username corresponding to this identity.
   */
  userName?: string;

  /**
   * The groupName corresponding to this identity.
   */
  groupName?: string;

  /**
   * The path to the executable.
   */
  exePath?: string;

  /**
   * The process name of the executable.
   */
  processName?: string;
}

/**
 * The properties of an Access Control Rule RoleAssignment.
 */
model AccessControlRulesRoleAssignment {
  /**
   * The name of the role.
   */
  role: string;

  /**
   * A list of identities that can access the privileges defined by the role.
   */
  identities: string[];
}

/**
 * The properties of a gallery ResourceProfile version.
 */
model GalleryResourceProfileVersionPropertiesBase {
  /**
   * The target regions where the Resource Profile version is going to be replicated to. This property is updatable.
   */
  @identifiers(#["name"])
  targetLocations?: TargetRegion[];

  /**
   * If set to true, Virtual Machines deployed from the latest version of the Resource Profile won't use this Profile version.
   */
  excludeFromLatest?: boolean;

  /**
   * The timestamp for when the Resource Profile Version is published.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: GalleryProvisioningState;

  /**
   * This is the replication status of the gallery image version.
   */
  @visibility(Lifecycle.Read)
  replicationStatus?: ReplicationStatus;
}

/**
 * Specifies information about the gallery inVMAccessControlProfile version that you want to update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GalleryInVMAccessControlProfileVersionUpdate
  extends UpdateResourceDefinition {
  /**
   * Describes the properties of an inVMAccessControlProfile version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: GalleryInVMAccessControlProfileVersionProperties;
}

/**
 * The List Gallery InVMAccessControlProfiles operation response.
 */
model GalleryInVMAccessControlProfileList
  is Azure.Core.Page<GalleryInVMAccessControlProfile>;

/**
 * The List Gallery InVMAccessControlProfile Versions operation response.
 */
model GalleryInVMAccessControlProfileVersionList
  is Azure.Core.Page<GalleryInVMAccessControlProfileVersion>;

/**
 * The List Shared Galleries operation response.
 */
model SharedGalleryList is Azure.Core.Page<SharedGallery>;

/**
 * Specifies the properties of a shared gallery
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SharedGalleryProperties {
  /**
   * The artifact tags of a shared gallery resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  artifactTags?: Record<string>;
}

/**
 * Base information about the shared gallery resource in pir.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PirSharedGalleryResource extends PirResource {
  /**
   * The identifier information of shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * The List Shared Gallery Images operation response.
 */
model SharedGalleryImageList is Azure.Core.Page<SharedGalleryImage>;
@@identifiers(SharedGalleryImageList.value, #[]);

/**
 * Describes the properties of a gallery image definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @identifiers(#["name"])
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
 * The List Shared Gallery Image versions operation response.
 */
model SharedGalleryImageVersionList
  is Azure.Core.Page<SharedGalleryImageVersion>;
@@identifiers(SharedGalleryImageVersionList.value, #[]);

/**
 * Describes the properties of a gallery image version.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @identifiers(#["lun"])
  dataDiskImages?: SharedGalleryDataDiskImage[];
}

/**
 * This is the OS disk image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model SharedGalleryOSDiskImage extends SharedGalleryDiskImage {}

/**
 * This is the disk image base class.
 */
model SharedGalleryDiskImage {
  /**
   * This property indicates the size of the VHD to be created.
   */
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;

  /**
   * The host caching of the disk. Valid values are 'None', 'ReadOnly', and 'ReadWrite'
   */
  hostCaching?: SharedGalleryHostCaching;
}

/**
 * This is the data disk image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SharedGalleryDataDiskImage extends SharedGalleryDiskImage {
  /**
   * This property specifies the logical unit number of the data disk. This value is used to identify data disks within the Virtual Machine and therefore must be unique for each data disk attached to the Virtual Machine.
   */
  lun: int32;
}

/**
 * Describes the properties of a community gallery.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The identifier information of community gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @identifiers(#["name"])
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

/**
 * The List Community Gallery Images operation response.
 */
model CommunityGalleryImageList is Azure.Core.Page<CommunityGalleryImage>;
@@identifiers(CommunityGalleryImageList.value, #[]);

/**
 * The List Community Gallery Image versions operation response.
 */
model CommunityGalleryImageVersionList
  is Azure.Core.Page<CommunityGalleryImageVersion>;
@@identifiers(CommunityGalleryImageVersionList.value, #[]);

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

/**
 * Concrete proxy resource types can be created by aliasing this type using a specific property type.
 *
 * See more details on [different Azure Resource Manager resource type here.](https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type)
 * @template Properties A model containing the provider-specific properties for this resource
 * @template PropertiesOptional A boolean flag indicating whether the resource `Properties` field is marked as optional or required. Default true is optional and recommended.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage"
@doc("Concrete proxy resource types can be created by aliasing this type using a specific property type.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.customAzureResource
model ProxyResourceCommunity<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends PirCommunityGalleryResource {
  @doc("The resource-specific properties for this resource.")
  properties?: Properties;

  /**
   * The name of the parent resource.
   */
  @path
  @visibility(Lifecycle.Read)
  @segment("parents")
  parentName: string;
}

/**
 * Concrete proxy resource types can be created by aliasing this type using a specific property type.
 *
 * See more details on [different Azure Resource Manager resource type here.](https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type)
 * @template Properties A model containing the provider-specific properties for this resource
 * @template PropertiesOptional A boolean flag indicating whether the resource `Properties` field is marked as optional or required. Default true is optional and recommended.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage"
@doc("Concrete proxy resource types can be created by aliasing this type using a specific property type.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.customAzureResource
model ProxyResourceShared<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends PirSharedGalleryResource {
  @doc("The resource-specific properties for this resource.")
  properties?: Properties;

  /**
   * The name of the parent resource.
   */
  @path
  @visibility(Lifecycle.Read)
  @segment("parents")
  parentName: string;
}
@@doc(CommunityGalleryImageList.value, "A list of community gallery images.");
@@doc(CommunityGalleryImageVersionList.value,
  "A list of community gallery image versions."
);
@@doc(CommunityGalleryImageVersionList.nextLink,
  "The URI to fetch the next page of community gallery image versions. Call ListNext() with this to fetch the next page of community gallery image versions."
);
@@doc(GalleryApplicationVersionList.value,
  "A list of gallery Application Versions."
);
@@doc(GalleryApplicationVersionList.nextLink,
  "The uri to fetch the next page of gallery Application Versions. Call ListNext() with this to fetch the next page of gallery Application Versions."
);
@@doc(GalleryImageList.value, "A list of Shared Image Gallery images.");
@@doc(GalleryImageList.nextLink,
  "The uri to fetch the next page of Image Definitions in the Shared Image Gallery. Call ListNext() with this to fetch the next page of gallery image definitions."
);
@@doc(GalleryImageVersionList.nextLink,
  "The uri to fetch the next page of gallery image versions. Call ListNext() with this to fetch the next page of gallery image versions."
);
@@doc(GalleryImageVersionList.value, "A list of gallery image versions.");
@@doc(GalleryList.nextLink,
  "The uri to fetch the next page of galleries. Call ListNext() with this to fetch the next page of galleries."
);
@@doc(GalleryList.value, "A list of galleries.");
@@doc(SharedGalleryImageList.value, "A list of shared gallery images.");
@@doc(SharedGalleryImageList.nextLink,
  "The uri to fetch the next page of shared gallery images. Call ListNext() with this to fetch the next page of shared gallery images."
);
@@doc(SharedGalleryList.nextLink,
  "The uri to fetch the next page of shared galleries. Call ListNext() with this to fetch the next page of shared galleries."
);
@@doc(SharedGalleryList.value, "A list of shared galleries.");
@@identifiers(SharedGalleryList.value, #["name"]);
