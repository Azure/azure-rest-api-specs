import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/**
 * EdgeMachine details.
 */
@added(Versions.v2026_10_01)
model EdgeMachine
  is Azure.ResourceManager.TrackedResource<EdgeMachineProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachine,
    KeyName = "edgeMachineName",
    SegmentName = "edgeMachines",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@added(Versions.v2026_10_01)
@armResourceOperations
interface EdgeMachines {
  /**
   * Get an edge machine.
   */
  get is ArmResourceRead<EdgeMachine>;

  /**
   * Create or update an edge machine.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachine>;

  /**
   * Update an edge machine.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<EdgeMachine, EdgeMachinePatch>;

  /**
   * Delete an edge machine.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachine>;

  /**
   * List all edge machines in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<EdgeMachine>;

  /**
   * List all edge machines in a subscription.
   */
  listBySubscription is ArmListBySubscription<EdgeMachine>;

  /**
   * A long-running resource action to validate the edge machine.
   */
  @added(Versions.v2026_10_01)
  validate is ArmResourceActionAsync<
    EdgeMachine,
    EdgeMachineValidateRequest,
    EdgeMachineValidateResponse
  >;

  /**
   * Trigger an on-demand sync of edge machine security settings from Guest Configuration.
   * Creates the default security settings child resource if it does not already exist.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @added(Versions.v2026_10_01)
  refreshSecuritySettings is ArmResourceActionNoContentAsync<EdgeMachine, void>;

  /**
   * Trigger an on-demand refresh of applicable updates for the edge machine.
   * Creates or updates the default EdgeMachineUpdate child resource with the latest set of applicable updates.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @added(Versions.v2026_10_01)
  refreshApplicableUpdates is ArmResourceActionNoContentAsync<
    EdgeMachine,
    void
  >;
}

@@doc(EdgeMachine.name, "Name of Device");
