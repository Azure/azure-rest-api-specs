import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Binding resource payload")
@parentResource(AppResource)
model BindingResource is ProxyResource<BindingResourceProperties> {
  @doc("The name of the Binding resource.")
  @path
  @key("bindingName")
  @segment("bindings")
  name: string;
}

@armResourceOperations
interface BindingResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Binding and its properties.")
  @operationId("Bindings_Get")
  get is ArmResourceRead<BindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new Binding or update an exiting Binding.")
  @operationId("Bindings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting Binding.")
  @operationId("Bindings_Update")
  update is ArmCustomPatchAsync<BindingResource, BindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a Binding.")
  @operationId("Bindings_Delete")
  delete is ArmResourceDeleteAsync<BindingResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in an App.")
  @operationId("Bindings_List")
  list is ArmResourceListByParent<BindingResource>;
}

@@projectedName(BindingResources.createOrUpdate::parameters.resource,
  "json",
  "bindingResource"
);
@@extension(BindingResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "bindingResource"
);
@@doc(BindingResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(BindingResources.update::parameters.properties,
  "json",
  "bindingResource"
);
@@extension(BindingResources.update::parameters.properties,
  "x-ms-client-name",
  "bindingResource"
);
@@doc(BindingResources.update::parameters.properties,
  "Parameters for the update operation"
);
