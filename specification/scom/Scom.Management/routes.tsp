import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Scom;

interface Operations {
    // TODO - is this correct?? Should be using `interface Operations extends Azure.ResourceManager.Operations {}`
    /** Lists all available operations on SCOM managed instance (SCOM MI)r */
    @tag("Operations")
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Scom/operations")
    @get
    list(
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
    ): ArmResponse<Foundations.OperationListResult> | ErrorResponse;

    @tag("Operations")
    @route("/providers/Microsoft.Scom/operations")
    @get
    listV2(
        ...ApiVersionParameter,
    ): ArmResponse<Foundations.OperationListResult> | ErrorResponse;
}

// Issue: The 'operation list' does not require this operation. It has been commented out.
// interface OperationsOperations {
//   /** Lists all available operations on SCOM monitoring instance */
//   @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Scom/operations")
//   @get
//   List is Azure.Core.Foundations.Operation<
//     {
//       /** The ID of the target subscription. */
//       @minLength(1)
//       @path
//       subscriptionId: string;

//       /** The name of the resource group. The name is case insensitive. */
//       @maxLength(90)
//       @minLength(1)
//       @path
//       resourceGroupName: string;
//     },
//     OperationListResult
//   >;
// }
