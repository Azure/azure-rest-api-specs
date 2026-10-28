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

/** API key credentials for an upstream service. */
@added(Versions.v2026_11_01)
model AiGatewayApiKeyCredential {
  /** Name of the HTTP header that carries the API key. */
  headerName: string;

  /** Secret API key value. This value is not returned by read operations. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/** Authentication configuration for a Foundry model provider. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryAuthentication {
  /** Authentication type. */
  kind: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. Applicable when kind is ManagedIdentity. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. Required when kind is ApiKey. */
  apiKey?: AiGatewayApiKeyCredential;
}

/** Managed identity settings for a model provider. */
@added(Versions.v2026_11_01)
model AiGatewayManagedIdentityAuthentication {
  /** Token audience requested for managed identity authentication. */
  resource?: string;

  /** Client ID of a user-assigned managed identity. */
  clientId?: string;
}

/** Foundry model provider configuration. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryProviderConfiguration {
  /** Foundry endpoint. */
  endpoint?: url;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>[];

  /** Authentication configuration. */
  authentication: AiGatewayFoundryAuthentication;
}

/** Authentication configuration for a custom model provider. */
@added(Versions.v2026_11_01)
model AiGatewayCustomAuthentication {
  /** Authentication type. */
  kind: "ApiKey";

  /** API key configuration. */
  apiKey: AiGatewayApiKeyCredential;
}

/** Custom model provider configuration. */
@added(Versions.v2026_11_01)
model AiGatewayCustomProviderConfiguration {
  /** Provider base endpoint. */
  endpoint: url;

  /** Authentication configuration. */
  authentication: AiGatewayCustomAuthentication;
}

/** API key credentials for updating an upstream service. */
@added(Versions.v2026_11_01)
model AiGatewayApiKeyCredentialUpdate {
  /** Name of the HTTP header that carries the API key. */
  headerName?: string;

  /** Secret API key value. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/** Foundry authentication settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryAuthenticationUpdate {
  /** Authentication type. */
  kind?: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Foundry model provider settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryProviderConfigurationUpdate {
  /** Foundry endpoint. */
  endpoint?: url;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>[];

  /** Authentication configuration. */
  authentication?: AiGatewayFoundryAuthenticationUpdate;
}

/** Custom model provider authentication settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayCustomAuthenticationUpdate {
  /** Authentication type. */
  kind?: "ApiKey";

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Custom model provider settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayCustomProviderConfigurationUpdate {
  /** Provider base endpoint. */
  endpoint?: url;

  /** Authentication configuration. */
  authentication?: AiGatewayCustomAuthenticationUpdate;
}

/** Properties for updating an AI Gateway model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelProviderUpdateProperties {
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
@added(Versions.v2026_11_01)
model AiGatewayModelProviderUpdateParameters {
  /** Model provider properties to update. */
  properties?: AiGatewayModelProviderUpdateProperties;
}

/** Properties of an AI Gateway model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelProviderProperties {
  /** Model provider type. This value cannot be changed after creation. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
@added(Versions.v2026_11_01)
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
