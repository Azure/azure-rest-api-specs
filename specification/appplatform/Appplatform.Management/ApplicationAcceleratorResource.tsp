import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Application accelerator resource
 */
@parentResource(ServiceResource)
model ApplicationAcceleratorResource
  is Azure.ResourceManager.ProxyResource<ApplicationAcceleratorProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationAcceleratorResource,
    KeyName = "applicationAcceleratorName",
    SegmentName = "applicationAccelerators",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;

  /**
   * Sku of the application accelerator resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface ApplicationAcceleratorResources {
  /**
   * Get the application accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationAccelerators_Get")
  get is ArmResourceRead<ApplicationAcceleratorResource>;

  /**
   * Create or update the application accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationAccelerators_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationAcceleratorResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the application accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationAccelerators_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationAcceleratorResource>;

  /**
   * Handle requests to list all application accelerator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationAccelerators_List")
  list is ArmResourceListByParent<
    ApplicationAcceleratorResource,
    Response = ArmResponse<ApplicationAcceleratorResourceCollection>
  >;
}

@@doc(ApplicationAcceleratorResource.name,
  "The name of the application accelerator."
);
@@doc(ApplicationAcceleratorResource.properties,
  "Application accelerator properties payload"
);
@@doc(ApplicationAcceleratorResources.createOrUpdate::parameters.resource,
  "The application accelerator for the create or update operation"
);
