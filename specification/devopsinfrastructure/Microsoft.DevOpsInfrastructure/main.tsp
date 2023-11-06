import "@typespec/http";
import "@typespec/rest";
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
  @doc("Name of the pool. It needs to be globally unique.")
  name: string;

  ...ManagedServiceIdentity;
}

@doc("Pool properties")
model PoolProperties {
  @doc("The status of the current operation.")
  provisioningState?: ProvisioningState;

  @minValue(1)
  @maxValue(10000)
  @doc("Defines how many resources can there be created at any given time.")
  maximumConcurrency: int32;

  @doc("Defines the organization in which the pool will be used.")
  organizationProfile: OrganizationProfile;

  @doc("Defines how the machine will be handled once it executed a job.")
  agentProfile: AgentProfile;

  @doc("Defines the type of fabric the agent will run on.")
  fabricProfile: FabricProfile;
}

@doc("Defines the organization in which the pool will be used.")
@discriminator("kind")
model OrganizationProfile {}

@doc("Azure DevOps organization profile")
model AzureDevOpsOrganizationProfile extends OrganizationProfile {
  @doc("Azure DevOps organization profile")
  kind: "AzureDevOps";

  @doc("The list of Azure DevOps organizations the pool should be present in.")
  organizations: Organization[];
}
@doc("Defines an Azure DevOps organization.")
model Organization {
  @doc("The Azure DevOps organization URL in which the pool should be created.")
  url: string;

  @doc("Optional list of projects in which the pool should be created.")
  projects?: string[];

  @doc("How many machines can be created at maximum in this organization out of the maximumConcurrency of the pool.")
  parallelism?: int32;
}

@doc("Defines the type of fabric the agent will run on.")
@discriminator("kind")
model FabricProfile {}
@doc("The agents will run on Virtual Machine Scale Sets.")
model VmssFabricProfile extends FabricProfile {
  @doc("Virtual Machine Scale Sets")
  kind: "Vmss";

  @doc("The Azure SKU of the machines in the pool.")
  sku: DevOpsAzureSku;

  @doc("The VM images of the machines in the pool.")
  images: PoolImage[];

  @doc("The OS profile of the machines in the pool.")
  osProfile?: OsProfile;

  @doc("The network profile of the machines in the pool.")
  networkProfile?: NetworkProfile;
}

@doc("The Azure SKU of the machines in the pool.")
model DevOpsAzureSku {
  @doc("The Azure SKU name of the machines in the pool.")
  name: string;

  @doc("The Azure SKU tier of the machines in the pool.")
  tier?: string = "Standard";
}
@doc("The VM image of the machines in the pool.")
model PoolImage {
  @doc("The resource id of the image.")
  resourceId: string;

  @doc("List of aliases to reference the image by.")
  aliases?: string[];

  @doc("The percentage of the buffer to be allocated to this image.")
  buffer?: string = "*";
}
@doc("The OS profile of the machines in the pool.")
model OsProfile {
  @doc("The secret management settings of the machines in the pool.")
  secretsManagementSettings: SecretsManagementSettings;
}
@doc("The secret management settings of the machines in the pool.")
model SecretsManagementSettings {
  @doc("Where to store certificates on the machine.")
  certificateStoreLocation?: string;

  @doc("The list of certificates to install on all machines in the pool.")
  observedCertificates: url[];

  @doc("Defines if the key of the certificates should be exportable.")
  keyExportable: boolean;
}
@doc("The network profile of the machines in the pool.")
model NetworkProfile {
  @doc("The subnet id on which to put all machines created in the pool.")
  subnetId: string;
}

@doc("The agent profile of the machines in the pool.")
@discriminator("kind")
model AgentProfile {
  @doc("Defines pool buffer.")
  resourcePredictions?: ResourcePredictions;
}
@doc("Stateless profile meaning that the machines will be cleaned up after running a job.")
model StatelessAgentProfile extends AgentProfile {
  @doc("Stateless profile meaning that the machines will be cleaned up after running a job.")
  kind: "Stateless";
}
@doc("Stateful profile meaning that the machines will be returned to the pool after running a job.")
model Stateful extends AgentProfile {
  @doc("Stateful profile meaning that the machines will be returned to the pool after running a job.")
  kind: "Stateful";

  @doc("How long should stateful machines be kept around. The maximum is one week.")
  maxAgentLifetime: string;
}
@doc("Defines pool buffer.")
model ResourcePredictions {}

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
  update is ArmResourcePatchAsync<Pool, PoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Pool>;
  listByResourceGroup is ArmResourceListByParent<Pool>;
  listBySubscription is ArmListBySubscription<Pool>;
}
