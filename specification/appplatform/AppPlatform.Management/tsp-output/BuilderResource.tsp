import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * KPack Builder resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BuildService)
@includeInapplicableMetadataInPayload(false)
model BuilderResource extends ProxyResource {
  /**
   * The name of the builder resource.
   */
  @path
  @key("builderName")
  @segment("builders")
  @visibility("read")
  name: string;

  /**
   * Property of the Builder resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: BuilderProperties;
}

@armResourceOperations
interface BuilderResources {
  /**
   * Get a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceBuilder_Get")
  get is ArmResourceRead<BuilderResource>;

  /**
   * Create or update a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceBuilder_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuilderResource>;

  /**
   * Delete a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceBuilder_Delete")
  delete is ArmResourceDeleteAsync<BuilderResource>;

  /**
   * List KPack builders result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceBuilder_List")
  list is ArmResourceListByParent<BuilderResource>;

  /**
   * List deployments that are using the builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceBuilder_ListDeployments")
  listDeployments is ArmResourceActionSync<
    BuilderResource,
    void,
    DeploymentList
  >;
}

@@projectedName(BuilderResources.createOrUpdate::parameters.resource,
  "json",
  "builderResource"
);
@@extension(BuilderResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "builderResource"
);
@@doc(BuilderResources.createOrUpdate::parameters.resource,
  "The target builder for the create or update operation"
);
