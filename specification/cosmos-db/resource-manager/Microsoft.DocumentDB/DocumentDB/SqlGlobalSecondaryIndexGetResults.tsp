import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./SqlContainerGetResults.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DocumentDB;

/** Supplies the global secondary index route for the SQL container creation contract. */
@added(Versions.v2026_09_01_preview)
@parentResource(SqlDatabaseGetResults)
model SqlGlobalSecondaryIndexRoute is ProxyResource<SqlContainerGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlGlobalSecondaryIndexRoute,
    KeyName = "containerName",
    SegmentName = "globalSecondaryIndexes",
    NamePattern = ""
  >;
}

/** Operations for Azure Cosmos DB SQL global secondary index containers. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "This alternate route supports only container creation; no delete operation is exposed."
@added(Versions.v2026_09_01_preview)
@armResourceOperations(#{ omitTags: true })
interface SqlGlobalSecondaryIndexGetResultsOperationGroup {
  /** Creates or updates an Azure Cosmos DB SQL global secondary index container. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This endpoint reuses the SQL container PUT contract, including its 200 and 202 responses."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "The resource model supplies only the alternate route; the response intentionally reuses SqlContainerGetResults."
  createUpdateSqlGlobalSecondaryIndex is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlGlobalSecondaryIndexRoute,
    Request = SqlContainerCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<SqlContainerGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlContainerGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(SqlGlobalSecondaryIndexRoute.name, "Cosmos DB container name.");
@@doc(
  SqlGlobalSecondaryIndexGetResultsOperationGroup.createUpdateSqlGlobalSecondaryIndex::parameters.resource,
  "The parameters to provide for the current SQL container."
);
