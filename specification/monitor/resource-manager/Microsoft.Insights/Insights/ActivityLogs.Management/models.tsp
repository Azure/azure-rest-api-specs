import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * the event level
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EventLevel {
  /**
   * Critical
   */
  Critical,

  /**
   * Error
   */
  Error,

  /**
   * Warning
   */
  Warning,

  /**
   * Informational
   */
  Informational,

  /**
   * Verbose
   */
  Verbose,
}

/**
 * Represents collection of events.
 */
model EventDataCollection is Azure.Core.Page<EventData>;

/**
 * The Azure event log entries are of type EventData
 */
model EventData {
  /**
   * The sender authorization information.
   */
  @visibility(Lifecycle.Read)
  authorization?: SenderAuthorization;

  /**
   * key value pairs to identify ARM permissions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  claims?: Record<string>;

  /**
   * the email address of the user who has performed the operation, the UPN claim or SPN claim based on availability.
   */
  @visibility(Lifecycle.Read)
  caller?: string;

  /**
   * the description of the event.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * the Id of this event as required by ARM for RBAC. It contains the EventDataID and a timestamp information.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * the event data Id. This is a unique identifier for an event.
   */
  @visibility(Lifecycle.Read)
  eventDataId?: string;

  /**
   * the correlation Id, usually a GUID in the string format. The correlation Id is shared among the events that belong to the same uber operation.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * the event name. This value should not be confused with OperationName. For practical purposes, OperationName might be more appealing to end users.
   */
  @visibility(Lifecycle.Read)
  eventName?: LocalizableString;

  /**
   * the event category.
   */
  @visibility(Lifecycle.Read)
  category?: LocalizableString;

  /**
   * the HTTP request info. Usually includes the 'clientRequestId', 'clientIpAddress' (IP address of the user who initiated the event) and 'method' (HTTP method e.g. PUT).
   */
  @visibility(Lifecycle.Read)
  httpRequest?: HttpRequestInfo;

  /**
   * the event level
   */
  @visibility(Lifecycle.Read)
  level?: EventLevel;

  /**
   * the resource group name of the impacted resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @OpenAPI.externalDocs("http://msdn.microsoft.com/en-us/library/azure/dn790546.aspx")
  resourceGroupName?: string;

  /**
   * the resource provider name of the impacted resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @OpenAPI.externalDocs("http://msdn.microsoft.com/en-us/library/azure/dn790572.aspx")
  resourceProviderName?: LocalizableString;

  /**
   * the resource uri that uniquely identifies the resource that caused this event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @OpenAPI.externalDocs("http://msdn.microsoft.com/en-us/library/azure/dn790569.aspx")
  resourceId?: string;

  /**
   * the resource type
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @OpenAPI.externalDocs("http://msdn.microsoft.com/en-us/library/azure/dn790569.aspx")
  resourceType?: LocalizableString;

  /**
   * It is usually a GUID shared among the events corresponding to single operation. This value should not be confused with EventName.
   */
  @visibility(Lifecycle.Read)
  operationId?: string;

  /**
   * the operation name.
   */
  @visibility(Lifecycle.Read)
  operationName?: LocalizableString;

  /**
   * the set of <Key, Value> pairs (usually a Dictionary<String, String>) that includes details about the event.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  properties?: Record<string>;

  /**
   * a string describing the status of the operation. Some typical values are: Started, In progress, Succeeded, Failed, Resolved.
   */
  @visibility(Lifecycle.Read)
  status?: LocalizableString;

  /**
   * the event sub status. Most of the time, when included, this captures the HTTP status code of the REST call. Common values are: OK (HTTP Status Code: 200), Created (HTTP Status Code: 201), Accepted (HTTP Status Code: 202), No Content (HTTP Status Code: 204), Bad Request(HTTP Status Code: 400), Not Found (HTTP Status Code: 404), Conflict (HTTP Status Code: 409), Internal Server Error (HTTP Status Code: 500), Service Unavailable (HTTP Status Code:503), Gateway Timeout (HTTP Status Code: 504)
   */
  @visibility(Lifecycle.Read)
  subStatus?: LocalizableString;

  /**
   * the timestamp of when the event was generated by the Azure service processing the request corresponding the event. It in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  /**
   * the timestamp of when the event became available for querying via this API. It is in ISO 8601 format. This value should not be confused eventTimestamp. As there might be a delay between the occurrence time of the event, and the time that the event is submitted to the Azure logging infrastructure.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submissionTimestamp?: utcDateTime;

  /**
   * the Azure subscription Id usually a GUID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * the Azure tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * the authorization used by the user who has performed the operation that led to this event. This captures the RBAC properties of the event. These usually include the 'action', 'role' and the 'scope'
 */
model SenderAuthorization {
  /**
   * the permissible actions. For instance: microsoft.support/supporttickets/write
   */
  action?: string;

  /**
   * the role of the user. For instance: Subscription Admin
   */
  role?: string;

  /**
   * the scope.
   */
  scope?: string;
}

/**
 * The localizable string class.
 */
model LocalizableString {
  /**
   * the invariant value.
   */
  value: string;

  /**
   * the locale specific value.
   */
  localizedValue?: string;
}

/**
 * The Http request info.
 */
model HttpRequestInfo {
  /**
   * the client request id.
   */
  clientRequestId?: string;

  /**
   * the client Ip Address
   */
  clientIpAddress?: string;

  /**
   * the Http request method.
   */
  method?: string;

  /**
   * the Uri.
   */
  uri?: string;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * A collection of event categories. Currently possible values are: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.
 */
model EventCategoryCollection {
  /**
   * the list that includes the Azure event categories.
   */
  @pageItems
  @identifiers(#["value"])
  value: LocalizableString[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}
