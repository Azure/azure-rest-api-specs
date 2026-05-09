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
 * Subscription Information with the alias.
 */
@tenantResource
model SubscriptionAliasResponse
  is Azure.ResourceManager.ProxyResource<SubscriptionAliasResponseProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionAliasResponse,
    KeyName = "aliasName",
    SegmentName = "aliases",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SubscriptionAliasResponses {
  /**
   * Get Alias Subscription.
   */
  get is ArmResourceRead<
    SubscriptionAliasResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create Alias Subscription.
   */
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SubscriptionAliasResponse,
    Request = PutAliasRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = SubscriptionAliasResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Alias.
   */
  delete is ArmResourceDeleteSync<
    SubscriptionAliasResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List Alias Subscription.
   */
  list is ArmResourceListByParent<
    SubscriptionAliasResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<SubscriptionAliasListResult>
  >;
}

@@doc(SubscriptionAliasResponse.name,
  "AliasName is the name for the subscription creation request. Note that this is not the same as subscription name and this doesn’t have any other lifecycle need beyond the request for subscription creation."
);
@@doc(SubscriptionAliasResponse.properties,
  "Subscription Alias response properties."
);
@@doc(SubscriptionAliasResponses.create::parameters.resource, "");
