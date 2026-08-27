import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Provisioning state of an AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
union AiGatewayProvisioningState {
  string,

  /** The resource is ready. */
  Succeeded: "Succeeded",

  /** The resource operation failed. */
  Failed: "Failed",

  /** The resource operation was canceled. */
  Canceled: "Canceled",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

/** The type of an AI model provider. */
@added(Versions.v2026_09_01_preview)
union AiGatewayModelProviderKind {
  string,

  /** Azure AI Foundry provider. */
  Foundry: "Foundry",

  /** Custom model provider. */
  Custom: "Custom",
}

/** Authentication type used by an AI model provider. */
@added(Versions.v2026_09_01_preview)
union AiGatewayModelProviderAuthenticationKind {
  string,

  /** Authenticate using a managed identity. */
  ManagedIdentity: "ManagedIdentity",

  /** Authenticate using an API key. */
  ApiKey: "ApiKey",
}

/** Authentication type used by a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerCredentialKind {
  string,

  /** No credentials. */
  None: "None",

  /** Authenticate using an API key. */
  ApiKey: "ApiKey",
}

/** The type of a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerEndpointKind {
  string,

  /** Connect to an MCP server URL. */
  McpUrl: "McpUrl",

  /** Create an MCP endpoint from an OpenAPI document. */
  McpFromOpenApi: "McpFromOpenApi",
}

/** Transport used to connect to an MCP server. */
@added(Versions.v2026_09_01_preview)
union AiGatewayMcpTransport {
  string,

  /** Streamable HTTP transport. */
  StreamableHttp: "StreamableHttp",
}

/** Source type for an OpenAPI document. */
@added(Versions.v2026_09_01_preview)
union AiGatewayOpenApiSpecSourceKind {
  string,

  /** The OpenAPI document is supplied inline. */
  Inline: "Inline",

  /** The OpenAPI document is loaded from a URL. */
  Url: "Url",
}

/** API key slot to regenerate. */
@added(Versions.v2026_09_01_preview)
union AiGatewayApiKeyTarget {
  string,

  /** The primary key. */
  Primary: "Primary",

  /** The secondary key. */
  Secondary: "Secondary",
}

alias AiGatewayIfMatchOptional = {
  /** ETag of the resource. Required for an update. */
  @header("If-Match")
  ifMatch?: string;
};
