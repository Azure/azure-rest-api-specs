using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

union SandboxGroupCredentialOrigin {
  "Credentials",
  "Connections",
}

/** Supported provider credential kinds. */
union SandboxGroupCredentialProvider {
  "GitHubCopilot",
  "Claude",
}

model SandboxGroupCredentialRequestView {
  displayName?: null | string;
  provider: SandboxGroupCredentialProvider;
  source: SandboxGroupCredentialSource;
}

model SandboxGroupCredentialResponseView {
  name: string;
  displayName?: null | string;
  provider: SandboxGroupCredentialProvider;
  state: ConnectionState;
  source: SandboxGroupCredentialSource;
  origin: SandboxGroupCredentialOrigin;
}

/** Stored source metadata for a sandbox group credential. */
model SandboxGroupCredentialSource {
  kind: SandboxGroupCredentialSourceKind;
  connectionResourceId?: null | string;
  @oneOf connectionRefDetails?:
    | null
    | SandboxGroupCredentialConnectionRefDetails;

  @secret
  parameterValues?: null | Record<string>;

  @oneOf connectionId?: null | ConnectionId;
  connectionType?: null | string;
  connectionName?: null | string;
}

/** Supported credential source kinds. */
union SandboxGroupCredentialSourceKind {
  "Pat",
  "SecretRef",
  "GatewayConnectionRef",
  "ExistingAdcConnection",
}
