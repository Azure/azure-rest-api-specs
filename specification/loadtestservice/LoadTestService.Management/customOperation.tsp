import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService;

@armResourceOperations
interface CustomOperations {
  /**
   * A synchronous resource action.
   * @template Resource The resource being acted upon
   * @template Request The request model for the action
   * @template Response The response model for the action
   * @template BaseParameters Optional. Allows overriding the parameters for the operation
   * @template Parameters Optional. Additional parameters after the path parameters
   * @template Error Optional. The error response, if non-standard.
   */
  @autoRoute
  @armResourceList(Resource)
  @armResourceAction(Resource)
  @get
  @returnsDoc("Azure operation completed successfully.")
  ArmResourceActionSyncCustomGet<
    Resource extends ArmResource,
    Request extends TypeSpec.Reflection.Model | void,
    Response extends TypeSpec.Reflection.Model | void,
    BaseParameters = DefaultBaseParameters<Resource>,
    Parameters extends {} = {},
    Error extends {} = ErrorResponse
  >(
    ...ResourceInstanceParameters<Resource, BaseParameters>,
    ...Parameters,

    @doc("The content of the action request")
    @body
    body: Request,
  ): Response | Error;
}
