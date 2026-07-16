import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Resources.DeploymentExtensionRuntimes;

/**
 * A deployment extension runtime. Represents the regional runtime
 * infrastructure that hosts an Azure Deployments server-side extension. The
 * backend architecture is selected by the discriminated `properties.config`
 * property.
 */
model DeploymentExtensionRuntime
  is TrackedResource<DeploymentExtensionRuntimeProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentExtensionRuntime,
    KeyName = "runtimeName",
    SegmentName = "deploymentExtensionRuntimes",
    NamePattern = "^[a-z][a-z0-9-]{0,26}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

// The runtime's managed identity is immutable after creation: it is set at
// create time and cannot be changed by a subsequent update. Marking it
// create + read emits `x-ms-mutability: ["create", "read"]`.
@@visibility(
  DeploymentExtensionRuntime.identity,
  Lifecycle.Create,
  Lifecycle.Read
);

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
   * Updates the tags of a deployment extension runtime.
   */
  updateTags is ArmTagsPatchAsync<DeploymentExtensionRuntime>;

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
