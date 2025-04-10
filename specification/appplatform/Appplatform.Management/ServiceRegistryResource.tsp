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
 * Service Registry resource
 */
@parentResource(ServiceResource)
model ServiceRegistryResource
  is Azure.ResourceManager.ProxyResource<ServiceRegistryProperties> {
  ...ResourceNameParameter<
    Resource = ServiceRegistryResource,
    KeyName = "serviceRegistryName",
    SegmentName = "serviceRegistries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceRegistryResources {
  /**
   * Get the Service Registry and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceRegistries_Get")
  get is ArmResourceRead<ServiceRegistryResource>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create the default Service Registry or update the existing Service Registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceRegistries_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceRegistryResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable the default Service Registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ServiceRegistries_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceRegistryResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceRegistries_List")
  list is ArmResourceListByParent<
    ServiceRegistryResource,
    Response = ArmResponse<ServiceRegistryResourceCollection>
  >;
}

@@doc(ServiceRegistryResource.name, "The name of Service Registry.");
@@doc(ServiceRegistryResource.properties,
  "Service Registry properties payload"
);
