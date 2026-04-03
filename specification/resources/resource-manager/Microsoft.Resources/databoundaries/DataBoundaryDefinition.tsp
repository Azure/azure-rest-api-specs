import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;
/**
 * A data boundary definition.
 */
@tenantResource
model DataBoundaryDefinition
  is Azure.ResourceManager.ProxyResource<DataBoundaryProperties> {
  ...ResourceNameParameter<
    Resource = DataBoundaryDefinition,
    KeyName = "default",
    SegmentName = "dataBoundaries",
    NamePattern = "",
    Type = DefaultName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
@armResourceOperations(#{ omitTags: true })
interface DataBoundaryDefinitions {
  /**
   * Get data boundary of tenant.
   */
  @tag("DataBoundaries")
  getTenant is Extension.Read<Extension.Tenant, DataBoundaryDefinition>;

  /**
   * Opt-in tenant to data boundary.
   */
  @tag("DataBoundaries")
  put is Extension.CreateOrReplaceSync<
    Extension.Tenant,
    DataBoundaryDefinition
  >;
}

@armResourceOperations
interface DataBoundaries {
  /**
   * Get data boundary at specified scope
   */
  getScope is Extension.Read<Extension.ScopeParameter, DataBoundaryDefinition>;
}

@@doc(DataBoundaryDefinition.name,
  "Default string modeled as parameter for auto generation to work correctly."
);
@@doc(DataBoundaryDefinition.properties, "Data boundary properties");
@@doc(DataBoundaryDefinitions.put::parameters.resource,
  "The data boundary to opt the tenant to."
);
