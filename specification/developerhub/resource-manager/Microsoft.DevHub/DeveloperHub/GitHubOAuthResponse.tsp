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
 * Singleton response of GitHubOAuth containing
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@singleton("default")
@subscriptionResource
model GitHubOAuthResponse
  is Azure.ResourceManager.ProxyResource<GitHubOAuthProperties> {
  ...ResourceNameParameter<
    Resource = GitHubOAuthResponse,
    KeyName = "githuboauth",
    SegmentName = "githuboauth",
    NamePattern = ""
  >;
}

alias GitHubOAuthResponsesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;
    ...LocationParameter;
  },
  {
    /** undefined */
    @path
    @segment("githuboauth")
    default: "default";
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "GitHubOAuth naming is preserved for compatibility with the existing OAuth operation group."
@armResourceOperations(#{ omitTags: true })
interface GitHubOAuthResponses {
  /**
   * Callback URL to hit once authenticated with GitHub App to have the service store the OAuth token.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Callback URL to hit once authenticated with GitHub App to have the service store the OAuth token.")
  @tag("GitHubOAuth")
  gitHubOAuthCallback is GitHubOAuthResponsesOps.Read<
    GitHubOAuthResponse,
    Parameters = {
      /**
       * The code response from authenticating the GitHub App.
       */
      @query("code")
      code: string;

      /**
       * The state response from authenticating the GitHub App.
       */
      @query("state")
      state: string;
    }
  >;

  /**
   * Callback URL to hit once authenticated with GitHub App to have the service store the OAuth token.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Callback URL to hit once authenticated with GitHub App to have the service store the OAuth token.")
  @tag("GitHubOAuth")
  listGitHubOAuth is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    GitHubOAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<GitHubOAuthListResponse>,
    Parameters = {
      ...LocationResourceParameter;
    }
  >;

  /**
   * Gets GitHubOAuth info used to authenticate users with the Developer Hub GitHub App.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets GitHubOAuth info used to authenticate users with the Developer Hub GitHub App.")
  @tag("GitHubOAuth")
  @action("getGitHubOAuthInfo")
  gitHubOAuth is GitHubOAuthResponsesOps.ActionSync<
    GitHubOAuthResponse,
    GitHubOAuthCallRequest,
    ArmResponse<GitHubOAuthInfoResponse>,
    OptionalRequestBody = true
  >;
}

@@doc(GitHubOAuthResponse.name, "");
@@doc(GitHubOAuthResponse.properties, "Properties of a workflow.");
@@doc(GitHubOAuthResponses.gitHubOAuth::parameters.body, "");
