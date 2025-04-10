import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Container registry resource payload.
 */
@parentResource(ServiceResource)
model ContainerRegistryResource
  is Azure.ResourceManager.ProxyResource<ContainerRegistryProperties> {
  ...ResourceNameParameter<
    Resource = ContainerRegistryResource,
    KeyName = "containerRegistryName",
    SegmentName = "containerRegistries",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;
}

@armResourceOperations
interface ContainerRegistryResources {
  /**
   * Get the container registries resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerRegistries_Get")
  get is ArmResourceRead<ContainerRegistryResource>;

  /**
   * Create or update container registry resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerRegistries_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ContainerRegistryResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a container registry resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerRegistries_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ContainerRegistryResource>;

  /**
   * List container registries resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerRegistries_List")
  list is ArmResourceListByParent<
    ContainerRegistryResource,
    Response = ArmResponse<ContainerRegistryResourceCollection>
  >;

  /**
   * Check if the container registry properties are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerRegistries_Validate")
  validate is ArmResourceActionAsync<
    ContainerRegistryResource,
    ContainerRegistryProperties,
    ArmResponse<ContainerRegistryValidateResult>
  >;
}

@@doc(ContainerRegistryResource.name, "The name of the container registry.");
@@doc(ContainerRegistryResource.properties,
  "Properties of the container registry resource payload."
);
@@doc(ContainerRegistryResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(ContainerRegistryResources.validate::parameters.body,
  "Parameters for the validate operation"
);
