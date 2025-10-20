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
 * An Azure Cosmos DB Cassandra view.
 */
@parentResource(CassandraKeyspaceGetResults)
model CassandraViewGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CassandraViewGetProperties> {
  ...ResourceNameParameter<
    Resource = CassandraViewGetResults,
    KeyName = "viewName",
    SegmentName = "views",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface CassandraViewGetResultsOperationGroup {
  /**
   * Gets the Cassandra view under an existing Azure Cosmos DB database account.
   */
  getCassandraView is ArmResourceRead<CassandraViewGetResults>;

  /**
   * Create or update an Azure Cosmos DB Cassandra View
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateCassandraView is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    CassandraViewGetResults,
    Request = CassandraViewCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<CassandraViewGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CassandraViewGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra view.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteCassandraView is ArmResourceDeleteWithoutOkAsync<
    CassandraViewGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the Cassandra materialized views under an existing Azure Cosmos DB database account.
   */
  listCassandraViews is ArmResourceListByParent<
    CassandraViewGetResults,
    Response = ArmResponse<CassandraViewListResult>
  >;
}

@@doc(CassandraViewGetResults.name, "Cosmos DB view name.");
@@doc(CassandraViewGetResults.properties,
  "The properties of an Azure Cosmos DB Cassandra view"
);
@@doc(CassandraViewGetResultsOperationGroup.createUpdateCassandraView::parameters.resource,
  "The parameters to provide for the current Cassandra View."
);
