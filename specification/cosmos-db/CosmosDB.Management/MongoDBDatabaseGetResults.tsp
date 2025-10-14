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
 * An Azure Cosmos DB MongoDB database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(DatabaseAccountGetResults)
model MongoDBDatabaseGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<MongoDBDatabaseGetProperties> {
  ...ResourceNameParameter<
    Resource = MongoDBDatabaseGetResults,
    KeyName = "databaseName",
    SegmentName = "mongodbDatabases",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoDBDatabaseGetResultsOperationGroup {
  /**
   * Gets the MongoDB databases under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_GetMongoDBDatabase")
  getMongoDBDatabase is ArmResourceRead<MongoDBDatabaseGetResults>;

  /**
   * Create or updates Azure Cosmos DB MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_CreateUpdateMongoDBDatabase")
  createUpdateMongoDBDatabase is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoDBDatabaseGetResults,
    Request = MongoDBDatabaseCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<MongoDBDatabaseGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MongoDBDatabaseGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoDB database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_DeleteMongoDBDatabase")
  deleteMongoDBDatabase is ArmResourceDeleteWithoutOkAsync<MongoDBDatabaseGetResults>;

  /**
   * Lists the MongoDB databases under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_ListMongoDBDatabases")
  listMongoDBDatabases is ArmResourceListByParent<
    MongoDBDatabaseGetResults,
    Response = ArmResponse<MongoDBDatabaseListResult>
  >;

  /**
   * Merges the partitions of a MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_MongoDBDatabasePartitionMerge")
  @action("partitionMerge")
  mongoDBDatabasePartitionMerge is ArmResourceActionAsync<
    MongoDBDatabaseGetResults,
    MergeParameters,
    PhysicalPartitionStorageInfoCollection
  >;
}

@@doc(MongoDBDatabaseGetResults.name, "Cosmos DB database name.");
@@doc(MongoDBDatabaseGetResults.properties,
  "The properties of an Azure Cosmos DB MongoDB database"
);
@@doc(MongoDBDatabaseGetResultsOperationGroup.createUpdateMongoDBDatabase::parameters.resource,
  "The parameters to provide for the current MongoDB database."
);
@@doc(MongoDBDatabaseGetResultsOperationGroup.mongoDBDatabasePartitionMerge::parameters.body,
  "The parameters for the merge operation."
);
