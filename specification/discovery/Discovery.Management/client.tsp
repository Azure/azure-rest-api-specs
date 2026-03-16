import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./tool.tsp";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Bookshelf.Management/all.tsp";
import "../Discovery.Supercomputer.Management/all.tsp";
import "../Discovery.Workspace.Management/all.tsp";
import "@typespec/versioning";

using Microsoft.Discovery;
using Microsoft.Discovery.Shared;

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

// Rename DiscoveryStorage to ManagedStorage for Go SDK to avoid collision with Storage type
// after the Go emitter removes the "Discovery" prefix
@@clientName(Microsoft.Discovery.DiscoveryStorage,
  "DiscoveryManagedStorage",
  "go"
);

@@clientName(Microsoft.Discovery, "DiscoveryMgmtClient", "python");

@doc("Tool tracked resource")
model ToolUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: ToolUpdateProperties;
}

@doc("Discovery Tool list item properties")
model ToolUpdateProperties {
  ...DiscoveryResourceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Environment variables to make available")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  environmentVariables?: Record<string>;

  ...WithDefinitionContent;
}

@@alternateType(Microsoft.Discovery.Tools.update::parameters.properties,
  ToolUpdate,
  "javascript"
);

@doc("Key Vault update properties for Bookshelf (all fields optional for PATCH)")
@added(Microsoft.Discovery.Versions.v2026_02_01_preview)
model BookshelfKeyVaultUpdateProperties {
  @doc("The Key Name in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyName?: string;

  @doc("The Key Version in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyVersion?: string;
}

@doc("The updatable properties of the Bookshelf.")
model BookshelfUpdateProperties {
  @doc("The key to use for encrypting data at rest when customer managed keys are enabled. Required if Customer Managed Keys is enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  keyVaultProperties?: BookshelfKeyVaultUpdateProperties;

  @doc("Whether or not public network access is allowed for this resource. For security reasons, it is recommended to disable it whenever possible.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The type used for update operations of the Bookshelf.")
model BookshelfUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: BookshelfUpdateProperties;
}
@@alternateType(Microsoft.Discovery.Bookshelves.update::parameters.properties,
  BookshelfUpdate,
  "javascript"
);

@doc("Storage Asset tracked resource")
model StorageAssetUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: StorageAssetUpdateProperties;
}

@doc("Storage Asset properties")
model StorageAssetUpdateProperties {
  @doc("The description")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;
}

@@alternateType(Microsoft.Discovery.StorageAssets.update::parameters.properties,
  StorageAssetUpdate,
  "javascript"
);
@doc("Storage Container tracked resource")
model StorageContainerUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}
@@alternateType(Microsoft.Discovery.StorageContainers.update::parameters.properties,
  StorageContainerUpdate,
  "javascript"
);

@doc("NodePool tracked resource")
model NodePoolUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: NodePoolUpdateProperties;
}
@doc("NodePool properties")
model NodePoolUpdateProperties {
  @doc("The maximum number of nodes.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  maxNodeCount?: int32;

  @doc("The minimum number of nodes.")
  @minValue(0)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  minNodeCount?: int32 = 0;
}
@@alternateType(Microsoft.Discovery.NodePools.update::parameters.properties,
  NodePoolUpdate,
  "javascript"
);

@doc("Dictionary of identity properties for the Supercomputer.")
model SupercomputerIdentitiesUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("User assigned identity IDs to be used by workloads as federated credentials running on supercomputer. The key value must be the resource ID of the identity resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  workloadIdentities?: Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity | null>;
}

@doc("Updatable properties for Supercomputer (all fields optional for PATCH)")
model SupercomputerUpdateProperties {
  @doc("Dictionary of identity properties.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  identities?: SupercomputerIdentitiesUpdate;
}

@doc("Update model for Supercomputer PATCH operations")
model SupercomputerUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: SupercomputerUpdateProperties;
}

@@alternateType(Microsoft.Discovery.Supercomputers.update::parameters.properties,
  SupercomputerUpdate,
  "javascript"
);

@doc("Represents a deployment that ties a specific model family to a user defined deployment name used when invoking the chat model.")
model ChatModelDeploymentUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}
@@alternateType(Microsoft.Discovery.ChatModelDeployments.update::parameters.properties,
  ChatModelDeploymentUpdate,
  "javascript"
);

@doc("Project tracked resource")
model ProjectUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: ProjectUpdateProperties;
}

@doc("Project properties")
model ProjectUpdateProperties {
  @doc("Allowed AgentIds (Control plane resource references).")
  @removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agentIds?: AgentId[];

  @doc("Allowed WorkFlowIds (Control plane resource references).")
  @removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  workflowIds?: WorkflowId[];

  @doc("ARM ID of the the starting (entry) point Agent or Workflow.")
  @removed(Microsoft.Discovery.Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  entryReferenceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Discovery/agents";
    },
    {
      type: "Microsoft.Discovery/workflows";
    }
  ]>;

  @doc("Settings for the project.")
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  settings?: ProjectSettings;
}

@@alternateType(Microsoft.Discovery.Projects.update::parameters.properties,
  ProjectUpdate,
  "javascript"
);

@doc("For Key Vault Key references")
@added(Microsoft.Discovery.Versions.v2026_02_01_preview)
model KeyVaultUpdateProperties {
  @doc("The Key Name in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyName?: string;

  @doc("The Key Version in Key Vault")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyVersion?: string;
}

@doc("Updatable properties for Workspace (all fields optional for PATCH)")
model WorkspaceUpdateProperties {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked SuperComputers.")
  supercomputerIds?: Array<Microsoft.Discovery.Shared.SuperComputerId>;

  @doc("The key to use for encrypting data at rest when customer managed keys are enabled.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  keyVaultProperties?: KeyVaultUpdateProperties;

  @doc("Whether or not public network access is allowed for this resource. For security reasons, it is recommended to disable it whenever possible.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Microsoft.Discovery.Versions.v2026_02_01_preview)
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Update model for Workspace PATCH operations")
model WorkspaceUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: WorkspaceUpdateProperties;
}

@@alternateType(Microsoft.Discovery.Workspaces.update::parameters.properties,
  WorkspaceUpdate,
  "javascript"
);
