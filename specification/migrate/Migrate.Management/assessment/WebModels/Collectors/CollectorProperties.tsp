import "../Common/AzureResourceProperties.tsp";

@doc("Collector properties class.")
model CollectorPropertiesBaseWithAgent extends AzureResourceProperties {
  @doc("Gets or sets the collector agent properties.")
  agentProperties?: CollectorAgentPropertiesBase;

  @doc("Gets the discovery site id.")
  @visibility("read")
  discoverySiteId?: string;

  @doc("Gets the Timestamp when collector was created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("Timestamp when collector was last updated.")
  @visibility("read")
  updatedTimestamp?: string;
}

@doc("Collector agent property class.")
model CollectorAgentPropertiesBase {
  @doc("Gets the collector agent id.")
  @visibility("read")
  id?: string;

  @doc("Gets the collector agent version.")
  @visibility("read")
  version?: string;

  @doc("Gets the collector last heartbeat time.")
  @visibility("read")
  lastHeartbeatUtc?: utcDateTime;

  @doc("Gets or sets the SPN details.")
  spnDetails?: CollectorAgentSpnPropertiesBase;
}

@doc("Collector agent SPN details class.")
model CollectorAgentSpnPropertiesBase {
  @doc("Gets the AAD authority endpoint.")
  @visibility("read")
  authority?: string;

  @doc("Gets the AAD application id.")
  @visibility("read")
  applicationId?: string;

  @doc("Gets the AAD audience url.")
  @visibility("read")
  audience?: string;

  @doc("Gets the object id of the AAD application.")
  @visibility("read")
  objectId?: string;

  @doc("Gets the tenant id of the AAD application.")
  @visibility("read")
  tenantId?: string;
}
