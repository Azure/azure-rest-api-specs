import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Graph resource.
 */
@parentResource(DatabaseAccountGetResults)
model GraphResourceGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<GraphResourceGetProperties> {
  ...ResourceNameParameter<
    Resource = GraphResourceGetResults,
    KeyName = "graphName",
    SegmentName = "graphs",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface GraphResources {
  /**
   * Gets the Graph resource under an existing Azure Cosmos DB database account with the provided name.
   */
  getGraph is ArmResourceRead<GraphResourceGetResults>;

  /**
   * Create or update an Azure Cosmos DB Graph.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateGraph is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    GraphResourceGetResults,
    Request = GraphResourceCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<GraphResourceGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GraphResourceGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Graph Resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteGraphResource is ArmResourceDeleteWithoutOkAsync<
    GraphResourceGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the graphs under an existing Azure Cosmos DB database account.
   */
  listGraphs is ArmResourceListByParent<
    GraphResourceGetResults,
    Response = ArmResponse<GraphResourcesListResult>
  >;
}

@@doc(GraphResourceGetResults.name, "Cosmos DB graph resource name.");
@@doc(GraphResourceGetResults.properties,
  "The properties of an Azure Cosmos DB Graph resource."
);
@@doc(GraphResources.createUpdateGraph::parameters.resource,
  "The parameters to provide for the current graph."
);
