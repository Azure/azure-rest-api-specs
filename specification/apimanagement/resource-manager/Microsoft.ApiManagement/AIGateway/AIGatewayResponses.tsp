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

/** Credential returned for a model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCredentialValue {
  /** Stored credential value. */
  @secret
  value?: string;
}

/** Secret values configured on tool server endpoints. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecrets {
  /** Endpoint secret values. */
  @identifiers(#["id"])
  endpoints: AiGatewayToolServerSecret[];
}

/** Secret value configured on one tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecret {
  /** Stable endpoint identifier. */
  id: string;

  /** Endpoint authentication including secret values. */
  credentials?: AiGatewayToolServerCredentials;

  /** OpenAPI configuration including inline content. */
  openApi?: AiGatewayOpenApiConfiguration;
}

/** Primary and secondary API key values. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyValues {
  /** Primary API key value. */
  @secret
  primaryKey: string;

  /** Secondary API key value. */
  @secret
  secondaryKey: string;
}
