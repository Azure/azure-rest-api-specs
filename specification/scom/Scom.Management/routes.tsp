import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Scom;

interface Operations extends Azure.ResourceManager.Operations {}

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
