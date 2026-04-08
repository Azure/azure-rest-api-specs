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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource extends ProxyResource {
  properties?: ApplicationTypeVersionResourceProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations(#{ omitTags: true })
interface ApplicationTypeVersionResources {
  /**
   * Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.
   */
  @summary("Gets a Service Fabric application type version resource.")
  @tag("ApplicationTypeVersion")
  get is ArmResourceRead<ApplicationTypeVersionResource, Error = ErrorModel>;

  /**
   * Create or update a Service Fabric application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service with existing non-standard response codes"
  @summary("Creates or updates a Service Fabric application type version resource.")
  @tag("ApplicationTypeVersion")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationTypeVersionResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationTypeVersionResource>> & {
      @bodyRoot
      _: ApplicationTypeVersionResource;
    },
    Error = ErrorModel
  >;

  /**
   * Delete a Service Fabric application type version resource with the specified name.
   */
  @summary("Deletes a Service Fabric application type version resource.")
  @tag("ApplicationTypeVersion")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeVersionResource,
    Error = ErrorModel
  >;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.
   */
  @summary("Gets the list of application type version resources created in the specified Service Fabric application type name resource.")
  @tag("ApplicationTypeVersion")
  list is ArmResourceListByParent<
    ApplicationTypeVersionResource,
    Response = ArmResponse<ApplicationTypeVersionResourceList>,
    Error = ErrorModel
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "servicefabric is a brownfield service with existing provisioning state property as string and not enum"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;

  /**
   * List of application type parameters that can be overridden when creating or updating the application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  @visibility(Lifecycle.Read)
  defaultParameterList?: Record<string>;
}

/**
 * The list of application type version resources for the specified application type name resource.
 */
model ApplicationTypeVersionResourceList
  is Azure.Core.Page<ApplicationTypeVersionResource>;
