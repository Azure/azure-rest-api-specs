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

@armResourceOperations
interface GitHubOAuthResponses {
  /**
   * Callback URL to hit once authenticated with GitHub App to have the service store the OAuth token.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GitHubOAuthCallback")
  gitHubOAuthCallback is ArmResourceRead<
    GitHubOAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ListGitHubOAuth")
  listGitHubOAuth is ArmResourceListByParent<
    GitHubOAuthResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<GitHubOAuthListResponse>
  >;

  /**
   * Gets GitHubOAuth info used to authenticate users with the Developer Hub GitHub App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GitHubOAuth")
  @action("getGitHubOAuthInfo")
  gitHubOAuth is ArmResourceActionSync<
    GitHubOAuthResponse,
    GitHubOAuthCallRequest,
    ArmResponse<GitHubOAuthInfoResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    OptionalRequestBody = true
  >;
}

@@doc(GitHubOAuthResponse.name, "");
@@doc(GitHubOAuthResponse.properties, "Properties of a workflow.");
@@doc(GitHubOAuthResponses.gitHubOAuth::parameters.body, "");
