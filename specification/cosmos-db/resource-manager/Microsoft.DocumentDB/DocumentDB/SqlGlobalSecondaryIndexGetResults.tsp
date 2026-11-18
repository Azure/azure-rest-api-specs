import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./SqlContainerGetResults.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DocumentDB;

/** An Azure Cosmos DB SQL global secondary index container. */
@added(Versions.v2026_09_01_preview)
@parentResource(SqlDatabaseGetResults)
model SqlGlobalSecondaryIndexGetResults
  is ProxyResource<SqlContainerGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlGlobalSecondaryIndexGetResults,
    KeyName = "containerName",
    SegmentName = "globalSecondaryIndexes",
    NamePattern = ""
  >;
  ...PickProperties<SqlContainerGetResults, "location" | "tags" | "identity">;
}

/** Operations for Azure Cosmos DB SQL global secondary index containers. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Only container creation is supported on this endpoint; no delete operation is exposed."
@added(Versions.v2026_09_01_preview)
@armResourceOperations(#{ omitTags: true })
interface SqlGlobalSecondaryIndexGetResultsOperationGroup {
  /** Creates or updates an Azure Cosmos DB SQL global secondary index container. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This endpoint follows the existing SQL container PUT contract, returning 200 or 202."
  createUpdateSqlGlobalSecondaryIndex is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlGlobalSecondaryIndexGetResults,
    Request = SqlContainerCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<SqlGlobalSecondaryIndexGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlGlobalSecondaryIndexGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(
  SqlGlobalSecondaryIndexGetResults.name,
  "Cosmos DB global secondary index container name."
);
@@doc(
  SqlGlobalSecondaryIndexGetResults.properties,
  "The properties of an Azure Cosmos DB SQL global secondary index container."
);
@@doc(
  SqlGlobalSecondaryIndexGetResultsOperationGroup.createUpdateSqlGlobalSecondaryIndex::parameters.resource,
  "The parameters for the SQL global secondary index container."
);
