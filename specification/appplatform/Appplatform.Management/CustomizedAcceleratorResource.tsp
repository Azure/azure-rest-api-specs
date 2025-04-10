import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationAcceleratorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Customized accelerator resource
 */
@parentResource(ApplicationAcceleratorResource)
model CustomizedAcceleratorResource
  is Azure.ResourceManager.ProxyResource<CustomizedAcceleratorProperties> {
  ...ResourceNameParameter<
    Resource = CustomizedAcceleratorResource,
    KeyName = "customizedAcceleratorName",
    SegmentName = "customizedAccelerators",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])$"
  >;

  /**
   * Sku of the customized accelerator resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface CustomizedAcceleratorResources {
  /**
   * Get the customized accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomizedAccelerators_Get")
  get is ArmResourceRead<CustomizedAcceleratorResource>;

  /**
   * Create or update the customized accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomizedAccelerators_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomizedAcceleratorResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the customized accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomizedAccelerators_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<CustomizedAcceleratorResource>;

  /**
   * Handle requests to list all customized accelerators.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomizedAccelerators_List")
  list is ArmResourceListByParent<
    CustomizedAcceleratorResource,
    Response = ArmResponse<CustomizedAcceleratorResourceCollection>
  >;

  /**
   * Check the customized accelerator are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomizedAccelerators_Validate")
  validate is ArmResourceActionAsync<
    CustomizedAcceleratorResource,
    CustomizedAcceleratorProperties,
    ArmResponse<CustomizedAcceleratorValidateResult>
  >;
}

@@doc(CustomizedAcceleratorResource.name,
  "The name of the customized accelerator."
);
@@doc(CustomizedAcceleratorResource.properties,
  "Customized accelerator properties payload"
);
@@doc(CustomizedAcceleratorResources.createOrUpdate::parameters.resource,
  "The customized accelerator for the create or update operation"
);
@@doc(CustomizedAcceleratorResources.validate::parameters.body,
  "Customized accelerator properties to be validated"
);
