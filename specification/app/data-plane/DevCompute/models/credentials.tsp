namespace AzureDevCompute {
  /** Represents the state of a connection. */
  union ConnectionState {
    /** StringValue variant. */
    StringValue: string,

    /** Creating variant. */
    Creating: "Creating",

    /** Ready variant. */
    Ready: "Ready",

    /** Error variant. */
    Error: "Error",
  }

  /** Authentication configuration for a gateway connection (CosmosDB storage). */
  model GatewayConnectionAuthRecord {
    /** type value. */
    type: GatewayConnectionAuthType;

    /** identityResourceId value. */
    identityResourceId?: string;
  }

  /** Connector Namespace reference details required by egress HookRef resolution. */
  model SandboxGroupCredentialConnectionRefDetails {
    /** authentication value. */
    authentication: GatewayConnectionAuthRecord;

    /** tokenExchangeEndpoint value. */
    tokenExchangeEndpoint: string;
  }

  /** SandboxGroupCredentialOrigin wire model. */
  union SandboxGroupCredentialOrigin {
    /** StringValue variant. */
    StringValue: string,

    /** Credentials variant. */
    Credentials: "Credentials",

    /** Connections variant. */
    Connections: "Connections",
  }

  /** Supported provider credential kinds. */
  union SandboxGroupCredentialProvider {
    /** StringValue variant. */
    StringValue: string,

    /** GitHubCopilot variant. */
    GitHubCopilot: "GitHubCopilot",

    /** Claude variant. */
    Claude: "Claude",
  }

  /** SandboxGroupCredentialRequest wire model. */
  model SandboxGroupCredentialRequest {
    /** displayName value. */
    displayName?: string;

    /** provider value. */
    provider: SandboxGroupCredentialProvider;

    /** source value. */
    source: SandboxGroupCredentialSource;
  }

  /** SandboxGroupCredentialResponse wire model. */
  model SandboxGroupCredentialResponse {
    /** name value. */
    name: string;

    /** displayName value. */
    displayName?: string;

    /** provider value. */
    provider: SandboxGroupCredentialProvider;

    /** state value. */
    state: ConnectionState;

    /** source value. */
    source: SandboxGroupCredentialSource;

    /** origin value. */
    origin: SandboxGroupCredentialOrigin;
  }

  /** Stored source metadata for a sandbox group credential. */
  model SandboxGroupCredentialSource {
    /** kind value. */
    kind: SandboxGroupCredentialSourceKind;

    /** connectionResourceId value. */
    connectionResourceId?: string;

    /** connectionRefDetails value. */
    connectionRefDetails?: SandboxGroupCredentialConnectionRefDetails;

    /** parameterValues value. */
    parameterValues?: Record<string>;

    /** connectionId value. */
    connectionId?: ConnectionId;

    /** connectionType value. */
    connectionType?: string;

    /** connectionName value. */
    connectionName?: string;
  }

  /** Supported credential source kinds. */
  union SandboxGroupCredentialSourceKind {
    /** StringValue variant. */
    StringValue: string,

    /** Pat variant. */
    Pat: "Pat",

    /** SecretRef variant. */
    SecretRef: "SecretRef",

    /** GatewayConnectionRef variant. */
    GatewayConnectionRef: "GatewayConnectionRef",

    /** ExistingAdcConnection variant. */
    ExistingAdcConnection: "ExistingAdcConnection",
  }
}
