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

/** Properties of an AI Gateway API key. */
@added(Versions.v2026_11_01)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  primaryKey?: string;

  /** Secondary key value. Omitted from ordinary read responses. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secondaryKey?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway API key. */
@added(Versions.v2026_11_01)
model AiGatewayApiKeyUpdateProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Subscription state. */
  state?: string;

  /** Optional expiration time. */
  expirationDate?: utcDateTime;

  /** Replacement primary key value. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  primaryKey?: string;

  /** Replacement secondary key value. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secondaryKey?: string;
}

/** Parameters for updating an AI Gateway API key. */
@added(Versions.v2026_11_01)
model AiGatewayApiKeyUpdateParameters {
  /** API key properties to update. */
  properties?: AiGatewayApiKeyUpdateProperties;
}

/** An AI Gateway API key resource. */
@added(Versions.v2026_11_01)
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
