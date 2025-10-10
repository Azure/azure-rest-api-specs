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
 * An Azure Cosmos DB Gremlin database.
 */
@parentResource(DatabaseAccountGetResults)
model GremlinDatabaseGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<GremlinDatabaseGetProperties> {
  ...ResourceNameParameter<
    Resource = GremlinDatabaseGetResults,
    KeyName = "databaseName",
    SegmentName = "gremlinDatabases",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface GremlinDatabaseGetResultsOperationGroup {
  /**
   * Gets the Gremlin databases under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_GetGremlinDatabase")
  getGremlinDatabase is ArmResourceRead<GremlinDatabaseGetResults>;

  /**
   * Create or update an Azure Cosmos DB Gremlin database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("GremlinResources_CreateUpdateGremlinDatabase")
  createUpdateGremlinDatabase is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    GremlinDatabaseGetResults,
    Request = GremlinDatabaseCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<GremlinDatabaseGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = GremlinDatabaseGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an existing Azure Cosmos DB Gremlin database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_DeleteGremlinDatabase")
  deleteGremlinDatabase is ArmResourceDeleteWithoutOkAsync<GremlinDatabaseGetResults>;

  /**
   * Lists the Gremlin databases under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_ListGremlinDatabases")
  listGremlinDatabases is ArmResourceListByParent<
    GremlinDatabaseGetResults,
    Response = ArmResponse<GremlinDatabaseListResult>
  >;
}

@@doc(GremlinDatabaseGetResults.name, "Cosmos DB database name.");
@@doc(GremlinDatabaseGetResults.properties,
  "The properties of an Azure Cosmos DB SQL database"
);
@@doc(GremlinDatabaseGetResultsOperationGroup.createUpdateGremlinDatabase::parameters.resource,
  "The parameters to provide for the current Gremlin database."
);
