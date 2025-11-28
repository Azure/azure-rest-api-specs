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
  @doc("Version 2023-01-01-preview")
  v2023_01_01_preview: "2023-01-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.CommonTypes.Versions.v6)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("Version 2024-01-01-preview")
  v2024_01_01_preview: "2024-01-01-preview",
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

#suppress "@azure-tools/typespec-azure-core/no-enum" "Already in previous protocol version"
@renamedFrom(Versions.v2024_01_01_preview, "Tier")
@doc("Media Tier enum.")
enum MediaTier {
  SSD,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Already in previous protocol version"
@doc("Redundancy enum.")
enum Redundancy {
  Local,
  Zone,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Already in previous protocol version"
@doc("Protocol enum.")
enum Protocol {
  NFS,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Already in previous protocol version"
@doc("Share root squash enum.")
enum ShareRootSquash {
  NoRootSquash,
  RootSquash,
  AllSquash,
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
  @renamedFrom(Versions.v2024_01_01_preview, "shareName")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The name of the file share as seen by the end user when mounting the share, such as in a URI or UNC format in their operating system.")
  mountName?: string;

  @visibility(Lifecycle.Read)
  @doc("The host name of the file share.")
  hostName?: string;

  @renamedFrom(Versions.v2024_01_01_preview, "tier")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The storage media tier of the file share.")
  mediaTier?: MediaTier;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The chosen redundancy level of the file share.")
  redundancy?: Redundancy;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The file sharing protocol for this file share.")
  @typeChangedFrom(Versions.v2024_01_01_preview, Protocol[])
  @renamedFrom(Versions.v2024_01_01_preview, "protocols")
  protocol?: Protocol;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.v2024_01_01_preview)
  @renamedFrom(Versions.v2024_01_01_preview, "provisionedStorageGiB")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(0)
  @maxValue(102400)
  @doc("The provisioned storage size of the share in GiB (1 GiB is 1024^3 bytes or 1073741824 bytes). A component of the file share's bill is the provisioned storage, regardless of the amount of used storage.")
  provisionedStorageGiBOld: int32;

  @added(Versions.v2024_01_01_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned storage size of the share in GiB (1 GiB is 1024^3 bytes or 1073741824 bytes). A component of the file share's bill is the provisioned storage, regardless of the amount of used storage.")
  provisionedStorageGiB?: int32;

  @visibility(Lifecycle.Read)
  @added(Versions.v2024_01_01_preview)
  @doc("A date/time value that specifies when the provisioned storage for the file share is permitted to be reduced.")
  provisionedStorageNextAllowedDowngrade?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.v2024_01_01_preview)
  @renamedFrom(Versions.v2024_01_01_preview, "provisionedIOPerSec")
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(102400)
  @doc("The provisioned IO / sec of the share. A component of the file share's bill is the provisioned IOPS, regardless of the amount of used IO. In 2023-01-01-preview, this is a computed value.")
  provisionedIOPerSecOld?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @added(Versions.v2024_01_01_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned IO / sec of the share.")
  provisionedIOPerSec?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_01_01_preview)
  @doc("A date/time value that specifies when the provisioned IOPS for the file share is permitted to be reduced.")
  provisionedIOPerSecNextAllowedDowngrade?: utcDateTime;

  // See
  // https://teams.microsoft.com/l/message/19:906c1efbbec54dc8949ac736633e6bdf@thread.skype/1723528633538?tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47&groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&parentMessageId=1723528633538&teamName=Azure%20SDK&channelName=TypeSpec%20Discussion&createdTime=1723528633538
  // https://azure.github.io/typespec-azure/docs/next/troubleshoot/versioning_operation_template_changes
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @removed(Versions.v2024_01_01_preview)
  @renamedFrom(Versions.v2024_01_01_preview, "provisionedThroughputMiBPerSec")
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(10737418240)
  @doc("The provisioned throughput / sec of the share. In 2023-01-01-preview, this is a computed value.")
  provisionedThroughputMiBPerSecOld?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @added(Versions.v2024_01_01_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("The provisioned throughput / sec of the share.")
  @typeChangedFrom(Versions.v2024_01_01_preview, int64)
  provisionedThroughputMiBPerSec?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @added(Versions.v2024_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("A date/time value that specifies when the provisioned throughput for the file share is permitted to be reduced.")
  provisionedThroughputNextAllowedDowngrade?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @visibility(Lifecycle.Read)
  @minValue(3000)
  @doc("Burst IOPS are extra buffer IOPS enabling you to consume more than your provisioned IOPS for a short period of time, depending on the burst credits available for your share.")
  includedBurstIOPerSec?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @visibility(Lifecycle.Read)
  @minValue(0)
  @doc("Max burst IOPS credits shows the maximum number of burst credits the share can have at the current IOPS provisioning level.")
  maxBurstIOPerSecCredits?: int64;

  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("Protocol settings specific NFS.")
  nfsProtocolProperties?: NfsProtocolProperties;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The set of properties for control public access.")
  @renamedFrom(Versions.v2024_01_01_preview, "publicEndpointNetworkRuleSet")
  publicAccessProperties?: PublicAccessProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: FileShareProvisioningState;

  @added(Versions.v2024_01_01_preview)
  @doc("Gets or sets allow or disallow public network access to azure managed file share")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * List of private endpoint connections associated with the azure managed file share.
   */
  @added(Versions.v2024_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("The list of associated private endpoint connections.")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Azure Async Operation")
model AzureAsyncOperation {
  /** Fully qualified ID for the async operation. */
  @doc("The resource path from GET operation.")
  id?: Azure.Core.armResourceIdentifier;

  @doc("The operation id.")
  name?: string;

  @doc("The status of the operation: <RP defined values> | Succeeded | Failed | Canceled")
  status: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("The percentage completed of the operation.")
  @minValue(0.0)
  @maxValue(100.0)
  percentComplete?: float64;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Not all values are strings in this dictionary."
  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: Record<unknown>;

  @doc("Operation error.")
  error?: ErrorDetail;
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

@doc("A virtual network rule for the public endpoint.")
model VirtualNetworkRule {
  @doc("The resource ID of a subnet.")
  id: string;
}

@doc("The set of properties for control public access.")
@renamedFrom(Versions.v2024_01_01_preview, "PublicEndpointNetworkRuleSet")
model PublicAccessProperties {
  @doc("The allowed set of subnets when access is restricted.")
  @renamedFrom(Versions.v2024_01_01_preview, "virtualNetworkRules")
  @typeChangedFrom(Versions.v2024_01_01_preview, VirtualNetworkRule[])
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
@doc("The status of the last operation.")
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

  /**
   * Update a FileShare
   */
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

  @added(Versions.v2024_01_01_preview)
  getFileShareSnapshot is ArmResourceRead<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>
  >;

  @added(Versions.v2024_01_01_preview)
  @doc("Create a FileShareSnapshot.")
  createOrUpdateFileShareSnapshot is ArmResourceCreateOrReplaceSync<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>
  >;

  @added(Versions.v2024_01_01_preview)
  @doc("Update a FileShareSnapshot.")
  updateFileShareSnapshot is ArmCustomPatchAsync<
    FileShareSnapshot,
    ResourceUpdateModel<FileShareSnapshot, FileShareSnapshotProperties>,
    BaseParameters<FileShareSnapshot>
  >;

  @added(Versions.v2024_01_01_preview)
  @doc("Delete a FileShareSnapshot.")
  deleteFileShareSnapshot is ArmResourceDeleteWithoutOkAsync<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>
  >;

  @added(Versions.v2024_01_01_preview)
  @doc("List FileShareSnapshot by FileShare.")
  listByFileShare is ArmResourceListByParent<
    FileShareSnapshot,
    BaseParameters<FileShareSnapshot>,
    "",
    ""
  >;
}

@added(Versions.v2024_01_01_preview)
@doc("Extension Resource Action Scope")
@armVirtualResource
@extensionResource
model ExtensionResourceActionScope {
  @doc("Symbolic name of scope")
  @path
  @visibility(Lifecycle.Read)
  @key
  @segment("extensionresource")
  name: string;
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
  list(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.ThisWillBeReplaced",
  ): ArmResponse<OperationListResult> | ErrorResponse;
}

@doc("State of the public network access.")
union PublicNetworkAccess {
  string,

  @doc("The public network access is enabled")
  Enabled: "Enabled",

  @doc("The public network access is disabled")
  Disabled: "Disabled",
}

@added(Versions.v2024_01_01_preview)
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

@doc("FileShareSnapshot properties")
@added(Versions.v2024_01_01_preview)
model FileShareSnapshotProperties {
  // The FileShareSnapshot time of the file share FileShareSnapshot.
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @visibility(Lifecycle.Read)
  @doc("The FileShareSnapshot time in UTC in string representation")
  snapshotTime?: string;

  @visibility(Lifecycle.Read)
  @doc("The initiator of the FileShareSnapshot")
  initiatorId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "only string value are expected."
  @doc("The metadata")
  metadata?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: FileShareProvisioningState;
}
