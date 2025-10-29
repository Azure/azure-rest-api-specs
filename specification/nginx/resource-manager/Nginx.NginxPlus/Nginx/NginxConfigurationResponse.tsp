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
/**
 * Nginx Configuration Response
 */
@parentResource(NginxDeployment)
model NginxConfigurationResponse
  is Azure.ResourceManager.ProxyResource<NginxConfigurationResponseProperties> {
  ...ResourceNameParameter<
    Resource = NginxConfigurationResponse,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface NginxConfigurationResponses {
  /**
   * Get the NGINX configuration of given NGINX deployment
   */
  get is ArmResourceRead<NginxConfigurationResponse>;

  /**
   * Create or update the NGINX configuration for given NGINX deployment
   */
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ResourceGroup,
    NginxConfigurationResponse,
    NginxConfigurationRequest,
    OptionalRequestBody = true
  >;

  /**
   * Reset the NGINX configuration of given NGINX deployment to default
   */
  delete is ArmResourceDeleteWithoutOkAsync<NginxConfigurationResponse>;

  /**
   * List the NGINX configuration of given NGINX deployment.
   */
  list is ArmResourceListByParent<
    NginxConfigurationResponse,
    Response = ArmResponse<NginxConfigurationListResponse>
  >;

  /**
   * Analyze an NGINX configuration without applying it to the NGINXaaS deployment
   */
  @action("analyze")
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
@@doc(NginxConfigurationResponse.properties,
  "Nginx Configuration Response Properties"
);
@@doc(NginxConfigurationResponses.createOrUpdate::parameters.resource,
  "The NGINX configuration"
);
@@doc(NginxConfigurationResponses.analysis::parameters.body,
  "The NGINX configuration to analyze"
);
