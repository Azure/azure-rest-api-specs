import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Experimentation;
/**
 * An experiment workspace.
 */
model ExperimentWorkspace
  is Azure.ResourceManager.TrackedResource<ExperimentWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = ExperimentWorkspace,
    KeyName = "experimentWorkspaceName",
    SegmentName = "experimentWorkspaces",
    NamePattern = "^[a-z0-9]{3,14}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard ManagedServiceIdentityProperty does not supports just UserAssigned identity"
  @doc("Managed identity.")
  identity?: ManagedIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard sku does not fit our needs"
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku?: ExperimentWorkspaceSku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The standard kind does not support list of enum values"
  @doc("Metadata used by portal/service to render different UX experiences for resources of the same type. Supported values are Regular and Advanced.")
  @pattern("^[-\\w\\._,\\(\\\\\\)]+$")
  @visibility("read", "create")
  kind?: ExperimentWorkspaceKind;
}

@armResourceOperations
interface ExperimentWorkspaces {
  /**
   * Gets an experiment workspace
   */
  get is ArmResourceRead<ExperimentWorkspace>;

  /**
   * Create an experiment workspace, or update an existing workspace
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExperimentWorkspace>;

  /**
   * Update an experiment workspace
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<ExperimentWorkspace, ExperimentWorkspacePatch>;

  /**
   * Deletes an experiment workspace
   */
  delete is ArmResourceDeleteWithoutOkAsync<ExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<ExperimentWorkspace>;
}

@@doc(ExperimentWorkspace.name, "The name of the experimentation workspace.");
@@doc(ExperimentWorkspace.properties, "Resource properties.");
@@doc(ExperimentWorkspaces.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate experiment workspace operation."
);
@@doc(ExperimentWorkspaces.update::parameters.properties,
  "Parameters supplied to the update experiment workspace operation."
);
