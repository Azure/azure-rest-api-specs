import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/adminmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using AdminModels;

@versioned(MdsSolution.Versions)
@route("/admin/")
namespace MdsSolution.AdminApis {
  alias BackgroundJobHeaders = ResponseHeadersTrait<
    {
      @header("background-jobid")
      @doc("The background job identifier.")
      @pollingOperationParameter
      backgroundJobId: string;
    },
    TraitContext.Create | TraitContext.Update | TraitContext.Delete
  >;

  alias CreateJobHeaders = ResponseHeadersTrait<
    {
      @doc("The background job location.")
      @header("Operation-Location")
      @pollingLocation
      operationLocation: string;

      @header("background-jobid")
      @doc("The background job identifier.")
      @pollingOperationParameter
      backgroundJobId: string;
    },
    TraitContext.Create | TraitContext.Update | TraitContext.Delete
  >;

  @doc("Get the version job status.")
  op getJobStatus is Operations.ResourceRead<MdsJobStatusResponse>;

  @doc("Get the cleanup job status.")
  op getCleanupStatus is Operations.ResourceRead<CleanupJobStatusResponse>;

  interface DataVersionApis {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
    listAllVersions is Azure.Core.Foundations.NonPagedResourceList<DataVersion>;

    @pollingOperation(getJobStatus)
    createVersion is Operations.LongRunningResourceCreateWithServiceProvidedName<
      DataVersion,
      CreateJobHeaders
    >;

    @pollingOperation(getJobStatus)
    @doc("Switch the current data version.")
    @action("switch")
    switchVersion is Operations.LongRunningResourceCollectionAction<
      DataVersion,
      DataVersionId,
      BackgroundJobHeaders
    >;

    @pollingOperation(getJobStatus)
    @doc("Delete a data version.")
    deleteVersion is Operations.LongRunningResourceDelete<
      DataVersion,
      BackgroundJobHeaders
    >;
  }

  alias CleanupQueryParams = QueryParametersTrait<
    {
      @doc("Entity Cleanup timerange start date.")
      @query
      startDate?: plainDate;

      @doc("Entity Cleanup timerange end date.")
      @query
      endDate?: plainDate;
    },
    TraitContext.Delete
  >;

  @pollingOperation(getCleanupStatus)
  op deleteOrCleanupEntityRequest is Operations.LongRunningResourceDelete<
    CleanupEntityRequest,
    CleanupQueryParams & BackgroundJobHeaders
  >;
}
