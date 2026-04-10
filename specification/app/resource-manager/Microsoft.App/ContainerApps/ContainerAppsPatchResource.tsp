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

alias ContainerAppsPatchesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;
  },
  {
    /** Name of the Container Apps Patch. */
    @path
    @segment("patches")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    @minLength(2)
    @maxLength(64)
    patchName: string;
  }
>;

@armResourceOperations
interface ContainerAppsPatches {
  /**
   * Get details for specific Container Apps Patch by patch name.
   */
  get is ContainerAppsPatchesOps.Read<ContainerAppsPatchResource>;

  /**
   * Delete specific Container Apps Patch by patch name.
   */
  delete is ContainerAppsPatchesOps.DeleteWithoutOkAsync<ContainerAppsPatchResource>;

  /**
   * List Container Apps Patch resources by ContainerApp.
   */
  listByContainerApp is ContainerAppsPatchesOps.List<
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
  @action("skipConfig")
  skipConfigure is ContainerAppsPatchesOps.ActionAsync<
    ContainerAppsPatchResource,
    PatchSkipConfig,
    ContainerAppsPatchResource,
    Response = ArmAcceptedLroResponse<"Updating patch skipping detail. Updating status tracked by location header.">
  >;

  /**
   * Apply a Container Apps Patch resource with patch name.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  apply is ContainerAppsPatchesOps.ActionAsync<
    ContainerAppsPatchResource,
    void,
    ArmResponse<ContainerAppsPatchResource>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ContainerAppsPatchResource> &
      ArmLroLocationHeader<FinalResult = ContainerAppsPatchResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(ContainerAppsPatchResource.name, 64);
@@minLength(ContainerAppsPatchResource.name, 2);
@@doc(ContainerAppsPatchResource.name, "The name of the patch");
@@doc(ContainerAppsPatchResource.properties,
  "Properties that describes current states of the patch resource."
);
@@doc(ContainerAppsPatches.skipConfigure::parameters.body,
  "Configure patcher to skip a patch or not."
);
