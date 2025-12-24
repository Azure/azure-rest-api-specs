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

@@maxLength(IdentityBinding.name, 63);
@@minLength(IdentityBinding.name, 1);
@@doc(IdentityBinding.name, "The name of the identity binding.");
@@doc(IdentityBinding.properties,
  "The resource-specific properties for this resource."
);
@@doc(IdentityBindings.createOrUpdate::parameters.resource,
  "The identity binding to create or update."
);
