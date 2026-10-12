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

/** A successful existence check, with no response body. */
@added(Versions.v2026_10_01_preview)
@clientName("AiGatewayResourceExistsResult", "csharp")
model AiGatewayResourceExistsResponse {
  /** HTTP status for an existing resource. */
  @statusCode
  statusCode: 200;

  /** Entity tag of the resource. */
  @header("ETag")
  eTag?: string;
}

/** Parameters for checking an AI Gateway name in a location. */
@added(Versions.v2026_10_01_preview)
@clientName("AiGatewayCheckNameAvailabilityContent", "csharp")
model AiGatewayCheckNameAvailabilityRequest {
  /** Name to validate and check for availability. */
  name: string;

  /** Resource type to check. When supplied, must be Microsoft.ApiManagement/aigateways. */
  type?: string;
}

/** Result of name validation and availability checking. */
@added(Versions.v2026_10_01_preview)
union AiGatewayNameAvailabilityReason {
  string,

  /** The name is valid and available. */
  Valid: "Valid",

  /** The name does not satisfy gateway naming requirements. */
  Invalid: "Invalid",

  /** A gateway with this name already exists in the location. */
  AlreadyExists: "AlreadyExists",
}

/** Availability of an AI Gateway name in a location. */
@added(Versions.v2026_10_01_preview)
@clientName("AiGatewayCheckNameAvailabilityResult", "csharp")
model AiGatewayCheckNameAvailabilityResponse {
  /** Whether the name is valid and available. */
  nameAvailable: boolean;

  /** Reason for the availability result. */
  reason?: AiGatewayNameAvailabilityReason;

  /** Additional information about the availability result. */
  message?: string;
}

/** Links for completing OAuth consent for a tool-server endpoint. */
@added(Versions.v2026_10_01_preview)
model AiGatewayToolServerOauth2LoginLinks {
  /** Gateway URL to open to begin consent; includes an expiring signed capability. */
  loginLink?: url;

  /** Gateway callback URI to register with the identity provider. */
  redirectUri?: url;

  /** UTC expiry of the signed start capability. */
  expiresUtc: utcDateTime;
}

/** A client-facing endpoint for invoking an AI Gateway resource. */
@added(Versions.v2026_10_01_preview)
model AiGatewayEndpoint {
  /** Complete HTTPS invocation URL. */
  @visibility(Lifecycle.Read)
  url: url;

  /** HTTPS base URL for SDKs that construct operation paths, when metadata is enabled. */
  @visibility(Lifecycle.Read)
  @clientName("baseUri", "csharp")
  baseUrl?: url;

  /** API identifier relative to the provider prefix, when metadata is enabled. */
  @visibility(Lifecycle.Read)
  api?: string;
}

/** Credential returned for a model provider. */
@added(Versions.v2026_10_01_preview)
model AiGatewayCredentialValue {
  /** Stored credential value. */
  @secret
  value?: string;
}

/** Secret values configured on tool server endpoints. */
@added(Versions.v2026_10_01_preview)
model AiGatewayToolServerSecrets {
  /** Endpoint secret values. */
  @identifiers(#["id"])
  endpoints: AiGatewayToolServerSecret[];
}

/** Secret value configured on one tool server endpoint. */
@added(Versions.v2026_10_01_preview)
model AiGatewayToolServerSecret {
  /** Stable endpoint identifier. */
  id: string;

  /** Endpoint authentication including secret values. */
  credentials?: AiGatewayToolServerCredentials;

  /** OpenAPI configuration including inline content. */
  openApi?: AiGatewayOpenApiConfiguration;
}

/** Primary and secondary API key values. */
@added(Versions.v2026_10_01_preview)
model AiGatewayApiKeyValues {
  /** Primary API key value. */
  @secret
  primaryKey: string;

  /** Secondary API key value. */
  @secret
  secondaryKey: string;
}
