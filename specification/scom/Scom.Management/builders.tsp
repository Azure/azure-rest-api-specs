import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Scom.Builders;

/**
 * A long-running resource action.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response model for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template op"
op ScomArmResourceActionAsync<
    TResource extends ArmResource,
    TRequest extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model,
    TBaseParameters extends TypeSpec.Reflection.Model = BaseParameters<TResource>
> is ArmResourceActionAsyncBase<
    TResource,
    TRequest,
    ScomArmAcceptedLroResponse | ArmResponse<TResponse>,
    TBaseParameters
>;

/**
 * The standard ARM response for asynchronous PATCH, POST, and DELETE operations
 * @template TMessage The description of the response status (defaults to `Resource operation accepted`)
 */
@doc(TMessage)
model ScomArmAcceptedLroResponse<TMessage extends valueof string = "Resource operation accepted.">
    is ArmAcceptedResponse<TMessage> {
    /** The Location header contains the URL where the status of the long running operation can be checked. */
    @header("Location") location?: string;

    /** The URL to retrieve the status of the asynchronous operation. */
    @header("Azure-AsyncOperation") azureAsyncOperation?: string;
}
