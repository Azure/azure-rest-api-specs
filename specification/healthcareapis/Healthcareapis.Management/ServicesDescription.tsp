import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * The description of the service.
 */
model ServicesDescription
  is Azure.ResourceManager.TrackedResource<ServicesProperties> {
  ...ResourceNameParameter<
    Resource = ServicesDescription,
    KeyName = "resourceName",
    SegmentName = "services",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServicesDescriptions {
  /**
   * Get the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Get")
  get is ArmResourceRead<ServicesDescription>;

  /**
   * Create or update the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServicesDescription,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the metadata of a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<
    ServicesDescription,
    PatchModel = ServicesPatchDescription,
    Response = ArmResponse<ServicesDescription>
  >;

  /**
   * Delete a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ServicesDescription>;

  /**
   * Get all the service instances in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ServicesDescription>;

  /**
   * Get all the service instances in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_List")
  list is ArmListBySubscription<ServicesDescription>;
}

@@maxLength(ServicesDescription.name, 24);
@@minLength(ServicesDescription.name, 3);
@@doc(ServicesDescription.name, "The name of the service instance.");
@@doc(ServicesDescription.properties, "The common properties of a service.");
@@doc(ServicesDescriptions.createOrUpdate::parameters.resource,
  "The service instance metadata."
);
@@doc(ServicesDescriptions.update::parameters.properties,
  "The service instance metadata and security metadata."
);
