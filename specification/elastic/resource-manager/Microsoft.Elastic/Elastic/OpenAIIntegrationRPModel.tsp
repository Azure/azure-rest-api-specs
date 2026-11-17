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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface OpenAIIntegrationRPModels {
  /**
   * Get detailed information about OpenAI integration rules for a given Elastic monitor resource.
   */
  get is ArmResourceRead<
    OpenAIIntegrationRPModel,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update an OpenAI integration rule for a given Elastic monitor resource, enabling advanced AI-driven observability and monitoring.
   */
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    OpenAIIntegrationRPModel,
    Response =
      | ArmResourceUpdatedResponse<OpenAIIntegrationRPModel>
      | ArmResourceCreatedResponse<OpenAIIntegrationRPModel, LroHeaders = {}>,
    Error = ResourceProviderDefaultErrorResponse,
    OptionalRequestBody = true
  >;

  /**
   * Delete an OpenAI integration rule for a given Elastic monitor resource, removing AI-driven observability and monitoring capabilities.
   */
  delete is ArmResourceDeleteSync<
    OpenAIIntegrationRPModel,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all OpenAI integration rules for a given Elastic monitor resource, helping you manage AI-driven observability and monitoring.
   */
  list is ArmResourceListByParent<
    OpenAIIntegrationRPModel,
    Response = ArmResponse<OpenAIIntegrationRPModelListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Get the status of OpenAI integration for a given Elastic monitor resource, ensuring optimal observability and performance.
   */
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
