import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric resource definition.")
model NetworkFabric is TrackedResource<NetworkFabricProperties> {
  @doc("Name of the Network Fabric.")
  @key("networkFabricName")
  @segment("networkFabrics")
  name: string;
}

@armResourceOperations
interface NetworkFabrics {
  @doc("Get Network Fabric resource details.")
  get is ArmResourceRead<NetworkFabric>;

  @doc("Create Network Fabric resource.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabric>;

  @doc("Update certain properties of the Network Fabric resource.")
  update is ArmCustomPatchAsync<NetworkFabric, NetworkFabricPatch>;

  @doc("Delete Network Fabric resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabric>;

  @doc("List all the Network Fabric resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabric>;

  @doc("List all the Network Fabric resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabric>;

  @doc("Provisions the underlying resources in the given Network Fabric instance.")
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Deprovisions the underlying resources in the given Network Fabric instance.")
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Upgrades the version of the underlying resources in the given Network Fabric instance.")
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Refreshes the configuration of the underlying resources in the given Network Fabric instance.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Validates the configuration of the underlying resources in the given Network Fabric instance.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.")
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}
