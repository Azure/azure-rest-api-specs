import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified relationship.")
  @operationId("Relationships_Get")
  get is ArmResourceRead<RelationshipResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a relationship or updates an existing relationship within a hub.")
  @operationId("Relationships_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelationshipResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a relationship within a hub.")
  @operationId("Relationships_Delete")
  delete is ArmResourceDeleteAsync<RelationshipResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all relationships in the hub.")
  @operationId("Relationships_ListByHub")
  listByHub is ArmResourceListByParent<RelationshipResourceFormat>;
}

@@projectedName(RelationshipResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(RelationshipResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(RelationshipResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Relationship operation."
);
