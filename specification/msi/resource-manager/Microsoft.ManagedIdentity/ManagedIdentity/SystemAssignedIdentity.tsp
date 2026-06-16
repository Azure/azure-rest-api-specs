import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using Azure.ResourceManager;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a system assigned identity resource.
 */
@singleton("default")
model SystemAssignedIdentity
  is Azure.ResourceManager.ExtensionResource<SystemAssignedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = SystemAssignedIdentity,
    KeyName = "identity",
    SegmentName = "identities",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}
@@visibility(SystemAssignedIdentity.properties, Lifecycle.Read);

@armResourceOperations
interface SystemAssignedIdentities {
  /**
   * Gets the systemAssignedIdentity available under the specified RP scope.
   */
  getByScope is Extension.Read<
    Extension.ScopeParameter,
    SystemAssignedIdentity,
    Error = CloudError
  >;
}

@@doc(SystemAssignedIdentity.name, "");
@@doc(SystemAssignedIdentity.properties,
  "The properties associated with the identity."
);
