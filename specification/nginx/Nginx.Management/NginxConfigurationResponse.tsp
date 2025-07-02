import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;

@parentResource(NginxDeployment)
model NginxConfigurationResponse
  is Azure.ResourceManager.ProxyResource<NginxConfigurationResponseProperties> {
  ...ResourceNameParameter<
    Resource = NginxConfigurationResponse,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NginxConfigurationResponses {
  /**
   * Get the NGINX configuration of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Configurations_Get")
  get is ArmResourceRead<NginxConfigurationResponse>;

  /**
   * Create or update the NGINX configuration for given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Configurations_CreateOrUpdate")
  @put
  createOrUpdate is Azure.ResourceManager.Legacy.UpdateOperation<
    ResourceInstanceParameters<
      NginxConfigurationResponse,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<NginxConfigurationResponse>
    >,
    NginxConfigurationRequest,
    NginxConfigurationResponse | ArmResourceCreatedResponse<
      NginxConfigurationResponse,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = NginxConfigurationResponse>
    >,
    ErrorResponse,
    OptionalRequestBody = true
  >;
  /**
   * Reset the NGINX configuration of given NGINX deployment to default
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Configurations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NginxConfigurationResponse,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List the NGINX configuration of given NGINX deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Configurations_List")
  list is ArmResourceListByParent<
    NginxConfigurationResponse,
    Response = ArmResponse<NginxConfigurationListResponse>
  >;

  /**
   * Analyze an NGINX configuration without applying it to the NGINXaaS deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("analyze")
  @operationId("Configurations_Analysis")
  analysis is ArmResourceActionSync<
    NginxConfigurationResponse,
    AnalysisCreate,
    ArmResponse<AnalysisResult>,
    OptionalRequestBody = true
  >;
}

@@doc(NginxConfigurationResponse.name,
  "The name of configuration, only 'default' is supported value due to the singleton of NGINX conf"
);
@@doc(NginxConfigurationResponse.properties, "");
@@doc(NginxConfigurationResponses.createOrUpdate::parameters.properties,
  "The NGINX configuration"
);
@@doc(NginxConfigurationResponses.analysis::parameters.body,
  "The NGINX configuration to analyze"
);
