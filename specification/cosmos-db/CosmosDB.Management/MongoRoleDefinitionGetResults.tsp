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
 * An Azure Cosmos DB Mongo Role Definition.
 */
@parentResource(DatabaseAccountGetResults)
model MongoRoleDefinitionGetResults
  is Azure.ResourceManager.ProxyResource<MongoRoleDefinitionResource> {
  ...ResourceNameParameter<
    Resource = MongoRoleDefinitionGetResults,
    KeyName = "mongoRoleDefinitionId",
    SegmentName = "mongodbRoleDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MongoRoleDefinitionGetResultsOperationGroup {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Mongo Role Definition with the given Id.
   */
  getMongoRoleDefinition is ArmResourceRead<
    MongoRoleDefinitionGetResults,
    Error = CloudError
  >;

  /**
   * Creates or updates an Azure Cosmos DB Mongo Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateMongoRoleDefinition is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoRoleDefinitionGetResults,
    Request = MongoRoleDefinitionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<MongoRoleDefinitionGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MongoRoleDefinitionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes an existing Azure Cosmos DB Mongo Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteMongoRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    MongoRoleDefinitionGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Mongo Role Definitions.
   */
  listMongoRoleDefinitions is ArmResourceListByParent<
    MongoRoleDefinitionGetResults,
    Response = ArmResponse<MongoRoleDefinitionListResult>,
    Error = CloudError
  >;
}

@@doc(MongoRoleDefinitionGetResults.name,
  "The ID for the Role Definition {dbName.roleName}."
);
@@doc(MongoRoleDefinitionGetResults.properties,
  "Properties related to the Mongo Role Definition."
);
@@doc(MongoRoleDefinitionGetResultsOperationGroup.createUpdateMongoRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
