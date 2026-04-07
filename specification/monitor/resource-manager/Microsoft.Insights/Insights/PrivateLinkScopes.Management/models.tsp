import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it.
 */
union PrivateLinkScopeProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Access mode types.
 */
union AccessMode {
  string,

  /**
   * Open
   */
  Open: "Open",

  /**
   * PrivateOnly
   */
  PrivateOnly: "PrivateOnly",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The kind of scoped Azure monitor resource.
 */
union ScopedResourceKind {
  string,

  /**
   * Resource
   */
  Resource: "Resource",

  /**
   * Metrics
   */
  Metrics: "Metrics",
}

/**
 * State of the Azure monitor resource.
 */
union ScopedResourceProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Properties that define a Azure Monitor PrivateLinkScope resource.
 */
model AzureMonitorPrivateLinkScopeProperties {
  /**
   * Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateLinkScopeProvisioningState;

  /**
   * List of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Access mode settings
   */
  accessModeSettings: AccessModeSettings;
}

/**
 * Properties that define the scope private link mode settings.
 */
model AccessModeSettings {
  /**
   * Specifies the default access mode of queries through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.
   */
  queryAccessMode: AccessMode;

  /**
   * Specifies the default access mode of ingestion through associated private endpoints in scope. If not specified default value is 'Open'. You can override this default setting for a specific private endpoint connection by adding an exclusion in the 'exclusions' array.
   */
  ingestionAccessMode: AccessMode;

  /**
   * List of exclusions that override the default access mode settings for specific private endpoint connections.
   */
  @identifiers(#[])
  exclusions?: AccessModeSettingsExclusion[];
}

/**
 * Properties that define the scope private link mode settings exclusion item. This setting applies to a specific private endpoint connection and overrides the default settings for that private endpoint connection.
 */
model AccessModeSettingsExclusion {
  /**
   * The private endpoint connection name associated to the private endpoint on which we want to apply the specific access mode settings.
   */
  privateEndpointConnectionName?: string;

  /**
   * Specifies the access mode of queries through the specified private endpoint connection in the exclusion.
   */
  queryAccessMode?: AccessMode;

  /**
   * Specifies the access mode of ingestion through the specified private endpoint connection in the exclusion.
   */
  ingestionAccessMode?: AccessMode;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The status of operation.
 */
model OperationStatus {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * Start time of the job in standard ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime | null;

  /**
   * End time of the job in standard ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The error detail of the operation if any.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail | null;
}

/**
 * Properties of a private link scoped resource.
 */
model ScopedResourceProperties {
  /**
   * The kind of scoped Azure monitor resource.
   */
  kind?: ScopedResourceKind;

  /**
   * The resource id of the scoped Azure monitor resource.
   */
  linkedResourceId?: string;

  /**
   * The location of a scoped subscription. Only needs to be specified for metric dataplane subscriptions.
   */
  subscriptionLocation?: string;

  /**
   * State of the Azure monitor resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ScopedResourceProvisioningState;
}
