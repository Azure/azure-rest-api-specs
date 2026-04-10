import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SecurityStandardsAPI;
/**
 * Security Standard on a resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model SecurityStandard
  is Azure.ResourceManager.ExtensionResource<SecurityStandardProperties> {
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
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    SecurityStandard
  >;

  /**
   * Creates or updates a security standard over a given scope
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    SecurityStandard
  >;

  /**
   * Delete a security standard over a given scope
   */
  delete is Azure.ResourceManager.Extension.DeleteSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    SecurityStandard
  >;

  /**
   * Get a list of all relevant security standards over a scope
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
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

