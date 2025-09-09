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

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Site extension name. */
        @path
        @segment("siteextensions")
        @key
        siteExtensionId: string,
      }
    > {}

@armResourceOperations
interface SiteExtensionInfos {
  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteExtension")
  getSiteExtension is SiteExtensionInfoOps.Read<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_InstallSiteExtension")
  installSiteExtension is SiteExtensionInfoOps.CreateOrUpdateAsync<
    SiteExtensionInfo,
    LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
      Azure.Core.Foundations.RetryAfterHeader,
    Request = void,
    Response = ArmResponse<SiteExtensionInfo> | ArmResourceCreatedResponse<
      SiteExtensionInfo,
      LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmTooManyRequestsResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSiteExtension")
  deleteSiteExtension is SiteExtensionInfoOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteExtensions")
  listSiteExtensions is SiteExtensionInfoOps.List<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API uses the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Site extension name. */
        @path
        @segment("siteextensions")
        @key
        siteExtensionId: string,
      }
    > {}

@armResourceOperations
interface SiteExtensionInfoOperationGroup {
  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetSiteExtensionSlot")
  getSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.Read<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfo> | ArmNotFoundResponse
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_InstallSiteExtensionSlot")
  installSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.CreateOrUpdateAsync<
    SiteExtensionInfo,
    LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
      Azure.Core.Foundations.RetryAfterHeader,
    Request = void,
    Response = ArmResponse<SiteExtensionInfo> | ArmResourceCreatedResponse<
      SiteExtensionInfo,
      LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmTooManyRequestsResponse
  >;
  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSiteExtensionSlot")
  deleteSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListSiteExtensionsSlot")
  listSiteExtensionsSlot is SiteExtensionInfoOperationGroupOps.List<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfoCollection> | ArmNotFoundResponse
  >;
}

@@doc(SiteExtensionInfo.name, "Site extension name.");
@@doc(SiteExtensionInfo.properties,
  "SiteExtensionInfo resource specific properties"
);
