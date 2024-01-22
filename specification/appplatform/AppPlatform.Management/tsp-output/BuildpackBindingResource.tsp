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
/**
 * Buildpack Binding Resource object
 */
@parentResource(BuilderResource)
model BuildpackBindingResource is ProxyResource<BuildpackBindingProperties> {
  /**
   * The name of the Buildpack Binding Name
   */
  @path
  @key("buildpackBindingName")
  @segment("buildpackBindings")
  name: string;
}

@armResourceOperations
interface BuildpackBindingResources {
  /**
   * Get a buildpack binding by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildpackBinding_Get")
  get is ArmResourceRead<BuildpackBindingResource>;

  /**
   * Create or update a buildpack binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildpackBinding_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BuildpackBindingResource>;

  /**
   * Operation to delete a Buildpack Binding
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildpackBinding_Delete")
  delete is ArmResourceDeleteAsync<BuildpackBindingResource>;

  /**
   * Handles requests to list all buildpack bindings in a builder.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
