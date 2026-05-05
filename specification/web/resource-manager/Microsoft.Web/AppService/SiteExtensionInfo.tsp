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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Get site extension information by its ID for a web site, or a deployment slot.")
  getSiteExtension is SiteExtensionInfoOps.Read<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  @summary("Install site extension on a web site, or a deployment slot.")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Remove a site extension from a web site, or a deployment slot.")
  deleteSiteExtension is SiteExtensionInfoOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  @summary("Get list of siteextensions for a web site, or a deployment slot.")
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
  @summary("Get site extension information by its ID for a web site, or a deployment slot.")
  getSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.Read<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Install site extension on a web site, or a deployment slot.")
  installSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.CreateOrUpdateAsync<
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Remove a site extension from a web site, or a deployment slot.")
  deleteSiteExtensionSlot is SiteExtensionInfoOperationGroupOps.DeleteSync<
    SiteExtensionInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  @summary("Get list of siteextensions for a web site, or a deployment slot.")
  listSiteExtensionsSlot is SiteExtensionInfoOperationGroupOps.List<
    SiteExtensionInfo,
    Response = ArmResponse<SiteExtensionInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(SiteExtensionInfo.name, "Site extension name.");
@@doc(SiteExtensionInfo.properties,
  "SiteExtensionInfo resource specific properties"
);
