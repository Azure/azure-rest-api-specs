import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Resources.DeploymentExtensionRuntimes;

/**
 * A deployment extension runtime. Represents the regional runtime
 * infrastructure that hosts an Azure Deployments server-side extension. The
 * `kind` discriminator selects the backend architecture and the shape of
 * `properties`.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Runtimes are authored mainly in Bicep, where a resource-level kind discriminator narrows the resource body and offers per-kind snippets. No non-legacy template models a polymorphic resource without overriding properties."
model DeploymentExtensionRuntime
  is Azure.ResourceManager.Legacy.DiscriminatedTrackedResource<ExtensionRuntimeKind> {
  ...ResourceNameParameter<
    Resource = DeploymentExtensionRuntime,
    KeyName = "runtimeName",
    SegmentName = "deploymentExtensionRuntimes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{0,62}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@@doc(
  DeploymentExtensionRuntime.kind,
  "The backend architecture of the runtime. Selects the shape of `properties` and is immutable after creation."
);

/**
 * A `ContainerApps` deployment extension runtime: a customer-managed container
 * hosted on Azure Container Apps.
 */
model ContainerAppsExtensionRuntime extends DeploymentExtensionRuntime {
  /**
   * The runtime kind for a customer-managed Azure Container Apps runtime.
   */
  kind: "ContainerApps";

  /**
   * The resource-specific properties for this resource.
   */
  properties: ContainerAppsExtensionRuntimeProperties;
}

/**
 * A `BuiltIn` deployment extension runtime: a platform-provided extension
 * backed by a first-party service. It carries no customer-supplied
 * configuration.
 */
model BuiltInExtensionRuntime extends DeploymentExtensionRuntime {
  /**
   * The runtime kind for a platform-provided runtime.
   */
  kind: "BuiltIn";

  /**
   * The resource-specific properties for this resource.
   */
  properties?: DeploymentExtensionRuntimeProperties;
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
