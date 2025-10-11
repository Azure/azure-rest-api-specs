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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface GremlinGraphGetResultsOperationGroup {
  /**
   * Gets the Gremlin graph under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_GetGremlinGraph")
  getGremlinGraph is ArmResourceRead<GremlinGraphGetResults>;

  /**
   * Create or update an Azure Cosmos DB Gremlin graph
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("GremlinResources_CreateUpdateGremlinGraph")
  createUpdateGremlinGraph is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    GremlinGraphGetResults,
    Request = GremlinGraphCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<GremlinGraphGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = GremlinGraphGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Gremlin graph.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_DeleteGremlinGraph")
  deleteGremlinGraph is ArmResourceDeleteWithoutOkAsync<GremlinGraphGetResults>;

  /**
   * Lists the Gremlin graph under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_ListGremlinGraphs")
  listGremlinGraphs is ArmResourceListByParent<
    GremlinGraphGetResults,
    Response = ArmResponse<GremlinGraphListResult>
  >;

  /**
   * Retrieves continuous backup information for a gremlin graph.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_RetrieveContinuousBackupInformation")
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
