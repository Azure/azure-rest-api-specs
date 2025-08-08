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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WafPolicy_Get")
  get is ArmResourceRead<NginxDeploymentWafPolicy>;

  /**
   * Create or update the Nginx Waf Policy for given Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WafPolicy_Create")
  create is ArmResourceCreateOrReplaceAsync<NginxDeploymentWafPolicy>;

  /**
   * Reset the Nginx Waf Policy of given Nginx deployment to default
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WafPolicy_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<NginxDeploymentWafPolicy>;
}

@@doc(NginxDeploymentWafPolicy.name, "The name of Waf Policy");
@@doc(NginxDeploymentWafPolicy.properties,
  "Nginx Deployment Waf Policy Properties"
);
@@doc(NginxDeploymentWafPolicies.create::parameters.resource,
  "The Nginx Deployment Waf Policy"
);
