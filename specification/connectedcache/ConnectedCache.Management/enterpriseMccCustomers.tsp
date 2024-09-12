import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ConnectedCache;

@doc("Represents the high level Nodes needed to provision customer resources")
model EnterpriseMccCustomerResource is TrackedResource<CustomerProperty> {
  @doc("Name of the Customer resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("customerResourceName")
  @segment("enterpriseMccCustomers")
  @path
  name: string;
}

@armResourceOperations
interface EnterpriseMccCustomers {
  @doc("Gets the enterprise mcc customer resource information using this get call")
  get is ArmResourceRead<EnterpriseMccCustomerResource>;
  @doc("This api creates an enterprise mcc customer with the specified create parameters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EnterpriseMccCustomerResource>;
  @doc("This api updates an existing enterprise mcc customer resource")
  update is ArmCustomPatchSync<
    EnterpriseMccCustomerResource,
    ConnectedCachePatchResource
  >;
  @doc("This api deletes an existing enterprise mcc customer resource")
  delete is ArmResourceDeleteWithoutOkAsync<EnterpriseMccCustomerResource>;
  @doc("This api gets the information about all enterprise mcc customer resources under the given subscription and resource group")
  listByResourceGroup is ArmResourceListByParent<EnterpriseMccCustomerResource>;
  @doc("This api gets information about all enterpriseMccCustomer resources under the given subscription")
  listBySubscription is ArmListBySubscription<EnterpriseMccCustomerResource>;
}
