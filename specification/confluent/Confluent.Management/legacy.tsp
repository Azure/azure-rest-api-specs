import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Legacy {
  interface LegacyOperations<
    ParentParameters extends {},
    ResourceTypeParameter extends {},
    ErrorType extends {} = ErrorResponse
  > {
    /**
     * A synchronous resource action.
     * @template Resource The resource being acted upon
     * @template Request The request model for the action
     * @template Response The response model for the action
     * @template Parameters Optional. Additional parameters after the path parameters
     */
    #suppress "@azure-tools/typespec-azure-core/no-private-usage"
    @armResourceAction(Resource)
    @Private.enforceConstraint(Resource, Foundations.Resource)
    @post
    @returnsDoc("Azure operation completed successfully.")
    ActionSync<
      Resource extends Foundations.Resource,
      Request extends TypeSpec.Reflection.Model | void,
      Response extends TypeSpec.Reflection.Model | void,
      Parameters extends {} = {}
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,

      @doc("The content of the action request")
      @bodyRoot
      body: Request,
    ): Response | ErrorType;

    /**
     * A long-running resource action.
     * @template Resource The resource being acted upon
     * @template Request The request model for the action
     * @template LroHeaders Optional. Allows overriding the headers returned in the Accepted response
     * @template Response The response model for the action
     * @template Parameters Optional. Additional parameters after the path parameters
     */
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "ARM"
    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "template"
    @autoRoute
    @armResourceAction(Resource)
    @Private.enforceConstraint(Resource, Foundations.Resource)
    @post
    @returnsDoc("Azure operation completed successfully.")
    ActionAsync<
      Resource extends Foundations.Resource,
      Request extends TypeSpec.Reflection.Model | void,
      Result extends TypeSpec.Reflection.Model | void,
      LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        Result,
        string
      > &
        Azure.Core.Foundations.RetryAfterHeader,
      Parameters extends {} = {},
      Response extends {} | void = ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders
      > | Result
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,

      @doc("The content of the action request")
      @bodyRoot
      body: Request,
    ): Response | ErrorType;
  }
  /**
   * @dev Get the provider namespace key-value pair
   * @template Resource Optional.  The resource to get the provider namespace for.
   */
  model Provider<Resource extends {} = TenantActionScope> {
    ...ProviderNamespace<Resource>;
  }
}
