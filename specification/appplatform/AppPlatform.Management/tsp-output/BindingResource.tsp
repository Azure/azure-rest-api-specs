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
/**
 * Binding resource payload
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AppResource)
@includeInapplicableMetadataInPayload(false)
model BindingResource extends ProxyResource {
  /**
   * The name of the Binding resource.
   */
  @path
  @key("bindingName")
  @segment("bindings")
  @visibility("read")
  name: string;

  /**
   * Properties of the Binding resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: BindingResourceProperties;
}

@armResourceOperations
interface BindingResources {
  /**
   * Get a Binding and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bindings_Get")
  get is ArmResourceRead<BindingResource>;

  /**
   * Create a new Binding or update an exiting Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bindings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BindingResource>;

  /**
   * Operation to update an exiting Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Bindings_Update")
  update is ArmCustomPatchAsync<BindingResource, BindingResource>;

  /**
   * Operation to delete a Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Bindings_Delete")
  delete is ArmResourceDeleteAsync<BindingResource>;

  /**
   * Handles requests to list all resources in an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
