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
@doc("KPack Builder resource")
@parentResource(BuildService)
model BuilderResource is ProxyResource<BuilderProperties> {
  @doc("The name of the builder resource.")
  @path
  @key("builderName")
  @segment("builders")
  name: string;
}

@armResourceOperations
interface BuilderResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a KPack builder.")
  @operationId("BuildServiceBuilder_Get")
  get is ArmResourceRead<BuilderResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a KPack builder.")
  @operationId("BuildServiceBuilder_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BuilderResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a KPack builder.")
  @operationId("BuildServiceBuilder_Delete")
  delete is ArmResourceDeleteAsync<BuilderResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List KPack builders result.")
  @operationId("BuildServiceBuilder_List")
  list is ArmResourceListByParent<BuilderResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List deployments that are using the builder.")
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
