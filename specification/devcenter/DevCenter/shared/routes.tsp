import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface SharedOperations {
    @doc("Get the status of an operation.")
    @route("/projects/{projectName}/operationstatuses/{operationId}")
    @get
    GetProjectOperationStatus is DevCenterBaseResponse<
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