import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * An application type version resource for the specified application type name resource.
 */
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationTypeVersionResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeVersionResource,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  /**
   * Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_Get")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  /**
   * Create or update a Service Fabric application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationTypeVersionResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationTypeVersionResource>> & {
      @bodyRoot
      _: ApplicationTypeVersionResource;
    }
  >;

  /**
   * Delete a Service Fabric application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeVersionResource>;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_List")
  list is ArmResourceListByParent<
    ApplicationTypeVersionResource,
    Response = ArmResponse<ApplicationTypeVersionResourceList>
  >;
}

@@doc(ApplicationTypeVersionResource.name, "The application type version.");
@@doc(ApplicationTypeVersionResource.properties,
  "The properties of the application type version resource."
);
@@doc(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "The application type version resource."
);

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;

  /**
   * List of application type parameters that can be overridden when creating or updating the application.
   */
  @visibility(Lifecycle.Read)
  defaultParameterList?: Record<string>;
}

/**
 * The list of application type version resources for the specified application type name resource.
 */
model ApplicationTypeVersionResourceList
  is Azure.Core.Page<ApplicationTypeVersionResource>;
