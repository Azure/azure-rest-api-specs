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
 * Build service resource payload
 */
@parentResource(ServiceResource)
model BuildService
  is Azure.ResourceManager.ProxyResource<BuildServiceProperties> {
  ...ResourceNameParameter<
    Resource = BuildService,
    KeyName = "buildServiceName",
    SegmentName = "buildServices",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BuildServices {
  /**
   * Get a build service resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetBuildService")
  getBuildService is ArmResourceRead<BuildService>;

  /**
   * Create a build service resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BuildService,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List build services resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_ListBuildServices")
  listBuildServices is ArmResourceListByParent<
    BuildService,
    Response = ArmResponse<BuildServiceCollection>
  >;

  /**
   * Get an resource upload URL for build service, which may be artifacts or source archive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    BuildService,
    void,
    ArmResponse<ResourceUploadDefinition>
  >;
}

@@doc(BuildService.name, "The name of the build service resource.");
@@doc(BuildService.properties, "Properties of the build resource");
@@doc(BuildServices.createOrUpdate::parameters.resource,
  "Parameters for the create operation"
);
