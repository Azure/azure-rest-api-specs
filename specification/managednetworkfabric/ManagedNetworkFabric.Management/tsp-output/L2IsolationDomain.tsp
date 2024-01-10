import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The L2 Isolation Domain resource definition.")
model L2IsolationDomain is TrackedResource<L2IsolationDomainProperties> {
  @doc("Name of the L2 Isolation Domain.")
  @key("l2IsolationDomainName")
  @segment("l2IsolationDomains")
  name: string;
}

@armResourceOperations
interface L2IsolationDomains {
  @doc("Implements L2 Isolation Domain GET method.")
  get is ArmResourceRead<L2IsolationDomain>;

  @doc("Creates layer 2 network connectivity between compute nodes within a rack and across racks.The configuration is applied on the devices only after the isolation domain is enabled.")
  create is ArmResourceCreateOrUpdateAsync<L2IsolationDomain>;

  @doc("API to update certain properties of the L2 Isolation Domain resource.")
  update is ArmCustomPatchAsync<L2IsolationDomain, L2IsolationDomainPatch>;

  @doc("Deletes layer 2 connectivity between compute nodes by managed by named L2 Isolation name.")
  delete is ArmResourceDeleteWithoutOkAsync<L2IsolationDomain>;

  @doc("Displays L2IsolationDomains list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<L2IsolationDomain>;

  @doc("Displays L2IsolationDomains list by subscription GET method.")
  listBySubscription is ArmListBySubscription<L2IsolationDomain>;

  @doc("Enables isolation domain across the fabric or on specified racks.")
  updateAdministrativeState is ArmResourceActionAsync<
    L2IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}
