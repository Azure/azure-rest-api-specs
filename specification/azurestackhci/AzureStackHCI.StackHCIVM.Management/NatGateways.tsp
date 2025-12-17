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
@doc("The NatGateway resource definition.")
@extension("x-ms-azure-resource", true)
@added(Versions.v2025_09_01_preview)
model NatGateway is TrackedResource<NatGatewayProperties> {
  @doc("Name of the nat gateway")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("natGatewayName")
  @segment("natGateways")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface NatGateways {
  @doc("The operation to get a natGateway.")
  get is ArmResourceRead<NatGateway>;

  @doc("The operation to create or update a natGateway. Please note some properties can be set only during NatGateway creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NatGateway>;

  @doc("Updates a natGateway tags.")
  updateTags is ArmTagsPatchAsync<NatGateway, TagsObject>;

  @doc("The operation to delete a natGateway.")
  delete is ArmResourceDeleteWithoutOkAsync<NatGateway>;

  @doc("Lists all of the natGateways in the specified resource group. Use the nextLink property in the response to get the next page of NatGateway.")
  listByResourceGroup is ArmResourceListByParent<NatGateway>;

  @doc("Lists all of the natGateways in the specified subscription. Use the nextLink property in the response to get the next page of NatGateway.")
  listAll is ArmListBySubscription<NatGateway>;
}
