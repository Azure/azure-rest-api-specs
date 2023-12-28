import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Quota;

interface Operations extends Azure.ResourceManager.Operations {}

enum UsagesTypes {
  Individual,
  Combined,
}

enum LimitType {
  LimitValue,
}

enum QuotaRequestState {
  Accepted,
  Invalid,
  Succeeded,
  Failed,
  InProgress,
}

enum QuotaLimitTypes {
  Independent,
  Shared,
}

@doc("Usage properties for the specified resource.")
model UsagesProperties {
  @doc("The quota limit properties for this resource.")
  usages?: UsagesObject;

  @doc(" The units for the quota usage, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.")
  @visibility("read")
  unit?: string;

  @doc("Resource name provided by the resource provider. Use this property name when requesting quota.")
  name?: ResourceName;

  @doc("The name of the resource type. Optional field.")
  resourceType?: string;

  @doc("""
The time period for the summary of the quota usage values. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because it is not relevant for all resources such as compute.
""")
  @visibility("read")
  quotaPeriod?: duration;

  @doc("States if quota can be requested for this resource.")
  @visibility("read")
  isQuotaApplicable?: boolean;

  @doc("Additional properties for the specific resource provider.")
  properties?: Record<unknown>;
}

@doc("The resource usages value.")
model UsagesObject {
  @doc("The usages value.")
  value: int32;

  @doc("The quota or usages limit types.")
  usagesType?: UsagesTypes;
}

@doc("Name of the resource provided by the resource Provider. When requesting quota, use this property name.")
model ResourceName {
  @doc("Resource name.")
  value?: string;

  @doc("Resource display name.")
  @visibility("read")
  localizedValue?: string;
}

@doc("Error.")
@error
model ExceptionResponse {
  @doc("API error details.")
  error?: ServiceError;
}

@doc("API error details.")
model ServiceError {
  @doc("Error code.")
  code?: string;

  @doc("Error message.")
  message?: string;

  @doc("List of error details.")
  @visibility("read")
  details?: ServiceErrorDetail[];
}

@doc("Error details.")
model ServiceErrorDetail {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message.")
  @visibility("read")
  message?: string;
}

@doc("Quota properties for the specified resource.")
model QuotaProperties {
  @doc("Resource quota limit properties.")
  limit?: LimitJsonObject;

  @doc(" The quota units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.")
  @visibility("read")
  unit?: string;

  @doc("Resource name provided by the resource provider. Use this property name when requesting quota.")
  name?: ResourceName;

  @doc("The name of the resource type. Optional field.")
  resourceType?: string;

  @doc("""
The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
""")
  @visibility("read")
  quotaPeriod?: duration;

  @doc("States if quota can be requested for this resource.")
  @visibility("read")
  isQuotaApplicable?: boolean;

  @doc("Additional properties for the specific resource provider.")
  properties?: Record<unknown>;
}

@doc("LimitJson abstract class.")
@discriminator("limitObjectType")
model LimitJsonObject {}

@doc("Quota request properties.")
model QuotaRequestProperties {
  @doc("The quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("User-friendly status message.")
  @visibility("read")
  message?: string;

  @doc("Error details of the quota request.")
  error?: ServiceErrorDetail;

  @doc("The quota request submission time. The date conforms to the following format specified by the ISO 8601 standard: yyyy-MM-ddTHH:mm:ssZ")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  @doc("Quota request details.")
  value?: SubRequest[];
}

@doc("Request property.")
model SubRequest {
  @doc("Resource name.")
  name?: ResourceName;

  @doc("Resource type for which the quota properties were requested.")
  @visibility("read")
  resourceType?: string;

  @doc(" Quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.")
  unit?: string;

  @doc("The quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("User-friendly status message.")
  @visibility("read")
  message?: string;

  @doc("Quota request ID.")
  @visibility("read")
  subRequestId?: string;

  @doc("Resource quota limit properties.")
  limit?: LimitJsonObject;
}

model OperationResponse {
  name?: string;
  display?: OperationDisplay;
  origin?: string;
}

@doc("Resource properties.")
model CommonResourceProperties {
  @doc("Resource ID")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type. Example: \"Microsoft.Quota/quotas\"")
  @visibility("read")
  type?: string;
}

@doc("Quota limits request response.")
model QuotaLimitsResponse {
  @doc("List of quota limits with the quota request status.")
  value?: CurrentQuotaLimitBase[];

  @doc("The URI used to fetch the next page of quota limits. When there are no more pages, this is null.")
  nextLink?: string;
}

@doc("Quota change requests information.")
model CreateGenericQuotaRequestParameters {
  @doc("Quota change requests.")
  value?: CurrentQuotaLimitBase[];
}

@doc("The resource quota limit value.")
model LimitObject extends LimitJsonObject {
  @doc("The quota/limit value")
  value: int32;

  @doc("The quota or usages limit types.")
  limitType?: QuotaLimitTypes;

  @doc("The limit object type.")
  limitObjectType: "LimitValue";
}

@doc("Quota request response.")
model QuotaRequestOneResourceSubmitResponse {
  @doc("Quota request ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the quota request.")
  @visibility("read")
  name?: string;

  @doc("Resource type. \"Microsoft.Quota/ServiceLimitRequests\"")
  @visibility("read")
  type?: string;

  @doc("Quota request details.")
  properties?: QuotaRequestOneResourceProperties;
}

@doc("Quota request.")
model QuotaRequestOneResourceProperties {
  @doc("Quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("User-friendly status message.")
  @visibility("read")
  message?: string;

  @doc("Quota request submission time. The date conforms to the following ISO 8601 standard format: yyyy-MM-ddTHH:mm:ssZ.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  @doc("Resource quota limit properties.")
  limit?: LimitObject;

  @doc("Usage information for the current resource.")
  @visibility("read")
  currentValue?: int32;

  @doc(" The quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.")
  unit?: string;

  @doc("Resource name provided by the resource provider. Use this property name when requesting quota.")
  name?: ResourceName;

  @doc("The name of the resource type. Optional field.")
  resourceType?: string;

  @doc("""
The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
""")
  @visibility("read")
  quotaPeriod?: string;

  @doc("States if quota can be requested for this resource.")
  @visibility("read")
  isQuotaApplicable?: boolean;

  @doc("Error details of the quota request.")
  error?: ServiceErrorDetail;

  @doc("Additional properties for the specific resource provider.")
  properties?: Record<unknown>;
}

@doc("Quota request response.")
model QuotaRequestSubmitResponse {
  @doc("Quota request ID.")
  @visibility("read")
  id?: string;

  @doc("Quota request name.")
  @visibility("read")
  name?: string;

  @doc("Quota request details.")
  properties?: QuotaRequestProperties;

  @doc("Resource type. \"Microsoft.Quota/quotas\".")
  @visibility("read")
  type?: string;
}

@doc("The quota request response with the quota request ID.")
model QuotaRequestSubmitResponse202 {
  @doc("The quota request ID. To check the request status, use the **id** value in a [Quota Request Status](https://docs.microsoft.com/en-us/rest/api/reserved-vm-instances/quotarequeststatus/get) GET operation.")
  @visibility("read")
  id?: string;

  @doc("Operation ID.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Quota request status.")
  properties?: QuotaRequestStatusDetails;
}

@doc("Quota request status details.")
model QuotaRequestStatusDetails {
  @doc("Quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("User-friendly message.")
  @visibility("read")
  message?: string;

  @doc("Resource quota limit properties.")
  limit?: LimitObject;

  @doc(" The quota limit units, such as Count and Bytes. When requesting quota, use the **unit** value returned in the GET response in the request body of your PUT operation.")
  unit?: string;

  @doc("Resource name provided by the resource provider. Use this property name when requesting quota.")
  name?: ResourceName;

  @doc("The name of the resource type. Optional field.")
  resourceType?: string;

  @doc("""
The time period over which the quota usage values are summarized. For example:
*P1D (per one day)
*PT1M (per one minute)
*PT1S (per one second).
This parameter is optional because, for some resources like compute, the period is irrelevant.
""")
  @visibility("read")
  quotaPeriod?: string;

  @doc("Additional properties for the specific resource provider.")
  properties?: Record<unknown>;
}
