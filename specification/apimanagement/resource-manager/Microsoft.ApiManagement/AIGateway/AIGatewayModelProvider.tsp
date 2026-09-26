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

/** API key credentials for an upstream service. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyCredential {
  /** Name of the HTTP header that carries the API key. */
  headerName: string;

  /** Secret API key value. This value is not returned by read operations. */
  @secret
  value?: string;
}

/** Authentication configuration for a Foundry model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryAuthentication {
  /** Authentication type. */
  kind: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. Applicable when kind is ManagedIdentity. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. Required when kind is ApiKey. */
  apiKey?: AiGatewayApiKeyCredential;
}

/** Managed identity settings for a model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayManagedIdentityAuthentication {
  /** Token audience requested for managed identity authentication. */
  resource?: string;

  /** Client ID of a user-assigned managed identity. */
  clientId?: string;
}

/** Foundry model provider configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryProviderConfiguration {
  /** Foundry endpoint. */
  endpoint?: string;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds: string[];

  /** Authentication configuration. */
  authentication: AiGatewayFoundryAuthentication;
}

/** Authentication configuration for a custom model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomAuthentication {
  /** Authentication type. */
  kind: "ApiKey";

  /** API key configuration. */
  apiKey: AiGatewayApiKeyCredential;
}

/** Custom model provider configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomProviderConfiguration {
  /** Provider base endpoint. */
  endpoint: string;

  /** Authentication configuration. */
  authentication: AiGatewayCustomAuthentication;
}

/** API key credentials for updating an upstream service. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyCredentialUpdate {
  /** Name of the HTTP header that carries the API key. */
  headerName?: string;

  /** Secret API key value. */
  @secret
  value?: string;
}

/** Foundry authentication settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryAuthenticationUpdate {
  /** Authentication type. */
  kind?: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Foundry model provider settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryProviderConfigurationUpdate {
  /** Foundry endpoint. */
  endpoint?: string;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds?: string[];

  /** Authentication configuration. */
  authentication?: AiGatewayFoundryAuthenticationUpdate;
}

/** Custom model provider authentication settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomAuthenticationUpdate {
  /** Authentication type. */
  kind?: "ApiKey";

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Custom model provider settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomProviderConfigurationUpdate {
  /** Provider base endpoint. */
  endpoint?: string;

  /** Authentication configuration. */
  authentication?: AiGatewayCustomAuthenticationUpdate;
}

/** Properties for updating an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderUpdateProperties {
  /** Model provider type. */
  kind?: AiGatewayModelProviderKind;

  /** Display name of the model provider. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. */
  foundry?: AiGatewayFoundryProviderConfigurationUpdate;

  /** Custom provider configuration. */
  custom?: AiGatewayCustomProviderConfigurationUpdate;
}

/** Parameters for updating an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderUpdateParameters {
  /** Model provider properties to update. */
  properties?: AiGatewayModelProviderUpdateProperties;
}

/** Properties of an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderProperties {
  /** Model provider type. This value cannot be changed after creation. */
  kind: AiGatewayModelProviderKind;

  /** Display name of the model provider. */
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. Required when kind is Foundry. */
  foundry?: AiGatewayFoundryProviderConfiguration;

  /** Custom provider configuration. Required when kind is Custom. */
  custom?: AiGatewayCustomProviderConfiguration;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway model provider resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayModelProviderResource
  is Azure.ResourceManager.ProxyResource<AiGatewayModelProviderProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayModelProviderResource,
    KeyName = "modelProviderName",
    SegmentName = "modelProviders",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}
