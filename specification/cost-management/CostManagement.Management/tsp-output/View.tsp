import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * States and configurations of Cost Analysis.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(ViewProperties)
@includeInapplicableMetadataInPayload(false)
model View extends ProxyResourceBase {
  /**
   * View name
   */
  @path
  @key("viewName")
  @segment("views")
  name: string;

  /**
   * The properties of the view.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ViewProperties;
}

@armResourceOperations
interface Views {
  /**
   * Gets the view by view name.
   */
  get is ArmResourceRead<View>;

  /**
   * The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<View>;

  /**
   * The operation to delete a view.
   */
  delete is ArmResourceDeleteSync<View>;
}

@@projectedName(Views.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Views.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Views.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
