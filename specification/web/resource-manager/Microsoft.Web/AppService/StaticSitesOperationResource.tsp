import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Properties for a static site async operation status.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operation status resources use 'status' field instead of provisioningState."
@added(Versions.v2026_03_15)
model StaticSitesAsyncOperationProperties {
  /**
   * The current status of the asynchronous operation performed. For example, Running, Succeeded, Failed
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The start time of the asynchronous operation.
   */
  startTime?: string;

  /**
   * The end time of the asynchronous operation.
   */
  endTime?: string;

  /**
   * The generic properties of a staticSite.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Matching existing StaticSitesOperationResults schema from swagger."
  properties?: StaticSite;

  /**
   * Error details for the asynchronous operation, if any.
   */
  error?: ErrorResponse;
}

/**
 * Proxy resource representing a static site async operation result.
 */
@added(Versions.v2026_03_15)
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model StaticSitesOperationResultResource
  is Azure.ResourceManager.ProxyResource<StaticSitesAsyncOperationProperties> {
  ...ResourceNameParameter<
    Resource = StaticSitesOperationResultResource,
    KeyName = "operationId",
    SegmentName = "staticSitesOperationResults",
    NamePattern = ""
  >;
}

/**
 * Proxy resource representing a static site async operation status.
 */
@added(Versions.v2026_03_15)
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model StaticSiteOperationStatusResource
  is Azure.ResourceManager.ProxyResource<StaticSitesAsyncOperationProperties> {
  ...ResourceNameParameter<
    Resource = StaticSiteOperationStatusResource,
    KeyName = "operationId",
    SegmentName = "staticSiteOperationStatuses",
    NamePattern = ""
  >;
}

@added(Versions.v2026_03_15)
@armResourceOperations
interface StaticSitesOperationResultsInterface {
  /**
   * Description for Gets the result of a static site async operation.
   */
  @summary("Gets the result of a static site async operation.")
  getStaticSiteOperationResult is ArmResourceRead<
    StaticSitesOperationResultResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = NoContentResponse | ArmAcceptedLroResponse,
    Error = DefaultErrorResponse
  >;
}

@added(Versions.v2026_03_15)
@armResourceOperations
interface StaticSiteOperationStatusesInterface {
  /**
   * Description for Gets the result of a static site async operation.
   */
  @summary("Gets the result of a static site async operation.")
  getStaticSiteOperationResult is ArmResourceRead<
    StaticSiteOperationStatusResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = DefaultErrorResponse
  >;
}
