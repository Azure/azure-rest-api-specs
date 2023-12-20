import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EdgeOrder;
@doc("Address Resource.")
model EdgeOrderAddress is TrackedResource<AddressProperties> {
  @doc("The name of the address Resource within the specified resource group. address names must be between 3 and 24 characters in length and use any alphanumeric and underscore only")
  @maxLength(24)
  @minLength(3)
  @pattern("^[-\\w\\.]+$")
  @path
  @key("addressName")
  @segment("addresses")
  name: string;
}

@armResourceOperations
interface EdgeOrderAddresses {
  @doc("Gets information about the specified address.")
  getAddressByName is ArmResourceRead<EdgeOrderAddress>;
  @doc("Creates a new address with the specified parameters. Existing address can be updated with this API")
  createAddress is ArmResourceCreateOrUpdateAsync<EdgeOrderAddress>;
  @doc("Updates the properties of an existing address.")
  updateAddress is ArmResourcePatchAsync<
    EdgeOrderAddress,
    AddressProperties,
    {
      ...BaseParameters<EdgeOrderAddress>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes an address.")
  deleteAddressByName is ArmResourceDeleteAsync<EdgeOrderAddress>;
  @doc("Lists all the addresses available under the given resource group.")
  listAddressesAtResourceGroupLevel is ArmResourceListByParent<
    EdgeOrderAddress,
    {
      ...BaseParameters<EdgeOrderAddress>;

      @doc("$filter is supported to filter based on shipping address properties. Filter supports only equals operation.")
      @query("$filter")
      $filter?: string;

      @doc("$skipToken is supported on Get list of addresses, which provides the next page in the list of address.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("Lists all the addresses available under the subscription.")
  listAddressesAtSubscriptionLevel is ArmListBySubscription<EdgeOrderAddress>;
}
