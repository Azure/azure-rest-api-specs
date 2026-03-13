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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Gets a site container of a site, or a deployment slot.")
  getSiteContainer is SiteContainerOps.Read<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Creates or Updates a site container for a site, or a deployment slot.
   */
  @summary("Creates or Updates a site container for a site, or a deployment slot.")
  createOrUpdateSiteContainer is SiteContainerOps.CreateOrUpdateSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Deletes a site container for a site, or a deployment slot.
   */
  @summary("Deletes a site container for a site, or a deployment slot.")
  deleteSiteContainer is SiteContainerOps.DeleteSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Lists all the site containers of a site, or a deployment slot.
   */
  @summary("Lists all the site containers of a site, or a deployment slot.")
  listSiteContainers is SiteContainerOps.List<
    SiteContainer,
    Response = ArmResponse<SiteContainerCollection>,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Gets a site container of a site, or a deployment slot.")
  getSiteContainerSlot is SiteContainerOperationGroupOps.Read<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Creates or Updates a site container for a site, or a deployment slot.
   */
  @summary("Creates or Updates a site container for a site, or a deployment slot.")
  createOrUpdateSiteContainerSlot is SiteContainerOperationGroupOps.CreateOrUpdateSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Deletes a site container for a site, or a deployment slot.
   */
  @summary("Deletes a site container for a site, or a deployment slot.")
  deleteSiteContainerSlot is SiteContainerOperationGroupOps.DeleteSync<
    SiteContainer,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Lists all the site containers of a site, or a deployment slot.
   */
  @summary("Lists all the site containers of a site, or a deployment slot.")
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
