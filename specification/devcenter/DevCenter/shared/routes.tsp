import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface SharedOperations {
  @doc("Get the status of an operation.")
  getProjectOperationStatus is StandardResourceOperations.ResourceRead<OperationStatus>;
}
