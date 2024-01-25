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
/**
 * The relationship resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@includeInapplicableMetadataInPayload(false)
model RelationshipResourceFormat extends ProxyResource {
  /**
   * The name of the relationship.
   */
  @path
  @key("relationshipName")
  @segment("relationships")
  @visibility("read")
  name: string;

  /**
   * The definition of Relationship.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RelationshipDefinition;
}

@armResourceOperations
interface RelationshipResourceFormats {
  /**
   * Gets information about the specified relationship.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Relationships_Get")
  get is ArmResourceRead<RelationshipResourceFormat>;

  /**
   * Creates a relationship or updates an existing relationship within a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Relationships_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RelationshipResourceFormat>;

  /**
   * Deletes a relationship within a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Relationships_Delete")
  delete is ArmResourceDeleteAsync<RelationshipResourceFormat>;

  /**
   * Gets all relationships in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
