import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CassandraKeyspaceGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Cassandra table.
 */
@parentResource(CassandraKeyspaceGetResults)
model CassandraTableGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CassandraTableGetProperties> {
  ...ResourceNameParameter<
    Resource = CassandraTableGetResults,
    KeyName = "tableName",
    SegmentName = "tables",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface CassandraTableGetResultsOperationGroup {
  /**
   * Gets the Cassandra table under an existing Azure Cosmos DB database account.
   */
  getCassandraTable is ArmResourceRead<CassandraTableGetResults>;

  /**
   * Create or update an Azure Cosmos DB Cassandra Table
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateCassandraTable is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    CassandraTableGetResults,
    Request = CassandraTableCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<CassandraTableGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CassandraTableGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra table.
   */
  deleteCassandraTable is ArmResourceDeleteWithoutOkAsync<
    CassandraTableGetResults,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | NoContentResponse
  >;

  /**
   * Lists the Cassandra table under an existing Azure Cosmos DB database account.
   */
  listCassandraTables is ArmResourceListByParent<
    CassandraTableGetResults,
    Response = ArmResponse<CassandraTableListResult>
  >;
}

@@doc(CassandraTableGetResults.name, "Cosmos DB table name.");
@@doc(CassandraTableGetResults.properties,
  "The properties of an Azure Cosmos DB Cassandra table"
);
@@doc(CassandraTableGetResultsOperationGroup.createUpdateCassandraTable::parameters.resource,
  "The parameters to provide for the current Cassandra Table."
);
