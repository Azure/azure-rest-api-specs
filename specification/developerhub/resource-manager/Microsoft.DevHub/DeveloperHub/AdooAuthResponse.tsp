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
model AdooAuthResponse is Azure.ResourceManager.ProxyResource<ADOOAuth> {
  ...ResourceNameParameter<
    Resource = AdooAuthResponse,
    KeyName = "adooauth",
    SegmentName = "adooauth",
    NamePattern = ""
  >;
}

alias AdooAuthResponsesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
    ...LocationParameter;
  },
  {
    /** undefined */
    @path
    @segment("adooauth")
    default: "default";
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AdooAuthResponses {
  /**
   * Callback URL to hit once authenticated with Entra ID to have the service store the OAuth token.
   */
  @summary("Callback URL to hit once authenticated with Entra ID to have the service store the OAuth token.")
  @tag("ADOOAuth")
  get is AdooAuthResponsesOps.Read<AdooAuthResponse>;

  /**
   * Callback URL to hit once authenticated with ADO to have the service store the OAuth token.
   */
  @summary("Callback URL to hit once authenticated with ADO to have the service store the OAuth token.")
  @tag("ADOOAuth")
  list is ArmResourceListByParent<
    AdooAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      ...LocationParameter;
    },
    Response = ArmResponse<AdooAuthListResponse>
  >;

  /**
   * Gets ADOOAuth info used to authenticate users with ADO.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets ADOOAuth info used to authenticate users with ADO.")
  @tag("ADOOAuth")
  @operationId("GetADOOAuthInfo")
  getADOOAuthInfo is AdooAuthResponsesOps.ActionSync<
    AdooAuthResponse,
    AdooAuthCallRequest,
    Response = ArmResponse<AdooAuthInfoResponse>,
    OptionalRequestBody = true
  >;
}

@@doc(AdooAuthResponse.name, "");
@@doc(AdooAuthResponse.properties, "Details of ADO OAuth.");
@@doc(
  AdooAuthResponses.getADOOAuthInfo::parameters.body,
  "The fields required in ADO OAuth call request."
);
