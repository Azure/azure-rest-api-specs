import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Quantum;
/**
 * The resource proxy definition object for Quantum Workspace.
 */
model QuantumWorkspace
  is Azure.ResourceManager.TrackedResource<WorkspaceResourceProperties> {
  ...ResourceNameParameter<
    Resource = QuantumWorkspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Workspaces {
  /**
   * Check the availability of the resource name for the given location.
   */
  checkNameAvailability is checkLocalNameAvailability;

  /**
   * Returns the Workspace resource associated with the given name.
   */
  get is ArmResourceRead<QuantumWorkspace>;

  /**
   * Creates or updates a Workspace resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<QuantumWorkspace>;

  /**
   * Updates an existing Workspace's tags.
   */
  updateTags is ArmTagsPatchSync<QuantumWorkspace>;

  /**
   * Deletes a Workspace resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<QuantumWorkspace>;

  /**
   * Gets the list of Workspaces within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<QuantumWorkspace>;

  /**
   * Gets the list of Workspaces within a Subscription.
   */
  listBySubscription is ArmListBySubscription<QuantumWorkspace>;

  /**
   * Get the keys to use with the Quantum APIs. A key is used to authenticate and authorize access to the Quantum REST APIs. Only one key is needed at a time; two are given to provide seamless key regeneration.
   */
  listKeys is ArmResourceActionSync<
    QuantumWorkspace,
    void,
    ArmResponse<ListKeysResult>
  >;

  /**
   * Regenerate either the primary or secondary key for use with the Quantum APIs. The old key will stop working immediately.
   */
  @action("regenerateKey")
  regenerateKeys is ArmResourceActionSync<
    QuantumWorkspace,
    ApiKeys,
    NoContentResponse
  >;
}

@armResourceOperations
@added(Versions.v2025_08_11_preview)
interface SuiteOffers {
  /**
   * Returns the SuiteOffer resource associated with the given name.
   */
  listBySubscription is ArmListBySubscription<
    QuantumSuiteOffer,
    Parameters = {
      /**
       * The filter to apply to the operation. Example: '$filter=kind eq 'v1'
       */
      @added(Versions.v2025_11_01_preview)
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(QuantumWorkspace.name, "The name of the quantum workspace resource.");
@@doc(QuantumWorkspace.properties,
  "Gets or sets the properties. Define quantum workspace's specific properties."
);
@@doc(Workspaces.createOrUpdate::parameters.resource, "Workspace details.");
@@doc(Workspaces.updateTags::parameters.properties,
  "Parameters supplied to update tags."
);
@@doc(Workspaces.regenerateKeys::parameters.body,
  "Which key to regenerate:  primary or secondary."
);
