import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;
/**
 * Nginx Deployment Waf Policy
 */
@parentResource(NginxDeployment)
model NginxDeploymentWafPolicy
  is Azure.ResourceManager.ProxyResource<NginxDeploymentWafPolicyProperties> {
  ...ResourceNameParameter<
    Resource = NginxDeploymentWafPolicy,
    KeyName = "wafPolicyName",
    SegmentName = "wafPolicies",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;
}

@armResourceOperations
interface NginxDeploymentWafPolicies {
  /**
   * Get the Nginx Waf Policy of given Nginx deployment
   */
  get is ArmResourceRead<NginxDeploymentWafPolicy>;

  /**
   * Create or update the Nginx Waf Policy for given Nginx deployment
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ResourceGroup,
    NginxDeploymentWafPolicy,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = NginxDeploymentWafPolicy> &
      ArmLroLocationHeader<FinalResult = NginxDeploymentWafPolicy> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Reset the Nginx Waf Policy of given Nginx deployment to default
   */
  delete is ArmResourceDeleteWithoutOkAsync<NginxDeploymentWafPolicy>;

  /**
   * Analyze an Nginx Waf Policy
   */
  @added(Versions.v2025_11_01)
  @action("analyzeWafPolicy")
  analysis is ArmResourceActionSync<
    NginxDeploymentWafPolicy,
    NginxDeploymentWafPolicyAnalysisCreateRequest,
    ArmResponse<NginxDeploymentWafPolicyAnalysisResponse>,
    OptionalRequestBody = true
  >;
}

@@doc(NginxDeploymentWafPolicy.name, "The name of Waf Policy");
@@doc(NginxDeploymentWafPolicy.properties,
  "Nginx Deployment Waf Policy Properties"
);
