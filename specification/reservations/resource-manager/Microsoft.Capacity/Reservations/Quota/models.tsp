import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Quota;

/**
 * Proxy resource for resource provider path segment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
@subscriptionResource
@armVirtualResource
model ResourceProviderProxy is Azure.ResourceManager.ProxyResource<{}> {
  /**
   * Azure resource provider ID.
   */
  @key("providerId")
  @segment("resourceProviders")
  @path
  @visibility(Lifecycle.Read)
  providerId: string;
}

/**
 * Proxy resource for location path segment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
@parentResource(ResourceProviderProxy)
@armVirtualResource
model LocationProxy is Azure.ResourceManager.ProxyResource<{}> {
  /**
   * Azure region.
   */
  @key("location")
  @segment("locations")
  @path
  @visibility(Lifecycle.Read)
  location: string;
}

/**
 * The resource types.
 */
union ResourceType {
  string,

  /**
   * standard
   */
  standard: "standard",

  /**
   * dedicated
   */
  dedicated: "dedicated",

  /**
   * lowPriority
   */
  lowPriority: "lowPriority",

  /**
   * shared
   */
  shared: "shared",

  /**
   * serviceSpecific
   */
  serviceSpecific: "serviceSpecific",
}

/**
 * The quota request status.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union QuotaRequestState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * Quota properties for the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model QuotaProperties {
  /**
   * Quota properties.
   */
  limit?: int32;

  /**
   * Current usage value for the resource.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   *  The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.
   */
  unit?: string;

  /**
   * Name of the resource provide by the resource provider. Use this property for quotaRequests resource operations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" ""
  name?: ResourceName;

  /**
   * The name of the resource type.
   */
  resourceType?: ResourceType;

  /**
   * The time period over which the quota usage values are summarized. For example, P1D (per one day), PT1M (per one minute), and PT1S (per one second). This parameter is optional because, for some resources such as compute, the time period is irrelevant.
   */
  @visibility(Lifecycle.Read)
  quotaPeriod?: string;

  /**
   * Additional properties for the specified resource provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" ""
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  properties?: unknown;
}

/**
 * Resource name provided by the resource provider. Use this property for quotaRequest parameter.
 */
model ResourceName {
  /**
   * Resource name.
   */
  value?: string;

  /**
   * Resource display localized name.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * The API error.
 */
@error
model ExceptionResponse {
  /**
   * The API error details.
   */
  error?: ServiceError;
}

/**
 * The API error details.
 */
model ServiceError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message text.
   */
  message?: string;

  /**
   * The list of error details.
   */
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  details?: ServiceErrorDetail[];
}

/**
 * The error details.
 */
model ServiceErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Response with request ID that the quota request was accepted.
 */
model QuotaRequestSubmitResponse201 {
  /**
   * The quota request ID. Use the requestId parameter to check the request status.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Operation ID
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Quota request status.
   */
  properties?: QuotaRequestStatusDetails;
}

/**
 * Quota request status details.
 */
model QuotaRequestStatusDetails {
  /**
   * The details of the quota request status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: QuotaRequestState;

  /**
   * A user friendly message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Quota limits.
 */
model QuotaLimits is Azure.Core.Page<CurrentQuotaLimitBase>;

/**
 * The details of quota request.
 */
model QuotaRequestProperties {
  /**
   * The quota request status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  provisioningState?: QuotaRequestState;

  /**
   * User friendly status message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * The quotaRequests.
   */
  value?: SubRequest[];
}

/**
 * The sub-request submitted with the quota request.
 */
model SubRequest {
  /**
   * Quota (resource limit).
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The resource name.
   */
  name?: ResourceName;

  /**
   * Resource type for which the quota check was made.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   *  The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.
   */
  unit?: string;

  /**
   * The quota request status.
   */
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly status message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Sub request ID for individual request.
   */
  @visibility(Lifecycle.Read)
  subRequestId?: string;
}

/**
 * Quota request details.
 */
model QuotaRequestDetailsList is Azure.Core.Page<QuotaRequestDetails>;

/**
 * Current quota limits.
 */
model CurrentQuotaLimit {
  /**
   * Quota details.
   */
  quotaInformation?: CurrentQuotaLimitBase;

  /**
   * Additional properties for the quota status for the resource.
   */
  properties?: QuotaRequestStatusDetails;
}

/**
 * Quotas (service limits) in the request response.
 */
model QuotaLimitsResponse is Azure.Core.Page<CurrentQuotaLimit>;

/**
 * Quota change requests information.
 */
model CreateGenericQuotaRequestParameters {
  /**
   * Quota change requests.
   */
  value?: CurrentQuotaLimitBase[];
}

/**
 * Response for the quota submission request.
 */
model QuotaRequestOneResourceSubmitResponse {
  /**
   * The quota request ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the quota request.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of resource. "Microsoft.Capacity/ServiceLimits"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The details for quota request.
   */
  properties?: QuotaRequestOneResourceProperties;
}

/**
 * The details of quota request.
 */
model QuotaRequestOneResourceProperties {
  /**
   * The quota request status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: QuotaRequestState;

  /**
   * User friendly status message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * The quota request addition properties.
   */
  properties?: CurrentQuotaLimitBase;
}

/**
 * Response for the quota submission request.
 */
model QuotaRequestSubmitResponse {
  /**
   * The quota request ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the quota request.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The quota request details.
   */
  properties?: QuotaRequestProperties;

  /**
   * Type of resource. "Microsoft.Capacity/serviceLimits"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}
