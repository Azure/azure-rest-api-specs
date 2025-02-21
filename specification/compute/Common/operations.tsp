import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Http;
using Rest;
// using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

/** Custom ArmResourceRead operation template with CloudError as Error */
op ComputeResourceRead<
  Resource extends {},
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource>,
  Error extends {} = Microsoft.Compute.CloudError
> is ArmResourceRead<Resource, BaseParameters, Parameters, Response, Error>;

/** Custom ArmResourceCreateOrReplaceAsync operation template with CloudError as Error */
op ComputeResourceCreateOrReplaceAsync<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmAsyncOperationHeader<FinalResult = Resource> &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
    Resource,
    LroHeaders
  >,
  Error extends {} = Microsoft.Compute.CloudError
> is ArmResourceCreateOrReplaceAsync<
  Resource,
  BaseParameters,
  LroHeaders,
  Parameters,
  Response,
  Error
>;

/** Custom ArmProviderActionAsync operation template with CloudError as Error */
op ComputeProviderActionAsync<
  Request extends {} | void = void,
  Response extends {} | void = void,
  Scope extends {} = TenantActionScope,
  Parameters extends {} = {},
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Response,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Error extends {} = CloudError
> is ArmProviderActionAsync<
  Request,
  Response,
  Scope,
  Parameters,
  LroHeaders,
  Error
>;

/** Custom ArmProviderActionSync operation template with CloudError as Error */
op ComputeProviderActionSync<
  Request extends {} | void = void,
  Response extends {} | void = void,
  Scope extends {} = TenantActionScope,
  Parameters extends {} = {},
  Error extends {} = CloudError
> is ArmProviderActionSync<Request, Response, Scope, Parameters, Error>;

/** Custom ArmResourceCreateOrReplaceSync operation template with CloudError as Error */
op ComputeResourceCreateOrReplaceSync<
  Resource extends Foundations.Resource,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedSyncResponse<Resource>,
  Error extends {} = CloudError
> is ArmResourceCreateOrReplaceSync<
  Resource,
  BaseParameters,
  Parameters,
  Response,
  Error
>;

/** Custom ArmListBySubscription operation template with CloudError as Error */
op ComputeListBySubscription<
  Resource extends Azure.ResourceManager.Foundations.Resource,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<Resource>>,
  Error extends {} = CloudError
> is ArmListBySubscription<Resource, Parameters, Response, Error>;

/** Custom ArmResourceListByParent operation template with CloudError as Error */
op ComputeResourceListByParent<
  Resource extends Foundations.Resource,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  ParentName extends valueof string = "",
  ParentFriendlyName extends valueof string = "",
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ResourceListResult<Resource>>,
  Error extends {} = CloudError
> is ArmResourceListByParent<
  Resource,
  BaseParameters,
  ParentName,
  ParentFriendlyName,
  Parameters,
  Response,
  Error
>;

/** Custom ArmCustomPatchAsync operation template with CloudError as Error */
op ComputeCustomPatchAsync<
  Resource extends Foundations.Resource,
  PatchModel extends TypeSpec.Reflection.Model = Foundations.TagsUpdateModel<Resource>,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Resource,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource> | ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders
  >,
  Error extends {} = CloudError
> is ArmCustomPatchAsync<
  Resource,
  PatchModel,
  BaseParameters,
  LroHeaders,
  Parameters,
  Response,
  Error
>;

/** Custom ArmCustomPatchSync operation template with CloudError as Error */
op ComputeCustomPatchSync<
  Resource extends Foundations.Resource,
  PatchModel extends TypeSpec.Reflection.Model = Foundations.TagsUpdateModel<Resource>,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<Resource>,
  Error extends {} = CloudError
> is ArmCustomPatchSync<
  Resource,
  PatchModel,
  BaseParameters,
  Parameters,
  Response,
  Error
>;

/** Custom ArmResourceDeleteSync operation template with CloudError as Error */
op ComputeResourceDeleteSync<
  Resource extends Foundations.Resource,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Response extends {} = ArmDeletedResponse | ArmDeletedNoContentResponse,
  Error = CloudError
> is ArmResourceDeleteSync<
  Resource,
  BaseParameters,
  Parameters,
  Response,
  Error
>;

/** Custom ArmResourceDeleteAsync operation template with CloudError as Error */
#suppress "deprecated" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
op ComputeResourceDeleteAsync<
  Resource extends Foundations.Resource,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders> | ArmDeletedNoContentResponse,
  Error extends {} = CloudError
> is ArmResourceDeleteAsync<
  Resource,
  BaseParameters,
  LroHeaders,
  Parameters,
  Response,
  Error
>;

/** Custom ArmResourceActionSync operation template with CloudError as Error */
op ComputeResourceActionSync<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters = Foundations.DefaultBaseParameters<Resource>,
  Parameters extends {} = {},
  Error extends {} = CloudError
> is ArmResourceActionSync<
  Resource,
  Request,
  Response,
  BaseParameters,
  Parameters,
  Error
>;

/** Custom ArmResourceActionAsync operation template with CloudError as Error */
op ComputeResourceActionAsync<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Response,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = CloudError
> is ArmResourceActionAsync<
  Resource,
  Request,
  Response,
  BaseParameters,
  LroHeaders,
  Parameters,
  Error
>;
/** Custom ArmResourceActionAsync operation template with CloudError as Error */
op ComputeResourceActionAsyncBase<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  Response extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    Response,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = CloudError
> is ArmResourceActionAsyncBase<
  Resource,
  Request,
  Response,
  BaseParameters,
  Parameters,
  Error
>;
/** Custom ArmResourceActionNoResponseContentAsync operation template with CloudError as Error */
op ComputeResourceActionNoResponseContentAsync<
  Resource extends Foundations.Resource,
  Request extends TypeSpec.Reflection.Model | void,
  BaseParameters extends TypeSpec.Reflection.Model = Foundations.DefaultBaseParameters<Resource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    void,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Error extends {} = ErrorResponse
> is ArmResourceActionNoResponseContentAsync<
  Resource,
  Request,
  BaseParameters,
  LroHeaders,
  Parameters,
  Error
>;
