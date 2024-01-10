import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The link resource format.")
@parentResource(Hub)
model LinkResourceFormat is ProxyResource<LinkDefinition> {
  @doc("The name of the link.")
  @key("linkName")
  @segment("links")
  name: string;
}

@armResourceOperations
@projectedName("client", "Links")
interface LinkResourceFormats_Links {
  @doc("Gets a link in the hub.")
  get is ArmResourceRead<LinkResourceFormat>;

  @doc("Creates a link or updates an existing link in the hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LinkResourceFormat>;

  @doc("Deletes a link in the hub.")
  delete is ArmResourceDeleteSync<LinkResourceFormat>;

  @doc("Gets all the links in the specified hub.")
  listByHub is ArmResourceListByParent<LinkResourceFormat>;
}
