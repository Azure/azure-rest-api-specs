import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
@parentResource(ApplicationResource)
model ServiceResource
  is Azure.ResourceManager.ProxyResource<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Services {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.
   */
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric managed service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ServiceResource,
    Response = ArmResourceUpdatedResponse<ServiceResource> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServiceResource>> & {
      @bodyRoot
      _: ServiceResource;
    })
  >;

  /**
   * Updates the tags of a service resource of a given managed cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServiceResource,
    PatchModel = ServiceUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed service resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ServiceResource,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric managed application resource.
   */
  listByApplications is ArmResourceListByParent<
    ServiceResource,
    Response = ArmResponse<ServiceResourceList>
  >;
}

@@doc(ServiceResource.name,
  "The name of the service resource in the format of {applicationName}~{serviceName}."
);
@@doc(ServiceResource.properties, "The service resource properties.");
@@doc(Services.createOrUpdate::parameters.resource, "The service resource.");
@@doc(Services.update::parameters.properties,
  "The service resource updated tags."
);
