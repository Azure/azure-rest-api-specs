import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

@versioned(Microsoft.Discovery.Shared.Versions)
namespace Microsoft.Discovery.Shared;

@doc("The Microsoft.Discovery.Shared versions.")
enum Versions {
  @doc("The 2025-07-01-preview version of the Microsoft.Discovery.Shared.")
  `2025-07-01-preview`,

  @doc("The 2025-12-01-preview version of the Microsoft.Discovery.Shared.")
  `2025-12-01-preview`,

  @doc("The 2026-02-01-preview version of the Microsoft.Discovery.Shared.")
  `2026-02-01-preview`,
}

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

@doc("Enum for resource visibility Scope.")
@removed(Versions.`2026-02-01-preview`)
union Scope {
  /** The resource is Archived/discarded. */
  Archived: "Archived",

  /** The resource is visible by users. */
  Visible: "Visible",

  /** The resource is hidden from users. */
  Hidden: "Hidden",

  string,
}

/** For tracking scope. */
@removed(Versions.`2026-02-01-preview`)
model WithScope {
  /** Resource scope of visibility. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  scope: Scope;
}

// ============================================================================
// ARM Resource ID Aliases - Used by Management Plane
// ============================================================================

alias DataContainerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/DataContainers";
  }
]>;

alias DataAssetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/DataContainers/DataAssets";
  }
]>;

alias StorageContainerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/StorageContainers";
  }
]>;

alias StorageAssetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/StorageContainers/StorageAssets";
  }
]>;

alias DiscoveryStorageId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Storages";
  }
]>;

alias BookShelfId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Bookshelves";
  }
]>;

alias SuperComputerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/SuperComputers";
  }
]>;

alias ToolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Tools";
  }
]>;

alias AgentId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Agents";
  }
]>;

alias ProjectId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/workspaces/projects";
  }
]>;

alias ModelId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Models";
  }
]>;

alias NodePoolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/Supercomputers/NodePools";
  }
]>;

alias WorkspaceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/workspaces";
  }
]>;

alias WorkflowId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Discovery/workflows";
  }
]>;

alias SubnetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Network/virtualNetworks/subnets";
  }
]>;

alias UserAssignedIdentityId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.ManagedIdentity/userAssignedIdentities";
  }
]>;

alias LogAnalyticsClusterId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.OperationalInsights/clusters";
  }
]>;

alias DiskEncryptionSetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Compute/diskEncryptionSets";
  }
]>;

alias PrivateEndpointId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Network/privateEndpoints";
  }
]>;
