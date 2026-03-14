import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevOpsConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * GitHub Owner resource.
 */
@parentResource(DevOpsConfiguration)
model GitHubOwner
  is Azure.ResourceManager.ProxyResource<GitHubOwnerProperties> {
  ...ResourceNameParameter<
    Resource = GitHubOwner,
    KeyName = "ownerName",
    SegmentName = "gitHubOwners",
    NamePattern = ""
  >;
}

alias GitHubOwnerOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The security connector name. */
    @path
    @segment("securityConnectors")
    @key
    securityConnectorName: string;

    @path
    @segment("devops")
    @key
    devop: "default";
  },
  {
    @path
    @segment("gitHubOwners")
    @key
    ownerName: string;
  }
>;

@armResourceOperations
interface GitHubOwners {
  /**
   * Returns a monitored GitHub owner.
   */
  get is GitHubOwnerOps.Read<GitHubOwner>;

  /**
   * Returns a list of GitHub owners onboarded to the connector.
   */
  list is GitHubOwnerOps.List<
    GitHubOwner,
    Response = ArmResponse<GitHubOwnerListResponse>
  >;
}

@@doc(GitHubOwner.name, "The GitHub owner name.");
@@doc(GitHubOwner.properties, "GitHub Owner properties.");
