import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Autorest;

namespace DevCenterService;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
interface SharedOperations {
  @doc("Get the status of an operation.")
  @example(
    "./examples/SharedOperations_GetProjectOperationStatus.json",
    "Get the status of an operation."
  )
  @route("/projects/{projectName}/operationstatuses/{operationId}")
  @get
  getProjectOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;

      @doc("Operation Id")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}
