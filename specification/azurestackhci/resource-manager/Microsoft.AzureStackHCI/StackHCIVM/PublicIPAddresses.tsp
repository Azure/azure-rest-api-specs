import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - x-ms-azure-resource is this needed?"
#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("The publicIP resource definition.")
@extension("x-ms-azure-resource", true)
@added(Versions.v2025_09_01_preview)
model PublicIPAddress is TrackedResource<PublicIPAddressProperties> {
  @doc("Name of the public IP")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("publicIPAddressName")
  @segment("publicIPAddresses")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface PublicIPAddresses {
  @doc("The operation to get a virtual network.")
  get is ArmResourceRead<PublicIPAddress>;

  @doc("The operation to create or update a publicIPAddress. Please note some properties can be set only during PublicIP creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PublicIPAddress>;

  @doc("Updates a publicIPAddress tags.")
  updateTags is ArmTagsPatchAsync<PublicIPAddress, TagsObject>;

  @doc("The operation to delete a publicIPAddresses.")
  delete is ArmResourceDeleteWithoutOkAsync<PublicIPAddress>;

  @doc("Lists all of the publicIPAddresses in the specified resource group. Use the nextLink property in the response to get the next page of PublicIP.")
  listByResourceGroup is ArmResourceListByParent<PublicIPAddress>;

  @doc("Lists all of the publicIPAddresses in the specified subscription. Use the nextLink property in the response to get the next page of PublicIP.")
  listAll is ArmListBySubscription<PublicIPAddress>;
}
