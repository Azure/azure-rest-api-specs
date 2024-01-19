import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuilderResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Buildpack Binding Resource object")
@parentResource(BuilderResource)
model BuildpackBindingResource is ProxyResource<BuildpackBindingProperties> {
  @doc("The name of the Buildpack Binding Name")
  @path
  @key("buildpackBindingName")
  @segment("buildpackBindings")
  name: string;
}

@armResourceOperations
interface BuildpackBindingResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a buildpack binding by name.")
  @operationId("BuildpackBinding_Get")
  get is ArmResourceRead<BuildpackBindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a buildpack binding.")
  @operationId("BuildpackBinding_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BuildpackBindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a Buildpack Binding")
  @operationId("BuildpackBinding_Delete")
  delete is ArmResourceDeleteAsync<BuildpackBindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all buildpack bindings in a builder.")
  @operationId("BuildpackBinding_List")
  list is ArmResourceListByParent<BuildpackBindingResource>;
}

@@projectedName(BuildpackBindingResources.createOrUpdate::parameters.resource,
  "json",
  "buildpackBinding"
);
@@extension(BuildpackBindingResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "buildpackBinding"
);
@@doc(BuildpackBindingResources.createOrUpdate::parameters.resource,
  "The target buildpack binding for the create or update operation"
);
