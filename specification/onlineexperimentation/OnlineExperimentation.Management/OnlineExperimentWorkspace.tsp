import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.OnlineExperimentation;

@doc("An online experiment workspace resource.")
model OnlineExperimentWorkspace
  is TrackedResource<OnlineExperimentWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = OnlineExperimentWorkspace,
    KeyName = "workspaceName",
    NamePattern = "^[a-z0-9](?!.*---)[a-z0-9-]{1,53}[a-z0-9]",
    SegmentName = "workspaces"
  >;
  ...ManagedServiceIdentityProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The common types sku doesn't support Developer tier."
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku?: OnlineExperimentationWorkspaceSku;
}

@armResourceOperations
interface OnlineExperimentWorkspaces {
  /**
   * Gets an experiment workspace
   */
  get is ArmResourceRead<OnlineExperimentWorkspace>;

  /**
   * Create an experiment workspace, or update an existing workspace
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentWorkspace>;

  /**
   * Patch an experiment workspace
   */
  update is ArmResourcePatchAsync<
    OnlineExperimentWorkspace,
    OnlineExperimentWorkspaceProperties
  >;

  /**
   * Deletes an experiment workspace
   */
  delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<OnlineExperimentWorkspace>;
}
