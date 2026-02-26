import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The application type name resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
@parentResource(Cluster)
model ApplicationTypeResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationTypeResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeResource,
    KeyName = "applicationTypeName",
    SegmentName = "applicationTypes",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ApplicationTypeResources {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric cluster resource.
   */
  get is ArmResourceRead<ApplicationTypeResource>;

  /**
   * Create or update a Service Fabric application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service existing api without 201 response code"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ApplicationTypeResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeResource>
  >;

  /**
   * Delete a Service Fabric application type name resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeResource>;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypes_List")
  list is ArmResourceListByParent<
    ApplicationTypeResource,
    Response = ArmResponse<ApplicationTypeResourceList>
  >;
}

@@doc(ApplicationTypeResource.name,
  "The name of the application type name resource."
);
@@doc(ApplicationTypeResource.properties,
  "The application type name properties"
);
@@doc(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "The application type name resource."
);

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "servicefabric is a brownfield service with existing provisioning state property as string and not enum"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The list of application type names.
 */
model ApplicationTypeResourceList is Azure.Core.Page<ApplicationTypeResource>;
