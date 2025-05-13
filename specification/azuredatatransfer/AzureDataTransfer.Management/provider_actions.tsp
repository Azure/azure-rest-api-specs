import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./action_models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;

interface AzureDataTransferOperationGroup {
  /**
   * Lists approved schemas for Azure Data Transfer.
   */
  @operationId("AzureDataTransfer_listApprovedSchemas")
  @autoRoute
  listApprovedSchemas is ArmProviderActionSync<
    Request = ListApprovedSchemasRequest,
    Response = SchemasListResult
  >;
  /**
   * Validates a schema for Azure Data Transfer.
   */
  @operationId("AzureDataTransfer_validateSchema")
  @autoRoute
  validateSchema is ArmProviderActionSync<
    Request = Schema,
    Response = ValidateSchemaResult
  >;
}
