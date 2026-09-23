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
 * An Azure Cosmos DB Table.
 */
@parentResource(DatabaseAccountGetResults)
model TableGetResults
  is Azure.ResourceManager.ProxyResource<TableGetProperties> {
  ...ResourceNameParameter<
    Resource = TableGetResults,
    KeyName = "tableName",
    SegmentName = "tables",
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

@armResourceOperations(#{ omitTags: true })
interface TableGetResultsOperationGroup {
  /**
   * Gets the Tables under an existing Azure Cosmos DB database account with the provided name.
   */
  getTable is ArmResourceRead<TableGetResults>;

  /**
   * Create or update an Azure Cosmos DB Table
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateTable is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    TableGetResults,
    Request = TableCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<TableGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = TableGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Table.
   */
  deleteTable is ArmResourceDeleteWithoutOkAsync<
    TableGetResults,
    Response =
      | NoContentResponse
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the Tables under an existing Azure Cosmos DB database account.
   */
  listTables is ArmResourceListByParent<
    TableGetResults,
    Response = ArmResponse<TableListResult>
  >;

  /**
   * Retrieves continuous backup information for a table.
   */
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    TableGetResults,
    ContinuousBackupRestoreLocation,
    BackupInformation,
    Error = CloudError
  >;
}

@@doc(TableGetResults.name, "Cosmos DB table name.");
@@doc(TableGetResults.properties, "The properties of an Azure Cosmos DB Table");
@@doc(
  TableGetResultsOperationGroup.createUpdateTable::parameters.resource,
  "The parameters to provide for the current Table."
);
@@doc(
  TableGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "The name of the continuous backup restore location."
);
@@visibility(
  TableGetResults.location,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
