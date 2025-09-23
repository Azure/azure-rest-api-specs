import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MongoDBDatabaseGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB MongoDB collection.
 */
@parentResource(MongoDBDatabaseGetResults)
model MongoDBCollectionGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<MongoDBCollectionGetProperties> {
  ...ResourceNameParameter<
    Resource = MongoDBCollectionGetResults,
    KeyName = "collectionName",
    SegmentName = "collections",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface MongoDBCollectionGetResultsOperationGroup {
  /**
   * Gets the MongoDB collection under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_GetMongoDBCollection")
  getMongoDBCollection is ArmResourceRead<MongoDBCollectionGetResults>;

  /**
   * Create or update an Azure Cosmos DB MongoDB Collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MongoDBResources_CreateUpdateMongoDBCollection")
  createUpdateMongoDBCollection is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoDBCollectionGetResults,
    Request = MongoDBCollectionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<MongoDBCollectionGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = MongoDBCollectionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoDB Collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_DeleteMongoDBCollection")
  deleteMongoDBCollection is ArmResourceDeleteWithoutOkAsync<MongoDBCollectionGetResults>;

  /**
   * Lists the MongoDB collection under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_ListMongoDBCollections")
  listMongoDBCollections is ArmResourceListByParent<
    MongoDBCollectionGetResults,
    Response = ArmResponse<MongoDBCollectionListResult>
  >;

  /**
   * Merges the partitions of a MongoDB Collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_ListMongoDBCollectionPartitionMerge")
  @action("partitionMerge")
  listMongoDBCollectionPartitionMerge is ArmResourceActionAsync<
    MongoDBCollectionGetResults,
    MergeParameters,
    ArmResponse<PhysicalPartitionStorageInfoCollection>
  >;

  /**
   * Retrieves continuous backup information for a Mongodb collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_RetrieveContinuousBackupInformation")
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    MongoDBCollectionGetResults,
    ContinuousBackupRestoreLocation,
    ArmResponse<BackupInformation>
  >;
}

@@doc(MongoDBCollectionGetResults.name, "Cosmos DB collection name.");
@@doc(MongoDBCollectionGetResults.properties,
  "The properties of an Azure Cosmos DB MongoDB collection"
);
@@doc(MongoDBCollectionGetResultsOperationGroup.createUpdateMongoDBCollection::parameters.resource,
  "The parameters to provide for the current MongoDB Collection."
);
@@doc(MongoDBCollectionGetResultsOperationGroup.listMongoDBCollectionPartitionMerge::parameters.body,
  "The parameters for the merge operation."
);
@@doc(MongoDBCollectionGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "The name of the continuous backup restore location."
);
