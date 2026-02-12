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
  is Azure.ResourceManager.ProxyResource<ApplicationTypeResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeResource,
    KeyName = "applicationTypeName",
    SegmentName = "applicationTypes",
    NamePattern = ""
  >;

  /**
   * It will be deprecated in New API, resource location depends on the parent resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * Azure resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing property in original swagger"
  @visibility(Lifecycle.Read)
  etag?: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations(#{ omitTags: true })
interface ApplicationTypeResources {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric cluster resource.
   */
  @summary("Gets a Service Fabric application type name resource.")
  @tag("ApplicationType")
  get is ArmResourceRead<ApplicationTypeResource, Error = ErrorModel>;

  /**
   * Create or update a Service Fabric application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service existing api without 201 response code"
  @summary("Creates or updates a Service Fabric application type name resource.")
  @tag("ApplicationType")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ApplicationTypeResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeResource>,
    Error = ErrorModel
  >;

  /**
   * Delete a Service Fabric application type name resource with the specified name.
   */
  @summary("Deletes a Service Fabric application type name resource.")
  @tag("ApplicationType")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeResource,
    Error = ErrorModel
  >;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of application type name resources created in the specified Service Fabric cluster resource.")
  @tag("ApplicationType")
  @operationId("ApplicationTypes_List")
  list is ArmResourceListByParent<
    ApplicationTypeResource,
    Response = ArmResponse<ApplicationTypeResourceList>,
    Error = ErrorModel
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
