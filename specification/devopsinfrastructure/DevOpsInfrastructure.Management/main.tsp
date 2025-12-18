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
@service(#{ title: "Managed DevOps Infrastructure" })
@versioned(Versions)
namespace Microsoft.DevOpsInfrastructure;

enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  `2023-10-30-preview`,
}

model Pool is TrackedResource<PoolProperties> {
  @key("poolName")
  @pattern("^[a-z][a-z0-9]*$")
  @path
  @segment("pools")
  @doc("Name of the pool. It needs to be globally unique.")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
  ...Azure.ResourceManager.Legacy.ManagedServiceIdentityV4Property;
}

@doc("Pool properties")
model PoolProperties {
  @doc("The status of the current operation.")
  @visibility(Lifecycle.Read)
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

  @doc("The resource id of the DevCenter Project the pool belongs to.")
  devCenterProjectResourceId: string;
}

/** The kinds of organization profile */
union OrganizationProfileKind {
  /** An ADO organization profile */
  AzureDevOps: "AzureDevOps",

  string,
}
@doc("Defines the organization in which the pool will be used.")
@discriminator("kind")
model OrganizationProfile {
  kind: OrganizationProfileKind;
}

@doc("Azure DevOps organization profile")
model AzureDevOpsOrganizationProfile extends OrganizationProfile {
  @doc("Azure DevOps organization profile")
  kind: OrganizationProfileKind.AzureDevOps;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Legacy"
  @doc("The list of Azure DevOps organizations the pool should be present in.")
  @identifiers(#[])
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

/** The kind of fabric profile */
union FabricProfileKind {
  string,

  /** A fabric profile containing virtual machine scale sets */
  Vmss: "Vmss",
}
@doc("Defines the type of fabric the agent will run on.")
@discriminator("kind")
model FabricProfile {
  kind: FabricProfileKind;
}
@doc("The agents will run on Virtual Machine Scale Sets.")
model VmssFabricProfile extends FabricProfile {
  @doc("Virtual Machine Scale Sets")
  kind: FabricProfileKind.Vmss;

  @doc("The Azure SKU of the machines in the pool.")
  sku: DevOpsAzureSku;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Legacy"
  @doc("The VM images of the machines in the pool.")
  @identifiers(#[])
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

/** The kinds of agents */
union AgentProfileKind {
  /** Machines will be cleaned up after execution */
  Stateless: "Stateless",

  /** Machines returned to the pool after execution */
  Stateful: "Stateful",

  string,
}

@doc("The agent profile of the machines in the pool.")
@discriminator("kind")
model AgentProfile {
  kind: AgentProfileKind;

  @doc("Defines pool buffer.")
  resourcePredictions?: ResourcePredictions;
}
@doc("Stateless profile meaning that the machines will be cleaned up after running a job.")
model StatelessAgentProfile extends AgentProfile {
  @doc("Stateless profile meaning that the machines will be cleaned up after running a job.")
  kind: AgentProfileKind.Stateless;
}
@doc("Stateful profile meaning that the machines will be returned to the pool after running a job.")
model Stateful extends AgentProfile {
  @doc("Stateful profile meaning that the machines will be returned to the pool after running a job.")
  kind: AgentProfileKind.Stateful;

  @doc("How long should stateful machines be kept around. The maximum is one week.")
  maxAgentLifetime: string;
}
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
@doc("Defines pool buffer.")
model ResourcePredictions {}

@doc("The status of the current operation.")
union ProvisioningState {
  string,

  /** Represents a succeeded operation. */
  Succeeded: "Succeeded",

  /** Represents a failed operation. */
  Failed: "Failed",

  /** Represents a canceled operation. */
  Canceled: "Canceled",

  /** Represents a pending operation. */
  Provisioning: "Provisioning",

  /** Represents a pending operation. */
  Updating: "Updating",

  /** Represents an operation under deletion. */
  Deleting: "Deleting",

  /** Represents an accepted operation. */
  Accepted: "Accepted",
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
