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
/**
 * The resource proxy definition object for quantum workspace.
 */
model QuantumWorkspace is TrackedResource<WorkspaceResourceProperties> {
  /**
   * The name of the quantum workspace resource.
   */
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface QuantumWorkspaces {
  /**
   * Returns the Workspace resource associated with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_Get")
  get is ArmResourceRead<QuantumWorkspace>;

  /**
   * Creates or updates a workspace resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    QuantumWorkspace,
    BaseParameters<QuantumWorkspace>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing workspace's tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Workspaces_UpdateTags")
  updateTags is ArmCustomPatchSync<QuantumWorkspace, TagsObject>;

  /**
   * Deletes a Workspace resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_Delete")
  delete is ArmResourceDeleteAsync<QuantumWorkspace>;

  /**
   * Gets the list of Workspaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<QuantumWorkspace>;

  /**
   * Gets the list of Workspaces within a Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
