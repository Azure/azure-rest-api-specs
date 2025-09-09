import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Container of a site
 */
@parentResource(Site)
model SiteContainer
  is Azure.ResourceManager.ProxyResource<SiteContainerProperties> {
  ...ResourceNameParameter<
    Resource = SiteContainer,
    KeyName = "containerName",
    SegmentName = "sitecontainers",
    NamePattern = "(^[a-zA-Z0-9]$)|(^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface SiteContainerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Site Container Name */
        @path
        @segment("sitecontainers")
        @key
        @pattern("(^[a-zA-Z0-9]$)|(^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$)")
        containerName: string,
      }
    > {}

@armResourceOperations
interface SiteContainers {
  /**
   * Gets a site container of a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteContainer")
  getSiteContainer is SiteContainerOps.Read<SiteContainer>;

  /**
   * Creates or Updates a site container for a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateSiteContainer")
  createOrUpdateSiteContainer is SiteContainerOps.CreateOrUpdateSync<SiteContainer>;

  /**
   * Deletes a site container for a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteSiteContainer")
  deleteSiteContainer is SiteContainerOps.DeleteSync<SiteContainer>;

  /**
   * Lists all the site containers of a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteContainers")
  listSiteContainers is SiteContainerOps.List<
    SiteContainer,
    Response = ArmResponse<SiteContainerCollection>
  >;
}
@armResourceOperations
interface SiteContainerOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the Site Container for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Site Container Name */
        @path
        @segment("sitecontainers")
        @key
        @pattern("(^[a-zA-Z0-9]$)|(^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$)")
        containerName: string,
      }
    > {}

@armResourceOperations
interface SiteContainerOperationGroup {
  /**
   * Gets a site container of a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteContainerSlot")
  getSiteContainerSlot is SiteContainerOperationGroupOps.Read<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Creates or Updates a site container for a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateSiteContainerSlot")
  createOrUpdateSiteContainerSlot is SiteContainerOperationGroupOps.CreateOrUpdateSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Deletes a site container for a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteSiteContainerSlot")
  deleteSiteContainerSlot is SiteContainerOperationGroupOps.DeleteSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Lists all the site containers of a site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteContainersSlot")
  listSiteContainersSlot is SiteContainerOperationGroupOps.List<
    SiteContainer,
    Response = ArmResponse<SiteContainerCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(SiteContainer.name, "Site Container Name");
@@doc(SiteContainer.properties, "SiteContainer resource specific properties");
@@doc(SiteContainers.createOrUpdateSiteContainer::parameters.resource,
  "Container Entity"
);
@@doc(SiteContainerOperationGroup.createOrUpdateSiteContainerSlot::parameters.resource,
  "Container Entity"
);
