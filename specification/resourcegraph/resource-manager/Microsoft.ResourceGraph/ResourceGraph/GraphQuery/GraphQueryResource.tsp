import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace GraphQueryApi;
/**
 * Graph Query entity definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
model GraphQueryResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<GraphQueryProperties> {
  ...ResourceNameParameter<
    Resource = GraphQueryResource,
    KeyName = "resourceName",
    SegmentName = "queries",
    NamePattern = "^[^<>&:\\?]*$"
  >;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface GraphQueryResources {
  /**
   * Get a single graph query by its resourceName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Get")
  @tag("GraphQuery")
  get is ArmResourceRead<GraphQueryResource, Error = GraphQueryError>;

  /**
   * Create a new graph query.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_CreateOrUpdate")
  @tag("GraphQuery")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    GraphQueryResource,
    Error = GraphQueryError
  >;

  /**
   * Updates a graph query that has already been added.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    GraphQueryResource,
    PatchModel = GraphQueryUpdateParameters,
    Error = GraphQueryError
  >;

  /**
   * Delete a graph query.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Delete")
  @tag("GraphQuery")
  delete is ArmResourceDeleteSync<GraphQueryResource, Error = GraphQueryError>;

  /**
   * Get all graph queries defined within a specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_List")
  @tag("GraphQuery")
  list is ArmResourceListByParent<
    GraphQueryResource,
    Response = ArmResponse<GraphQueryListResult>,
    Error = GraphQueryError
  >;

  /**
   * Get all graph queries defined within a specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_ListBySubscription")
  @tag("GraphQuery")
  listBySubscription is ArmListBySubscription<
    GraphQueryResource,
    Response = ArmResponse<GraphQueryListResult>,
    Error = GraphQueryError
  >;
}

@@doc(GraphQueryResource.name, "The name of the Graph Query resource.");
@@doc(GraphQueryResource.properties,
  "Metadata describing a graph query for an Azure resource."
);
@@doc(GraphQueryResources.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new graph query."
);
@@doc(GraphQueryResources.update::parameters.properties,
  "Properties that need to be specified to create a new graph query."
);
