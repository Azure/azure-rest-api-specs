// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Microsoft.AzureDataTransfer;

/**
 * AzureDataTransfer interface defines provider-level operations for managing
 * schemas and FlowProfiles in Azure Data Transfer.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface corresponds to our Provider level actions, no decorator exists for that."
interface AzureDataTransfer {
  /**
   * Retrieves the list of approved schemas available for Azure Data Transfer. This operation has reached end of life support starting version 2025-05-30-preview. For schema support please create and use a FlowProfile resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Operation Id generated does not match original OpenAPIv2 JSON specification."
  @operationId("AzureDataTransfer_listApprovedSchemas")
  @autoRoute
  listApprovedSchemas is ArmProviderActionSync<
    Request = ListApprovedSchemasRequest,
    Response = SchemasListResult
  >;

  /**
   * Retrieves a list of FlowProfile resources associated with a specified pipeline.
   */
  @added(Versions.v2025_05_30_preview)
  @autoRoute
  listFlowProfiles is ArmProviderActionSync<
    Request = ListFlowProfilesRequest,
    Response = {
      /**
       * A list of FlowProfile metadata created under the specified pipeline.
       */
      @added(Versions.v2025_05_30_preview)
      @bodyRoot
      flowProfileList?: FlowProfileMetadata[];
    }
  >;

  /**
   * Validates the structure and content of a schema for use in Azure Data Transfer. This operation has reached end of life support starting version 2025-05-30-preview. For schema support please create and use a FlowProfile resource.
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
  "The request payload for listing approved schemas."
);
