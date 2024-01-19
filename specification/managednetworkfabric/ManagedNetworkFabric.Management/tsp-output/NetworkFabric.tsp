import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric resource definition.")
model NetworkFabric is TrackedResource<NetworkFabricProperties> {
  @doc("Name of the Network Fabric.")
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  name: string;
}

@armResourceOperations
interface NetworkFabrics {
  @doc("Get Network Fabric resource details.")
  get is ArmResourceRead<NetworkFabric>;

  @doc("Create Network Fabric resource.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkFabric,
    BaseParameters<NetworkFabric>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network Fabric resource.")
  update is ArmCustomPatchAsync<
    NetworkFabric,
    NetworkFabricPatch,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Delete Network Fabric resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFabric,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("List all the Network Fabric resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabric>;

  @doc("List all the Network Fabric resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabric>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Provisions the underlying resources in the given Network Fabric instance.")
  @operationId("NetworkFabrics_provision")
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deprovisions the underlying resources in the given Network Fabric instance.")
  @operationId("NetworkFabrics_deprovision")
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Upgrades the version of the underlying resources in the given Network Fabric instance.")
  @operationId("NetworkFabrics_upgrade")
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refreshes the configuration of the underlying resources in the given Network Fabric instance.")
  @operationId("NetworkFabrics_refreshConfiguration")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Validates the configuration of the underlying resources in the given Network Fabric instance.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  @doc("Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.")
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkFabrics.create::parameters.resource, "json", "body");
@@extension(NetworkFabrics.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkFabrics.create::parameters.resource, "Request payload.");
@@projectedName(NetworkFabrics.update::parameters.properties, "json", "body");
@@extension(NetworkFabrics.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkFabrics.update::parameters.properties,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.upgrade::parameters.body,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.updateWorkloadManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.updateInfraManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.validateConfiguration::parameters.body,
  "Validate configuration properties."
);
