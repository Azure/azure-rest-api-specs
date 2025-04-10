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

namespace Microsoft.CertificateRegistration;
/**
 * Site Extension Information.
 */
@parentResource(Site)
model SiteExtensionInfo
  is Azure.ResourceManager.ProxyResource<SiteExtensionInfoProperties> {
  ...ResourceNameParameter<
    Resource = SiteExtensionInfo,
    KeyName = "siteExtensionId",
    SegmentName = "siteextensions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SiteExtensionInfoOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SiteExtensionInfo,
        KeyName = "siteExtensionId",
        SegmentName = "siteextensions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SiteExtensionInfos {
  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteExtension")
  getSiteExtension is SiteExtensionInfoOps.Read<SiteExtensionInfo>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_InstallSiteExtension")
  installSiteExtension is SiteExtensionInfoOps.CreateOrUpdateAsync<
    SiteExtensionInfo,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSiteExtension")
  deleteSiteExtension is SiteExtensionInfoOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteExtensions")
  listSiteExtensions is SiteExtensionInfoOps.List<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfoCollection>
  >;
}
@armResourceOperations
interface SiteExtensionInfoOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SiteExtensionInfo,
        KeyName = "siteExtensionId",
        SegmentName = "siteextensions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SiteExtensionInfoOperationGroup {
  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteExtensionSlot")
  getSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.Read<SiteExtensionInfo>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_InstallSiteExtensionSlot")
  installSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.CreateOrUpdateAsync<
    SiteExtensionInfo,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSiteExtensionSlot")
  deleteSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteExtensionsSlot")
  listSiteExtensionsSlot is SiteExtensionInfoOperationGroupOps.List<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfoCollection>
  >;
}

@@doc(SiteExtensionInfo.name, "Site extension name.");
@@doc(SiteExtensionInfo.properties,
  "SiteExtensionInfo resource specific properties"
);
