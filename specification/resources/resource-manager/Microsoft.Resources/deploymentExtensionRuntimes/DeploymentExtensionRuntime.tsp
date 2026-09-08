import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Resources.DeploymentExtensionRuntimes;

/**
 * A deployment extension runtime. Represents the regional runtime
 * infrastructure that hosts an Azure Deployments server-side extension. The
 * backend architecture is selected by the discriminated `properties.hosting`
 * property.
 */
model DeploymentExtensionRuntime
  is TrackedResource<DeploymentExtensionRuntimeProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentExtensionRuntime,
    KeyName = "runtimeName",
    SegmentName = "deploymentExtensionRuntimes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{0,62}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

// The runtime's managed identity is patchable: it is set at create time and can
// be changed by a subsequent PATCH. Marking it create + read + update emits
// `x-ms-mutability: ["create", "read", "update"]`.
@@visibility(
  DeploymentExtensionRuntime.identity,
  Lifecycle.Create,
  Lifecycle.Read,
  Lifecycle.Update
);

/**
 * The updatable envelope of a deployment extension runtime. PATCH accepts only
 * the resource tags and the managed identity; all runtime configuration is
 * replaced via PUT.
 */
model DeploymentExtensionRuntimeUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface DeploymentExtensionRuntimes {
  /**
   * Gets a deployment extension runtime.
   */
  get is ArmResourceRead<DeploymentExtensionRuntime>;

  /**
   * Creates or updates a deployment extension runtime.
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<DeploymentExtensionRuntime>;

  /**
   * Updates the tags and managed identity of a deployment extension runtime.
   */
  update is ArmCustomPatchAsync<
    DeploymentExtensionRuntime,
    DeploymentExtensionRuntimeUpdate
  >;

  /**
   * Deletes a deployment extension runtime.
   */
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentExtensionRuntime>;

  /**
   * Lists all deployment extension runtimes in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<DeploymentExtensionRuntime>;

  /**
   * Lists all deployment extension runtimes in a subscription.
   */
  listBySubscription is ArmListBySubscription<DeploymentExtensionRuntime>;
}
