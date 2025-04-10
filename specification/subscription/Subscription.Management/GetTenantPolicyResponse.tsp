import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Subscription;
/**
 * Tenant policy Information.
 */
@singleton("default")
@tenantResource
model GetTenantPolicyResponse
  is Azure.ResourceManager.ProxyResource<TenantPolicy> {
  ...ResourceNameParameter<
    Resource = GetTenantPolicyResponse,
    KeyName = "policy",
    SegmentName = "policies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GetTenantPolicyResponses {
  /**
   * Get the subscription tenant policy for the user's tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionPolicy_GetPolicyForTenant")
  getPolicyForTenant is ArmResourceRead<
    GetTenantPolicyResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or Update Subscription tenant policy for user's tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SubscriptionPolicy_AddUpdatePolicyForTenant")
  addUpdatePolicyForTenant is ArmResourceCreateOrReplaceSync<
    GetTenantPolicyResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<GetTenantPolicyResponse>
  >;

  /**
   * Get the subscription tenant policy for the user's tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionPolicy_ListPolicyForTenant")
  listPolicyForTenant is ArmResourceListByParent<
    GetTenantPolicyResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<GetTenantPolicyListResponse>
  >;
}

@@doc(GetTenantPolicyResponse.name, "");
@@doc(GetTenantPolicyResponse.properties, "Tenant policy properties.");
@@doc(GetTenantPolicyResponses.addUpdatePolicyForTenant::parameters.resource,
  ""
);
