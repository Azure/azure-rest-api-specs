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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlContainerGetResultsOperationGroup {
  /**
   * Gets the SQL container under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlContainer")
  getSqlContainer is ArmResourceRead<SqlContainerGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_CreateUpdateSqlContainer")
  createUpdateSqlContainer is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlContainerGetResults,
    Request = SqlContainerCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlContainerGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlContainerGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_DeleteSqlContainer")
  deleteSqlContainer is ArmResourceDeleteWithoutOkAsync<SqlContainerGetResults>;

  /**
   * Lists the SQL container under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_ListSqlContainers")
  listSqlContainers is ArmResourceListByParent<
    SqlContainerGetResults,
    Response = ArmResponse<SqlContainerListResult>
  >;

  /**
   * Merges the partitions of a SQL Container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_ListSqlContainerPartitionMerge")
  @action("partitionMerge")
  listSqlContainerPartitionMerge is ArmResourceActionAsync<
    SqlContainerGetResults,
    MergeParameters,
    ArmResponse<PhysicalPartitionStorageInfoCollection>
  >;

  /**
   * Retrieves continuous backup information for a container resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_RetrieveContinuousBackupInformation")
  retrieveContinuousBackupInformation is ArmResourceActionAsync<
    SqlContainerGetResults,
    ContinuousBackupRestoreLocation,
    ArmResponse<BackupInformation>,
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
