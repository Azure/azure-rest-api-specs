import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./namespace.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.DataPlane.Shared.Versions)
namespace Microsoft.Discovery.DataPlane.Shared;

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  string,
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@access(Access.internal)
@doc("For adding ID.")
model WithId {
  @doc("The ID for the resource.")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@access(Access.internal)
@doc("For adding tags.")
model WithTags {
  @doc("The tags")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Tag[];
}

@access(Access.internal)
@doc("For adding copilot instruction.")
model WithCopilotInstruction {
  @doc("The copilot instruction")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  copilotInstruction: string;
}

@access(Access.internal)
@doc("For adding status.")
model WithStatus<T> {
  @doc("The status")
  @visibility(Lifecycle.Read)
  status?: T;
}

@access(Access.internal)
@doc("For adding status reason")
model WithStatusReason {
  @doc("The reason for the current status")
  @visibility(Lifecycle.Read)
  statusReason?: string;
}

@doc("Enum for entity type")
union ByType {
  /** A human user. */
  User: "User",

  /** Application */
  Application: "Application",

  /** The backend system. */
  System: "System",

  string,
}

@access(Access.internal)
@doc("For adding creation timestamp.")
model WithCreatedAt {
  @doc("The timestamp when the resource was created")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;
}

@access(Access.internal)
@doc("For tracking who created a resource.")
model WithCreatedBy {
  @doc("The ID of the user who created this resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;
}

@access(Access.internal)
@doc("For tracking type of who created a resource.")
model WithCreatedByType {
  @doc("The type of user who created this resource.")
  @visibility(Lifecycle.Read)
  createdByType?: ByType;
}

@access(Access.internal)
@doc("For tracking resource creation data.")
model WithCreated {
  ...WithCreatedAt;
  ...WithCreatedBy;
  ...WithCreatedByType;
}

@access(Access.internal)
@doc("For adding last update timestamp.")
model WithLastModifiedAt {
  @doc("The timestamp when the resource was last updated")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

@access(Access.internal)
@doc("For tracking who Updated a resource.")
model WithLastModifiedBy {
  @doc("The ID of the user who Updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;
}

@access(Access.internal)
@doc("For tracking type of who Updated a resource.")
model WithLastModifiedByType {
  @doc("The type of user who Updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: ByType;
}

@access(Access.internal)
@doc("For tracking resource modification data.")
model WithLastModified {
  ...WithLastModifiedAt;
  ...WithLastModifiedBy;
  ...WithLastModifiedByType;
}

@access(Access.internal)
@doc("For searching items created after specified timestamp.")
model WithQueryCreatedSince {
  @doc("The oldest creation timestamp to keep")
  @TypeSpec.Http.query
  createdSince?: utcDateTime;
}

@access(Access.internal)
@doc("For searching items created after specified timestamp.")
model DataPlaneResource {
  ...WithCreated;
  ...WithLastModified;
}

@access(Access.internal)
@doc("For region information about Control plane resource proxy.")
model Region {
  /** Name of the region. */
  @visibility(Lifecycle.Read)
  regionName: string;

  /** Whether region is primary. */
  @visibility(Lifecycle.Read)
  isPrimary: boolean;
}

@access(Access.internal)
@doc("For data plane list/get of control plane resource proxy.")
model ControlPlaneProxyResource {
  ...DataPlaneResource;

  /** TenantId of the associated ARM resource. */
  @visibility(Lifecycle.Read)
  sourceTenantId: string;

  /** SubscriptionId of the associated ARM resource. */
  @visibility(Lifecycle.Read)
  sourceSubscriptionId: string;

  /** ResourceGroup of the associated ARM resource. */
  @visibility(Lifecycle.Read)
  sourceResourceGroup: string;

  ...WithTags;

  /** Regions associated resource is available */
  @visibility(Lifecycle.Read)
  regions: Region[];
}

/** Paged list resources */
model Paged<T extends {}> is Foundations.CustomPage<T>;

/** Regex for resource names */
alias resourceNamePattern = "^[a-zA-Z0-9-]{3,24}$";

// ============================================================================
// ARM Resource ID Aliases for data plane cross-reference
// ============================================================================

/** ARM Resource ID for Tool resources. */
alias ToolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Tools";
  }
]>;

/** ARM Resource ID for StorageAsset resources. */
alias StorageAssetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/StorageContainers/StorageAssets";
  }
]>;

/** ARM Resource ID for DataAsset resources. */
alias DataAssetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/DataContainers/DataAssets";
  }
]>;

/** ARM Resource ID for User Assigned Managed Identity. */
alias UserAssignedIdentityId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.ManagedIdentity/userAssignedIdentities";
  }
]>;

/** ARM Resource ID for Discovery Storage resources. */
alias DiscoveryStorageId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Storages";
  }
]>;

/** ARM Resource ID for NodePool resources. */
alias NodePoolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Supercomputers/NodePools";
  }
]>;

model DataPlaneResourceNameParameter<
  Resource extends {},
  KeyName extends valueof string = "",
  SegmentName extends valueof string = "",
  NamePattern extends valueof string = resourceNamePattern,
  Type extends string = string
> {
  @doc("The name of the {name}", Resource)
  @visibility(Lifecycle.Read)
  @pattern(NamePattern)
  @key(KeyName)
  @path
  name: Type;
}

/**
 * A URI that references data. There are three forms this can take:
 *  1. discovery://storages/<storageArmId>/paths/<path> to reference data on Discovery Storage.
 *  2. discovery://dataassets/<dataAssetArmId> to reference a Discovery Data Asset.
 *  3. discovery://dataassets/<dataAssetArmId>/paths/<path> to reference a subpath within a Discovery Data Asset.
 *
 * Note that in the discovery://storages/<storageArmId>/paths/<path>, the <path> is not an absolute path within
 * the underlying NFS volume. Rather, the service creates a subdirectory on each storage for storing job
 * artifacts, and the <path> is relative to that subdirectory. The location of the subdirectory is not published,
 * nor is it guaranteed to be stable over time, but we do guarantee that a given discovery://storages/ URI will
 * always point to the same logical data. We do not expect API consumers to build these URIs from scratch,
 * but to use the output URI (or a subpath of it) from an earlier API call as the input to a later API call.
 */
@removed(Versions.`2026-02-01-preview`)
@pattern("^discovery://(storages|dataassets)/.*$")
scalar DataUri extends string;

/**
 * A URI that references data. There are three forms this can take:
 *  1. discovery://storages/<storageArmId>/paths/<path> to reference data on Discovery Storage.
 *  2. discovery://storageassets/<storageAssetArmId> to reference a Discovery Storage Asset.
 *  3. discovery://storageassets/<storageAssetArmId>/paths/<path> to reference a subpath within a Discovery Storage Asset.
 *
 * Note that in the discovery://storages/<storageArmId>/paths/<path>, the <path> is not an absolute path within
 * the underlying NFS volume. Rather, the service creates a subdirectory on each storage for storing job
 * artifacts, and the <path> is relative to that subdirectory. The location of the subdirectory is not published,
 * nor is it guaranteed to be stable over time, but we do guarantee that a given discovery://storages/ URI will
 * always point to the same logical data. We do not expect API consumers to build these URIs from scratch,
 * but to use the output URI (or a subpath of it) from an earlier API call as the input to a later API call.
 */
@added(Versions.`2026-02-01-preview`)
@pattern("^discovery://(storages|storageassets)/.*$")
scalar StorageUri extends string;

// ============================================================================
// Data Plane specific models
// ============================================================================

@access(Access.internal)
@doc("For adding title to display instead of name.")
model WithTitle {
  @doc("The title")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;
}

@access(Access.internal)
@doc("For adding description.")
model WithDescription {
  @doc("The description")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description: string;
}
