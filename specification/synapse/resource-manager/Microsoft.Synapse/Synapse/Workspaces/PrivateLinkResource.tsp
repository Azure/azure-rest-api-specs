import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Workspaces;
/**
 * A private link resource
 */
@parentResource(Workspace)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

alias PrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;
  },
  {
    /** The name of the private link resource */
    @path
    @segment("privateLinkResources")
    @key
    privateLinkResourceName: string;
  }
>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Get private link resource in workspace
   */
  get is PrivateLinkResourceOps.Read<PrivateLinkResource>;

  /**
   * Get all private link resources for a workspaces
   */
  list is PrivateLinkResourceOps.List<PrivateLinkResource>;
}
alias PrivateLinkHubPrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the private link hub */
    @path
    @segment("privateLinkHubs")
    @key
    privateLinkHubName: string;
  },
  {
    /** The name of the private link resource */
    @path
    @segment("privateLinkResources")
    @key
    privateLinkResourceName: string;
  }
>;

@armResourceOperations
interface PrivateLinkHubPrivateLinkResources {
  /**
   * Get private link resource in private link hub
   */
  get is PrivateLinkHubPrivateLinkResourceOps.Read<PrivateLinkResource>;

  /**
   * Get all private link resources for a private link hub
   */
  list is PrivateLinkHubPrivateLinkResourceOps.List<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource");
@@doc(PrivateLinkResource.properties, "The private link resource properties.");
