import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace GraphQueryApi;
/**
 * Graph Query entity definition.
 */
model GraphQueryResource
  is Azure.ResourceManager.ProxyResource<GraphQueryProperties> {
  ...ResourceNameParameter<
    Resource = GraphQueryResource,
    KeyName = "resourceName",
    SegmentName = "queries",
    NamePattern = "^[^<>&:\\?]*$"
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface GraphQueryResources {
  /**
   * Get a single graph query by its resourceName.
   */
  @tag("GraphQuery")
  get is ArmResourceRead<GraphQueryResource, Error = GraphQueryError>;

  /**
   * Create a new graph query.
   */
  @tag("GraphQuery")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    GraphQueryResource,
    Error = GraphQueryError
  >;

  /**
   * Updates a graph query that has already been added.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    GraphQueryResource,
    PatchModel = GraphQueryUpdateParameters,
    Error = GraphQueryError
  >;

  /**
   * Delete a graph query.
   */
  @tag("GraphQuery")
  delete is ArmResourceDeleteSync<GraphQueryResource, Error = GraphQueryError>;

  /**
   * Get all graph queries defined within a specified subscription and resource group.
   */
  @tag("GraphQuery")
  list is ArmResourceListByParent<
    GraphQueryResource,
    Response = ArmResponse<GraphQueryListResult>,
    Error = GraphQueryError
  >;

  /**
   * Get all graph queries defined within a specified subscription.
   */
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
