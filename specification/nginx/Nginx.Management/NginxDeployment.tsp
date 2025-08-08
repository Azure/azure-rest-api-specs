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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;

  /**
   * Resource Sku
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ResourceSku;
}

@armResourceOperations
interface NginxDeployments {
  /**
   * Get the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Get")
  get is ArmResourceRead<NginxDeployment>;

  /**
   * Create or update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NginxDeployment>;

  /**
   * Update the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Update")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<NginxDeployment>;

  /**
   * List all NGINX deployments under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;

  /**
   * List the NGINX deployments resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_List")
  list is ArmListBySubscription<
    NginxDeployment,
    Response = ArmResponse<NginxDeploymentListResponse>
  >;

  /**
   * List Waf Policies of given Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WafPolicy_List")
  @get
  @action("wafPolicies")
  wafPolicyList is ArmResourceActionSync<
    NginxDeployment,
    void,
    ArmResponse<NginxDeploymentWafPolicyListResponse>
  >;

  /**
   * Get the Nginx Waf Policy of given Nginx deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DefaultWafPolicy_List")
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
