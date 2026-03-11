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

namespace ResourceGraph;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QueryOperationGroup {
  /**
   * Generates ARG query for a given user prompt.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Query_GenerateQuery")
  @autoRoute
  @Versioning.added(Versions.v2023_09_01_preview)
  generateQuery is ArmProviderActionSync<
    Request = QueryGenerationRequest,
    Response = QueryGenerationResponse,
    Error = ErrorResponse
  >;
}

/**
 * Queries the resources managed by Azure Resource Manager for scopes specified in the request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" ""
@autoRoute
@tag("Resources")
@externalDocs(
  "https://aka.ms/resource-graph/learntoquery",
  "Learn more about the query syntax here"
)
op resources is ArmProviderActionSync<
  Request = QueryRequest,
  Response = QueryResponse,
  Error = ErrorResponse
>;

/**
 * Graph Query entity definition.
 */
@Versioning.added(Versions.v2018_09_01_preview)
@Versioning.removed(Versions.v2020_04_01_preview)
model GraphQueryResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<GraphQueryProperties> {
  ...ResourceNameParameter<
    Resource = GraphQueryResource,
    KeyName = "resourceName",
    SegmentName = "queries",
    NamePattern = ""
  >;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
@Versioning.added(Versions.v2018_09_01_preview)
@Versioning.removed(Versions.v2020_04_01_preview)
interface GraphQueryResources {
  /**
   * Get a single graph query by its resourceName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Get")
  get is ArmResourceRead<GraphQueryResource>;

  /**
   * Create a new graph query.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("GraphQuery_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    GraphQueryResource,
    Response = ArmResourceUpdatedResponse<GraphQueryResource>
  >;

  /**
   * Updates a graph query that has already been added.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    GraphQueryResource,
    PatchModel = GraphQueryUpdateParameters
  >;

  /**
   * Delete a graph query.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_Delete")
  delete is ArmResourceDeleteSync<GraphQueryResource>;

  /**
   * Get all graph queries defined within a specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQuery_List")
  list is ArmResourceListByParent<GraphQueryResource>;
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