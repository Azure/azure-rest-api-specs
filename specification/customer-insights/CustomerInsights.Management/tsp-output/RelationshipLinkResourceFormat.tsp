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
 * The relationship link resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@Azure.ResourceManager.Private.armResourceInternal(RelationshipLinkDefinition)
@includeInapplicableMetadataInPayload(false)
model RelationshipLinkResourceFormat extends ProxyResource {
  /**
   * The name of the relationship link.
   */
  @path
  @key("relationshipLinkName")
  @segment("relationshipLinks")
  name: string;

  /**
   * The definition of relationship link.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RelationshipLinkDefinition;
}

@armResourceOperations
interface RelationshipLinkResourceFormats {
  /**
   * Gets information about the specified relationship Link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RelationshipLinks_Get")
  get is ArmResourceRead<RelationshipLinkResourceFormat>;

  /**
   * Creates a relationship link or updates an existing relationship link within a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RelationshipLinks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RelationshipLinkResourceFormat>;

  /**
   * Deletes a relationship link within a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RelationshipLinks_Delete")
  delete is ArmResourceDeleteAsync<RelationshipLinkResourceFormat>;

  /**
   * Gets all relationship links in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
