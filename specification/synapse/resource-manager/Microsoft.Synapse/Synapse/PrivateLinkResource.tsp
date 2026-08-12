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

namespace Microsoft.Synapse;
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

@armResourceOperations
interface PrivateLinkResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateLinkResource,
        KeyName = "privateLinkResourceName",
        SegmentName = "privateLinkResources",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateLinkResourceOperationGroup {
  /**
   * Get private link resource in workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_Get")
  get is PrivateLinkResourceOperationGroupOps.Read<PrivateLinkResource>;

  /**
   * Get all private link resources for a workspaces
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_List")
  list is PrivateLinkResourceOperationGroupOps.List<PrivateLinkResource>;
}
@armResourceOperations
interface PrivateLinkHubPrivateLinkResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = PrivateLinkHub,
          KeyName = "privateLinkHubName",
          SegmentName = "privateLinkHubs",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateLinkResource,
        KeyName = "privateLinkResourceName",
        SegmentName = "privateLinkResources",
        NamePattern = ""
      >>
    > {}

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
