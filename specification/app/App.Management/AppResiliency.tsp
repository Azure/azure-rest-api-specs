import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Configuration to setup App Resiliency
 */
model AppResiliency
  is Azure.ResourceManager.ProxyResource<AppResiliencyProperties> {
  ...ResourceNameParameter<
    Resource = AppResiliency,
    KeyName = "name",
    SegmentName = "resiliencyPolicies",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface AppResiliencies {
  /**
   * Get container app resiliency policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppResiliency_Get")
  get is ArmResourceRead<AppResiliency>;

  /**
   * Create or update container app resiliency policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppResiliency_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AppResiliency>;

  /**
   * Update container app resiliency policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppResiliency_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<AppResiliency, PatchModel = AppResiliency>;

  /**
   * Delete container app resiliency policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppResiliency_Delete")
  delete is ArmResourceDeleteSync<AppResiliency>;

  /**
   * List container app resiliency policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppResiliency_List")
  list is ArmResourceListByParent<
    AppResiliency,
    Response = ArmResponse<AppResiliencyCollection>
  >;
}

@@doc(AppResiliency.name, "Name of the resiliency policy.");
@@doc(AppResiliency.properties, "App Resiliency resource specific properties");
@@doc(AppResiliencies.createOrUpdate::parameters.resource,
  "The resiliency policy to create or update."
);
@@doc(AppResiliencies.update::parameters.properties,
  "The resiliency policy to update."
);
