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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
interface OpenAiCreateOrUpdateResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("monitors")
        @pattern("^.*$")
        monitorName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("openAIIntegrations")
        @pattern("^[a-z][a-z0-9]*$")
        integrationName: string,
      },
      ErrorType = ResourceProviderDefaultErrorResponse
    > {}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface OpenAIIntegrationRPModels {
  /**
   * Get detailed information about OpenAI integration rules for a given Elastic monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("OpenAI_Get")
  get is ArmResourceRead<
    OpenAIIntegrationRPModel,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Create or update an OpenAI integration rule for a given Elastic monitor resource, enabling advanced AI-driven observability and monitoring.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("OpenAI_CreateOrUpdate")
  createOrUpdate is OpenAiCreateOrUpdateResourceOps.CreateOrUpdateAsync<
    OpenAIIntegrationRPModel,
    Response = ArmResourceUpdatedResponse<OpenAIIntegrationRPModel> | ArmResourceCreatedResponse<
      OpenAIIntegrationRPModel,
      LroHeaders = {}
    >,
    OptionalRequestBody = true
  >;

  /**
   * Delete an OpenAI integration rule for a given Elastic monitor resource, removing AI-driven observability and monitoring capabilities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("OpenAI_Delete")
  delete is ArmResourceDeleteSync<
    OpenAIIntegrationRPModel,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * List all OpenAI integration rules for a given Elastic monitor resource, helping you manage AI-driven observability and monitoring.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("OpenAI_List")
  list is ArmResourceListByParent<
    OpenAIIntegrationRPModel,
    Response = ArmResponse<OpenAIIntegrationRPModelListResponse>,
    Error = ResourceProviderDefaultErrorResponse
  >;

  /**
   * Get the status of OpenAI integration for a given Elastic monitor resource, ensuring optimal observability and performance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
