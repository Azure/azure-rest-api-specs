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
 * Parameters to create and update an Azure Cosmos DB Gremlin Role Definition.
 */
@parentResource(DatabaseAccountGetResults)
model GremlinRoleDefinitionResource
  is Azure.ResourceManager.ProxyResource<GremlinRoleDefinitionResourceProperties> {
  ...ResourceNameParameter<
    Resource = GremlinRoleDefinitionResource,
    KeyName = "roleDefinitionId",
    SegmentName = "gremlinRoleDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GremlinRoleDefinitionResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Gremlin Role Definition with the given Id.
   */
  getGremlinRoleDefinition is ArmResourceRead<GremlinRoleDefinitionResource>;

  /**
   * Creates or updates an Azure Cosmos DB Gremlin Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateGremlinRoleDefinition is ArmResourceCreateOrReplaceAsync<
    GremlinRoleDefinitionResource,
    Response = ArmResourceUpdatedResponse<GremlinRoleDefinitionResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GremlinRoleDefinitionResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Gremlin Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteGremlinRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    GremlinRoleDefinitionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Gremlin Role Definitions.
   */
  listGremlinRoleDefinitions is ArmResourceListByParent<GremlinRoleDefinitionResource>;
}

@@doc(GremlinRoleDefinitionResource.name, "The GUID for the Role Definition.");
@@doc(GremlinRoleDefinitionResource.properties,
  "Properties to create and update an Azure Cosmos DB Gremlin Role Definition."
);
@@doc(GremlinRoleDefinitionResources.createUpdateGremlinRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
