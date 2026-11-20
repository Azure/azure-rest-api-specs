import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB MongoDB database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(DatabaseAccountGetResults)
model MongoDBDatabaseGetResults
  is Azure.ResourceManager.ProxyResource<MongoDBDatabaseGetProperties> {
  ...ResourceNameParameter<
    Resource = MongoDBDatabaseGetResults,
    KeyName = "databaseName",
    SegmentName = "mongodbDatabases",
    NamePattern = ""
  >;

  /** The location of the resource group to which the resource belongs. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /** Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with \"defaultExperience\": \"Cassandra\". Current \"defaultExperience\" values also include \"Table\", \"Graph\", \"DocumentDB\", and \"MongoDB\". */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface MongoDBDatabaseGetResultsOperationGroup {
  /**
   * Gets the MongoDB databases under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getMongoDBDatabase is ArmResourceRead<MongoDBDatabaseGetResults>;

  /**
   * Create or updates Azure Cosmos DB MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateMongoDBDatabase is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoDBDatabaseGetResults,
    Request = MongoDBDatabaseCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<MongoDBDatabaseGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MongoDBDatabaseGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoDB database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteMongoDBDatabase is ArmResourceDeleteWithoutOkAsync<
    MongoDBDatabaseGetResults,
    Response =
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
      | NoContentResponse
  >;

  /**
   * Lists the MongoDB databases under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listMongoDBDatabases is ArmResourceListByParent<
    MongoDBDatabaseGetResults,
    Response = ArmResponse<MongoDBDatabaseListResult>
  >;

  /**
   * Merges the partitions of a MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_04_01_preview)
  @action("partitionMerge")
  mongoDBDatabasePartitionMerge is ArmResourceActionAsyncBase<
    MongoDBDatabaseGetResults,
    MergeParameters,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<PhysicalPartitionStorageInfoCollection>,
    Response =
      | ArmResponse<PhysicalPartitionStorageInfoCollection>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionStorageInfoCollection> &
          Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;
}

@@doc(MongoDBDatabaseGetResults.name, "Cosmos DB database name.");
@@doc(
  MongoDBDatabaseGetResults.properties,
  "The properties of an Azure Cosmos DB MongoDB database"
);
@@doc(
  MongoDBDatabaseGetResultsOperationGroup.createUpdateMongoDBDatabase::parameters.resource,
  "The parameters to provide for the current MongoDB database."
);
@@doc(
  MongoDBDatabaseGetResultsOperationGroup.mongoDBDatabasePartitionMerge::parameters.body,
  "The parameters for the merge operation."
);
@@visibility(
  MongoDBDatabaseGetResults.location,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
