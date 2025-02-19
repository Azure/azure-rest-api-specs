import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
@parentResource(ApplicationResource)
model ServiceResource
  is Azure.ResourceManager.TrackedResource<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric managed service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceResource,
    Response = ArmResourceUpdatedResponse<ServiceResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the tags of a service resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @parameterVisibility
  @operationId("Services_Update")
  update is ArmCustomPatchSync<
    ServiceResource,
    PatchModel = ServiceUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric managed application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListByApplications")
  listByApplications is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;
}

@@doc(ServiceResource.name,
  "The name of the service resource in the format of {applicationName}~{serviceName}."
);
@@doc(ServiceResource.properties, "The service resource properties.");
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "The service resource."
);
@@doc(ServiceResources.update::parameters.properties,
  "The service resource updated tags."
);
