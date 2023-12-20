import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("The security connector resource.")
model SecurityConnector is TrackedResource<SecurityConnectorProperties> {
  @doc("The security connector name.")
  @path
  @key("securityConnectorName")
  @segment("securityConnectors")
  name: string;
}

@armResourceOperations
interface SecurityConnectors {
  @doc("Retrieves details of a specific security connector")
  get is ArmResourceRead<SecurityConnector>;
  @doc("Creates or updates a security connector. If a security connector is already created and a subsequent request is issued for the same security connector id, then it will be updated.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityConnector>;
  @doc("Updates a security connector")
  update is ArmResourcePatchSync<
    SecurityConnector,
    SecurityConnectorProperties
  >;
  @doc("Deletes a security connector.")
  delete is ArmResourceDeleteSync<SecurityConnector>;
  @doc("Lists all the security connectors in the specified resource group. Use the 'nextLink' property in the response to get the next page of security connectors for the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<SecurityConnector>;
  @doc("Lists all the security connectors in the specified subscription. Use the 'nextLink' property in the response to get the next page of security connectors for the specified subscription.")
  list is ArmListBySubscription<SecurityConnector>;
}
