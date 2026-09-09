import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ContainerAppsSandbox;

namespace ContainerAppsSandbox;

// Client-surface customizations. Every rule here is scoped to "csharp", so none of them affect the
// wire contract or the emitted OpenAPI under stable/ and preview/.
//
// Only types the emitter actually materializes can be renamed. HTTP envelope models ending in
// Result are unwrapped into Response<T> / Response and never become C# classes, so @@clientName
// rules on them are ineffective.

// The service namespace is ContainerAppsSandbox, so the emitter derives the root client name
// (ContainerAppsSandboxClient) on its own - no override needed for it.
// The sub-client accessor preserves an existing Client suffix, yielding GetSandboxesClient().
// The operationId in the OpenAPI stays AzureSandboxes_*.
@@clientName(AzureSandboxes, "SandboxesClient", "csharp");

// Qualify generic model names to avoid collisions with other libraries.
@@clientName(Connection, "SandboxConnection", "csharp");
@@clientName(Secret, "SandboxSecret", "csharp");
@@clientName(Sandbox, "ContainerAppsSandbox", "csharp");
@@clientName(Snapshot, "SandboxSnapshot", "csharp");

// SandboxVolume already describes a volume mount; this model is the group-scoped resource.
@@clientName(Volume, "SandboxGroupVolume", "csharp");

// Url -> Uri, matching .NET naming conventions.
@@clientName(Sandbox.appUrl, "appUri", "csharp");
@@clientName(Sandbox.managementUrl, "managementUri", "csharp");
@@clientName(GatewayConnection.mcpRuntimeUrl, "mcpRuntimeUri", "csharp");
@@clientName(
  GatewayConnection.connectionRuntimeUrl,
  "connectionRuntimeUri",
  "csharp"
);
@@clientName(GenerateConsentLinkContent.redirectUrl, "redirectUri", "csharp");

// Container image references can include registry names and tags rather than absolute URIs.
@@clientName(
  CreateDiskImageSourceRegistrySource.imageUrl,
  "imageReference",
  "csharp"
);

// Name response bodies independently of their HTTP envelopes.
@@clientName(
  GenerateConsentLinkResponse,
  "GenerateConsentLinkResult",
  "csharp"
);
@@clientName(ContentPackageListResponse, "ContentPackageListResult", "csharp");
@@clientName(
  NamedEgressPolicyListResponse,
  "NamedEgressPolicyListResult",
  "csharp"
);
@@clientName(DirListingResponse, "DirListingResult", "csharp");
@@clientName(FileOpStatusResponse, "FileOpStatusResult", "csharp");
@@clientName(WriteFileResponse, "WriteFileResult", "csharp");
@@clientName(ConnectionsListResponse, "ConnectionsListResult", "csharp");
@@clientName(EgressDecisionsResponse, "EgressDecisionsResult", "csharp");
@@clientName(PortsListResponse, "PortsListResult", "csharp");
@@clientName(CommitSandboxResponse, "CommitSandboxResult", "csharp");
@@clientName(
  SandboxExecuteCommandResponse,
  "SandboxExecuteCommandResult",
  "csharp"
);
@@clientName(
  SandboxExecuteShellCommandResponse,
  "SandboxExecuteShellCommandResult",
  "csharp"
);
@@clientName(SandboxStatsResponse, "SandboxStatsResult", "csharp");
@@clientName(SecretKeysResponse, "SecretKeysResult", "csharp");
@@clientName(SecretListResponse, "SecretListResult", "csharp");
@@clientName(SecretPeekResponse, "SecretPeekResult", "csharp");
@@clientName(VolumeCountResponse, "VolumeCountResult", "csharp");
@@clientName(
  VolumeListDirectoryResponse,
  "VolumeListDirectoryResult",
  "csharp"
);
