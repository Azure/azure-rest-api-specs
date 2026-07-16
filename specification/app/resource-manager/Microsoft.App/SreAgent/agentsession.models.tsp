import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** The properties of an Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionProperties {
  /** The primary Azure resource included in the troubleshooting scope. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  targetResourceId: armResourceIdentifier;

  /** Additional Azure resources included in the troubleshooting scope. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  additionalResourceIds: armResourceIdentifier[];

  /** Additional subscription identifiers that the Agent Session may inspect. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  additionalSubscriptionIds: string[];

  /** The provisioning state of the persistent Agent Session resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentSessionProvisioningState;

  /** The latest sandbox generation associated with the Agent Session. */
  @visibility(Lifecycle.Read)
  sandbox?: AgentSessionSandbox;
}

/** The provisioning state of an Agent Session. */
@added(Versions.v2026_08_01_preview)
@lroStatus
union AgentSessionProvisioningState {
  string,
  ResourceProvisioningState,

  /** The Agent Session and its initial sandbox are being created. */
  Creating: "Creating",

  /** The Agent Session is being deleted. */
  Deleting: "Deleting",
}

/** The latest isolated runtime associated with an Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionSandbox {
  /** The service-issued identifier of the sandbox. */
  sandboxId: string;

  /** The WebSocket endpoint for a ready sandbox. */
  endpoint?: url;

  /** The time when the sandbox expires. */
  expiresAt: utcDateTime;

  /** The current state of the sandbox. */
  state: AgentSessionSandboxState;

  /** The monotonically increasing sandbox generation. */
  @minValue(1)
  generation: int32;
}

/** The lifecycle state of an Agent Session sandbox. */
@added(Versions.v2026_08_01_preview)
union AgentSessionSandboxState {
  string,

  /** The sandbox is being provisioned. */
  Provisioning: "Provisioning",

  /** The sandbox is ready for use. */
  Ready: "Ready",

  /** The sandbox has reached its expiration time. */
  Expired: "Expired",

  /** The sandbox has been deleted. */
  Deleted: "Deleted",

  /** Sandbox provisioning failed. */
  Failed: "Failed",
}

/** The conditional header required for operations that modify an existing Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionIfMatchParameter {
  /** The ETag of the Agent Session. */
  @header("If-Match")
  ifMatch: string;
}
