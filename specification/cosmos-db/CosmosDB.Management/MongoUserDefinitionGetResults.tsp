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
 * An Azure Cosmos DB User Definition
 */
@parentResource(DatabaseAccountGetResults)
model MongoUserDefinitionGetResults
  is Azure.ResourceManager.ProxyResource<MongoUserDefinitionResource> {
  ...ResourceNameParameter<
    Resource = MongoUserDefinitionGetResults,
    KeyName = "mongoUserDefinitionId",
    SegmentName = "mongodbUserDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MongoUserDefinitionGetResultsOperationGroup {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Mongo User Definition with the given Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_GetMongoUserDefinition")
  getMongoUserDefinition is ArmResourceRead<MongoUserDefinitionGetResults>;

  /**
   * Creates or updates an Azure Cosmos DB Mongo User Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_CreateUpdateMongoUserDefinition")
  createUpdateMongoUserDefinition is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MongoUserDefinitionGetResults,
    Request = MongoUserDefinitionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<MongoUserDefinitionGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MongoUserDefinitionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Mongo User Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_DeleteMongoUserDefinition")
  deleteMongoUserDefinition is ArmResourceDeleteWithoutOkAsync<
    MongoUserDefinitionGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Mongo User Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoDBResources_ListMongoUserDefinitions")
  listMongoUserDefinitions is ArmResourceListByParent<
    MongoUserDefinitionGetResults,
    Response = ArmResponse<MongoUserDefinitionListResult>
  >;
}

@@doc(MongoUserDefinitionGetResults.name,
  "The ID for the User Definition {dbName.userName}."
);
@@doc(MongoUserDefinitionGetResults.properties,
  "Properties related to the User Definition."
);
@@doc(MongoUserDefinitionGetResultsOperationGroup.createUpdateMongoUserDefinition::parameters.resource,
  "The properties required to create or update a User Definition."
);
