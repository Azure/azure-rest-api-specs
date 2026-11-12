import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EdgeOperator;

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/** Connection intent for a system configuration. */
union ConnectionIntent {
  string,

  /** Device is connected to cloud. */
  Connected: "Connected",

  /** Device is disconnected from cloud. */
  Disconnected: "Disconnected",
}

/** Automatic update preparation state for a system configuration. */
union AutomaticUpdatePreparationStatus {
  string,

  /** The system is prepared for an automatic update. */
  Enabled: "Enabled",

  /** The system is not prepared for an automatic update. */
  Disabled: "Disabled",
}

/** Telemetry opt-out state for a system configuration. */
union TelemetryOptOutStatus {
  string,

  /** The system has opted out of telemetry. */
  Enabled: "Enabled",

  /** The system has not opted out of telemetry. */
  Disabled: "Disabled",
}

// ---------------------------------------------------------------------------
// Properties
// ---------------------------------------------------------------------------

/**
 * System configuration properties for Azure Local Disconnected Operations (ALDO).
 * The writable fields are supplied by the caller on PUT; the remaining fields are
 * computed by the resource provider and returned on GET.
 */
model SystemConfigurationProperties {
  /** The IP address of the DNS forwarder used by the system. Not yet set until configured. */
  dnsForwarderIpAddress?: string;

  /** The connection intent for the system. Not yet set until configured. */
  connectionIntent?: ConnectionIntent;

  /** The identifier of the stamp hosting the system. Must be a valid GUID. Not yet set until configured. */
  @pattern("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$")
  stampId?: string;

  /** The resource ID of the device associated with this system configuration. Not yet set until configured. */
  deviceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/disconnectedOperations";
    }
  ]>;

  /** Indicates whether the system is prepared for an automatic update. */
  @visibility(Lifecycle.Read)
  automaticUpdatePreparationStatus?: AutomaticUpdatePreparationStatus;

  /** The external time servers configured for the system. */
  @visibility(Lifecycle.Read)
  externalTimeServers?: string[];

  /** Indicates whether the system has opted out of telemetry. */
  @visibility(Lifecycle.Read)
  telemetryOptOutStatus?: TelemetryOptOutStatus;

  /** The external domain suffix configured for the system. */
  @visibility(Lifecycle.Read)
  externalDomainSuffix?: string;

  /** The image version currently deployed on the system. */
  @visibility(Lifecycle.Read)
  imageVersion?: string;

  /** The prefix length of the ingress network interface controller (NIC). */
  @visibility(Lifecycle.Read)
  ingressNicPrefixLength?: int32;

  /** The IP address of the ingress network interface controller (NIC). */
  @visibility(Lifecycle.Read)
  ingressNicIpAddress?: string;

  /** The default gateway of the ingress network interface controller (NIC). */
  @visibility(Lifecycle.Read)
  ingressNicDefaultGateway?: string;

  /** The provisioning state of the system configuration resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// ---------------------------------------------------------------------------
// Resources
// ---------------------------------------------------------------------------

/**
 * The active system configuration for ALDO.
 * This is a singleton resource; the only accepted resource name is `default`.
 *
 * The subscription in the request path must be the Operator subscription. This subscription is used
 * only for the access check: the resource provider verifies it on every request, and only operators
 * have access to the Operator subscription and can therefore invoke the Microsoft.EdgeOperator APIs.
 * Requests scoped to any other subscription are rejected.
 */
@subscriptionResource
@singleton("default")
model SystemConfiguration is ProxyResource<SystemConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = SystemConfiguration,
    SegmentName = "systemConfiguration"
  >;
}

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

/**
 * Operations on the active system configuration for ALDO.
 * Only GET and PUT (create-or-replace) are supported. PATCH and DELETE are not allowed —
 * customers manage the configuration exclusively via PUT /systemConfiguration/default.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "SystemConfiguration is a singleton proxy resource that intentionally does not support DELETE. The active configuration can only be replaced via PUT /systemConfiguration/default."
@armResourceOperations
@tag("SystemConfiguration")
interface SystemConfigurationOperations {
  /** Gets the active system configuration for ALDO. */
  get is ArmResourceRead<SystemConfiguration>;

  /**
   * Creates or fully replaces the active system configuration for ALDO.
   * The resource name must be `default`.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SystemConfiguration>;
}
