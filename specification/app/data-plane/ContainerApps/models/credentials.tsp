#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
  /** Managed identity type stored for a gateway-connection credential. */
  union GatewayConnectionAuthType {
    string,

    /** Uses the sandbox group's system-assigned managed identity. */
    SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

    /** Uses a user-assigned managed identity. */
    UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
  }

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

  /** Request body for creating or updating a sandbox-group credential. */
  model CreateSandboxGroupCredentialContent {
    /** displayName value. */
    displayName?: string;

    /** provider value. */
    provider: SandboxGroupCredentialProvider;

    /** source value. */
    source: SandboxGroupCredentialSource;
  }

  /** Customer-facing sandbox-group credential resource returned by the service. */
  model SandboxGroupCredential {
    /** Credential name assigned by the service. */
    @visibility(Lifecycle.Read)
    name: string;

    /** displayName value. */
    displayName?: string;

    /** provider value. */
    provider: SandboxGroupCredentialProvider;

    /** Current credential state. */
    @visibility(Lifecycle.Read)
    state: ConnectionState;

    /** source value. */
    source: SandboxGroupCredentialSource;

    /** Origin of the credential. */
    @visibility(Lifecycle.Read)
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
