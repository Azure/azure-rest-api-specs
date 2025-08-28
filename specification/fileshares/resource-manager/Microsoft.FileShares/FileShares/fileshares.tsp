import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

@armProviderNamespace
@service(#{ title: "Microsoft.FileShares" })
@doc("Azure File Shares Resource Provider API.")
@versioned(Microsoft.FileShares.Versions)
namespace Microsoft.FileShares;

@doc("Service versions")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.CommonTypes.Versions.v6)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("Version 2025-06-01-preview")
  v2025_06_01_preview: "2025-06-01-preview",
}

@doc("File share resource")
model FileShare is Azure.ResourceManager.TrackedResource<FileShareProperties> {
  @doc("The resource name of the file share, as seen by the administrator through Azure Resource Manager.")
  @pattern("^([a-z]|[0-9])([a-z]|[0-9]|(-(?!-))){1,61}([a-z]|[0-9])$")
  @key("resourceName")
  @path
  @segment("fileShares")
  name: string;
}

@doc("Media Tier enum.")
union MediaTier {
  string,

  @doc("SSD media tier.")
  SSD: "SSD",
}

@doc("Redundancy enum.")
union Redundancy {
  string,

  @doc("Local redundancy.")
  Local: "Local",

  @doc("Zone redundancy.")
  Zone: "Zone",
}

@doc("Protocol enum.")
union Protocol {
  string,

  @doc("NFS protocol.")
  NFS: "NFS",
}

@doc("Share root squash enum.")
union ShareRootSquash {
  string,

  @doc("No root squash.")
  NoRootSquash: "NoRootSquash",

  @doc("Root squash.")
  RootSquash: "RootSquash",

  @doc("All squash.")
  AllSquash: "AllSquash",
}

@doc("State of the public network access.")
union PublicNetworkAccess {
  string,

  @doc("The public network access is enabled")
  Enabled: "Enabled",

  @doc("The public network access is disabled")
  Disabled: "Disabled",
}

// Important Technicalities: TypeSpec and ARM have different mindset wrt PUT/PATCH modeling.
// For ARM - PATCH contract is a replica of PUT contract, which can repeat any member
// from it and RP is responsible to maintain immutability guarantees.
//
// TypeSpec authors separate PUT model from PATCH model. It is done automagically - PATCH model is built from resource properties with Lifecycle.Update visibility.
// It turns PATCH contract into a different class, members of which are a subset of PUT contract, and are all exclusively mutable.
//
// This divide doesn't seem to have good solution, so it is a problem #1.
// Newer version of TypeSpec compiler have @parameterVisibility operation attribute
// that is supposed to be applied over ArmCustomPatch-type of operations to make all involved fields
// visible, but my experiments with it are not yielding desired outcome.
//
// In addition we have a problem #2 - our action framework currently support only 1:1 mapping between unified model and its versioned counterpart.
// That is, for a given API version - single Unified Model corresponds to a single Protocol Contract.
// Therefore, that protocol contract will be used in both PUT and PATCH scenarios, and has to be coded up appropriately.
//
// Consequences:
// - We still apply visibility attributes to benefit from OpenAPI spec correctness and documentation.
// - We must mark members optional, if we don't - generated contracts will have "Required.Always" JSON attributes on those members which will make it impossible to accept differential PATCH payloads.
// - Server side would rely on runtime ValidatePutResource/ValidatePatchResource execution for guaranteeing correctness of incoming payloads, rather than just trusting JSON deserialization.
@doc("File share properties")
model FileShareProperties {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The name of the file share as seen by the end user when mounting the share, such as in a URI or UNC format in their operating system.")
  mountName?: string;

  @visibility(Lifecycle.Read)
  @doc("The host name of the file share.")
  hostName?: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The storage media tier of the file share.")
  mediaTier?: MediaTier;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The chosen redundancy level of the file share.")
  redundancy?: Redundancy;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The file sharing protocol for this file share.")
  protocol?: Protocol;

  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned storage size of the share in GiB (1 GiB is 1024^3 bytes or 1073741824 bytes). A component of the file share's bill is the provisioned storage, regardless of the amount of used storage.")
  provisionedStorageGiB?: int32;

  @visibility(Lifecycle.Read)
  @doc("A date/time value that specifies when the provisioned storage for the file share is permitted to be reduced.")
  provisionedStorageNextAllowedDowngrade?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned IO / sec of the share.")
  provisionedIOPerSec?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @visibility(Lifecycle.Read)
  @doc("A date/time value that specifies when the provisioned IOPS for the file share is permitted to be reduced.")
  provisionedIOPerSecNextAllowedDowngrade?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned throughput / sec of the share.")
  provisionedThroughputMiBPerSec?: int32;

  @visibility(Lifecycle.Read)
  @doc("A date/time value that specifies when the provisioned throughput for the file share is permitted to be reduced.")
  provisionedThroughputNextAllowedDowngrade?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @visibility(Lifecycle.Read)
  @minValue(3000)
  @doc("Burst IOPS are extra buffer IOPS enabling you to consume more than your provisioned IOPS for a short period of time, depending on the burst credits available for your share.")
  includedBurstIOPerSec?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @visibility(Lifecycle.Read)
  @minValue(0)
  @doc("Max burst IOPS credits shows the maximum number of burst credits the share can have at the current IOPS provisioning level.")
  maxBurstIOPerSecCredits?: int64;

  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("Protocol settings specific NFS.")
  nfsProtocolProperties?: NfsProtocolProperties;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The set of properties for control public access.")
  publicAccessProperties?: PublicAccessProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: FileShareProvisioningState;

  @doc("Gets or sets allow or disallow public network access to azure managed file share")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  publicNetworkAccess?: PublicNetworkAccess;

  @visibility(Lifecycle.Read)
  @doc("The list of associated private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

#deprecated "Deprecating 202 for PUT requests. Use 201 instead."
@doc("ARM create operation completed successfully.")
model ArmCreatedResponseWithAzureAsyncOperationHeader<T extends TypeSpec.Reflection.Model>
  extends ArmAcceptedResponse {
  @doc("Response with a long running operation status follow up link.")
  @pollingLocation
  @header("Azure-AsyncOperation")
  @visibility(Lifecycle.Read)
  operationLocation: ResourceLocation<ResourceOperationStatus<T>>;
}

@doc("The set of properties for control public access.")
model PublicAccessProperties {
  @doc("The allowed set of subnets when access is restricted.")
  allowedSubnets?: string[];
}

@doc("Properties specific to the NFS protocol.")
model NfsProtocolProperties {
  // Unless the user has explicitly set the root squash property, the default
  // value is NoRootSquash.
  @doc("Root squash defines how root users on clients are mapped to the NFS share.")
  rootSquash?: ShareRootSquash;
}

@lroStatus
@doc("The status of file share's ProvisioningState.")
union FileShareProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  @doc("The operation is provisioning.")
  Provisioning: "Provisioning",

  @doc("The operation is updating.")
  Updating: "Updating",

  @doc("The operation is deleting.")
  Deleting: "Deleting",

  @doc("The operation is accepted.")
  Accepted: "Accepted",

  @doc("The resource has been created.")
  Created: "Created",

  @doc("The operation is in a transient failure state.")
  TransientFailure: "TransientFailure",

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being patched.")
  Patching: "Patching",

  @doc("The resource is being posted.")
  Posting: "Posting",
}

@armResourceOperations
interface FileShares {
  get is ArmResourceRead<FileShare, BaseParameters<FileShare>>;

  @doc("Create or update a file share.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FileShare,
    BaseParameters<FileShare>,
    ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    FileShare,
    ResourceUpdateModel<FileShare, FileShareProperties>,
    BaseParameters<FileShare>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    FileShare,
    BaseParameters<FileShare>
  >;

  listBySubscription is ArmListBySubscription<FileShare>;

  listByParent is ArmResourceListByParent<
    FileShare,
    BaseParameters<FileShare>,
    "",
    ""
  >;

  checkNameAvailability is checkLocalNameAvailability;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Added Operation ID as it determines the PowerShell verb used."
@armResourceOperations
interface FileShareSnapshots {
  @operationId("FileShareSnapshot_Get")
  getFileShareSnapshot is ArmResourceRead<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "RP doesn't support 201 Created pattern for proxy resources in public preview. To be addressed in GA."
  @operationId("FileShareSnapshot_CreateOrUpdate")
  @doc("Create a FileShareSnapshot.")
  createOrUpdateFileShareSnapshot is ArmResourceCreateOrReplaceAsync<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader<FinalResult = FileShareSnapshot> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  @operationId("FileShareSnapshot_Update")
  @doc("Update a FileShareSnapshot.")
  updateFileShareSnapshot is ArmCustomPatchAsync<
    FileShareSnapshot,
    ResourceUpdateModel<FileShareSnapshot, FileShareSnapshotProperties>,
    BaseParameters<FileShareSnapshot>,
    Response = ArmResponse<FileShareSnapshot> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader<FinalResult = FileShareSnapshot> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  @operationId("FileShareSnapshot_Delete")
  @doc("Delete a FileShareSnapshot.")
  deleteFileShareSnapshot is ArmResourceDeleteWithoutOkAsync<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>
  >;

  @operationId("FileShareSnapshot_List")
  @doc("List FileShareSnapshot by FileShare.")
  listByFileShare is ArmResourceListByParent<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>,
    "",
    ""
  >;
}

interface Operations {
  // This operation was pulled from "extends Azure.ResourceManager.Operations" so that a @doc description can
  // be added to generate a description in swagger. Primarily done to satisfy lint in azure-rest-api-specs-pr repo.
  @tag("Operations")
  @autoRoute
  @armResourceList(OperationListResult)
  @doc("List the operations for the provider")
  @segment("operations")
  @get
  @list
  list(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.ThisWillBeReplaced",
  ): ArmResponse<OperationListResult> | ErrorResponse;
}

@doc("FileShareSnapshot resource")
@parentResource(FileShare)
model FileShareSnapshot
  is Azure.ResourceManager.ProxyResource<FileShareSnapshotProperties> {
  ...ResourceNameParameter<
    Resource = FileShareSnapshot,
    KeyName = "name",
    NamePattern = "^([a-z]|[0-9])([a-z]|[0-9]|(-(?!-))){1,61}([a-z]|[0-9])$",
    SegmentName = "fileShareSnapshots"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing use case"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing use case"
@doc("FileShareSnapshot properties")
model FileShareSnapshotProperties {
  // The FileShareSnapshot time of the file share FileShareSnapshot.
  @visibility(Lifecycle.Read)
  @doc("The FileShareSnapshot time in UTC in string representation")
  snapshotTime?: string;

  // User-defined value. Resource users and/or automated systems (like Azure Backup) managing snapshots will specify the value based on semantics of their own.
  // Examples:
  // - Users in Company A might use aliases.
  // - Users in company B might use email addresses.
  // - Automated systems like MAB might use resource identifier of Azure Backup Vault.
  @visibility(Lifecycle.Read)
  @doc("The initiator of the FileShareSnapshot. This is a user-defined value.")
  initiatorId?: string;

  @doc("The metadata")
  metadata?: Record<string>;
}

@doc("Response structure for file shares usage in the specified subscription/location.")
model FileShareUsageDataResponse {
  @doc("The properties of the file share usage data.")
  properties: FileShareUsageDataOutput;
}

@doc("File shares usage result.")
model FileShareUsageDataOutput {
  @doc("File share usage data for active file shares.")
  liveShares: LiveSharesUsageData;
}

@doc("Usage data for live shares.")
model LiveSharesUsageData {
  @doc("The number of active file shares.")
  fileShareCount: int32;
}

@doc("File share-related limits in the specified subscription/location.")
model FileShareLimits {
  @doc("The maximum number of file shares that can be created.")
  maxFileShares: int32;

  @doc("The maximum number of snapshots allowed per file share.")
  maxFileShareSnapshots: int32;

  @doc("The maximum number of subnets that can be associated with a file share.")
  maxFileShareSubnets: int32;

  @doc("The maximum number of private endpoint connections allowed for a file share.")
  maxFileSharePrivateEndpointConnections: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The minimum provisioned storage in GiB for a file share.")
  minProvisionedStorageGiB: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The maximum provisioned storage in GiB for a file share.")
  maxProvisionedStorageGiB: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The minimum provisioned IOPS (Input/Output Operations Per Second) for a file share.")
  minProvisionedIOPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The maximum provisioned IOPS (Input/Output Operations Per Second) for a file share.")
  maxProvisionedIOPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The minimum provisioned throughput in MiB/s for a file share.")
  minProvisionedThroughputMiBPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The maximum provisioned throughput in MiB/s for a file share.")
  maxProvisionedThroughputMiBPerSec: int32;
}

@doc("Constants used for calculating recommended values of file share provisioning properties.")
model FileShareProvisioningConstants {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("Base IO per second.")
  baseIOPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("Scalar IO per second.")
  scalarIOPerSec: float64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("Base throughput in MiB per second.")
  baseThroughputMiBPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("Scalar throughput in MiB per second.")
  scalarThroughputMiBPerSec: float64;
}

@doc("Response structure for file share limits API.")
model FileShareLimitsResponse {
  @doc("The properties of the file share limits.")
  properties: FileShareLimitsOutput;
}

@doc("File share limits API result.")
model FileShareLimitsOutput {
  @doc("The limits for the file share.")
  limits: FileShareLimits;

  @doc("The provisioning constants for the file share.")
  provisioningConstants: FileShareProvisioningConstants;
}

@doc("Request structure for file share provisioning parameters recommendation API.")
model FileShareProvisioningRecommendationRequest {
  @doc("The properties of the file share provisioning recommendation input.")
  properties: FileShareProvisioningRecommendationInput;
}

@doc("File share provisioning parameters recommendation API input structure.")
model FileShareProvisioningRecommendationInput {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The desired provisioned storage size of the share in GiB. Will be use to calculate the values of remaining provisioning parameters.")
  provisionedStorageGiB: int32;
}

@doc("Response structure for file share provisioning parameters recommendation API.")
model FileShareProvisioningRecommendationResponse {
  @doc("The properties of the file share provisioning recommendation output.")
  properties: FileShareProvisioningRecommendationOutput;
}

@doc("File share provisioning parameters recommendation API result.")
model FileShareProvisioningRecommendationOutput {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The recommended value of provisioned IO / sec of the share.")
  provisionedIOPerSec: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "customized style suitable for storage admins"
  @doc("The recommended value of provisioned throughput / sec of the share.")
  provisionedThroughputMiBPerSec: int32;

  @doc("Redundancy options for the share.")
  availableRedundancyOptions: Redundancy[];
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Added Operation ID as it determines the PowerShell verb used."
@armResourceOperations
interface InformationalOperations {
  @doc("Get file shares usage data.")
  @operationId("FileShare_GetUsageData")
  getUsageData is ArmProviderActionSync<
    Response = FileShareUsageDataResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;

  @doc("Get file shares limits.")
  @operationId("FileShare_GetLimits")
  getLimits is ArmProviderActionSync<
    Response = FileShareLimitsResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;

  @doc("Get file shares provisioning parameters recommendation.")
  @operationId("FileShare_GetProvisioningRecommendation")
  getProvisioningRecommendation is ArmProviderActionSync<
    Request = FileShareProvisioningRecommendationRequest,
    Response = FileShareProvisioningRecommendationResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationResourceParameter
  >;
}
