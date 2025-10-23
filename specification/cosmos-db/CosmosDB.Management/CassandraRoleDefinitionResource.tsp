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
 * Parameters to create and update an Azure Cosmos DB Cassandra Role Definition.
 */
@parentResource(DatabaseAccountGetResults)
model CassandraRoleDefinitionResource
  is Azure.ResourceManager.ProxyResource<CassandraRoleDefinitionResourceProperties> {
  ...ResourceNameParameter<
    Resource = CassandraRoleDefinitionResource,
    KeyName = "roleDefinitionId",
    SegmentName = "cassandraRoleDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CassandraRoleDefinitionResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Cassandra Role Definition with the given Id.
   */
  getCassandraRoleDefinition is ArmResourceRead<CassandraRoleDefinitionResource>;

  /**
   * Creates or updates an Azure Cosmos DB Cassandra Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateCassandraRoleDefinition is ArmResourceCreateOrReplaceAsync<
    CassandraRoleDefinitionResource,
    Response = ArmResourceUpdatedResponse<CassandraRoleDefinitionResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CassandraRoleDefinitionResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteCassandraRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    CassandraRoleDefinitionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Cassandra Role Definitions.
   */
  listCassandraRoleDefinitions is ArmResourceListByParent<CassandraRoleDefinitionResource>;
}

@@doc(CassandraRoleDefinitionResource.name,
  "The GUID for the Role Definition."
);
@@doc(CassandraRoleDefinitionResource.properties,
  "Properties to create and update an Azure Cosmos DB Cassandra Role Definition."
);
@@doc(CassandraRoleDefinitionResources.createUpdateCassandraRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
