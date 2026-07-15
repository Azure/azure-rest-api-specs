import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** The request body for starting a debug session. */
@added(Versions.v2026_06_01_preview)
model StartDebugSessionRequest {
  /** The properties of the debug session to start. */
  properties: StartDebugSessionRequestProperties;
}

/** The properties used to start a debug session. */
@added(Versions.v2026_06_01_preview)
model StartDebugSessionRequestProperties {
  /**
   * The full `/subscriptions/{subscriptionId}` resource IDs of the other
   * subscriptions participating in the debug session. The subscription in the
   * action URL is always a participant and must not be repeated here.
   */
  additionalSubscriptionResourceIds?: armResourceIdentifier[];

  /**
   * The non-empty list of exact ARM resource IDs authorized for the debug
   * session. Every resource must belong to the URL subscription or to one of the
   * subscriptions listed in `additionalSubscriptionResourceIds`.
   */
  @minItems(1)
  armResourceIds: armResourceIdentifier[];
}

/** The result of starting a debug session. */
@added(Versions.v2026_06_01_preview)
model StartDebugSessionResponse {
  /** The unique identifier of the debug session. */
  sessionId: string;

  /** Indicates whether this call created a new debug session or resumed an existing one. */
  sessionDisposition: DebugSessionDisposition;

  /** The mode used to authorize the debug session. */
  authorizationMode: DebugSessionAuthorizationMode;

  /**
   * The full `/subscriptions/{subscriptionId}` resource IDs of every
   * subscription participating in the debug session, including the URL
   * subscription.
   */
  participatingSubscriptionResourceIds: armResourceIdentifier[];

  /** The list of ARM resource IDs authorized for the debug session. */
  authorizedResourceIds: armResourceIdentifier[];

  /** The sandbox connection details for the debug session. */
  sandbox: DebugSessionSandbox;
}

/** The sandbox connection details for a debug session. */
@added(Versions.v2026_06_01_preview)
model DebugSessionSandbox {
  /** The identifier of the provisioned sandbox. */
  sandboxId: string;

  /** The WebSocket endpoint used to connect to the debug sandbox. */
  endpoint: url;

  /** The time at which the sandbox connection expires. */
  expiresAt: utcDateTime;
}

/** The mode used to authorize a debug session. */
@added(Versions.v2026_06_01_preview)
union DebugSessionAuthorizationMode {
  string,

  /**
   * The debug session was authorized by evaluating subscription read access
   * across every participating subscription.
   */
  ArmParticipatingSubscriptionRead: "ArmParticipatingSubscriptionRead",
}

/** Indicates whether a debug session was newly created or resumed. */
@added(Versions.v2026_06_01_preview)
union DebugSessionDisposition {
  string,

  /** The call created a new debug session. */
  Created: "Created",

  /** The call returned an existing matching debug session. */
  Resumed: "Resumed",
}
