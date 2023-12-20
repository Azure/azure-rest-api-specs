import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Peering;
@doc("The peering service prefix class.")
@parentResource(PeeringService)
model PeeringServicePrefix is ProxyResource<PeeringServicePrefixProperties> {
  @doc("The name of the prefix.")
  @path
  @key("prefixName")
  @segment("prefixes")
  name: string;
}

@armResourceOperations
interface PeeringServicePrefixes {
  @doc("Gets an existing prefix with the specified name under the given subscription, resource group and peering service.")
  get is ArmResourceRead<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      @doc("The properties to be expanded.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates a new prefix with the specified name under the given subscription, resource group and peering service.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringServicePrefix>;
  @doc("Deletes an existing prefix with the specified name under the given subscription, resource group and peering service.")
  delete is ArmResourceDeleteSync<PeeringServicePrefix>;
  @doc("Lists all prefixes under the given subscription, resource group and peering service.")
  listByPeeringService is ArmResourceListByParent<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      @doc("The properties to be expanded.")
      @query("$expand")
      $expand?: string;
    }
  >;
}
