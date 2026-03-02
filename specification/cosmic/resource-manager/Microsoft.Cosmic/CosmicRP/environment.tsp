import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./namespace.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.Cosmic;

@doc("An Environment resource representing a per-ring deployment environment within a namespace.")
@parentResource(Namespace)
model Environment is TrackedResource<EnvironmentProperties> {
  ...ResourceNameParameter<Environment>;
}

@doc("Properties of an Environment resource.")
model EnvironmentProperties {
  @doc("Topology configuration for the environment.")
  @identifiers(#["partitionName"])
  topology?: TopologyConfiguration[];

  @doc("Capacity configuration for the environment.")
  capacity: CapacityConfiguration;

  @doc("Resource policy configuration for the environment.")
  resourcePolicy?: ResourcePolicyConfiguration;

  @doc("Networking configuration for the environment including BYOIP and SNAT settings.")
  networking?: NetworkingConfiguration;

  @doc("The status of the environment.")
  @visibility(Lifecycle.Read)
  status?: EnvironmentStatus;

  @doc("The provisioning state of the environment resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CosmicProvisioningState;
}

@armResourceOperations
interface Environments {
  get is ArmResourceRead<Environment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Environment>;
  update is ArmCustomPatchSync<
    Environment,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Environment,
      EnvironmentProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Environment>;
  listByNamespace is ArmResourceListByParent<Environment>;
}
