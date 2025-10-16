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
 * Parameters to create and update an Azure Cosmos DB Table Role Definition.
 */
@parentResource(DatabaseAccountGetResults)
model TableRoleDefinitionResource
  is Azure.ResourceManager.ProxyResource<TableRoleDefinitionResourceProperties> {
  ...ResourceNameParameter<
    Resource = TableRoleDefinitionResource,
    KeyName = "roleDefinitionId",
    SegmentName = "tableRoleDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TableRoleDefinitionResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Table Role Definition with the given Id.
   */
  getTableRoleDefinition is ArmResourceRead<TableRoleDefinitionResource>;

  /**
   * Creates or updates an Azure Cosmos DB Table Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateTableRoleDefinition is ArmResourceCreateOrReplaceAsync<
    TableRoleDefinitionResource,
    Response = ArmResourceUpdatedResponse<TableRoleDefinitionResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = TableRoleDefinitionResource>>,
    LroHeaders = ArmLroLocationHeader<FinalResult = TableRoleDefinitionResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an existing Azure Cosmos DB Table Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteTableRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    TableRoleDefinitionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Table Role Definitions.
   */
  listTableRoleDefinitions is ArmResourceListByParent<
    TableRoleDefinitionResource,
    Response = TableRoleDefinitionListResult
  >;
}

@@doc(TableRoleDefinitionResource.name, "The GUID for the Role Definition.");
@@doc(TableRoleDefinitionResource.properties,
  "Properties to create and update an Azure Cosmos DB Table Role Definition."
);
@@doc(TableRoleDefinitionResources.createUpdateTableRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
