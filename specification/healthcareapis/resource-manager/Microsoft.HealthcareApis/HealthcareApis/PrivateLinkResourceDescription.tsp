import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateLinkResourceDescription has no properties property
/**
 * The Private Endpoint Connection resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ServicesDescription)
model PrivateLinkResourceDescription
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResourceDescription,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

alias PrivateLinkResourceDescriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the service instance. */
    @path
    @segment("services")
    @key
    @minLength(3)
    @maxLength(24)
    resourceName: string;
  },
  {
    /** The name of the private link resource group. */
    @path
    @segment("privateLinkResources")
    @key
    groupName: string;
  },
  ErrorDetails
>;

@armResourceOperations(#{ omitTags: true })
interface PrivateLinkResourceDescriptions {
  /**
   * Gets a private link resource that need to be created for a service.
   */
  @tag("PrivateLinkResources")
  get is PrivateLinkResourceDescriptionOps.Read<PrivateLinkResourceDescription>;

  /**
   * Gets the private link resources that need to be created for a service.
   */
  @tag("PrivateLinkResources")
  listByService is PrivateLinkResourceDescriptionOps.ListSinglePage<
    PrivateLinkResourceDescription,
    Response = ArmResponse<PrivateLinkResourceListResultDescription>
  >;
}
alias WorkspacePrivateLinkResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of workspace resource. */
    @path
    @segment("workspaces")
    @key
    @minLength(3)
    @maxLength(24)
    workspaceName: string;
  },
  {
    /** The name of the private link resource group. */
    @path
    @segment("privateLinkResources")
    @key
    groupName: string;
  },
  ErrorDetails
>;

@armResourceOperations
interface WorkspacePrivateLinkResources {
  /**
   * Gets a private link resource that need to be created for a workspace.
   */
  get is WorkspacePrivateLinkResourceOps.Read<PrivateLinkResourceDescription>;

  /**
   * Gets the private link resources that need to be created for a workspace.
   */
  listByWorkspace is WorkspacePrivateLinkResourceOps.List<
    PrivateLinkResourceDescription,
    Response = ArmResponse<PrivateLinkResourceListResultDescription>
  >;
}

@@doc(PrivateLinkResourceDescription.name,
  "The name of the private link resource group."
);
