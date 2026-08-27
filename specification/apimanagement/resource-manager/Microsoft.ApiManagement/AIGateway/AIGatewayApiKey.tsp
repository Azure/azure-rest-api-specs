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

/** Properties of an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Subscription state. */
  state?: string;

  /** Creation time. */
  @visibility(Lifecycle.Read)
  createdDate?: utcDateTime;

  /** Optional expiration time. */
  expirationDate?: utcDateTime;

  /** Primary key value. Omitted from ordinary read responses. */
  @secret
  primaryKey?: string;

  /** Secondary key value. Omitted from ordinary read responses. */
  @secret
  secondaryKey?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyUpdateProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Subscription state. */
  state?: string;

  /** Optional expiration time. */
  expirationDate?: utcDateTime;
}

/** Parameters for updating an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyUpdateParameters {
  /** API key properties to update. */
  properties?: AiGatewayApiKeyUpdateProperties;
}

/** An AI Gateway API key resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayResource)
model AiGatewayApiKeyResource
  is Azure.ResourceManager.ProxyResource<AiGatewayApiKeyProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayApiKeyResource,
    KeyName = "apiKeyName",
    SegmentName = "apiKeys",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}
