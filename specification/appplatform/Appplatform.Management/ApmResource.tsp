import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * APM Resource object
 */
@parentResource(ServiceResource)
model ApmResource is Azure.ResourceManager.ProxyResource<ApmProperties> {
  ...ResourceNameParameter<
    Resource = ApmResource,
    KeyName = "apmName",
    SegmentName = "apms",
    NamePattern = "^[a-z][a-z0-9-]*[a-z0-9]$"
  >;
}

@armResourceOperations
interface ApmResources {
  /**
   * Get the APM by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apms_Get")
  get is ArmResourceRead<ApmResource>;

  /**
   * Create or update an APM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apms_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApmResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to delete an APM
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apms_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApmResource>;

  /**
   * Get collection of APMs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apms_List")
  list is ArmResourceListByParent<
    ApmResource,
    Response = ArmResponse<ApmResourceCollection>
  >;

  /**
   * List keys of APM sensitive properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apms_ListSecretKeys")
  listSecretKeys is ArmResourceActionSync<
    ApmResource,
    void,
    ArmResponse<ApmSecretKeys>
  >;
}

@@doc(ApmResource.name, "The name of the APM");
@@doc(ApmResource.properties, "Properties of an APM");
@@doc(ApmResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
