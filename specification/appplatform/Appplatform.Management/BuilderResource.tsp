import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * KPack Builder resource
 */
@parentResource(BuildService)
model BuilderResource
  is Azure.ResourceManager.ProxyResource<BuilderProperties> {
  ...ResourceNameParameter<
    Resource = BuilderResource,
    KeyName = "builderName",
    SegmentName = "builders",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BuilderResources {
  /**
   * Get a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceBuilder_Get")
  get is ArmResourceRead<BuilderResource>;

  /**
   * Create or update a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceBuilder_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BuilderResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a KPack builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("BuildServiceBuilder_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BuilderResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List KPack builders result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceBuilder_List")
  list is ArmResourceListByParent<
    BuilderResource,
    Response = ArmResponse<BuilderResourceCollection>
  >;

  /**
   * List deployments that are using the builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listUsingDeployments")
  @operationId("BuildServiceBuilder_ListDeployments")
  listDeployments is ArmResourceActionSync<
    BuilderResource,
    void,
    ArmResponse<DeploymentList>
  >;
}

@@doc(BuilderResource.name, "The name of the builder resource.");
@@doc(BuilderResource.properties, "Property of the Builder resource.");
@@doc(BuilderResources.createOrUpdate::parameters.resource,
  "The target builder for the create or update operation"
);
