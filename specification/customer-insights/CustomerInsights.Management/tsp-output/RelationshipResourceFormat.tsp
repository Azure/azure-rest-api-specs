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
@doc("The relationship resource format.")
@parentResource(Hub)
model RelationshipResourceFormat is ProxyResource<RelationshipDefinition> {
  @doc("The name of the relationship.")
  @path
  @key("relationshipName")
  @segment("relationships")
  name: string;
}

@armResourceOperations
interface RelationshipResourceFormats {
  @doc("Gets information about the specified relationship.")
  get is ArmResourceRead<RelationshipResourceFormat>;
  @doc("Creates a relationship or updates an existing relationship within a hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelationshipResourceFormat>;
  @doc("Deletes a relationship within a hub.")
  delete is ArmResourceDeleteAsync<RelationshipResourceFormat>;
  @doc("Gets all relationships in the hub.")
  listByHub is ArmResourceListByParent<RelationshipResourceFormat>;
}
