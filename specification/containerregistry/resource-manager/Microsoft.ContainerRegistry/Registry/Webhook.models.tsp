namespace Microsoft.ContainerRegistry;

/**
 * The status of the webhook at the time the operation was called.
 */
union WebhookStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union WebhookAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  push: "push",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  quarantine: "quarantine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  chart_push: "chart_push",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  chart_delete: "chart_delete",
}

/**
 * The properties of a webhook.
 */
model WebhookProperties {
  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];

  /**
   * The provisioning state of the webhook at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The parameters for creating a webhook.
 */
model WebhookCreateParameters {
  /**
   * The tags for the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The location of the webhook. This cannot be changed after the resource is created.
   */
  location: string;

  /**
   * The properties that the webhook will be created with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: WebhookPropertiesCreateParameters;
}

/**
 * The parameters for creating the properties of a webhook.
 */
model WebhookPropertiesCreateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  @secret
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];
}

/**
 * The parameters for updating a webhook.
 */
model WebhookUpdateParameters {
  /**
   * The tags for the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties that the webhook will be updated with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: WebhookPropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a webhook.
 */
model WebhookPropertiesUpdateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  @secret
  serviceUri?: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions?: WebhookAction[];
}

/**
 * The basic information of an event.
 */
model EventInfo {
  /**
   * The event ID.
   */
  id?: string;
}

/**
 * The result of a request to list events for a webhook.
 */
model EventListResult {
  /**
   * The list of events. Since this list may be incomplete, the nextLink field should be used to request the next list of events.
   */
  @pageItems
  value?: Event[];

  /**
   * The URI that can be used to request the next list of events.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The event for a webhook.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Event extends EventInfo {
  /**
   * The event request message sent to the service URI.
   */
  eventRequestMessage?: EventRequestMessage;

  /**
   * The event response message received from the service URI.
   */
  eventResponseMessage?: EventResponseMessage;
}

/**
 * The event request message sent to the service URI.
 */
model EventRequestMessage {
  /**
   * The content of the event request message.
   */
  content?: EventContent;

  /**
   * The headers of the event request message.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string>;

  /**
   * The HTTP method used to send the event request message.
   */
  method?: string;

  /**
   * The URI used to send the event request message.
   */
  requestUri?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The content of the event request message.
 */
model EventContent {
  /**
   * The event ID.
   */
  id?: string;

  /**
   * The time at which the event occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The action that encompasses the provided event.
   */
  action?: string;

  /**
   * The target of the event.
   */
  target?: Target;

  /**
   * The request that generated the event.
   */
  request?: Request;

  /**
   * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
   */
  actor?: Actor;

  /**
   * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
   */
  source?: Source;
}

/**
 * The target of the event.
 */
model Target {
  /**
   * The MIME type of the referenced object.
   */
  mediaType?: string;

  /**
   * The number of bytes of the content. Same as Length field.
   */
  size?: int64;

  /**
   * The digest of the content, as defined by the Registry V2 HTTP API Specification.
   */
  digest?: string;

  /**
   * The number of bytes of the content. Same as Size field.
   */
  length?: int64;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The direct URL to the content.
   */
  url?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The name of the artifact.
   */
  name?: string;

  /**
   * The version of the artifact.
   */
  version?: string;
}

/**
 * The request that generated the event.
 */
model Request {
  /**
   * The ID of the request that initiated the event.
   */
  id?: string;

  /**
   * The IP or hostname and possibly port of the client connection that initiated the event. This is the RemoteAddr from the standard http request.
   */
  addr?: string;

  /**
   * The externally accessible hostname of the registry instance, as specified by the http host header on incoming requests.
   */
  host?: string;

  /**
   * The request method that generated the event.
   */
  method?: string;

  /**
   * The user agent header of the request.
   */
  useragent?: string;
}

/**
 * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
 */
model Actor {
  /**
   * The subject or username associated with the request context that generated the event.
   */
  name?: string;
}

/**
 * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
 */
model Source {
  /**
   * The IP or hostname and the port of the registry node that generated the event. Generally, this will be resolved by os.Hostname() along with the running port.
   */
  addr?: string;

  /**
   * The running instance of an application. Changes after each restart.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceID?: string;
}

/**
 * The event response message received from the service URI.
 */
model EventResponseMessage {
  /**
   * The content of the event response message.
   */
  content?: string;

  /**
   * The headers of the event response message.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string>;

  /**
   * The reason phrase of the event response message.
   */
  reasonPhrase?: string;

  /**
   * The status code of the event response message.
   */
  statusCode?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The configuration of service URI and custom headers for the webhook.
 */
model CallbackConfig {
  /**
   * The service URI for the webhook to post notifications.
   */
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customHeaders?: Record<string>;
}

/**
 * The result of a request to list webhooks for a container registry.
 */
model WebhookListResult {
  /**
   * The list of webhooks. Since this list may be incomplete, the nextLink field should be used to request the next list of webhooks.
   */
  @pageItems
  value?: Webhook[];

  /**
   * The URI that can be used to request the next list of webhooks.
   */
  @nextLink
  nextLink?: string;
}
