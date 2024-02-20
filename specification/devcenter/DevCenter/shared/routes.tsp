import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-autorest";

using TypeSpec.Rest;
using TypeSpec.Http;
using Autorest;

namespace DevCenterService;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
interface SharedOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "can not be represeted by using stand operations"
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
