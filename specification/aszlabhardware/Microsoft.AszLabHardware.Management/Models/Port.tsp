@doc("Information regarding an individual port")
model Port {
  @doc("Id of port")
  portId: string;

  @doc("Link type of port")
  linkType?: string;

  @doc("Link speed of port in Mbps")
  linkSpeedMbps: int64;

  @doc("Link status of port")
  linkStatus?: string;

  @doc("Associated MACs of port")
  associatedMacs?: string[];
}
