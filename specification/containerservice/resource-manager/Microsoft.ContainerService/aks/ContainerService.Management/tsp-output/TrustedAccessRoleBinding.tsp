import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * Defines binding between a resource and role
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedCluster)
@Azure.ResourceManager.Private.armResourceInternal(
  TrustedAccessRoleBindingProperties
)
@includeInapplicableMetadataInPayload(false)
model TrustedAccessRoleBinding extends ProxyResourceBase {
  /**
   * The name of trusted access role binding.
   */
  @maxLength(24)
  @minLength(1)
  @pattern("^([A-Za-z0-9-])+$")
  @path
  @key("trustedAccessRoleBindingName")
  @segment("trustedAccessRoleBindings")
  name: string;

  /**
   * Properties for trusted access role binding
   */
  @extension("x-ms-client-flatten", true)
  properties: TrustedAccessRoleBindingProperties;
}

@armResourceOperations
interface TrustedAccessRoleBindings {
  /**
   * Get a trusted access role binding.
   */
  get is ArmResourceRead<TrustedAccessRoleBinding>;

  /**
   * Create or update a trusted access role binding
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TrustedAccessRoleBinding>;

  /**
   * Delete a trusted access role binding.
   */
  delete is ArmResourceDeleteWithoutOkAsync<TrustedAccessRoleBinding>;

  /**
   * List trusted access role bindings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TrustedAccessRoleBindings_List")
  list is ArmResourceListByParent<TrustedAccessRoleBinding>;
}

@@projectedName(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "json",
  "trustedAccessRoleBinding"
);
@@extension(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "trustedAccessRoleBinding"
);
@@doc(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "A trusted access role binding"
);
