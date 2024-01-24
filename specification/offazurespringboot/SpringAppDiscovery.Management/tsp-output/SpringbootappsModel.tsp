import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
/**
 * The springbootapps envelope resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SpringbootsitesModel)
@Azure.ResourceManager.Private.armResourceInternal(SpringbootappsProperties)
@includeInapplicableMetadataInPayload(false)
model SpringbootappsModel extends ProxyResourceBase {
  /**
   * The springbootapps name.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @path
  @key("springbootappsName")
  @segment("springbootapps")
  name: string;

  /**
   * The springbootapps resource definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SpringbootappsProperties;
}

@armResourceOperations
interface SpringbootappsModels {
  /**
   * Get a springbootapps resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootapps_Get")
  get is ArmResourceRead<SpringbootappsModel>;

  /**
   * Update a springbootapps resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("springbootapps_Update")
  update is ArmCustomPatchAsync<
    SpringbootappsModel,
    SpringbootappsPatch,
    BaseParameters<SpringbootappsModel>,
    ArmLroLocationHeader
  >;

  /**
   * List springbootapps resource by resourceGroup
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootapps_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootappsModel>;

  /**
   * List springbootapps resource by subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("springbootapps_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootappsModel>;
}

@@projectedName(SpringbootappsModels.update::parameters.properties,
  "json",
  "springbootapps"
);
@@extension(SpringbootappsModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootapps"
);
@@doc(SpringbootappsModels.update::parameters.properties,
  "Update a springbootapps payload."
);
