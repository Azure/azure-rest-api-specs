import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;
@doc("Description of the WCF relay resource.")
@parentResource(RelayNamespace)
model WcfRelay is ProxyResource<WcfRelayProperties> {
  @doc("The relay name.")
  @minLength(1)
  @path
  @key("relayName")
  @segment("wcfRelays")
  name: string;
}

@armResourceOperations
interface WCFRelays {
  @doc("Returns the description for the specified WCF relay.")
  get is ArmResourceRead<WcfRelay>;
  @doc("Creates or updates a WCF relay. This operation is idempotent.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WcfRelay>;
  @doc("Deletes a WCF relay.")
  delete is ArmResourceDeleteSync<WcfRelay>;
  @doc("Lists the WCF relays within the namespace.")
  listByNamespace is ArmResourceListByParent<WcfRelay>;
}
