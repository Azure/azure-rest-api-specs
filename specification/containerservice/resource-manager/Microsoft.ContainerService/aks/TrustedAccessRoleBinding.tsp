import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * Defines binding between a resource and role
 */
@parentResource(ManagedCluster)
model TrustedAccessRoleBinding
  is Azure.ResourceManager.ProxyResource<
    TrustedAccessRoleBindingProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = TrustedAccessRoleBinding,
    KeyName = "trustedAccessRoleBindingName",
    SegmentName = "trustedAccessRoleBindings",
    NamePattern = "^([A-Za-z0-9-])+$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface TrustedAccessRoleBindings {
  /**
   * Get a trusted access role binding.
   */
  @tag("TrustedAccess")
  get is ArmResourceRead<TrustedAccessRoleBinding>;

  /**
   * Create or update a trusted access role binding
   */
  @tag("TrustedAccess")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TrustedAccessRoleBinding,
    LroHeaders = ArmLroLocationHeader<FinalResult = TrustedAccessRoleBinding> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a trusted access role binding.
   */
  @tag("TrustedAccess")
  delete is ArmResourceDeleteWithoutOkAsync<TrustedAccessRoleBinding>;

  /**
   * List trusted access role bindings.
   */
  @tag("TrustedAccess")
  list is ArmResourceListByParent<TrustedAccessRoleBinding>;
}

@@maxLength(TrustedAccessRoleBinding.name, 24);
@@minLength(TrustedAccessRoleBinding.name, 1);
@@doc(TrustedAccessRoleBinding.name,
  "The name of trusted access role binding."
);
@@doc(TrustedAccessRoleBinding.properties,
  "Properties for trusted access role binding"
);
@@doc(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "A trusted access role binding"
);
