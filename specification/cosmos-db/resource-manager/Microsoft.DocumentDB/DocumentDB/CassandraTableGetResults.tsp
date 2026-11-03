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
  is Azure.ResourceManager.ProxyResource<CassandraTableGetProperties> {
  ...ResourceNameParameter<
    Resource = CassandraTableGetResults,
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
    Response =
      | ArmResourceUpdatedResponse<CassandraTableGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CassandraTableGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra table.
   */
  deleteCassandraTable is ArmResourceDeleteWithoutOkAsync<
    CassandraTableGetResults,
    Response =
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
      | NoContentResponse
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
@@doc(
  CassandraTableGetResults.properties,
  "The properties of an Azure Cosmos DB Cassandra table"
);
@@doc(
  CassandraTableGetResultsOperationGroup.createUpdateCassandraTable::parameters.resource,
  "The parameters to provide for the current Cassandra Table."
);
@@visibility(
  CassandraTableGetResults.location,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
