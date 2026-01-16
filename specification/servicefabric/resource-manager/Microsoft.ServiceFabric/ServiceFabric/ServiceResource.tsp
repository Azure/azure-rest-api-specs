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
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceResource,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ServiceResource,
    PatchModel = ServiceResourceUpdate,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ServiceResource;
    }
  >;

  /**
   * Delete a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceResource>;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_List")
  list is ArmResourceListByParent<
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
  "The service resource for patch operations."
);
