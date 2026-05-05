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
// IdentityBinding resource and operations
// =============================================================================

/**
 * The IdentityBinding resource.
 */
@parentResource(ManagedCluster)
@added(Versions.v2025_10_02_preview)
model IdentityBinding
  is Azure.ResourceManager.ProxyResource<IdentityBindingProperties> {
  ...ResourceNameParameter<
    Resource = IdentityBinding,
    KeyName = "identityBindingName",
    SegmentName = "identityBindings",
    NamePattern = "^[a-z][a-z0-9]{0,63}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@@maxLength(IdentityBinding.name, 63);
@@minLength(IdentityBinding.name, 1);
@@doc(IdentityBinding.name, "The name of the identity binding.");
@@doc(IdentityBinding.properties,
  "The resource-specific properties for this resource."
);
@@doc(IdentityBindings.createOrUpdate::parameters.resource,
  "The identity binding to create or update."
);

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface IdentityBindings {
  /**
   * Gets the specified Identity Binding.
   */
  get is ArmResourceRead<IdentityBinding>;

  /**
   * Creates or updates an identity binding in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IdentityBinding,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = IdentityBinding> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an identity binding in the specified managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IdentityBinding,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of identity bindings in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<IdentityBinding>;
}

// =============================================================================
// IdentityBinding models
// =============================================================================

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union IdentityBindingProvisioningState {
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
   * The identity binding is being created.
   */
  Creating: "Creating",

  /**
   * The identity binding is being updated.
   */
  Updating: "Updating",

  /**
   * The identity binding is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * IdentityBinding properties.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingProperties {
  /**
   * Managed identity profile for the identity binding.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentity: IdentityBindingManagedIdentityProfile;

  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuer?: IdentityBindingOidcIssuerProfile;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: IdentityBindingProvisioningState;
}

/**
 * Managed identity profile for the identity binding.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingManagedIdentityProfile {
  /**
   * The resource ID of the managed identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^/subscriptions/[a-zA-Z0-9-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/[a-zA-Z0-9-]+$")
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The object ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  objectId?: string;

  /**
   * The client ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  clientId?: string;

  /**
   * The tenant ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  tenantId?: string;
}

/**
 * IdentityBinding OIDC issuer profile.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingOidcIssuerProfile {
  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuerUrl?: url;
}
