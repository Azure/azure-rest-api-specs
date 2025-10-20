import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GremlinDatabaseGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Gremlin graph.
 */
@parentResource(GremlinDatabaseGetResults)
model GremlinGraphGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<GremlinGraphGetProperties> {
  ...ResourceNameParameter<
    Resource = GremlinGraphGetResults,
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
interface GremlinGraphGetResultsOperationGroup {
  /**
   * Gets the Gremlin graph under an existing Azure Cosmos DB database account.
   */
  getGremlinGraph is ArmResourceRead<GremlinGraphGetResults>;

  /**
   * Create or update an Azure Cosmos DB Gremlin graph
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateGremlinGraph is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    GremlinGraphGetResults,
    Request = GremlinGraphCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<GremlinGraphGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GremlinGraphGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Gremlin graph.
   */
  deleteGremlinGraph is ArmResourceDeleteWithoutOkAsync<
    GremlinGraphGetResults,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | NoContentResponse
  >;

  /**
   * Lists the Gremlin graph under an existing Azure Cosmos DB database account.
   */
  listGremlinGraphs is ArmResourceListByParent<
    GremlinGraphGetResults,
    Response = ArmResponse<GremlinGraphListResult>
  >;

  /**
   * Retrieves continuous backup information for a gremlin graph.
   */
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    GremlinGraphGetResults,
    ContinuousBackupRestoreLocation,
    BackupInformation,
    Error = CloudError
  >;
}

@@doc(GremlinGraphGetResults.name, "Cosmos DB graph name.");
@@doc(GremlinGraphGetResults.properties,
  "The properties of an Azure Cosmos DB Gremlin graph"
);
@@doc(GremlinGraphGetResultsOperationGroup.createUpdateGremlinGraph::parameters.resource,
  "The parameters to provide for the current Gremlin graph."
);
@@doc(GremlinGraphGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "The name of the continuous backup restore location."
);
