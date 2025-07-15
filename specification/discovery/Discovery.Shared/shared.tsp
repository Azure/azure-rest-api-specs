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

@versioned(Microsoft.Discovery.Shared.Versions)
namespace Microsoft.Discovery.Shared;

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
// @access(Access.internal)
model WithScope {
  /** Resource scope of visibility. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  scope: Scope;
}

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
