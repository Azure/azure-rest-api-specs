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
 * Predefined accelerator resource
 */
@parentResource(ApplicationAcceleratorResource)
model PredefinedAcceleratorResource
  is Azure.ResourceManager.ProxyResource<PredefinedAcceleratorProperties> {
  ...ResourceNameParameter<
    Resource = PredefinedAcceleratorResource,
    KeyName = "predefinedAcceleratorName",
    SegmentName = "predefinedAccelerators",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;

  /**
   * Sku of the predefined accelerator resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface PredefinedAcceleratorResources {
  /**
   * Get the predefined accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PredefinedAccelerators_Get")
  get is ArmResourceRead<PredefinedAcceleratorResource>;

  /**
   * Handle requests to list all predefined accelerators.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PredefinedAccelerators_List")
  list is ArmResourceListByParent<
    PredefinedAcceleratorResource,
    Response = ArmResponse<PredefinedAcceleratorResourceCollection>
  >;

  /**
   * Disable predefined accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PredefinedAccelerators_Disable")
  disable is ArmResourceActionAsync<
    PredefinedAcceleratorResource,
    void,
    OkResponse
  >;

  /**
   * Enable predefined accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PredefinedAccelerators_Enable")
  enable is ArmResourceActionAsync<
    PredefinedAcceleratorResource,
    void,
    OkResponse
  >;
}

@@doc(PredefinedAcceleratorResource.name,
  "The name of the predefined accelerator."
);
@@doc(PredefinedAcceleratorResource.properties,
  "Predefined accelerator properties payload"
);
