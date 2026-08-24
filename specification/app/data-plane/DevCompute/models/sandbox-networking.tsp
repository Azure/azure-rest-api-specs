namespace AzureDevCompute {
  /** AddConnectionRequest wire model. */
  model AddConnectionRequest {
    /** connectionId value. */
    connectionId: ConnectionId;
  }

  /** ConnectionsListResponse wire model. */
  model ConnectionsListResponse {
    /** connectionIds value. */
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

    /** connectionId value. */
    connectionId?: ConnectionId;

    /** Connection display name if this is an API Hub connector call. */
    connectionName?: string;

    /** Name of the egress policy rule that matched this request. */
    matchedRule?: string;
  }

  /** EgressDecisionsResponse wire model. */
  model EgressDecisionsResponse {
    /** networkEgress value. */
    networkEgress: NetworkEgressDecisions;

    /** statefulTcp value. */
    statefulTcp?: StatefulTcpEgress;

    /** lastUpdated value. */
    lastUpdated: utcDateTime;
  }

  /** Network egress decisions (allowed and denied). */
  model NetworkEgressDecisions {
    /** Last 50 allowed egress requests (most recent first). */
    allowed: EgressDecisionEntry[];

    /** Last 50 denied egress requests (most recent first). */
    denied: EgressDecisionEntry[];
  }

  /** PatchPortRequest wire model. */
  model PatchPortRequest {
    /** port value. */
    port?: int32;

    /** name value. */
    name?: string;

    /** auth value. */
    auth?: PortAuthConfig;

    /** activationMode value. */
    activationMode?: PortActivationMode;

    /** protocol value. */
    protocol?: PortProtocol;

    /** ipAccessControl value. */
    ipAccessControl?: IpAccessControl;

    /** cors value. */
    cors?: PortCorsConfig;
  }

  /** PortsListResponse wire model. */
  model PortsListResponse {
    /** ports value. */
    ports: SandboxPort[];
  }

  /** RemovePortRequest wire model. */
  model RemovePortRequest {
    /** name value. */
    name?: string;

    /** port value. */
    port?: int32;
  }

  /** Stateful-TCP (TDS) egress connection audit entries. A single recent-connections list carries both lifecycle phases (Established, Closed); consumers pair them by string? DataPlaneStatefulTcpEntry.CorrelationId. */
  model StatefulTcpEgress {
    /** Last 50 stateful-TCP connection audit entries (most recent first). */
    connections?: StatefulTcpEntry[];
  }

  /** Single stateful-TCP (TDS) connection audit entry (one lifecycle phase of a connection). */
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

    /** SQL login used after proxy injection, masked to a prefix before it reaches this customer-facing view (never the connector's full username). */
    proxyLoginName?: string;

    /** Live client source IP of the sandbox connection. */
    sourceIp?: string;

    /** Short per-connection correlation id; identical across a connection's two phase entries. */
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

  /** UpdatePortsRequest wire model. */
  model UpdatePortsRequest {
    /** ports value. */
    ports: SandboxPort[];
  }
}
