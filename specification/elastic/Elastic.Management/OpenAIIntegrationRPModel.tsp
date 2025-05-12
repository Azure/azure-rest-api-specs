import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Elastic;
/**
 * Capture properties of Open AI resource Integration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@parentResource(ElasticMonitorResource)
model OpenAIIntegrationRPModel
  is Azure.ResourceManager.ProxyResource<OpenAIIntegrationProperties> {
  ...ResourceNameParameter<
    Resource = OpenAIIntegrationRPModel,
    KeyName = "integrationName",
    SegmentName = "openAIIntegrations",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface OpenAIIntegrationRPModels {
  /**
   * Get OpenAI integration rule for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OpenAI_Get")
  get is ArmResourceRead<
    OpenAIIntegrationRPModel,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update a OpenAI integration rule for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OpenAI_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<OpenAIIntegrationRPModel,Error = ResourceProviderDefaultErrorResponse>;

  /**
   * Delete OpenAI integration rule for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OpenAI_Delete")
  delete is ArmResourceDeleteSync<OpenAIIntegrationRPModel,Error = ResourceProviderDefaultErrorResponse>;

  /**
   * List OpenAI integration rule for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OpenAI_List")
  list is ArmResourceListByParent<
    OpenAIIntegrationRPModel,
    Response = ArmResponse<OpenAIIntegrationRPModelListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Get OpenAI integration status for a given integration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OpenAI_GetStatus")
  getStatus is ArmResourceActionSync<
    OpenAIIntegrationRPModel,
    void,
    ArmResponse<OpenAIIntegrationStatusResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;
}

@@doc(OpenAIIntegrationRPModel.name, "OpenAI Integration name");
@@doc(OpenAIIntegrationRPModel.properties, "Open AI Integration details.");
@@doc(OpenAIIntegrationRPModels.createOrUpdate::parameters.resource, "");
