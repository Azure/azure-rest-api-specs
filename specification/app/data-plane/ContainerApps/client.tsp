import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using ContainerAppsSandbox;

namespace ContainerAppsSandbox;

// Client-surface customizations. Every rule here is scoped to "csharp", so none of them affect the
// wire contract or the emitted OpenAPI under stable/ and preview/.
//
// Only types the emitter actually materializes can be renamed. HTTP envelope models
// (SandboxListResult, SandboxCreatedResult, SandboxDeletedResult,
// SandboxDeletedNoContentResult, SandboxResult, SandboxExecutionTokensContent,
// ErrorResult) are unwrapped by the emitter into
// Response<T> / Response and never become C# classes, so @@clientName on them is silently a no-op.
// Seven such dead rules were removed; do not add more.

// The service namespace is ContainerAppsSandbox, so the emitter derives the root client name
// (ContainerAppsSandboxClient) on its own - no override needed for it.
// The sub-client keeps a bare name: the accessor is generated as "Get" + <name> + "Client", so
// "Sandboxes" yields GetSandboxesClient(). The operationId in the OpenAPI stays AzureSandboxes_*.
@@clientName(AzureSandboxes, "Sandboxes", "csharp");

// Url -> Uri, matching .NET naming conventions.
@@clientName(Sandbox.appUrl, "appUri", "csharp");
@@clientName(Sandbox.managementUrl, "managementUri", "csharp");
@@clientName(GatewayConnection.mcpRuntimeUrl, "mcpRuntimeUri", "csharp");
@@clientName(
  GatewayConnection.connectionRuntimeUrl,
  "connectionRuntimeUri",
  "csharp"
);

// Request bodies surface as "Content" per the Azure .NET guidelines. These two are the only
// request models the emitter materializes as classes.
@@clientName(SandboxRequest, "SandboxContent", "csharp");
@@clientName(AddPortRequest, "AddPortContent", "csharp");
