import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
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
}

/** The type of an AI model provider. */
@added(Versions.v2026_11_01)
union AiGatewayModelProviderKind {
  string,

  /** Azure AI Foundry provider. */
  Foundry: "Foundry",

  /** Custom model provider. */
  Custom: "Custom",

  /** GitHub model provider. */
  GitHub: "GitHub",
}

/** An outbound service destination URL. */
@added(Versions.v2026_11_01)
model AiGatewayDestinationEndpoint {
  /** Destination HTTPS or HTTP URL. */
  url: url;
}

/** An outbound service destination URL to update. */
@added(Versions.v2026_11_01)
model AiGatewayDestinationEndpointUpdate {
  /** Destination HTTPS or HTTP URL. */
  url?: url;
}

/** A name/value pair entry. */
@added(Versions.v2026_11_01)
model AiGatewayNameValuePair {
  /** Entry name. */
  name: string;

  /** Entry value. */
  value: string;
}

/** A name/value pair entry to update. */
@added(Versions.v2026_11_01)
model AiGatewayNameValuePairUpdate
  is OptionalProperties<AiGatewayNameValuePair>;

/** A secret HTTP header injected into an outbound request. */
@added(Versions.v2026_11_01)
model AiGatewaySecretHeader {
  /** HTTP header name. */
  name: string;

  /** Secret HTTP header value. Omitted from ordinary read responses. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/** A secret HTTP header to update. */
@added(Versions.v2026_11_01)
model AiGatewaySecretHeaderUpdate {
  /** HTTP header name. */
  name?: string;

  /** Secret HTTP header value. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/** A secret HTTP header returned by a secret-retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewaySecretHeaderValue {
  /** HTTP header name. */
  name: string;

  /** Secret HTTP header value. */
  @secret
  value?: string;
}

/** Managed identity settings for an outbound connection. */
@added(Versions.v2026_11_01)
model AiGatewayManagedIdentityAuthentication {
  /** Target Entra resource or audience URI requested for managed identity authentication. */
  resource?: string;

  /** Client ID of a user-assigned managed identity; omit for system-assigned identity. */
  clientId?: string;
}

/** Resilience failure mode for an outbound endpoint or hook. */
@added(Versions.v2026_11_01)
union AiGatewayFailureMode {
  string,

  /** Continue processing when the endpoint or hook fails. */
  FailOpen: "failOpen",

  /** Fail the request when the endpoint or hook fails. */
  FailClosed: "failClosed",
}

alias AiGatewayIfMatchOptional = {
  /** ETag of the resource. Required for an update. */
  @header("If-Match")
  ifMatch?: string;

  /** Set to '*' to allow creating a new resource, but prevent updating an existing resource. */
  @header("If-None-Match")
  ifNoneMatch?: string;
};
