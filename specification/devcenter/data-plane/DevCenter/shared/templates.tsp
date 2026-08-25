import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

/**
 * Interface containing common resource operations.
 * @template InterfaceTraits Traits applicable to the operations.
 * @template ErrorResponse Error response of the operations. If not specified, the default error response is used.
 */
@Traits.Private.ensureTraitsPresent(
  InterfaceTraits,
  ExpectedResourceOperationTraits
)
interface DevCenterResourceOperations<
  InterfaceTraits extends TypeSpec.Reflection.Model,
  ErrorResponse = Azure.Core.Foundations.ErrorResponse
> {
  /**
   * Long-running resource action operation template.
   * @template Resource Resource type.
   * @template Parameters Object describing the parameters of the operation.
   * @template StatusResult Object describing the status result of the operation.
   * @template StatusError Object describing the status error of the operation.
   * @template Traits Object describing the traits of the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Custom template"
  #suppress "@azure-tools/typespec-providerhub/no-inline-model" "This operation signature is not used in Azure Resource Manager operations (yet)"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "This operation must return a status monitor in its response."
  @action
  @actionSeparator(":")
  LongRunningResourceAction<
    Resource extends TypeSpec.Reflection.Model,
    Parameters extends TypeSpec.Reflection.Model,
    StatusMonitor extends TypeSpec.Reflection.Model,
    Traits extends TypeSpec.Reflection.Model = {}
  > is Foundations.ResourceOperation<
    Resource,
    Parameters &
      Azure.Core.Traits.Private.TraitProperties<
        Traits & InterfaceTraits,
        Azure.Core.Traits.TraitLocation.Parameters,
        Azure.Core.Traits.TraitContext.Action
      >,
    AcceptedResponse &
      StatusMonitor & {
        @pollingLocation
        @doc("The location for monitoring the operation state.")
        @TypeSpec.Http.header("Operation-Location")
        operationLocation: ResourceLocation<StatusMonitor>;
      } & Azure.Core.Traits.Private.TraitProperties<
        Traits & InterfaceTraits,
        Azure.Core.Traits.TraitLocation.Response,
        Azure.Core.Traits.TraitContext.Action
      >,
    Traits & InterfaceTraits,
    ErrorResponse
  >;
}
