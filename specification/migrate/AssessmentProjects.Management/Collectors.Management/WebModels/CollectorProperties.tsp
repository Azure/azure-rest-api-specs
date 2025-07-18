import "../Common/ArmModels/AzureResourceProperties.tsp";

namespace Microsoft.Migrate;

@doc("Collector properties class.")
model CollectorPropertiesBaseWithAgent is AzureResourceProperties {
  @doc("Gets or sets the collector agent properties.")
  agentProperties?: CollectorAgentPropertiesBase;

  @doc("Gets the discovery site id.")
  discoverySiteId?: string;

  @doc("Gets the Timestamp when collector was created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("Timestamp when collector was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Collector properties class.")
model CollectorPropertiesBase is AzureResourceProperties {
  @doc("Gets the discovery site id.")
  discoverySiteId?: string;

  @doc("Gets the Timestamp when collector was created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("Timestamp when collector was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Collector agent property class.")
model CollectorAgentPropertiesBase {
  @doc("Gets the collector agent id.")
  id?: string;

  @doc("Gets the collector agent version.")
  version?: string;

  @doc("Gets the collector last heartbeat time.")
  lastHeartbeatUtc?: utcDateTime;

  @doc("Gets or sets the SPN details.")
  spnDetails?: CollectorAgentSpnPropertiesBase;
}

@doc("Collector agent SPN details class.")
model CollectorAgentSpnPropertiesBase {
  @doc("Gets the AAD authority endpoint.")
  authority?: string;

  @doc("Gets the AAD application id.")
  applicationId?: string;

  @doc("Gets the AAD audience url.")
  audience?: string;

  @doc("Gets the object id of the AAD application.")
  objectId?: string;

  @doc("Gets the tenant id of the AAD application.")
  tenantId?: string;
}
