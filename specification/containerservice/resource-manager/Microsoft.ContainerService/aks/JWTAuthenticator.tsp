import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * Configuration for JWT authenticator in the managed cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<JWTAuthenticator>;

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

@@maxLength(JWTAuthenticator.name, 24);
@@minLength(JWTAuthenticator.name, 1);
@@doc(JWTAuthenticator.name, "The name of the JWT authenticator.");
@@doc(JWTAuthenticator.properties,
  "The properties of JWTAuthenticator. For details on how to configure the properties of a JWT authenticator, please refer to the Kubernetes documentation: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#using-authentication-configuration. Please note that not all fields available in the Kubernetes documentation are supported by AKS. For troubleshooting, please see https://aka.ms/aks-external-issuers-docs."
);
@@doc(JWTAuthenticators.createOrUpdate::parameters.resource,
  "The JWT authenticator to create or update."
);
