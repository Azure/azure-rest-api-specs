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

/** GitHub App credentials for a GitHub model provider. */
@added(Versions.v2026_11_01)
model AiGatewayGitHubAppAuthentication {
  /** GitHub App identifier. */
  appId?: string;

  /** GitHub App installation identifier. */
  installationId?: string;

  /** GitHub App private key. Omitted from ordinary read responses. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  privateKey?: string;
}

/** Outbound authentication configuration for a model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelProviderAuthentication {
  /** GitHub App credentials when modelProviderType is GitHub. */
  githubApp?: AiGatewayGitHubAppAuthentication;

  /** Managed identity configuration when modelProviderType is Foundry. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** Secret HTTP headers injected when calling the model provider. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeader[];
}

/** Outbound authentication configuration to update on a model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelProviderAuthenticationUpdate {
  /** GitHub App credentials when modelProviderType is GitHub. */
  githubApp?: AiGatewayGitHubAppAuthentication;

  /** Managed identity configuration when modelProviderType is Foundry. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** Secret HTTP headers injected when calling the model provider. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeaderUpdate[];
}

/** Foundry model provider configuration. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryProviderConfiguration {
  /** Foundry endpoint. */
  endpoint?: AiGatewayDestinationEndpoint;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>[];
}

/** Custom model provider configuration. */
@added(Versions.v2026_11_01)
model AiGatewayCustomProviderConfiguration {
  /** Provider base endpoint. */
  endpoint: AiGatewayDestinationEndpoint;
}

/** Foundry model provider settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayFoundryProviderConfigurationUpdate {
  /** Foundry endpoint. */
  endpoint?: AiGatewayDestinationEndpointUpdate;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts";
    }
  ]>[];
}

/** Custom model provider settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayCustomProviderConfigurationUpdate {
  /** Provider base endpoint. */
  endpoint?: AiGatewayDestinationEndpointUpdate;
}

/** Properties for updating an AI Gateway model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelProviderUpdateProperties {
  /** Display name of the model provider. */
  displayName?: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. */
  foundry?: AiGatewayFoundryProviderConfigurationUpdate;

  /** Custom provider configuration. */
  custom?: AiGatewayCustomProviderConfigurationUpdate;

  /** Outbound authentication configuration. */
  authentication?: AiGatewayModelProviderAuthenticationUpdate;
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
  modelProviderType: AiGatewayModelProviderKind;

  /** Display name of the model provider. */
  displayName: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. Required when modelProviderType is Foundry. */
  foundry?: AiGatewayFoundryProviderConfiguration;

  /** Custom provider configuration. Required when modelProviderType is Custom. */
  custom?: AiGatewayCustomProviderConfiguration;

  /** Outbound authentication configuration. */
  authentication?: AiGatewayModelProviderAuthentication;

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
}
