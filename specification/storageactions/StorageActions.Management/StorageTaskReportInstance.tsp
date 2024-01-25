import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageActions;
@doc("Storage Tasks run report instance")
@parentResource(StorageTask)
model StorageTaskReportInstance is TrackedResource<StorageTaskReportProperties> {
  @path
  @key("reportName")
  @segment("reports")
  name: string;
}

@armResourceOperations
interface StorageTaskReportInstances {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StorageTasksReport_List")
  @doc("Fetch the storage tasks run report summary for each assignment.")
  reports is ArmResourceListByParent<StorageTaskReportInstance, {
    ...BaseParameters<StorageTaskReportInstance>,
    
    @doc("Optional, specifies the maximum number of storage task assignment Ids to be included in the list response.")
    @query("$maxpagesize")
    $maxpagesize?: string,

    @doc("Optional. When specified, it can be used to query using reporting properties.")
    @query("$filter")
    $filter?: string,
  }>;
}
