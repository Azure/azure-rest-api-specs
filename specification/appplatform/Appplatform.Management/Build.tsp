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
 * Build resource payload
 */
@parentResource(BuildService)
model Build is Azure.ResourceManager.ProxyResource<BuildProperties> {
  ...ResourceNameParameter<
    Resource = Build,
    KeyName = "buildName",
    SegmentName = "builds",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Builds {
  /**
   * Get a KPack build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetBuild")
  getBuild is ArmResourceRead<Build>;

  /**
   * Create or update a KPack build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_CreateOrUpdateBuild")
  createOrUpdateBuild is ArmResourceCreateOrReplaceSync<Build>;

  /**
   * delete a KPack build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_DeleteBuild")
  deleteBuild is ArmResourceDeleteWithoutOkAsync<Build>;

  /**
   * List KPack builds.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_ListBuilds")
  listBuilds is ArmResourceListByParent<
    Build,
    Response = ArmResponse<BuildCollection>
  >;
}

@@doc(Build.name, "The name of the build resource.");
@@doc(Build.properties, "Properties of the build resource");
@@doc(Builds.createOrUpdateBuild::parameters.resource,
  "Parameters for the create or update operation"
);
