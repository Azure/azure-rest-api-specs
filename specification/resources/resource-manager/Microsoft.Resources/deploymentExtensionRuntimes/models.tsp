import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using Azure.ResourceManager;

namespace Microsoft.Resources.DeploymentExtensionRuntimes;

/**
 * The backend architecture of a deployment extension runtime. This selects the
 * shape of `properties.hosting` and is immutable after creation.
 */
union ExtensionRuntimeKind {
  string,

  /**
   * Customer-managed runtime hosted on Azure Container Apps. The customer
   * provides the extension binary, an Entra ID app registration, and
   * configuration; the resource provider creates the Azure Container Apps
   * resources in the customer's subscription.
   */
  ContainerApps: "ContainerApps",

  /**
   * Platform-provided extension backed by a first-party service. No
   * customer-managed binary or Azure Container Apps resources are created.
   */
  BuiltIn: "BuiltIn",
}

/**
 * The provisioning state of a deployment extension runtime. The terminal
 * states are `Succeeded`, `Failed`, and `Canceled`.
 */
union ProvisioningState {
  /**
   * Standard ARM terminal provisioning states (`Succeeded`, `Failed`,
   * `Canceled`).
   */
  ResourceProvisioningState,

  /**
   * The runtime is being created.
   */
  Creating: "Creating",

  /**
   * The runtime is being updated.
   */
  Updating: "Updating",

  /**
   * The runtime is being deleted.
   */
  Deleting: "Deleting",

  string,
}

/**
 * Properties of a deployment extension runtime. The backend-specific
 * configuration lives in the discriminated `hosting` sub-property; the remaining
 * members are read-only outputs common to every runtime.
 */
model DeploymentExtensionRuntimeProperties {
  /**
   * The provisioning state of the runtime.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The backend configuration for the runtime. The `runtimeKind` discriminator
   * selects the backend architecture and the shape of this object.
   */
  hosting: RuntimeHosting;
}

/**
 * Backend configuration for a deployment extension runtime. The `runtimeKind`
 * discriminator selects the backend architecture and the concrete shape of this
 * object.
 */
@discriminator("runtimeKind")
model RuntimeHosting {
  /**
   * The backend architecture of the runtime. Immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  runtimeKind: ExtensionRuntimeKind;
}

/**
 * Backend configuration for a `ContainerApps` runtime: a customer-managed
 * container hosted on Azure Container Apps.
 */
model ContainerAppsHosting extends RuntimeHosting {
  /**
   * The backend architecture discriminator for a customer-managed Azure
   * Container Apps runtime.
   */
  runtimeKind: "ContainerApps";

  /**
   * OCI artifact reference for the extension binary, for example
   * `registry.azurecr.io/extensions/github:1.0`.
   */
  @pattern("^[a-z0-9]+([._-][a-z0-9]+)*(/[a-z0-9]+([._-][a-z0-9]+)*)*:[a-zA-Z0-9._-]+$")
  artifactUri: string;

  /**
   * The Entra ID application (client) ID whose audience the runtime endpoint
   * authenticates against.
   */
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  audienceAppId: string;

  /**
   * The ARM resource ID of a user-assigned managed identity that holds
   * `AcrPull` on the registry hosting `artifactUri`. Required only for private
   * registries.
   */
  registryIdentityId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * Observability configuration for the runtime.
   */
  observability?: RuntimeObservability;

  /**
   * Secret values injected into the runtime container. Secret literal values
   * are write-only and are never returned on read operations.
   */
  @identifiers(#["name"])
  secrets?: RuntimeSecret[];

  /**
   * Environment variables set on the runtime container. Plain-text values are
   * returned on read operations; values sourced from a secret reference are
   * returned by name only.
   */
  @identifiers(#["name"])
  env?: RuntimeEnvironmentVariable[];

  /**
   * Scaling configuration for the runtime.
   */
  scaling?: RuntimeScaling;

  /**
   * Compute resource allocation per replica.
   */
  resources?: RuntimeResources;

  /**
   * Optional virtual network integration for the runtime. Immutable after
   * creation.
   */
  networkProfile?: RuntimeNetworkProfile;

  /**
   * The externally accessible FQDN of the runtime endpoint. Populated once the
   * runtime reaches the `Succeeded` state.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The Entra ID home tenant of the runtime's subscription. This is the tenant
   * whose security token service is used for runtime token acquisition and
   * whose issuer is configured on the runtime endpoint.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Backend configuration for a `BuiltIn` runtime: a platform-provided extension
 * that carries no customer-supplied configuration.
 */
model BuiltInHosting extends RuntimeHosting {
  /**
   * The backend architecture discriminator for a platform-provided runtime.
   */
  runtimeKind: "BuiltIn";
}

/**
 * Observability configuration for a deployment extension runtime.
 */
model RuntimeObservability {
  /**
   * The ARM resource ID of a Log Analytics workspace that receives the
   * runtime's container logs.
   */
  workspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;
}

/**
 * Scaling configuration for a deployment extension runtime.
 */
model RuntimeScaling {
  /**
   * The minimum number of replicas. A value of `0` enables scale-to-zero.
   */
  @minValue(0)
  @maxValue(30)
  minReplicas?: int32 = 1;

  /**
   * The maximum number of replicas.
   */
  @minValue(1)
  @maxValue(30)
  maxReplicas?: int32 = 5;

  /**
   * The number of concurrent HTTP requests per replica that triggers
   * scale-out.
   */
  @minValue(1)
  @maxValue(500)
  concurrentRequestsPerReplica?: int32 = 10;
}

/**
 * Compute resource allocation per replica for a deployment extension runtime.
 */
model RuntimeResources {
  /**
   * The number of vCPUs allocated per replica. Must be a valid Azure Container
   * Apps Consumption vCPU value (for example `0.25`, `0.5`, `1.0`, `2.0`,
   * `4.0`).
   */
  cpu?: float64 = 0.5;

  /**
   * The amount of memory allocated per replica, for example `1Gi`. Must be
   * compatible with the configured `cpu` value per Azure Container Apps
   * Consumption limits.
   */
  memory?: string = "1Gi";
}

/**
 * A secret injected into a deployment extension runtime container.
 */
model RuntimeSecret {
  /**
   * The name of the secret. Referenced from environment variables via
   * `secretRef`.
   */
  @minLength(1)
  name: string;

  /**
   * The literal value of the secret. This property is write-only and is never
   * returned on read operations. Mutually exclusive with `keyVaultUri`.
   */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;

  /**
   * The Key Vault secret URI to source the secret value from. Requires
   * `identity`. Mutually exclusive with `value`.
   */
  keyVaultUri?: string;

  /**
   * The resource ID of a user-assigned managed identity used to read the secret
   * from Key Vault, or `System` to use the system-assigned identity. Applies
   * when `keyVaultUri` is set.
   */
  identity?: string;
}

/**
 * An environment variable set on a deployment extension runtime container.
 */
model RuntimeEnvironmentVariable {
  /**
   * The name of the environment variable.
   */
  @minLength(1)
  name: string;

  /**
   * The literal value of the environment variable. Mutually exclusive with
   * `secretRef`.
   */
  value?: string;

  /**
   * The name of a secret (from `secrets`) whose value is used for this
   * environment variable. Mutually exclusive with `value`.
   */
  secretRef?: string;
}

/**
 * Virtual network integration configuration for a deployment extension
 * runtime. Immutable after creation.
 */
model RuntimeNetworkProfile {
  /**
   * The ARM resource ID of the subnet the runtime's Azure Container Apps
   * environment is injected into. The subnet must be delegated to
   * `Microsoft.App/environments`. Immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}
