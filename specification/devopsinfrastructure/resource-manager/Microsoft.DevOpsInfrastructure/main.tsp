import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Managed DevOps Infrastructure",
  version: "2023-10-30-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.DevOpsInfrastructure;

model Pool is TrackedResource<PoolProperties> {
  @key("poolName")
  @pattern("^[a-z][a-z0-9]*$")
  @path
  @segment("pools")
  name: string;
}

model PoolProperties {
  provisioningState?: ProvisioningState;

  @minValue(1)
  @maxValue(10000)
  maximumConcurrency: int32;

  organizationProfile: OrganizationProfile;

  agentProfile: AgentProfile;

  fabricProfile: FabricProfile;
}

@discriminator("kind")
model OrganizationProfile {
}
model AzureDevOpsOrganizationProfile extends OrganizationProfile {
  kind: "AzureDevOps";
  organizations: Organization[];
}
model Organization {
  url: string;
  projects: string[];
  parallelism: int32;
}

@discriminator("kind")
model FabricProfile {
}
model VmssFabricProfile extends FabricProfile {
  kind: "Vmss";
  sku: DevOpsAzureSku;
  images: PoolImage[];
  osProfile: OsProfile;
  networkProfile: NetworkProfile;
}
model DevOpsAzureSku {
    name: string;
    tier: string = "Standard";
}
model PoolImage {
    resourceId: string;
    aliases: string[];
    buffer: string = "*";
}
model OsProfile {
    secretsManagementSettings: SecretsManagementSettings
}
model SecretsManagementSettings {
    certificateStoreLocation: string;
    observedCertificates: url[];
    keyExportable: boolean;
}
model NetworkProfile {
    subnetId: string
}

@discriminator("kind")
model AgentProfile {
    resourcePredictions: ResourcePredictions;
}
model StatelessAgentProfile extends AgentProfile {
  kind: "Stateless";
}
model Stateful extends AgentProfile {
  kind: "Stateful";
  maxAgentLifetime: unknown;
}
model ResourcePredictions {
}

@doc("The status of the current operation.")
enum ProvisioningState {
  /** Represents a succeeded operation. */
  Succeeded,
  /** Represents a failed operation. */
  Failed,
  /** Represents a canceled operation. */
  Canceled,
  /** Represents a pending operation. */
  Provisioning,
  /** Represents a pending operation. */
  Updating,
  /** Represents an operation under deletion. */
  Deleting,
  /** Represents an accepted operation. */
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Pools {
  get is ArmResourceRead<Pool>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Pool>;
  update is ArmResourcePatchSync<Pool, PoolProperties>;
  delete is ArmResourceDeleteSync<Pool>;
  listByResourceGroup is ArmResourceListByParent<Pool>;
  listBySubscription is ArmListBySubscription<Pool>;
}