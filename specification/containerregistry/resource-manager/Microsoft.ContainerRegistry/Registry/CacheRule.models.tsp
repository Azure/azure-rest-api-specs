import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The properties of a cache rule.
 */
model CacheRuleProperties {
  /**
   * The ARM resource ID of the credential store which is associated with the cache rule.
   */
  credentialSetResourceId?: string;

  /**
   * Authentication configuration used by the cache rule to access the upstream source repository.
   */
  @added(Versions.vLatestPreview)
  additionalAuthenticationProperties?: AdditionalAuthenticationProperties;

  /**
   * Source repository pulled from upstream.
   */
  sourceRepository?: string;

  /**
   * Target repository specified in docker pull command.
   * Eg: docker pull myregistry.azurecr.io/{targetRepository}:{tag}
   */
  targetRepository?: string;

  /**
   * The creation date of the cache rule.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The type of authentication configuration used by a cache rule to access an upstream registry.
 */
@added(Versions.vLatestPreview)
union AdditionalAuthenticationType {
  string,

  /**
   * Google Artifact Registry (GAR) authentication via workload identity federation.
   */
  GoogleArtifactRegistry: "GoogleArtifactRegistry",
}

/**
 * Authentication configuration used by a cache rule to access an upstream registry.
 */
@discriminator("type")
@added(Versions.vLatestPreview)
model AdditionalAuthenticationProperties {
  /**
   * Authentication type discriminator.
   */
  type: AdditionalAuthenticationType;
}

/**
 * Google Artifact Registry (GAR) authentication configuration.
 */
@added(Versions.vLatestPreview)
model GarAuthenticationProperties extends AdditionalAuthenticationProperties {
  type: "GoogleArtifactRegistry";

  // The following 3 properties are necessary to build the audience for the GAR token.
  // They are specific to the customer.  The final value will be of the form:
  // '//iam.googleapis.com/projects/{ProjectNumber}/locations/global/workloadIdentityPools/{WorkloadIdentityPool}/providers/{WorkloadIdentityProvider}'
  projectNumber: string;

  workloadIdentityPool: string;
  workloadIdentityProvider: string;
}

/**
 * The parameters for updating a cache rule.
 */
model CacheRuleUpdateParameters {
  /**
   * The properties of the cache rule update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: CacheRuleUpdateProperties;

  /**
   * The identity of the cache rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Unable to use `added` decorator on spread property. Use `...ManagedServiceIdentityProperty` instead when feature has been GA'd."
  @added(Versions.vLatestPreview)
  identity?: IdentityProperties;
}

/**
 * The parameters for updating cache rule properties.
 */
model CacheRuleUpdateProperties {
  /**
   * The ARM resource ID of the credential store which is associated with the Cache rule.
   */
  credentialSetResourceId?: string;

  /**
   * Authentication configuration used by the cache rule to access the upstream source repository.
   */
  @added(Versions.vLatestPreview)
  additionalAuthenticationProperties?: AdditionalAuthenticationProperties;
}

/**
 * The result of a request to list cache rules for a container registry.
 */
model CacheRulesListResult {
  /**
   * The list of cache rules. Since this list may be incomplete, the nextLink field should be used to request the next list of cache rules.
   */
  @pageItems
  value?: CacheRule[];

  /**
   * The URI that can be used to request the next list of cache rules.
   */
  @nextLink
  nextLink?: string;
}
