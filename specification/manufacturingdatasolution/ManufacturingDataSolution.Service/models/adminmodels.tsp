import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using Azure.Core;
using TypeSpec.Rest;
using MdsCommon;

namespace AdminModels;

@doc("Represents the Version Id")
model DataVersionId {
  @doc("The identifier for the data version.")
  versionId: string;
}

@doc("Represents a data version.")
@resource("version")
model DataVersion {
  @doc("The identifier for the data version.")
  @visibility(Lifecycle.Read)
  @key
  versionId: string;

  @doc("A description for the data version.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description: string;

  @doc("A flag indicating whether the data version is active.")
  @visibility(Lifecycle.Read)
  isActive?: boolean;
}

@doc("Represents the request of feature.")
@resource("feature")
model FeatureRequest {
  @doc("The feature name.")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Update)
  @doc("A flag indicating whether the feature is enabled.")
  isEnabled: boolean;
}

@doc("Represents a request to clean up an Entity.")
@resource("cleanup")
model CleanupEntityRequest {
  @doc("The entity type to be cleaned up.")
  @visibility(Lifecycle.Read)
  @key
  entityName: string;
}

@doc("Represents the response status of a cleanup job.")
@resource("cleanup/status")
model CleanupJobStatusResponse is MdsJobStatusResponse {
  @doc("The status of the cleanup ADX property events and Redis job.")
  @visibility(Lifecycle.Read)
  cleanupAdxPropertyEventsAndRedisJobStatus?: string;

  @doc("The status of the cleanup ADX twin events job.")
  @visibility(Lifecycle.Read)
  cleanupAdxTwinEventsJobStatus?: string;

  @doc("The status of the cleanup ADX relations job.")
  @visibility(Lifecycle.Read)
  cleanupAdxRelationsJobStatus?: string;

  @doc("The status of the cleanup ADX vectors job.")
  @visibility(Lifecycle.Read)
  cleanupAdxVectorsJobStatus?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the cleanup ADX reference data job.")
  cleanupAdxReferenceDataJobStatus?: string;
}

@doc("Represents the response containing the job status.")
@resource("job/status")
model MdsJobStatusResponse {
  @doc("The job identifier.")
  @key
  @visibility(Lifecycle.Read)
  jobId: string;

  @doc("The job status.")
  @pollingOperationParameter
  status: JobStatus;

  @doc("The job message.")
  message?: string;
}
