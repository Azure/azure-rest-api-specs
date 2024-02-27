import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface SharedOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is a custom operation status endpoint."
  @doc("Get the status of an operation.")
  @route("/projects/{projectName}/operationstatuses/{operationId}")
  getProjectOperationStatus is Foundations.GetOperationStatus<{
    @doc("The DevCenter Project upon which to execute operations.")
    @path
    projectName: string;
  }>;
}
