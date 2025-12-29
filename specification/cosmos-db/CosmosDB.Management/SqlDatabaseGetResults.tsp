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
 * An Azure Cosmos DB SQL database.
 */
@parentResource(DatabaseAccountGetResults)
model SqlDatabaseGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlDatabaseGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlDatabaseGetResults,
    KeyName = "databaseName",
    SegmentName = "sqlDatabases",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlResources {
  /**
   * Gets the SQL database under an existing Azure Cosmos DB database account with the provided name.
   */
  getSqlDatabase is ArmResourceRead<SqlDatabaseGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlDatabase is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlDatabaseGetResults,
    Request = SqlDatabaseCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlDatabaseGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlDatabaseGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL database.
   */
  deleteSqlDatabase is ArmResourceDeleteWithoutOkAsync<
    SqlDatabaseGetResults,
    Response = NoContentResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the SQL databases under an existing Azure Cosmos DB database account.
   */
  listSqlDatabases is ArmResourceListByParent<
    SqlDatabaseGetResults,
    Response = ArmResponse<SqlDatabaseListResult>
  >;

  /**
   * Merges the partitions of a SQL database
   */
  @action("partitionMerge")
  sqlDatabasePartitionMerge is ArmResourceActionAsyncBase<
    SqlDatabaseGetResults,
    MergeParameters,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlDatabaseGetResults>,
    Response = ArmResponse<PhysicalPartitionStorageInfoCollection> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionStorageInfoCollection> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;
}

@@doc(SqlDatabaseGetResults.name, "Cosmos DB database name.");
@@doc(SqlDatabaseGetResults.properties,
  "The properties of an Azure Cosmos DB SQL database"
);
@@doc(SqlResources.createUpdateSqlDatabase::parameters.resource,
  "The parameters to provide for the current SQL database."
);
@@doc(SqlResources.sqlDatabasePartitionMerge::parameters.body,
  "The parameters for the merge operation."
);
