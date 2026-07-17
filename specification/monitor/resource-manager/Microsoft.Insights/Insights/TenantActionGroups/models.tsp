import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace TenantActionGroups;

/**
 * A tenant  action group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TenantActionGroup {
  /**
   * The short name of the action group. This will be used in SMS messages.
   */
  @maxLength(12)
  groupShortName: string;

  /**
   * Indicates whether this tenant action group is enabled. If a tenant action group is not enabled, then none of its receivers will receive communications.
   */
  enabled: boolean = true;

  /**
   * The list of email receivers that are part of this tenant action group.
   */
  @identifiers(#["emailAddress"])
  emailReceivers?: EmailReceiver[];

  /**
   * The list of SMS receivers that are part of this tenant action group.
   */
  @identifiers(#["phoneNumber"])
  smsReceivers?: SmsReceiver[];

  /**
   * The list of webhook receivers that are part of this tenant action group.
   */
  @identifiers(#["name"])
  webhookReceivers?: WebhookReceiver[];

  /**
   * The list of AzureAppPush receivers that are part of this tenant action group.
   */
  @identifiers(#["emailAddress"])
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of voice receivers that are part of this tenant action group.
   */
  @identifiers(#["phoneNumber"])
  voiceReceivers?: VoiceReceiver[];
}

/**
 * A webhook receiver.
 */
model WebhookReceiver {
  /**
   * The name of the webhook receiver. Names must be unique across all receivers within a tenant action group.
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
}

/**
 * A tenant action group object for the body of patch operations.
 */
model ActionGroupPatchBody {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The action group settings for an update operation.
   */
  properties?: ActionGroupPatch;
}

/**
 * A list of tenant action groups.
 */
model TenantActionGroupList is Azure.Core.Page<TenantActionGroupResource>;

/**
 * The request body which contain contact detail metadata
 */
model TenantNotificationRequestBody {
  /**
   * The value of the supported alert type. Supported alert type value is: servicehealth
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
   * The list of AzureAppPush receivers that are part of this action group.
   */
  @identifiers(#[])
  azureAppPushReceivers?: AzureAppPushReceiver[];

  /**
   * The list of voice receivers that are part of this action group.
   */
  @identifiers(#[])
  voiceReceivers?: VoiceReceiver[];
}

/**
 * The details of the test notification results.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-response-suffix" "Name kept for backward compatibility"
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
 * The action detail
 */
model ActionDetail {
  /**
   * The mechanism type
   */
  mechanismType?: string;

  /**
   * The name of the action
   */
  name?: string;

  /**
   * The status of the action
   */
  status?: string;

  /**
   * The substatus of the action
   */
  subState?: string;

  /**
   * The send time
   */
  sendTime?: string;

  /**
   * The detail of the friendly error message
   */
  message?: string;
}
