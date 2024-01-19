import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetwork;
@doc("The Managed Network Peering Policy resource")
@parentResource(ManagedNetwork)
model ManagedNetworkPeeringPolicy
  is ProxyResource<ManagedNetworkPeeringPolicyProperties> {
  @doc("The name of the Managed Network Peering Policy.")
  @path
  @key("managedNetworkPeeringPolicyName")
  @segment("managedNetworkPeeringPolicies")
  name: string;
}

@armResourceOperations
interface ManagedNetworkPeeringPolicies {
  @doc("The Get ManagedNetworkPeeringPolicies operation gets a Managed Network Peering Policy resource, specified by the  resource group, Managed Network name, and peering policy name")
  get is ArmResourceRead<ManagedNetworkPeeringPolicy>;

  @doc("The Put ManagedNetworkPeeringPolicies operation creates/updates a new Managed Network Peering Policy")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedNetworkPeeringPolicy,
    BaseParameters<ManagedNetworkPeeringPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("The Delete ManagedNetworkPeeringPolicies operation deletes a Managed Network Peering Policy, specified by the  resource group, Managed Network name, and peering policy name")
  delete is ArmResourceDeleteAsync<
    ManagedNetworkPeeringPolicy,
    BaseParameters<ManagedNetworkPeeringPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("The ListByManagedNetwork PeeringPolicies operation retrieves all the Managed Network Peering Policies in a specified Managed Network, in a paginated format.")
  listByManagedNetwork is ArmResourceListByParent<
    ManagedNetworkPeeringPolicy,
    {
      ...BaseParameters<ManagedNetworkPeeringPolicy>;

      @doc("May be used to limit the number of results in a page for list queries.")
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@projectedName(ManagedNetworkPeeringPolicies.createOrUpdate::parameters.resource,
  "json",
  "managedNetworkPolicy"
);
@@extension(ManagedNetworkPeeringPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedNetworkPolicy"
);
@@doc(ManagedNetworkPeeringPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create/update a Managed Network Peering Policy"
);
