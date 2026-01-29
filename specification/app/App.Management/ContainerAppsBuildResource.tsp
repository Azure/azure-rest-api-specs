import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Information pertaining to an individual build.
 */
@parentResource(ContainerApp)
model ContainerAppsBuildResource
  is Azure.ResourceManager.ProxyResource<ContainerAppsBuildProperties> {
  ...ResourceNameParameter<
    Resource = ContainerAppsBuildResource,
    KeyName = "buildName",
    SegmentName = "builds",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface ContainerAppsBuildResources {
  /**
   * Get a Container Apps Build resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsBuilds_Get")
  get is ArmResourceRead<ContainerAppsBuildResource>;

  /**
   * Delete a Container Apps Build resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsBuilds_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ContainerAppsBuildResource>;

  /**
   * List Container Apps Build resources by Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsBuildsByContainerApp_List")
  list is ArmResourceListByParent<
    ContainerAppsBuildResource,
    Response = ArmResponse<ContainerAppsBuildCollection>
  >;
}

@@maxLength(ContainerAppsBuildResource.name, 64);
@@minLength(ContainerAppsBuildResource.name, 2);
@@doc(ContainerAppsBuildResource.name, "The name of a build.");
@@doc(ContainerAppsBuildResource.properties,
  "The resource-specific properties for this resource."
);
