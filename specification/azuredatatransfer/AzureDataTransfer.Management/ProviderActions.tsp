import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./action_models.tsp";
import "./versions.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AzureDataTransfer;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface corresponds to our Provider level actions, no decorator exists for that."
interface AzureDataTransfer {
  /**
   * Lists approved schemas for Azure Data Transfer.
   */
  @autoRoute
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @operationId("AzureDataTransfer_ValidateSchema")
  listApprovedSchemas is ArmProviderActionSync<
    Request = ListApprovedSchemasRequest,
    Response = SchemasListResult
  >;

  /**
   * Validates a schema for Azure Data Transfer.
   */
  @autoRoute
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @operationId("AzureDataTransfer_ValidateSchema")
  validateSchema is ArmProviderActionSync<
    Request = Schema,
    Response = ValidateSchemaResult
  >;
}
