// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace GraphQuery;

/**
 * Graph Query entity definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.TrackedResourceWithOptionalLocation to make location property optional for backward compatibility"
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

@armResourceOperations
interface GraphQuery {
  /**
   * Get a single graph query by its resourceName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Get")
  get is ArmResourceRead<
    GraphQueryResource,
    Error = GraphQueryError
  >;

  /**
   * Create a new graph query.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("GraphQuery_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    GraphQueryResource,
    Response = ArmResourceUpdatedResponse<GraphQueryResource>,
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
  delete is ArmResourceDeleteSync<
    GraphQueryResource,
    Error = GraphQueryError
  >;

  /**
   * Get all graph queries defined within a specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_List")
  list is ArmResourceListByParent<
    GraphQueryResource,
    Error = GraphQueryError
  >;

  /**
   * Get all graph queries defined within a specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_ListBySubscription")
  @Versioning.added(Versions.v2019_04_01)
  listBySubscription is ArmListBySubscription<
    GraphQueryResource,
    Error = GraphQueryError
  >;
}

@@doc(GraphQueryResource.name, "The name of the Graph Query resource.");
@@doc(GraphQueryResource.properties,
  "Metadata describing a graph query for an Azure resource."
);
@@doc(GraphQuery.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create a new graph query."
);
@@doc(GraphQuery.update::parameters.properties,
  "Properties that need to be specified to create a new graph query."
);