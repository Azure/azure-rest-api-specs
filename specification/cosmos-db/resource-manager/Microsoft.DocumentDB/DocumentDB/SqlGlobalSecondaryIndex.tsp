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
model SqlGlobalSecondaryIndex is ProxyResource<SqlContainerGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlGlobalSecondaryIndex,
    KeyName = "containerName",
    SegmentName = "globalSecondaryIndexes",
    NamePattern = ""
  >;
  ...PickProperties<SqlContainerGetResults, "location" | "tags" | "identity">;
}

/** Operations for Azure Cosmos DB SQL global secondary index containers. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Only container creation is supported on this endpoint; no delete operation is exposed."
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface SqlGlobalSecondaryIndexes {
  /** Creates or updates an Azure Cosmos DB SQL global secondary index container. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This endpoint follows the existing SQL container PUT contract, returning 200 or 202."
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlGlobalSecondaryIndex,
    Request = SqlContainerCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<SqlGlobalSecondaryIndex>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlGlobalSecondaryIndex> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(
  SqlGlobalSecondaryIndex.name,
  "Cosmos DB global secondary index container name."
);
@@doc(
  SqlGlobalSecondaryIndex.properties,
  "The properties of an Azure Cosmos DB SQL global secondary index container."
);
@@doc(
  SqlGlobalSecondaryIndexes.createOrUpdate::parameters.resource,
  "The parameters for the SQL global secondary index container."
);
