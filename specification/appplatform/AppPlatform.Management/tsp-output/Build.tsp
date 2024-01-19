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
@doc("Build resource payload")
@parentResource(BuildService)
model Build is ProxyResource<BuildProperties> {
  @doc("The name of the build resource.")
  @path
  @key("buildName")
  @segment("builds")
  name: string;
}

@armResourceOperations
interface Builds {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a KPack build.")
  @operationId("BuildService_GetBuild")
  getBuild is ArmResourceRead<Build>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a KPack build.")
  @operationId("BuildService_CreateOrUpdateBuild")
  createOrUpdateBuild is ArmResourceCreateOrReplaceSync<Build>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List KPack builds.")
  @operationId("BuildService_ListBuilds")
  listBuilds is ArmResourceListByParent<Build>;
}

@@projectedName(Builds.createOrUpdateBuild::parameters.resource,
  "json",
  "build"
);
@@extension(Builds.createOrUpdateBuild::parameters.resource,
  "x-ms-client-name",
  "build"
);
@@doc(Builds.createOrUpdateBuild::parameters.resource,
  "Parameters for the create or update operation"
);
