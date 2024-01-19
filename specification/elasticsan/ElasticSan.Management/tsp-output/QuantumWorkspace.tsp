import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Quantum;
@doc("The resource proxy definition object for quantum workspace.")
model QuantumWorkspace is TrackedResource<WorkspaceResourceProperties> {
  @doc("The name of the quantum workspace resource.")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface QuantumWorkspaces {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the Workspace resource associated with the given name.")
  @operationId("Workspaces_Get")
  get is ArmResourceRead<QuantumWorkspace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a workspace resource.")
  @operationId("Workspaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    QuantumWorkspace,
    BaseParameters<QuantumWorkspace>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing workspace's tags.")
  @operationId("Workspaces_UpdateTags")
  updateTags is ArmCustomPatchSync<QuantumWorkspace, TagsObject>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Workspace resource.")
  @operationId("Workspaces_Delete")
  delete is ArmResourceDeleteAsync<QuantumWorkspace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of Workspaces within a resource group.")
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<QuantumWorkspace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of Workspaces within a Subscription.")
  @operationId("Workspaces_ListBySubscription")
  listBySubscription is ArmListBySubscription<QuantumWorkspace>;
}

@@projectedName(QuantumWorkspaces.createOrUpdate::parameters.resource,
  "json",
  "QuantumWorkspace"
);
@@extension(QuantumWorkspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "QuantumWorkspace"
);
@@doc(QuantumWorkspaces.createOrUpdate::parameters.resource,
  "Workspace details."
);
@@projectedName(QuantumWorkspaces.updateTags::parameters.properties,
  "json",
  "workspaceTags"
);
@@extension(QuantumWorkspaces.updateTags::parameters.properties,
  "x-ms-client-name",
  "workspaceTags"
);
@@doc(QuantumWorkspaces.updateTags::parameters.properties,
  "Parameters supplied to update tags."
);
