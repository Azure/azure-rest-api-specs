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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_Get")
  get is ArmResourceRead<NginxConfigurationResponse>;

  /**
   * Create or update the NGINX configuration for given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NginxConfigurationResponse>;

  /**
   * Reset the NGINX configuration of given NGINX deployment to default
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Configurations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NginxConfigurationResponse,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List the NGINX configuration of given NGINX deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_List")
  list is ArmResourceListByParent<
    NginxConfigurationResponse,
    Response = ArmResponse<NginxConfigurationListResponse>
  >;

  /**
   * Analyze an NGINX configuration without applying it to the NGINXaaS deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("analyze")
  @operationId("Configurations_Analysis")
  analysis is ArmResourceActionSync<
    NginxConfigurationResponse,
    {
      /**
       * The NGINX configuration to analyze
       */
      @bodyRoot
      body?: AnalysisCreate;
    },
    ArmResponse<AnalysisResult>
  >;
}

@@doc(NginxConfigurationResponse.name,
  "The name of configuration, only 'default' is supported value due to the singleton of NGINX conf"
);
@@doc(NginxConfigurationResponse.properties, "");
@@doc(NginxConfigurationResponses.createOrUpdate::parameters.resource,
  "The NGINX configuration"
);
