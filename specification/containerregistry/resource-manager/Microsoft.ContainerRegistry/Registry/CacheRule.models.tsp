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

  /**
   * Amazon Elastic Container Registry (ECR) authentication via workload identity federation.
   */
  AwsElasticContainerRegistry: "AwsElasticContainerRegistry",

  /**
   * Microsoft Entra authentication via a federated identity credential on an application
   * in another tenant.
   */
  EntraFederatedIdentityCredential: "EntraFederatedIdentityCredential",
}

/**
 * Authentication configuration used by a cache rule to access an upstream registry.
 */
@discriminator("authenticationType")
@added(Versions.vLatestPreview)
model AdditionalAuthenticationProperties {
  /**
   * Authentication type discriminator.
   */
  authenticationType: AdditionalAuthenticationType;
}

/**
 * Google Artifact Registry (GAR) authentication configuration.
 */
@added(Versions.vLatestPreview)
model GarAuthenticationProperties extends AdditionalAuthenticationProperties {
  authenticationType: "GoogleArtifactRegistry";

  /**
   * The Google Cloud Platform project that is configured for authentication
   * Permissions should be granted to principal://iam.googleapis.com/projects/{ProjectNumber}/locations/global/workloadIdentityPools/{WorkloadIdentityPool}/providers/{WorkloadIdentityProvider}/subject/{ManagedIdentityPrincipal}
   */
  @minLength(5)
  @maxLength(30)
  @pattern("^[1-9][0-9]{4,29}$")
  projectNumber: string;

  /**
   * The Google Cloud platform workload identity pool used for authentication.
   */
  @minLength(4)
  @maxLength(32)
  @pattern("^[a-z][a-z0-9-]{2,30}[a-z0-9]$")
  workloadIdentityPool: string;

  /**
   * The Google Cloud Platform workload identity provider used for authentication.
   */
  @minLength(4)
  @maxLength(32)
  @pattern("^[a-z][a-z0-9-]{2,30}[a-z0-9]$")
  workloadIdentityProvider: string;
}

/**
 * Amazon Elastic Container Registry (ECR) authentication configuration.
 */
@added(Versions.vLatestPreview)
model EcrAuthenticationProperties extends AdditionalAuthenticationProperties {
  authenticationType: "AwsElasticContainerRegistry";

  /**
   * The AWS account that owns the IAM role used for authentication.
   * The IAM role is assumed via AWS Security Token Service (STS) when exchanging a
   * federated Entra access token for an ECR access token. The full IAM role ARN is
   * derived from `accountNumber`, `rolePath`, and `roleName` as
   * `arn:aws:iam::{accountNumber}:role{rolePath}{roleName}` (the path defaults to `/`).
   */
  @minLength(12)
  @maxLength(12)
  @pattern("^[0-9]{12}$")
  accountNumber: string;

  /**
   * The AWS region of the upstream Elastic Container Registry (e.g. `us-west-2`).
   * Only commercial AWS regions are supported; the GovCloud (`us-gov-*`), China
   * (`cn-*`), and Secret/Top Secret ISO (`us-iso*`) partitions are rejected. The
   * pattern stays forward-compatible for new commercial regions without requiring a
   * contract change.
   */
  @minLength(6)
  @maxLength(20)
  @pattern("^(?!cn-)(?!us-gov-)(?!us-iso)[a-z]{2,3}(-[a-z]+){1,2}-[0-9]{1,2}$")
  region: string;

  /**
   * The name of the AWS IAM role assumed for authentication.
   * This is the role name only, not the full ARN; the IAM path is supplied separately
   * via `rolePath`, so '/' is not permitted here.
   */
  @minLength(1)
  @maxLength(64)
  @pattern("^[A-Za-z0-9_+=,.@-]{1,64}$")
  roleName: string;

  /**
   * Optional IAM path of the role (for example `/team/` or `/division/team/`). The value
   * must be supplied in canonical form with a leading and trailing '/'; it is validated
   * as-is and is never normalized. A non-root path must contain at least one character
   * between the surrounding slashes. When omitted, the role is assumed to live at the path
   * root (`/`).
   */
  @minLength(1)
  @maxLength(512)
  @pattern("^/$|^/[!-~]{1,510}/$")
  rolePath?: string;
}

/**
 * Microsoft Entra federated identity credential authentication configuration.
 */
@added(Versions.vLatestPreview)
model EntraFederatedIdentityCredentialAuthenticationProperties
  extends AdditionalAuthenticationProperties {
  authenticationType: "EntraFederatedIdentityCredential";

  /**
   * The upstream tenant that issues the token for `federatedApplicationClientId` and contains
   * the application's enterprise application (service principal).
   */
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  sourceTenantId: string;

  /**
   * The client ID of the multi-tenant application. Its application registration and
   * federated identity credential must be in the cache rule managed identity's home tenant.
   * The credential's subject is the managed identity's principal/object ID, not its client ID.
   * Its enterprise application (service principal) must exist in `sourceTenantId`.
   */
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  federatedApplicationClientId: string;
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
