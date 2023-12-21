import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The L3 Isolation Domain resource definition.")
model L3IsolationDomain is TrackedResource<L3IsolationDomainProperties> {
  @doc("Name of the L3 Isolation Domain.")
  @path
  @key("l3IsolationDomainName")
  @segment("l3IsolationDomains")
  name: string;
}

@armResourceOperations
interface L3IsolationDomains {
  @doc("Retrieves details of this L3 Isolation Domain.")
  get is ArmResourceRead<L3IsolationDomain>;
  @doc("Create isolation domain resources for layer 3 connectivity between compute nodes and for communication with external services .This configuration is applied on the devices only after the creation of networks is completed and isolation domain is enabled. ")
  create is ArmResourceCreateOrUpdateAsync<L3IsolationDomain>;
  @doc("API to update certain properties of the L3 Isolation Domain resource.")
  update is ArmResourcePatchAsync<
    L3IsolationDomain,
    L3IsolationDomainProperties
  >;
  @doc("Deletes layer 3 connectivity between compute nodes by managed by named L3 Isolation name.")
  delete is ArmResourceDeleteWithoutOkAsync<L3IsolationDomain>;
  @doc("Displays L3IsolationDomains list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<L3IsolationDomain>;
  @doc("Displays L3IsolationDomains list by subscription GET method.")
  listBySubscription is ArmListBySubscription<L3IsolationDomain>;
  @doc("Enables racks for this Isolation Domain.")
  updateAdministrativeState is ArmResourceActionAsync<
    L3IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;
  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    ValidateConfigurationResponse
  >;
  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    L3IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}
