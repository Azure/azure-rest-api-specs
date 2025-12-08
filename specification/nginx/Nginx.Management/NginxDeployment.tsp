import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;
/**
 * Nginx Deployment
 */
model NginxDeployment
  is Azure.ResourceManager.TrackedResource<NginxDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = NginxDeployment,
    KeyName = "deploymentName",
    SegmentName = "nginxDeployments",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;

  /**
   * Identity Properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;

  /**
   * Resource Sku
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
}

@armResourceOperations
interface NginxDeployments {
  /**
   * Get the NGINX deployment
   */
  get is ArmResourceRead<NginxDeployment>;

  /**
   * Create or update the NGINX deployment
   */
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ResourceGroup,
    NginxDeployment,
    OptionalRequestBody = true
  >;

  /**
   * Update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    NginxDeployment,
    PatchModel = NginxDeploymentUpdateParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = NginxDeployment> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Delete the NGINX deployment resource
   */
  delete is ArmResourceDeleteWithoutOkAsync<NginxDeployment>;

  /**
   * List all NGINX deployments under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;

  /**
   * List the NGINX deployments resources
   */
  list is ArmListBySubscription<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;

  /**
   * List Waf Policies of given Nginx deployment
   */
  @get
  @list
  @action("wafPolicies")
  wafPolicyList is ArmResourceActionSync<
    NginxDeployment,
    void,
    ArmResponse<NginxDeploymentWafPolicyListResponse>
  >;

  /**
   * Get the Nginx Waf Policy of given Nginx deployment
   */
  @action("listDefaultWafPolicies")
  defaultWafPolicyList is ArmResourceActionSync<
    NginxDeployment,
    void,
    ArmResponse<NginxDeploymentDefaultWafPolicyListResponse>
  >;
}

@@doc(NginxDeployment.name, "The name of targeted NGINX deployment");
@@doc(NginxDeployment.properties, "Nginx Deployment Properties");
@@doc(NginxDeployments.createOrUpdate::parameters.resource,
  "The Nginx deployment"
);
@@doc(NginxDeployments.update::parameters.properties,
  "The Nginx deployment update parameters"
);
