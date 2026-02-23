import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// JWTAuthenticator resource and operations
// =============================================================================

/**
 * Configuration for JWT authenticator in the managed cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@parentResource(ManagedCluster)
@added(Versions.v2025_10_02_preview)
model JWTAuthenticator
  is Azure.ResourceManager.ProxyResource<JWTAuthenticatorProperties, false> {
  ...ResourceNameParameter<
    Resource = JWTAuthenticator,
    KeyName = "jwtAuthenticatorName",
    SegmentName = "jwtAuthenticators",
    NamePattern = "^[a-z][a-z0-9]{0,23}$"
  >;
}

@@maxLength(JWTAuthenticator.name, 24);
@@minLength(JWTAuthenticator.name, 1);
@@doc(JWTAuthenticator.name, "The name of the JWT authenticator.");
@@doc(JWTAuthenticator.properties,
  "The properties of JWTAuthenticator. For details on how to configure the properties of a JWT authenticator, please refer to the Kubernetes documentation: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#using-authentication-configuration. Please note that not all fields available in the Kubernetes documentation are supported by AKS. For troubleshooting, please see https://aka.ms/aks-external-issuers-docs."
);
@@doc(JWTAuthenticators.createOrUpdate::parameters.resource,
  "The JWT authenticator to create or update."
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface JWTAuthenticators {
  /**
   * Gets the specified JWT authenticator of a managed cluster.
   */
  get is ArmResourceRead<JWTAuthenticator>;

  /**
   * Creates or updates JWT authenticator in the managed cluster and updates the managed cluster to apply the settings.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    JWTAuthenticator,
    LroHeaders = ArmLroLocationHeader<FinalResult = JWTAuthenticator> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a JWT authenticator and updates the managed cluster to apply the settings.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    JWTAuthenticator,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of JWT authenticators in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<JWTAuthenticator>;
}

// =============================================================================
// JWTAuthenticator models
// =============================================================================

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union JWTAuthenticatorProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The JWT authenticator is being created.
   */
  Creating: "Creating",

  /**
   * The JWT authenticator is being updated.
   */
  Updating: "Updating",

  /**
   * The JWT authenticator is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * The properties of JWTAuthenticator. For details on how to configure the properties of a JWT authenticator, please refer to the Kubernetes documentation: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#using-authentication-configuration. Please note that not all fields available in the Kubernetes documentation are supported by AKS. For troubleshooting, please see https://aka.ms/aks-external-issuers-docs.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorProperties {
  /**
   * The current provisioning state of the JWT authenticator.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JWTAuthenticatorProvisioningState;

  /**
   * The JWT OIDC issuer details.
   */
  issuer: JWTAuthenticatorIssuer;

  /**
   * The rules that are applied to validate token claims to authenticate users. All the expressions must evaluate to true for validation to succeed.
   */
  @identifiers(#[])
  claimValidationRules?: JWTAuthenticatorValidationRule[];

  /**
   * The mappings that define how user attributes are extracted from the token claims.
   */
  claimMappings: JWTAuthenticatorClaimMappings;

  /**
   * The rules that are applied to the mapped user before completing authentication. All the expressions must evaluate to true for validation to succeed.
   */
  @identifiers(#[])
  userValidationRules?: JWTAuthenticatorValidationRule[];
}

/**
 * The OIDC issuer details for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorIssuer {
  /**
   * The issuer URL. The URL must begin with the scheme https and cannot contain a query string or fragment. This must match the "iss" claim in the presented JWT, and the issuer returned from discovery.
   */
  url: string;

  /**
   * The set of acceptable audiences the JWT must be issued to. At least one is required. When multiple is set, AudienceMatchPolicy is used in API Server configuration.
   */
  @minItems(1)
  audiences: string[];
}

/**
 * The validation rule for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorValidationRule {
  /**
   * The CEL expression used to validate the claim or attribute.
   */
  expression: string;

  /**
   * The validation error message.
   */
  message?: string;
}

/**
 * The claim mappings for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorClaimMappings {
  /**
   * The expression to extract username attribute from the token claims.
   */
  username: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract groups attribute from the token claims. When not provided, no groups are extracted from the token claims.
   */
  groups?: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract uid attribute from the token claims. When not provided, no uid is extracted from the token claims.
   */
  uid?: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract extra attribute from the token claims. When not provided, no extra attributes are extracted from the token claims.
   */
  @identifiers(#[])
  extra?: JWTAuthenticatorExtraClaimMappingExpression[];
}

/**
 * The claim mapping expression for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorClaimMappingExpression {
  /**
   * The CEL expression used to access token claims.
   */
  expression: string;
}

/**
 * The extra claim mapping expression for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorExtraClaimMappingExpression {
  /**
   * The key of the extra attribute.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "The 'key' property refers to the key of an extra claim mapping attribute, not a secret or credential."
  key: string;

  /**
   * The CEL expression used to extract the value of the extra attribute.
   */
  valueExpression: string;
}
