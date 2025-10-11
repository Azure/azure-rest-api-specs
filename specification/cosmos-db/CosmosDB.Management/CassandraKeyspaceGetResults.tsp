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
 * An Azure Cosmos DB Cassandra keyspace.
 */
@parentResource(DatabaseAccountGetResults)
model CassandraKeyspaceGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CassandraKeyspaceGetProperties> {
  ...ResourceNameParameter<
    Resource = CassandraKeyspaceGetResults,
    KeyName = "keyspaceName",
    SegmentName = "cassandraKeyspaces",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface CassandraKeyspaceGetResultsOperationGroup {
  /**
   * Gets the Cassandra keyspaces under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_GetCassandraKeyspace")
  getCassandraKeyspace is ArmResourceRead<CassandraKeyspaceGetResults>;

  /**
   * Create or update an Azure Cosmos DB Cassandra keyspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("CassandraResources_CreateUpdateCassandraKeyspace")
  createUpdateCassandraKeyspace is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    CassandraKeyspaceGetResults,
    Request = CassandraKeyspaceCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<CassandraKeyspaceGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CassandraKeyspaceGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra keyspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_DeleteCassandraKeyspace")
  deleteCassandraKeyspace is ArmResourceDeleteWithoutOkAsync<CassandraKeyspaceGetResults>;

  /**
   * Lists the Cassandra keyspaces under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_ListCassandraKeyspaces")
  listCassandraKeyspaces is ArmResourceListByParent<
    CassandraKeyspaceGetResults,
    Response = ArmResponse<CassandraKeyspaceListResult>
  >;
}

@@doc(CassandraKeyspaceGetResults.name, "Cosmos DB keyspace name.");
@@doc(CassandraKeyspaceGetResults.properties,
  "The properties of an Azure Cosmos DB Cassandra keyspace"
);
@@doc(CassandraKeyspaceGetResultsOperationGroup.createUpdateCassandraKeyspace::parameters.resource,
  "The parameters to provide for the current Cassandra keyspace."
);
