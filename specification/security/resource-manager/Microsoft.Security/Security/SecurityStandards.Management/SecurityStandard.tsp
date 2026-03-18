import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security Standard on a resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model SecurityStandard
  is Azure.ResourceManager.ExtensionResource<StandardProperties> {
  ...ResourceNameParameter<
    Resource = SecurityStandard,
    KeyName = "standardId",
    SegmentName = "securityStandards",
    NamePattern = "[{]?[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$"
  >;
}

@armResourceOperations
interface SecurityStandards {
  /**
   * Get a specific security standard for the requested scope by standardId
   */
  get is Extension.Read<Extension.ScopeParameter, SecurityStandard>;

  /**
   * Creates or updates a security standard over a given scope
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    SecurityStandard
  >;

  /**
   * Delete a security standard over a given scope
   */
  delete is Extension.DeleteSync<Extension.ScopeParameter, SecurityStandard>;

  /**
   * Get a list of all relevant security standards over a scope
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    SecurityStandard,
    Response = ArmResponse<SecurityStandardList>
  >;
}

@@doc(SecurityStandard.name,
  "The Security Standard key - unique key for the standard type"
);
@@doc(SecurityStandard.properties, "Properties of a security standard");
@@doc(SecurityStandards.createOrUpdate::parameters.resource,
  "Custom security standard over a pre-defined scope"
);
