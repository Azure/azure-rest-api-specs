import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ConnectedCache;
@doc("Represents the high level Nodes needed to provision isp customer resources")
model IspCustomerResource is TrackedResource<CustomerProperty> {
  @doc("Name of the Customer resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("customerResourceName")
  @segment("ispCustomers")
  @path
  name: string;
}

@armResourceOperations
interface IspCustomers {
  @doc("Gets the ispCustomer resource information using this get call")
  get is ArmResourceRead<IspCustomerResource>;
  @doc("This api creates an ispCustomer with the specified create parameters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IspCustomerResource>;
  @doc("This api updates an existing ispCustomer resource")
  update is ArmCustomPatchSync<
    IspCustomerResource,
    ConnectedCachePatchResource
  >;
  @doc("This api deletes an existing ispCustomer resource")
  delete is ArmResourceDeleteWithoutOkAsync<IspCustomerResource>;
  @doc("This api gets the information about all ispCustomer resources under the given subscription and resource group")
  listByResourceGroup is ArmResourceListByParent<IspCustomerResource>;
  @doc("This api gets information about all ispCustomer resources under the given subscription")
  listBySubscription is ArmListBySubscription<IspCustomerResource>;
}
