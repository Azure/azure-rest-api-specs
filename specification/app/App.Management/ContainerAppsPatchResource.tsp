import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Patch
 */
@parentResource(ContainerApp)
model ContainerAppsPatchResource
  is Azure.ResourceManager.ProxyResource<PatchProperties> {
  ...ResourceNameParameter<
    Resource = ContainerAppsPatchResource,
    KeyName = "patchName",
    SegmentName = "patches",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface ContainerAppsPatchResources {
  /**
   * Get details for specific Container Apps Patch by patch name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsPatches_Get")
  get is ArmResourceRead<ContainerAppsPatchResource>;

  /**
   * Delete specific Container Apps Patch by patch name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsPatches_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ContainerAppsPatchResource>;

  /**
   * List Container Apps Patch resources by ContainerApp.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsPatches_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<
    ContainerAppsPatchResource,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, $filter=properties/patchApplyStatus eq 'Succeeded'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PatchCollection>
  >;

  /**
   * Configure the Container Apps Patch skip option by patch name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsPatches_SkipConfigure")
  @action("skipConfig")
  skipConfigure is ArmResourceActionAsyncBase<
    ContainerAppsPatchResource,
    PatchSkipConfig,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ContainerAppsPatchResource>
  >;

  /**
   * Apply a Container Apps Patch resource with patch name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsPatches_Apply")
  apply is ArmResourceActionAsync<
    ContainerAppsPatchResource,
    void,
    ArmResponse<ContainerAppsPatchResource>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ContainerAppsPatchResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(ContainerAppsPatchResource.name, 64);
@@minLength(ContainerAppsPatchResource.name, 2);
@@doc(ContainerAppsPatchResource.name, "The name of the patch");
@@doc(ContainerAppsPatchResource.properties,
  "Properties that describes current states of the patch resource."
);
@@doc(ContainerAppsPatchResources.skipConfigure::parameters.body,
  "Configure patcher to skip a patch or not."
);
