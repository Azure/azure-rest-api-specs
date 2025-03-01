import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/adminmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using AdminModels;
using MdsCommon;

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

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
      @header
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
    list is Operations.ResourceList<DataVersion>;

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
      {
        @body
        @doc("The identifier for the data version.")
        versionId: string;
      },
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
