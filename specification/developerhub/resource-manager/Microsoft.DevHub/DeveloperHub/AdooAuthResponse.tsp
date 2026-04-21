import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevHub;
/**
 * Singleton response of ADO OAuth.
 */
@singleton("default")
@subscriptionResource
model AdooAuthResponse is Azure.ResourceManager.ProxyResource<AdooAuth> {
  ...ResourceNameParameter<
    Resource = AdooAuthResponse,
    KeyName = "adooauth",
    SegmentName = "adooauth",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AdooAuthResponses {
  /**
   * Callback URL to hit once authenticated with Entra ID to have the service store the OAuth token.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ADOOAuth_Get")
  get is ArmResourceRead<
    AdooAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Callback URL to hit once authenticated with ADO to have the service store the OAuth token.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ADOOAuth_List")
  list is ArmResourceListByParent<
    AdooAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<AdooAuthListResponse>
  >;

  /**
   * Gets ADOOAuth info used to authenticate users with ADO.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetADOOAuthInfo")
  getADOOAuthInfo is ArmResourceActionSync<
    AdooAuthResponse,
    AdooAuthCallRequest,
    ArmResponse<AdooAuthInfoResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    OptionalRequestBody = true
  >;
}

@@doc(AdooAuthResponse.name, "");
@@doc(AdooAuthResponse.properties, "Details of ADO OAuth.");
@@doc(AdooAuthResponses.getADOOAuthInfo::parameters.body,
  "The fields required in ADO OAuth call request."
);
