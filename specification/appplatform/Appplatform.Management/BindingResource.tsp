import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Binding resource payload
 */
@parentResource(AppResource)
model BindingResource
  is Azure.ResourceManager.ProxyResource<BindingResourceProperties> {
  ...ResourceNameParameter<
    Resource = BindingResource,
    KeyName = "bindingName",
    SegmentName = "bindings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BindingResources {
  /**
   * Get a Binding and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bindings_Get")
  get is ArmResourceRead<BindingResource>;

  /**
   * Create a new Binding or update an exiting Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Bindings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BindingResource,
    Response = ArmResourceUpdatedResponse<BindingResource> | ArmResourceCreatedResponse<
      BindingResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: BindingResource;
    })
  >;

  /**
   * Operation to update an exiting Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Bindings_Update")
  update is ArmCustomPatchAsync<
    BindingResource,
    PatchModel = BindingResource,
    Response = ArmResponse<BindingResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: BindingResource;
    })
  >;

  /**
   * Operation to delete a Binding.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Bindings_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BindingResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bindings_List")
  list is ArmResourceListByParent<
    BindingResource,
    Response = ArmResponse<BindingResourceCollection>
  >;
}

@@doc(BindingResource.name, "The name of the Binding resource.");
@@doc(BindingResource.properties, "Properties of the Binding resource");
@@doc(BindingResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(BindingResources.update::parameters.properties,
  "Parameters for the update operation"
);
