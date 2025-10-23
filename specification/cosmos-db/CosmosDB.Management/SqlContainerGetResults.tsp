import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabaseGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB container.
 */
@parentResource(SqlDatabaseGetResults)
model SqlContainerGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlContainerGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlContainerGetResults,
    KeyName = "containerName",
    SegmentName = "containers",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlContainerGetResultsOperationGroup {
  /**
   * Gets the SQL container under an existing Azure Cosmos DB database account.
   */
  getSqlContainer is ArmResourceRead<SqlContainerGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlContainer is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlContainerGetResults,
    Request = SqlContainerCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlContainerGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlContainerGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL container.
   */
  deleteSqlContainer is ArmResourceDeleteWithoutOkAsync<
    SqlContainerGetResults,
    Response = NoContentResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the SQL container under an existing Azure Cosmos DB database account.
   */
  listSqlContainers is ArmResourceListByParent<
    SqlContainerGetResults,
    Response = ArmResponse<SqlContainerListResult>
  >;

  /**
   * Merges the partitions of a SQL Container
   */
  @action("partitionMerge")
  listSqlContainerPartitionMerge is ArmResourceActionAsyncBase<
    SqlContainerGetResults,
    MergeParameters,
    Response = ArmResponse<PhysicalPartitionStorageInfoCollection> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionStorageInfoCollection>>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlContainerGetResults>,
    Error = CloudError
  >;

  /**
   * Retrieves continuous backup information for a container resource.
   */
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    SqlContainerGetResults,
    ContinuousBackupRestoreLocation,
    BackupInformation,
    Error = CloudError
  >;
}

@@doc(SqlContainerGetResults.name, "Cosmos DB container name.");
@@doc(SqlContainerGetResults.properties,
  "The properties of an Azure Cosmos DB container"
);
@@doc(SqlContainerGetResultsOperationGroup.createUpdateSqlContainer::parameters.resource,
  "The parameters to provide for the current SQL container."
);
@@doc(SqlContainerGetResultsOperationGroup.listSqlContainerPartitionMerge::parameters.body,
  "The parameters for the merge operation."
);
@@doc(SqlContainerGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "The name of the continuous backup restore location."
);
