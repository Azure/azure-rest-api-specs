import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ActionGroups;

/**
 * The incident management service type
 */
union IncidentManagementService {
  string,

  /**
   * Icm
   */
  Icm: "Icm",
}

/**
 * Indicates the status of the receiver. Receivers that are not Enabled will not receive any communications.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReceiverStatus {
  /**
   * NotSpecified
   */
  NotSpecified,

  /**
   * Enabled
   */
  Enabled,

  /**
   * Disabled
   */
  Disabled,
}

/**
 * An Azure action group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActionGroup {
  /**
   * The short name of the action group. This will be used in SMS messages.
   */
  @maxLength(12)
  groupShortName: string;

  /**
   * Indicates whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications.
   */
  enabled: boolean = true;

  /**
   * The list of email receivers that are part of this action group.
   */
  @identifiers(#[])
  emailReceivers?: EmailReceiver[];

  /**
   * The list of SMS receivers that are part of this action group.
   */
  @identifiers(#[])
  smsReceivers?: SmsReceiver[];

  /**
   * The list of webhook receivers that are part of this action group.
   */
  @identifiers(#[])
  webhookReceivers?: WebhookReceiver[];

  /**
   * The list of ITSM receivers that are part of this action group.
   */
  @identifiers(#[])
  itsmReceivers?: ItsmReceiver[];

  /**
   * The list of AzureAppPush receivers that are part of this action group.
   */
  @identifiers(#[])
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of AutomationRunbook receivers that are part of this action group.
   */
  @identifiers(#[])
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  /**
   * The list of voice receivers that are part of this action group.
   */
  @identifiers(#[])
  voiceReceivers?: VoiceReceiver[];

  /**
   * The list of logic app receivers that are part of this action group.
   */
  @identifiers(#[])
  logicAppReceivers?: LogicAppReceiver[];

  /**
   * The list of azure function receivers that are part of this action group.
   */
  @identifiers(#[])
  azureFunctionReceivers?: AzureFunctionReceiver[];

  /**
   * The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.
   */
  @identifiers(#[])
  armRoleReceivers?: ArmRoleReceiver[];

  /**
   * The list of event hub receivers that are part of this action group.
   */
  @identifiers(#[])
  eventHubReceivers?: EventHubReceiver[];

  /**
   * The list of incident receivers that are part of this action group.
   */
  @identifiers(#[])
  incidentReceivers?: IncidentReceiver[];
}

/**
 * An email receiver.
 */
model EmailReceiver {
  /**
   * The name of the email receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The email address of this receiver.
   */
  emailAddress: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * The receiver status of the e-mail.
   */
  @visibility(Lifecycle.Read)
  status?: ReceiverStatus;
}

/**
 * An SMS receiver.
 */
model SmsReceiver {
  /**
   * The name of the SMS receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The country code of the SMS receiver.
   */
  countryCode: string;

  /**
   * The phone number of the SMS receiver.
   */
  phoneNumber: string;

  /**
   * The status of the receiver.
   */
  @visibility(Lifecycle.Read)
  status?: ReceiverStatus;
}

/**
 * A webhook receiver.
 */
model WebhookReceiver {
  /**
   * The name of the webhook receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The URI where webhooks should be sent.
   */
  serviceUri: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * Indicates whether or not use AAD authentication.
   */
  useAadAuth?: boolean = false;

  /**
   * Indicates the webhook app object Id for aad auth.
   */
  objectId?: string;

  /**
   * Indicates the identifier uri for aad auth.
   */
  identifierUri?: string;

  /**
   * Indicates the tenant id for aad auth.
   */
  tenantId?: string;

  /**
   * The principal id of the managed identity. The value can be "None", "SystemAssigned"
   */
  managedIdentity?: string;
}

/**
 * An Itsm receiver.
 */
model ItsmReceiver {
  /**
   * The name of the Itsm receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * OMS LA instance identifier.
   */
  workspaceId: string;

  /**
   * Unique identification of ITSM connection among multiple defined in above workspace.
   */
  connectionId: string;

  /**
   * JSON blob for the configurations of the ITSM action. CreateMultipleWorkItems option will be part of this blob as well.
   */
  ticketConfiguration: string;

  /**
   * Region in which workspace resides. Supported values:'centralindia','japaneast','southeastasia','australiasoutheast','uksouth','westcentralus','canadacentral','eastus','westeurope'
   */
  region: string;
}

/**
 * The Azure mobile App push notification receiver.
 */
model AzureAppPushReceiver {
  /**
   * The name of the Azure mobile app push receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The email address registered for the Azure mobile app.
   */
  emailAddress: string;
}

/**
 * The Azure Automation Runbook notification receiver.
 */
model AutomationRunbookReceiver {
  /**
   * The Azure automation account Id which holds this runbook and authenticate to Azure resource.
   */
  automationAccountId: string;

  /**
   * The name for this runbook.
   */
  runbookName: string;

  /**
   * The resource id for webhook linked to this runbook.
   */
  webhookResourceId: string;

  /**
   * Indicates whether this instance is global runbook.
   */
  isGlobalRunbook: boolean;

  /**
   * Indicates name of the webhook.
   */
  name?: string;

  /**
   * The URI where webhooks should be sent.
   */
  serviceUri?: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * The principal id of the managed identity. The value can be "None", "SystemAssigned"
   */
  managedIdentity?: string;
}

/**
 * A voice receiver.
 */
model VoiceReceiver {
  /**
   * The name of the voice receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The country code of the voice receiver.
   */
  countryCode: string;

  /**
   * The phone number of the voice receiver.
   */
  phoneNumber: string;
}

/**
 * A logic app receiver.
 */
model LogicAppReceiver {
  /**
   * The name of the logic app receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The azure resource id of the logic app receiver.
   */
  resourceId: string;

  /**
   * The callback url where http request sent to.
   */
  callbackUrl: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * The principal id of the managed identity. The value can be "None", "SystemAssigned"
   */
  managedIdentity?: string;
}

/**
 * An azure function receiver.
 */
model AzureFunctionReceiver {
  /**
   * The name of the azure function receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The azure resource id of the function app.
   */
  functionAppResourceId: string;

  /**
   * The function name in the function app.
   */
  functionName: string;

  /**
   * The http trigger url where http request sent to.
   */
  httpTriggerUrl: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * The principal id of the managed identity. The value can be "None", "SystemAssigned"
   */
  managedIdentity?: string;
}

/**
 * An arm role receiver.
 */
model ArmRoleReceiver {
  /**
   * The name of the arm role receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The arm role id.
   */
  roleId: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;
}

/**
 * An Event hub receiver.
 */
model EventHubReceiver {
  /**
   * The name of the Event hub receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The Event Hub namespace
   */
  eventHubNameSpace: string;

  /**
   * The name of the specific Event Hub queue
   */
  eventHubName: string;

  /**
   * Indicates whether to use common alert schema.
   */
  useCommonAlertSchema?: boolean = false;

  /**
   * The tenant Id for the subscription containing this event hub
   */
  tenantId?: string;

  /**
   * The Id for the subscription containing this event hub
   */
  subscriptionId: string;

  /**
   * The principal id of the managed identity. The value can be "None", "SystemAssigned"
   */
  managedIdentity?: string;
}

/**
 * An Incident receiver.
 */
model IncidentReceiver {
  /**
   * The name of the Incident receiver. Names must be unique across all receivers within an action group.
   */
  name: string;

  /**
   * The incident service connection
   */
  connection: IncidentServiceConnection;

  /**
   * The incident management service type
   */
  incidentManagementService: IncidentManagementService;

  /**
   * Field mappings for the incident service
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mappings: Record<string>;
}

/**
 * The connection info for Incident Receiver.
 */
model IncidentServiceConnection {
  /**
   * The name of the connection.
   */
  name: string;

  /**
   * GUID value representing the connection ID for the incident management service.
   */
  id: string;
}

/**
 * An azure resource object
 */
model AzureResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
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
 * An action group object for the body of patch operations.
 */
model ActionGroupPatchBody {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The action group settings for an update operation.
   */
  properties?: ActionGroupPatch;
}

/**
 * An Azure action group for patch operations.
 */
model ActionGroupPatch {
  /**
   * Indicates whether this action group is enabled. If an action group is not enabled, then none of its actions will be activated.
   */
  enabled?: boolean = true;
}

/**
 * The request body which contain contact detail metadata
 */
model NotificationRequestBody {
  /**
   * The value of the supported alert type. Supported alert type values are: servicehealth, metricstaticthreshold, metricsdynamicthreshold, logalertv2, smartalert, webtestalert, logalertv1numresult, logalertv1metricmeasurement, resourcehealth, activitylog, actualcostbudget, forecastedbudget
   */
  @maxLength(30)
  alertType: string;

  /**
   * The list of email receivers that are part of this action group.
   */
  @identifiers(#[])
  emailReceivers?: EmailReceiver[];

  /**
   * The list of SMS receivers that are part of this action group.
   */
  @identifiers(#[])
  smsReceivers?: SmsReceiver[];

  /**
   * The list of webhook receivers that are part of this action group.
   */
  @identifiers(#[])
  webhookReceivers?: WebhookReceiver[];

  /**
   * The list of ITSM receivers that are part of this action group.
   */
  @identifiers(#[])
  itsmReceivers?: ItsmReceiver[];

  /**
   * The list of AzureAppPush receivers that are part of this action group.
   */
  @identifiers(#[])
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of AutomationRunbook receivers that are part of this action group.
   */
  @identifiers(#[])
  automationRunbookReceivers?: AutomationRunbookReceiver[];

  /**
   * The list of voice receivers that are part of this action group.
   */
  @identifiers(#[])
  voiceReceivers?: VoiceReceiver[];

  /**
   * The list of logic app receivers that are part of this action group.
   */
  @identifiers(#[])
  logicAppReceivers?: LogicAppReceiver[];

  /**
   * The list of azure function receivers that are part of this action group.
   */
  @identifiers(#[])
  azureFunctionReceivers?: AzureFunctionReceiver[];

  /**
   * The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.
   */
  @identifiers(#[])
  armRoleReceivers?: ArmRoleReceiver[];

  /**
   * The list of event hub receivers that are part of this action group.
   */
  @identifiers(#[])
  eventHubReceivers?: EventHubReceiver[];

  /**
   * The list of incident receivers that are part of this action group.
   */
  @identifiers(#[])
  incidentReceivers?: IncidentReceiver[];
}

/**
 * The details of the test notification results.
 */
model TestNotificationDetailsResponse {
  /**
   * The context info
   */
  context?: Context;

  /**
   * The overall state
   */
  state: string;

  /**
   * The completed time
   */
  completedTime?: string;

  /**
   * The created time
   */
  createdTime?: string;

  /**
   * The list of action detail
   */
  @identifiers(#[])
  actionDetails?: ActionDetail[];
}

/**
 * The context info
 */
model Context {
  /**
   * The source of the notification request
   */
  notificationSource?: string;

  /**
   * The context id type
   */
  contextType?: string;
}

/**
 * The action detail
 */
model ActionDetail {
  /**
   * The mechanism type
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MechanismType?: string;

  /**
   * The name of the action
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name?: string;

  /**
   * The status of the action
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Status?: string;

  /**
   * The substatus of the action
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SubState?: string;

  /**
   * The send time
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SendTime?: string;

  /**
   * The detail of the friendly error message
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Detail?: string;
}

/**
 * A list of action groups.
 */
model ActionGroupList is Azure.Core.Page<ActionGroupResource>;

/**
 * Describes a receiver that should be resubscribed.
 */
model EnableRequest {
  /**
   * The name of the receiver to resubscribe.
   */
  receiverName: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ArmConflictErrorResponse {
  ...Response<409>;
}
