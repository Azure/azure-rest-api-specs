import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SuppressionListResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Communication;
@doc("A object that represents a SuppressionList record.")
@parentResource(SuppressionListResource)
model SuppressionListAddressResource
  is ProxyResource<SuppressionListAddressProperties> {
  @doc("The id of the address in a suppression list.")
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("addressId")
  @segment("suppressionListAddresses")
  name: string;
}

@armResourceOperations
interface SuppressionListAddressResources {
  @doc("Get a SuppressionListAddress.")
  get is ArmResourceRead<SuppressionListAddressResource>;
  @doc("Create or update a SuppressionListAddress.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListAddressResource>;
  @doc("Operation to delete a single address from a suppression list.")
  delete is ArmResourceDeleteSync<SuppressionListAddressResource>;
  @doc("Get all the addresses in a suppression list.")
  list is ArmResourceListByParent<SuppressionListAddressResource>;
}
