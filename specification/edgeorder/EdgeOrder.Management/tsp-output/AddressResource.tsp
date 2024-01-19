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

namespace Microsoft.EdgeOrder;
@doc("Address Resource.")
model AddressResource is TrackedResource<AddressProperties> {
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
interface AddressResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified address.")
  @operationId("GetAddressByName")
  getAddressByName is ArmResourceRead<AddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new address with the specified parameters. Existing address can be updated with this API")
  @operationId("CreateAddress")
  createAddress is ArmResourceCreateOrUpdateAsync<AddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the properties of an existing address.")
  @operationId("UpdateAddress")
  updateAddress is ArmCustomPatchAsync<
    AddressResource,
    AddressUpdateParameter,
    {
      ...BaseParameters<AddressResource>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an address.")
  @operationId("DeleteAddressByName")
  deleteAddressByName is ArmResourceDeleteAsync<AddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the addresses available under the given resource group.")
  @operationId("ListAddressesAtResourceGroupLevel")
  listAddressesAtResourceGroupLevel is ArmResourceListByParent<
    AddressResource,
    {
      ...BaseParameters<AddressResource>;

      @doc("$filter is supported to filter based on shipping address properties. Filter supports only equals operation.")
      @query("$filter")
      $filter?: string;

      @doc("$skipToken is supported on Get list of addresses, which provides the next page in the list of address.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the addresses available under the subscription.")
  @operationId("ListAddressesAtSubscriptionLevel")
  listAddressesAtSubscriptionLevel is ArmListBySubscription<AddressResource>;
}

@@projectedName(AddressResources.createAddress::parameters.resource,
  "json",
  "addressResource"
);
@@extension(AddressResources.createAddress::parameters.resource,
  "x-ms-client-name",
  "addressResource"
);
@@doc(AddressResources.createAddress::parameters.resource,
  "Address details from request body."
);
@@projectedName(AddressResources.updateAddress::parameters.properties,
  "json",
  "addressUpdateParameter"
);
@@extension(AddressResources.updateAddress::parameters.properties,
  "x-ms-client-name",
  "addressUpdateParameter"
);
@@doc(AddressResources.updateAddress::parameters.properties,
  "Address update parameters from request body."
);
