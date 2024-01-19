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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified relationship Link.")
  @operationId("RelationshipLinks_Get")
  get is ArmResourceRead<RelationshipLinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a relationship link or updates an existing relationship link within a hub.")
  @operationId("RelationshipLinks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelationshipLinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a relationship link within a hub.")
  @operationId("RelationshipLinks_Delete")
  delete is ArmResourceDeleteAsync<RelationshipLinkResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all relationship links in the hub.")
  @operationId("RelationshipLinks_ListByHub")
  listByHub is ArmResourceListByParent<RelationshipLinkResourceFormat>;
}

@@projectedName(RelationshipLinkResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(RelationshipLinkResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(RelationshipLinkResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate relationship link operation."
);
