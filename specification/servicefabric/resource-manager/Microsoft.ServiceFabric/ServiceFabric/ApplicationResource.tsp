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
 * The application resource.
 */
@parentResource(Cluster)
model ApplicationResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * Describes the managed identities for an Azure resource.
   */
  identity?: ManagedIdentity;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationResource,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationResource;
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ApplicationResource,
    PatchModel = ApplicationResourceUpdate,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationResource;
    }
  >;

  /**
   * Delete a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationResource>;

  /**
   * Gets all application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_List")
  list is ArmResourceListByParent<
    ApplicationResource,
    Response = ArmResponse<ApplicationResourceList>
  >;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResource.properties, "The application resource properties.");
@@doc(ApplicationResources.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(ApplicationResources.update::parameters.properties,
  "The application resource for patch operations."
);
