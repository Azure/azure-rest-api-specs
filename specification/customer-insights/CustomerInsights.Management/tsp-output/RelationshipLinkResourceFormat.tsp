import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
@doc("The relationship link resource format.")
@parentResource(Hub)
model RelationshipLinkResourceFormat
  is ProxyResource<RelationshipLinkDefinition> {
  @doc("The name of the relationship link.")
  @path
  @key("relationshipLinkName")
  @segment("relationshipLinks")
  name: string;
}

@armResourceOperations
interface RelationshipLinkResourceFormats {
  @doc("Gets information about the specified relationship Link.")
  get is ArmResourceRead<RelationshipLinkResourceFormat>;
  @doc("Creates a relationship link or updates an existing relationship link within a hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelationshipLinkResourceFormat>;
  @doc("Deletes a relationship link within a hub.")
  delete is ArmResourceDeleteAsync<RelationshipLinkResourceFormat>;
  @doc("Gets all relationship links in the hub.")
  listByHub is ArmResourceListByParent<RelationshipLinkResourceFormat>;
}
