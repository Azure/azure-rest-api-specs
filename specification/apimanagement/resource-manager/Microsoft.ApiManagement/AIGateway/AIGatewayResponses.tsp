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

/** A successful existence check, with no response body. */
@added(Versions.v2026_11_01)
model AiGatewayResourceExistsResponse {
  /** HTTP status for an existing resource. */
  @statusCode
  statusCode: 200;

  /** Entity tag of the resource. */
  @header("ETag")
  eTag?: string;
}

/** Parameters for checking an AI Gateway name in a location. */
@added(Versions.v2026_11_01)
model AiGatewayCheckNameAvailabilityRequest {
  /** Name to validate and check for availability. */
  @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
  @minLength(3)
  @maxLength(24)
  name: string;

  /** Resource type to check. */
  type: "Microsoft.ApiManagement/aigateways";
}

/** Result of name validation and availability checking. */
@added(Versions.v2026_11_01)
union AiGatewayNameAvailabilityReason {
  string,

  /** The name does not satisfy gateway naming requirements. */
  Invalid: "Invalid",

  /** A gateway with this name already exists in the location. */
  AlreadyExists: "AlreadyExists",
}

/** Availability of an AI Gateway name in a location. */
@added(Versions.v2026_11_01)
model AiGatewayCheckNameAvailabilityResponse {
  /** Whether the name is valid and available. */
  nameAvailable: boolean;

  /** Reason for the availability result. */
  reason?: AiGatewayNameAvailabilityReason;

  /** Additional information about the availability result. */
  message?: string;
}

/** Links for completing OAuth consent for a tool-server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerOauth2LoginLinks {
  /** Gateway URL to open to begin consent; includes an expiring signed capability. */
  @secret
  loginLink?: url;

  /** Gateway callback URI to register with the identity provider. */
  redirectUri?: url;

  /** UTC expiry of the signed start capability. */
  expiresUtc: utcDateTime;
}

/** A client-facing endpoint for invoking an AI Gateway resource. */
@added(Versions.v2026_11_01)
model AiGatewayEndpoint {
  /** Complete HTTPS invocation URL. */
  @visibility(Lifecycle.Read)
  url: url;

  /** HTTPS base URL for SDKs that construct operation paths, when metadata is enabled. */
  @visibility(Lifecycle.Read)
  baseUrl?: url;

  /** API identifier relative to the provider prefix, when metadata is enabled. */
  @visibility(Lifecycle.Read)
  api?: string;
}

/** Credential returned for a model provider. */
@added(Versions.v2026_11_01)
model AiGatewayCredentialValue {
  /** Stored credential value. */
  @secret
  value?: string;
}

/** Secret values configured on tool server endpoints. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecrets {
  /** Endpoint secret values. */
  @identifiers(#["id"])
  endpoints: AiGatewayToolServerSecret[];
}

/** An endpoint header returned by the secret retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecretHeader {
  ...OmitProperties<AiGatewayToolServerHeader, "values">;

  /** Secret values for the HTTP header. */
  @secret
  values: string[];
}

/** OAuth settings returned by the secret retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecretOauth2Authentication {
  ...OmitProperties<AiGatewayToolServerOauth2Authentication, "clientSecret">;

  /** OAuth client secret. */
  @secret
  clientSecret?: string;
}

/** Endpoint credentials returned by the secret retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecretCredentials {
  ...OmitProperties<AiGatewayToolServerCredentials, "headers" | "oauth2">;

  /** Static headers injected when calling the endpoint. */
  @identifiers(#["name"])
  headers?: AiGatewayToolServerSecretHeader[];

  /** OAuth 2.0 configuration. */
  oauth2?: AiGatewayToolServerSecretOauth2Authentication;
}

/** OpenAPI document source returned by the secret retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecretOpenApiSpecSource {
  ...OmitProperties<AiGatewayOpenApiSpecSource, "contentBase64">;

  /** Base64-encoded OpenAPI document. Required when kind is Inline. */
  @secret
  contentBase64?: bytes;
}

/** OpenAPI settings returned by the secret retrieval action. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecretOpenApiConfiguration {
  /** OpenAPI document source. */
  specSource: AiGatewayToolServerSecretOpenApiSpecSource;
}

/** Secret value configured on one tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerSecret {
  /** Stable endpoint identifier. */
  id: string;

  /** Endpoint authentication including secret values. */
  credentials?: AiGatewayToolServerSecretCredentials;

  /** OpenAPI configuration including inline content. */
  openApi?: AiGatewayToolServerSecretOpenApiConfiguration;
}

/** Primary and secondary API key values. */
@added(Versions.v2026_11_01)
model AiGatewayApiKeyValues {
  /** Primary API key value. */
  @secret
  primaryKey: string;

  /** Secondary API key value. */
  @secret
  secondaryKey: string;
}
