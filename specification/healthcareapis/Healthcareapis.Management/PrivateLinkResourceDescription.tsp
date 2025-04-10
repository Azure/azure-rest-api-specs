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
@parentResource(ServicesDescription)
model PrivateLinkResourceDescription
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResourceDescription,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResourceDescriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ServicesDescription,
          KeyName = "resourceName",
          SegmentName = "services",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PrivateLinkResourceDescription,
        KeyName = "groupName",
        SegmentName = "privateLinkResources",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PrivateLinkResourceDescriptions {
  /**
   * Gets a private link resource that need to be created for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_Get")
  get is PrivateLinkResourceDescriptionOps.Read<PrivateLinkResourceDescription>;

  /**
   * Gets the private link resources that need to be created for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_ListByService")
  listByService is PrivateLinkResourceDescriptionOps.List<
    PrivateLinkResourceDescription,
    Response = ArmResponse<PrivateLinkResourceListResultDescription>
  >;
}
@armResourceOperations
interface WorkspacePrivateLinkResourceOps
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
        Resource = PrivateLinkResourceDescription,
        KeyName = "groupName",
        SegmentName = "privateLinkResources",
        NamePattern = ""
      >>
    > {}

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
