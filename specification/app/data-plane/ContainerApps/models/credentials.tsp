using Rest;

namespace ContainerAppsSandbox {
  /** Managed identity type stored for a gateway-connection credential. */
  union GatewayConnectionAuthType {
    string,

    /** Uses the sandbox group's system-assigned managed identity. */
    SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

    /** Uses a user-assigned managed identity. */
    UserAssignedManagedIdentity: "UserAssignedManagedIdentity",
  }

  /** The provisioning state of a credential or connection. */
  union ConnectionState {
    /** An unrecognized state returned by the service. */
    StringValue: string,

    /** The resource is being created. */
    Creating: "Creating",

    /** The resource is ready for use. */
    Ready: "Ready",

    /** The resource could not be provisioned. */
    Error: "Error",
  }

  /** Managed identity authentication for a gateway connection. */
  model GatewayConnectionAuthRecord {
    /** The managed identity type. */
    type: GatewayConnectionAuthType;

    /** The resource ID of the user-assigned managed identity. */
    identityResourceId?: string;
  }

  /** Connector Namespace reference details required by egress HookRef resolution. */
  model SandboxGroupCredentialConnectionRefDetails {
    /** Authentication used by the referenced connection. */
    authentication: GatewayConnectionAuthRecord;

    /** The endpoint used to exchange tokens for the connection. */
    tokenExchangeEndpoint: string;
  }

  /** The service feature that created the credential. */
  union SandboxGroupCredentialOrigin {
    /** An unrecognized origin returned by the service. */
    StringValue: string,

    /** The credential was created through the credentials API. */
    Credentials: "Credentials",

    /** The credential was created for a connection. */
    Connections: "Connections",
  }

  /** Supported provider credential kinds. */
  union SandboxGroupCredentialProvider {
    /** An unrecognized provider returned by the service. */
    StringValue: string,

    /** A GitHub Copilot credential. */
    GitHubCopilot: "GitHubCopilot",

    /** A Claude credential. */
    Claude: "Claude",
  }

  /** Request body for creating or updating a sandbox-group credential. */
  model CreateSandboxGroupCredentialContent {
    /** A display name for the credential. */
    displayName?: string;

    /** The provider that uses the credential. */
    provider: SandboxGroupCredentialProvider;

    /** The source of the credential material. */
    source: SandboxGroupCredentialSource;
  }

  /** Customer-facing sandbox-group credential resource returned by the service. */
  @resource("credentials")
  @parentResource(SandboxGroupScope)
  model SandboxGroupCredential {
    /** Credential name assigned by the service. */
    @key("credentialName")
    @visibility(Lifecycle.Read)
    name: string;

    /** The credential display name. */
    displayName?: string;

    /** The provider that uses the credential. */
    provider: SandboxGroupCredentialProvider;

    /** Current credential state. */
    @visibility(Lifecycle.Read)
    state: ConnectionState;

    /** The source metadata for the credential. */
    source: SandboxGroupCredentialSource;

    /** Origin of the credential. */
    @visibility(Lifecycle.Read)
    origin: SandboxGroupCredentialOrigin;
  }

  /** Stored source metadata for a sandbox group credential. */
  model SandboxGroupCredentialSource {
    /** The credential source type. */
    kind: SandboxGroupCredentialSourceKind;

    /** The Azure resource ID of the referenced connection. */
    connectionResourceId?: string;

    /** Authentication details for the referenced gateway connection. */
    connectionRefDetails?: SandboxGroupCredentialConnectionRefDetails;

    /** Sensitive provider parameters for the credential. */
    @secret
    @visibility(Lifecycle.Create, Lifecycle.Update)
    parameterValues?: Record<string>;

    /** The identifier of an existing connection. */
    connectionId?: ConnectionId;

    /** The type of the referenced connection. */
    connectionType?: string;

    /** The name of the referenced connection. */
    connectionName?: string;
  }

  /** Supported credential source kinds. */
  union SandboxGroupCredentialSourceKind {
    /** An unrecognized source kind returned by the service. */
    StringValue: string,

    /** A personal access token supplied directly. */
    Pat: "Pat",

    /** A reference to a stored secret. */
    SecretRef: "SecretRef",

    /** A reference to a gateway connection. */
    GatewayConnectionRef: "GatewayConnectionRef",

    /** A reference to an existing sandbox connection. */
    ExistingAdcConnection: "ExistingAdcConnection",
  }
}
