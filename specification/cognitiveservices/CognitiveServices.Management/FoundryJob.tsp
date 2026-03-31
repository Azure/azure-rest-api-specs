import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Azure Resource Manager resource envelope for a Foundry Job.
 */
@added(Versions.v2026_01_15_preview)
@parentResource(Project)
model FoundryJobResource
  is Azure.ResourceManager.ProxyResource<FoundryJobBase, false> {
  ...ResourceNameParameter<
    Resource = FoundryJobResource,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

@armResourceOperations(#{ omitTags: true })
@added(Versions.v2026_01_15_preview)
interface FoundryJobs {
  /**
   * Gets a Foundry Job by name.
   */
  @tag("FoundryJobs")
  get is ArmResourceRead<
    FoundryJobResource,
    Response = ArmResponse<FoundryJobResource>
  >;

  /**
   * Creates a Foundry Job.
   */
  @tag("FoundryJobs")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FoundryJobResource,
    Response = ArmResponse<FoundryJobResource> | ArmResourceCreatedResponse<FoundryJobResource>
  >;

  /**
   * Deletes a Foundry Job.
   */
  @tag("FoundryJobs")
  delete is ArmResourceDeleteWithoutOkAsync<FoundryJobResource>;

  /**
   * Lists Foundry Jobs in the project.
   */
  @tag("FoundryJobs")
  list is ArmResourceListByParent<
    FoundryJobResource,
    Response = ArmResponse<FoundryJobResourceArmPaginatedResult>
  >;

  /**
   * Cancels a Foundry Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "cancel operation uses Location header for async polling matching existing service behavior"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-response-codes" "cancel returns 200/202 matching existing service behavior"
  @tag("FoundryJobs")
  cancel is ArmResourceActionNoResponseContentAsync<FoundryJobResource, void>;
}

@@doc(FoundryJobResource.name, "The name of the Foundry Job.");
@@doc(FoundryJobResource.properties, "Foundry Job base definition.");
@@doc(FoundryJobs.createOrUpdate::parameters.resource,
  "Foundry Job definition."
);
