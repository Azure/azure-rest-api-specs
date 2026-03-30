import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./versions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Microsoft.Discovery.Common;

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

/** For adding ID. */
alias WithId = {
  @doc("The ID for the resource.")
  @visibility(Lifecycle.Read)
  id?: string;
};

@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

/** For adding tags. */
alias WithTags = {
  @doc("The tags")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Tag[];
};

/** For adding copilot instruction. */
alias WithCopilotInstruction = {
  @doc("The copilot instruction")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  copilotInstruction: string;
};

/** For adding status. */
alias WithStatus<T> = {
  @doc("The status")
  @visibility(Lifecycle.Read)
  status?: T;
};

/** For adding status reason. */
alias WithStatusReason = {
  @doc("The reason for the current status")
  @visibility(Lifecycle.Read)
  statusReason?: string;
};

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

/** For adding creation timestamp. */
alias WithCreatedAt = {
  @doc("The timestamp when the resource was created")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;
};

/** For tracking who created a resource. */
alias WithCreatedBy = {
  @doc("The ID of the user who created this resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;
};

/** For tracking type of who created a resource. */
alias WithCreatedByType = {
  @doc("The type of user who created this resource.")
  @visibility(Lifecycle.Read)
  createdByType?: ByType;
};

/** For tracking resource creation data. */
alias WithCreated = WithCreatedAt & WithCreatedBy & WithCreatedByType;

/** For adding last update timestamp. */
alias WithLastModifiedAt = {
  @doc("The timestamp when the resource was last updated")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
};

/** For tracking who updated a resource. */
alias WithLastModifiedBy = {
  @doc("The ID of the user who updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;
};

/** For tracking type of who updated a resource. */
alias WithLastModifiedByType = {
  @doc("The type of user who updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: ByType;
};

/** For tracking resource modification data. */
alias WithLastModified = WithLastModifiedAt &
  WithLastModifiedBy &
  WithLastModifiedByType;

/** For searching items created after specified timestamp. */
alias WithQueryCreatedSince = {
  @doc("The oldest creation timestamp to keep")
  @TypeSpec.Http.query
  createdSince?: utcDateTime;
};

/** Common data plane resource tracking properties. */
alias DataPlaneResource = WithCreated & WithLastModified;

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

/** Regex for conversation names */
alias conversationNamePattern = "^[a-zA-Z0-9-]{1,75}$";

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

// ============================================================================
// Data Plane specific models
// ============================================================================

/** For adding title to display instead of name. */
alias WithTitle = {
  @doc("The title")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;
};

/** For adding description. */
alias WithDescription = {
  @doc("The description")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description: string;
};
