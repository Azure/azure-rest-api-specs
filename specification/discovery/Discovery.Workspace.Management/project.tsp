import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./workspace.tsp";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Project tracked resource")
@parentResource(Workspace)
model Project is TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<Project>;
}

@doc("Project properties")
model ProjectProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Allowed AgentIds (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agentIds?: AgentId[];

  @doc("Allowed WorkFlowIds (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  workflowIds?: WorkflowId[];

  @doc("ARM ID of the the starting (entry) point Agent or Workflow.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  entryReferenceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Discovery/agents";
    },
    {
      type: "Microsoft.Discovery/workflows";
    }
  ]>;

  @doc("Allowed DataContainers (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataContainerIds: DataContainerId[];
}

@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  update is ArmResourcePatchAsync<Project, ProjectProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  listByWorkspace is ArmResourceListByParent<Project>;
  listBySubscription is ArmListBySubscription<Project>;
}
