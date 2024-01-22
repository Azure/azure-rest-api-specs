import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Quota;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The quota or usages limit types.
 */
enum UsagesTypes {
  Individual,
  Combined,
}

/**
 * The limit object type.
 */
enum LimitType {
  LimitValue,
}

/**
 * Quota request status.
 */
enum QuotaRequestState {
  Accepted,
  Invalid,
  Succeeded,
  Failed,
  InProgress,
}

/**
 * The quota or usages limit types.
 */
enum QuotaLimitTypes {
  Independent,
  Shared,
}

/**
 * Usage properties for the specified resource.
 */
model UsagesProperties {
  /**
   * The quota limit properties for this resource.
   */
  usages?: UsagesObject;

  /**
   *  The units for the quota usage, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.
   */
  @visibility("read")
  unit?: string;

  /**
   * Resource name provided by the resource provider. Use this property name when requesting quota.
   */
  name?: ResourceName;

  /**
   * The name of the resource type. Optional field.
   */
  resourceType?: string;

  /**
* The time period for the summary of the quota usage values. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because it is not relevant for all resources such as compute.
*/
  @visibility("read")
  quotaPeriod?: duration;

  /**
   * States if quota can be requested for this resource.
   */
  @visibility("read")
  isQuotaApplicable?: boolean;

  /**
   * Additional properties for the specific resource provider.
   */
  properties?: Record<unknown>;
}

/**
 * The resource usages value.
 */
model UsagesObject {
  /**
   * The usages value.
   */
  value: int32;

  /**
   * The quota or usages limit types.
   */
  usagesType?: UsagesTypes;
}

/**
 * Name of the resource provided by the resource Provider. When requesting quota, use this property name.
 */
model ResourceName {
  /**
   * Resource name.
   */
  value?: string;

  /**
   * Resource display name.
   */
  @visibility("read")
  localizedValue?: string;
}

/**
 * Error.
 */
@error
model ExceptionResponse {
  /**
   * API error details.
   */
  error?: ServiceError;
}

/**
 * API error details.
 */
model ServiceError {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message.
   */
  message?: string;

  /**
   * List of error details.
   */
  @visibility("read")
  details?: ServiceErrorDetail[];
}

/**
 * Error details.
 */
model ServiceErrorDetail {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message.
   */
  @visibility("read")
  message?: string;
}

/**
 * Quota properties for the specified resource.
 */
model QuotaProperties {
  /**
   * Resource quota limit properties.
   */
  limit?: LimitJsonObject;

  /**
   *  The quota units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.
   */
  @visibility("read")
  unit?: string;

  /**
   * Resource name provided by the resource provider. Use this property name when requesting quota.
   */
  name?: ResourceName;

  /**
   * The name of the resource type. Optional field.
   */
  resourceType?: string;

  /**
* The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
*/
  @visibility("read")
  quotaPeriod?: duration;

  /**
   * States if quota can be requested for this resource.
   */
  @visibility("read")
  isQuotaApplicable?: boolean;

  /**
   * Additional properties for the specific resource provider.
   */
  properties?: Record<unknown>;
}

/**
 * LimitJson abstract class.
 */
@discriminator("limitObjectType")
model LimitJsonObject {}

/**
 * Quota request properties.
 */
model QuotaRequestProperties {
  /**
   * The quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * Error details of the quota request.
   */
  error?: ServiceErrorDetail;

  /**
   * The quota request submission time. The date conforms to the following format specified by the ISO 8601 standard: yyyy-MM-ddTHH:mm:ssZ
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * Quota request details.
   */
  value?: SubRequest[];
}

/**
 * Request property.
 */
model SubRequest {
  /**
   * Resource name.
   */
  name?: ResourceName;

  /**
   * Resource type for which the quota properties were requested.
   */
  @visibility("read")
  resourceType?: string;

  /**
   *  Quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.
   */
  unit?: string;

  /**
   * The quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * Quota request ID.
   */
  @visibility("read")
  subRequestId?: string;

  /**
   * Resource quota limit properties.
   */
  limit?: LimitJsonObject;
}

model OperationResponse {
  name?: string;
  display?: OperationDisplay;
  origin?: string;
}

/**
 * Resource properties.
 */
model CommonResourceProperties {
  /**
   * Resource ID
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type. Example: "Microsoft.Quota/quotas"
   */
  @visibility("read")
  type?: string;
}

/**
 * Quota limits request response.
 */
model QuotaLimitsResponse {
  /**
   * List of quota limits with the quota request status.
   */
  value?: CurrentQuotaLimitBase[];

  /**
   * The URI used to fetch the next page of quota limits. When there are no more pages, this is null.
   */
  nextLink?: string;
}

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
 * The resource quota limit value.
 */
model LimitObject extends LimitJsonObject {
  /**
   * The quota/limit value
   */
  value: int32;

  /**
   * The quota or usages limit types.
   */
  limitType?: QuotaLimitTypes;

  /**
   * The limit object type.
   */
  limitObjectType: "LimitValue";
}

/**
 * Quota request response.
 */
model QuotaRequestOneResourceSubmitResponse {
  /**
   * Quota request ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the quota request.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type. "Microsoft.Quota/ServiceLimitRequests"
   */
  @visibility("read")
  type?: string;

  /**
   * Quota request details.
   */
  properties?: QuotaRequestOneResourceProperties;
}

/**
 * Quota request.
 */
model QuotaRequestOneResourceProperties {
  /**
   * Quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * Quota request submission time. The date conforms to the following ISO 8601 standard format: yyyy-MM-ddTHH:mm:ssZ.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * Resource quota limit properties.
   */
  limit?: LimitObject;

  /**
   * Usage information for the current resource.
   */
  @visibility("read")
  currentValue?: int32;

  /**
   *  The quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.
   */
  unit?: string;

  /**
   * Resource name provided by the resource provider. Use this property name when requesting quota.
   */
  name?: ResourceName;

  /**
   * The name of the resource type. Optional field.
   */
  resourceType?: string;

  /**
* The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
*/
  @visibility("read")
  quotaPeriod?: string;

  /**
   * States if quota can be requested for this resource.
   */
  @visibility("read")
  isQuotaApplicable?: boolean;

  /**
   * Error details of the quota request.
   */
  error?: ServiceErrorDetail;

  /**
   * Additional properties for the specific resource provider.
   */
  properties?: Record<unknown>;
}

/**
 * Quota request response.
 */
model QuotaRequestSubmitResponse {
  /**
   * Quota request ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Quota request name.
   */
  @visibility("read")
  name?: string;

  /**
   * Quota request details.
   */
  properties?: QuotaRequestProperties;

  /**
   * Resource type. "Microsoft.Quota/quotas".
   */
  @visibility("read")
  type?: string;
}

/**
 * The quota request response with the quota request ID.
 */
model QuotaRequestSubmitResponse202 {
  /**
   * The quota request ID. To check the request status, use the **id** value in a [Quota Request Status](https://docs.microsoft.com/en-us/rest/api/reserved-vm-instances/quotarequeststatus/get) GET operation.
   */
  @visibility("read")
  id?: string;

  /**
   * Operation ID.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
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
   * Quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly message.
   */
  @visibility("read")
  message?: string;

  /**
   * Resource quota limit properties.
   */
  limit?: LimitObject;

  /**
   *  The quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.
   */
  unit?: string;

  /**
   * Resource name provided by the resource provider. Use this property name when requesting quota.
   */
  name?: ResourceName;

  /**
   * The name of the resource type. Optional field.
   */
  resourceType?: string;

  /**
* The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
*/
  @visibility("read")
  quotaPeriod?: string;

  /**
   * Additional properties for the specific resource provider.
   */
  properties?: Record<unknown>;
}
