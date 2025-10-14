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
 * Parameters to create and update an Azure Cosmos DB MongoMI Role Definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(DatabaseAccountGetResults)
model MongoMIRoleDefinitionResource
  is Azure.ResourceManager.ProxyResource<MongoMIRoleDefinitionResourceProperties> {
  ...ResourceNameParameter<
    Resource = MongoMIRoleDefinitionResource,
    KeyName = "roleDefinitionId",
    SegmentName = "mongoMIRoleDefinitions",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoMIRoleDefinitionResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB MongoMI Role Definition with the given Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoMIResources_GetMongoMIRoleDefinition")
  getMongoMIRoleDefinition is ArmResourceRead<MongoMIRoleDefinitionResource>;

  /**
   * Creates or updates an Azure Cosmos DB MongoMI Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoMIResources_CreateUpdateMongoMIRoleDefinition")
  createUpdateMongoMIRoleDefinition is ArmResourceCreateOrReplaceAsync<
    MongoMIRoleDefinitionResource,
    Response = ArmResourceUpdatedResponse<MongoMIRoleDefinitionResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MongoMIRoleDefinitionResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoMI Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoMIResources_DeleteMongoMIRoleDefinition")
  deleteMongoMIRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    MongoMIRoleDefinitionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB MongoMI Role Definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("MongoMIResources_ListMongoMIRoleDefinitions")
  listMongoMIRoleDefinitions is ArmResourceListByParent<MongoMIRoleDefinitionResource>;
}

@@doc(MongoMIRoleDefinitionResource.name, "The GUID for the Role Definition.");
@@doc(MongoMIRoleDefinitionResource.properties,
  "Properties to create and update an Azure Cosmos DB MongoMI Role Definition."
);
@@doc(MongoMIRoleDefinitionResources.createUpdateMongoMIRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
