import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** The properties supplied when creating an Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionCreateProperties {
  /** The primary Azure resource included in the troubleshooting scope. */
  targetResourceId: armResourceIdentifier;

  /** Additional Azure resources included in the troubleshooting scope. */
  additionalResourceIds: armResourceIdentifier[];

  /** Additional subscription identifiers that the Agent Session may inspect. */
  additionalSubscriptionIds: string[];
}

/** The properties of an Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionProperties {
  ...AgentSessionCreateProperties;

  /** The provisioning state of the persistent Agent Session resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentSessionProvisioningState;

  /** The latest sandbox generation associated with the Agent Session. */
  @visibility(Lifecycle.Read)
  sandbox?: AgentSessionSandbox;
}

/** The request body used to create an Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionCreate {
  /** The Azure region where the Agent Session is created. */
  location: azureLocation;

  /** Resource tags fixed at creation. */
  ...ResourceTags;

  /** The immutable target scope of the Agent Session. */
  properties: AgentSessionCreateProperties;
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
  @visibility(Lifecycle.Read)
  sandboxId: string;

  /** The WebSocket endpoint for a ready sandbox. */
  @visibility(Lifecycle.Read)
  endpoint?: url;

  /** The time when the sandbox expires. */
  @visibility(Lifecycle.Read)
  expiresAt: utcDateTime;
}

/** The conditional header required for operations that modify an existing Agent Session. */
@added(Versions.v2026_08_01_preview)
model AgentSessionIfMatchParameter {
  /** The ETag of the Agent Session. */
  @header("If-Match")
  ifMatch?: string;
}
