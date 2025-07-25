// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface corresponds to our Provider level actions, no decorator exists for that."
interface AzureDataTransfer {
  /**
   * Lists approved schemas for Azure Data Transfer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @operationId("AzureDataTransfer_listApprovedSchemas")
  @autoRoute
  listApprovedSchemas is ArmProviderActionSync<
    Request = ListApprovedSchemasRequest,
    Response = SchemasListResult
  >;
  /**
   * Validates a schema for Azure Data Transfer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @operationId("AzureDataTransfer_validateSchema")
  @autoRoute
  validateSchema is ArmProviderActionSync<
    Request = Schema,
    Response = ValidateSchemaResult
  >;
}

@@clientName(AzureDataTransfer.listApprovedSchemas::parameters.body,
  "pipeline"
);
@@clientName(AzureDataTransfer.validateSchema::parameters.body, "schema");
@@doc(AzureDataTransfer.listApprovedSchemas::parameters.body,
  "The request to list approved schemas."
);
