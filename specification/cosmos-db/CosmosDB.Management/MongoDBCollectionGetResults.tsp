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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoDBCollectionGetResultsOperationGroup {
  /**
   * Gets the MongoDB collection under an existing Azure Cosmos DB database account.
   */
  getMongoDBCollection is ArmResourceRead<MongoDBCollectionGetResults>;

  /**
   * Create or update an Azure Cosmos DB MongoDB Collection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateMongoDBCollection is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoDBCollectionGetResults,
    Request = MongoDBCollectionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<MongoDBCollectionGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MongoDBCollectionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoDB Collection.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteMongoDBCollection is ArmResourceDeleteWithoutOkAsync<
    MongoDBCollectionGetResults,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | NoContentResponse
  >;

  /**
   * Lists the MongoDB collection under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listMongoDBCollections is ArmResourceListByParent<
    MongoDBCollectionGetResults,
    Response = ArmResponse<MongoDBCollectionListResult>
  >;

  /**
   * Merges the partitions of a MongoDB Collection
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("partitionMerge")
  listMongoDBCollectionPartitionMerge is ArmResourceActionAsyncBase<
    MongoDBCollectionGetResults,
    MergeParameters,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MongoDBCollectionGetResults>,
    Response = ArmResponse<PhysicalPartitionStorageInfoCollection> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionStorageInfoCollection> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Retrieves continuous backup information for a Mongodb collection.
   */
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    MongoDBCollectionGetResults,
    ContinuousBackupRestoreLocation,
    BackupInformation,
    Error = CloudError
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
