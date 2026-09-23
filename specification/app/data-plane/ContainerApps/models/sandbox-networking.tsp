namespace ContainerAppsSandbox {
  /** Identifies a connection to attach to a sandbox. */
  model AddConnectionContent {
    /** The connection identifier. */
    connectionId: ConnectionId;
  }

  /** Connections currently attached to a sandbox. */
  model ConnectionsListResponse {
    /** The identifiers of connections attached to the sandbox. */
    connectionIds: string[];
  }

  /** Single egress decision entry. */
  model EgressDecisionEntry {
    /** Timestamp of the request. */
    timestamp: utcDateTime;

    /** Host header of the request. */
    host?: string;

    /** HTTP method (GET, POST, etc.). */
    method?: string;

    /** Request path. */
    path?: string;

    /** Scheme (http, https). */
    scheme?: string;

    /** The connection associated with the request, when applicable. */
    connectionId?: ConnectionId;

    /** Connection display name if this is an API Hub connector call. */
    connectionName?: string;

    /** Name of the egress policy rule that matched this request. */
    matchedRule?: string;
  }

  /** Recent network egress decisions for a sandbox. */
  model EgressDecisionsResponse {
    /** HTTP egress decisions. */
    http: NetworkEgressDecisions;

    /** Recent stateful TCP connection decisions. */
    statefulTcp?: StatefulTcpEgress;

    /** The time when the decision data was last updated. */
    lastUpdated: utcDateTime;
  }

  /** Network egress decisions (allowed and denied). */
  model NetworkEgressDecisions {
    /** Last 50 allowed egress requests (most recent first). */
    allowed: EgressDecisionEntry[];

    /** Last 50 denied egress requests (most recent first). */
    denied: EgressDecisionEntry[];
  }

  /** Partial update for one sandbox port. */
  model UpdateSandboxPortContent {
    /** The port number to update. */
    port?: int32;

    /** The port name to update. */
    name?: string;

    /** The replacement authentication configuration. */
    auth?: PortAuthConfig;

    /** The replacement activation mode. */
    activationMode?: PortActivationMode;

    /** The replacement forwarding protocol. */
    protocol?: PortProtocol;

    /** The replacement IP access-control configuration. */
    ipAccessControl?: IpAccessControl;

    /** The replacement CORS configuration. */
    cors?: PortCorsConfig;
  }

  /** Ports configured on a sandbox. */
  model PortsListResponse {
    /** The sandbox ports. */
    ports: SandboxPort[];
  }

  /** Identifies a sandbox port to remove. */
  model RemovePortContent {
    /** The port name. */
    name?: string;

    /** The port number. */
    port?: int32;
  }

  /** Recent stateful TCP connection events. */
  model StatefulTcpEgress {
    /** Last 50 stateful-TCP connection audit entries (most recent first). */
    connections?: StatefulTcpEntry[];
  }

  /** An event from a stateful TCP connection. */
  model StatefulTcpEntry {
    /** When this phase event was emitted. */
    timestamp: utcDateTime;

    /** Lifecycle phase: "Established" or "Closed". */
    phase?: string;

    /** Connection outcome (Connected, PolicyDenied, LoginFailed, ...). */
    outcome?: string;

    /** Connector type (e.g. "AzureSql"). */
    connectorType?: string;

    /** Target backend hostname. */
    server?: string;

    /** Target backend port. */
    port?: int32;

    /** Target database (informational). */
    database?: string;

    /** Masked SQL login used for the connection. */
    proxyLoginName?: string;

    /** Live client source IP of the sandbox connection. */
    sourceIp?: string;

    /** Identifier shared by events for the same connection. */
    correlationId?: string;

    /** Bytes received from the sandbox (final only on the Closed phase). */
    bytesIn?: int64;

    /** Bytes sent to the backend (final only on the Closed phase). */
    bytesOut?: int64;

    /** Elapsed time from accept to this phase, in milliseconds. */
    durationMs?: int64;

    /** Optional failure detail when the outcome is not Connected. */
    failureReason?: string;

    /** When the connection was accepted (identical across both phases). */
    startedAt?: utcDateTime;
  }

  /** The complete set of ports to configure on a sandbox. */
  model UpdatePortsContent {
    /** The ports that replace the current configuration. */
    ports: SandboxPortUpdate[];
  }

  /**
   * Complete port representation accepted by the replace-all ports operation.
   * The current service contract requires the URL even though it is normally
   * assigned by the service.
   */
  model SandboxPortUpdate {
    /** Optional port name. */
    name?: string;

    /** Port number. */
    port: SandboxPortNumber;

    /** Current port URL required by the replace-all operation. */
    url: url;

    /** Authentication configuration. */
    auth?: PortAuthConfig;

    /** Activation mode. */
    activationMode?: PortActivationMode;

    /** HTTP protocol. */
    protocol?: PortProtocol;

    /** IP access-control configuration. */
    ipAccessControl?: IpAccessControl;

    /** CORS configuration. */
    cors?: PortCorsConfig;
  }
}
