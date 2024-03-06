// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";

import "../common/operations.tsp";
import "../common/params.tsp";
import "./items.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.Rest.Resource;
using OpenAPI;
using Quantum.Workspace.Common;

@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Quantum.Workspace.Jobs;

@doc("The type of the job.")
enum JobType {
  @doc("Unknown job type.")
  Unknown,

  @doc("Quantum Computing job type.")
  QuantumComputing,

  @doc("Optimization job type.")
  Optimization,
}

@doc("The status of the job.")
enum JobStatus {
  @doc("The job is waiting in the queue to be executed.")
  Waiting,

  @doc("The job is being executed.")
  Executing,

  @doc("The job completed with success.")
  Succeeded,

  @doc("The job completed with failure.")
  Failed,

  @doc("The job was cancelled.")
  Cancelled,
}

@doc("Quantum computing data.")
model QuantumComputingData {
  @doc("The number of quantum computing items in the job.")
  @visibility("read")
  count: int64;
}

@doc("A job to be run in the workspace.")
// Notes:
// - The generated Swagger is not automatically adding the x-ms-discriminator-value
//   so we are adding it manually.
@extension("x-ms-discriminator-value", ItemType.Job)
@resource("jobs")
@parentResource(Quantum.Workspace.Common.Workspace)
model JobDetails extends ItemDetails {
  @key
  @doc("Id of the job.")
  @visibility("read", "create")
  id: WorkspaceItemId;

  @visibility("read", "create")
  @doc("Type of the Quantum Workspace item is Job.")
  itemType: ItemType.Job;

  @visibility("read", "create")
  @doc("The type of job.")
  jobType?: JobType;

  @visibility("read", "create")
  @doc("The ID of the session that the job is part of.")
  sessionId?: string;

  @visibility("read", "create")
  @doc("The blob container SAS uri, the container is used to host job data.")
  containerUri: string;

  @visibility("read", "create")
  @doc("The input blob URI, if specified, it will override the default input blob in the container.")
  inputDataUri?: string;

  @visibility("read", "create")
  @doc("The format of the input data.")
  inputDataFormat?: string;

  @visibility("read")
  @doc("The status of the job.")
  status?: JobStatus;

  @visibility("read", "create", "update")
  @doc("The job metadata. Metadata provides client the ability to store client-specific information")
  metadata?: {};

  @visibility("read")
  @doc("The time when a job was successfully cancelled.")
  cancellationTime?: utcDateTime;

  @doc("List of user-supplied tags associated with the job.")
  @visibility("read", "create", "update")
  tags?: string[];

  @doc("Quantum computing data.")
  @visibility("read")
  quantumComputingData?: QuantumComputingData;

  @visibility("read", "create")
  @doc("The input parameters for the job. JSON object used by the target solver. It is expected that the size of this object is small and only used to specify parameters for the execution target, not the input data.")
  inputParams?: {};

  @visibility("read", "create")
  @doc("The output blob uri. When a job finishes successfully, results will be uploaded to this blob.")
  outputDataUri?: string;

  @visibility("read", "create")
  @doc("The format of the output data.")
  outputDataFormat?: string;
}

@doc("List of workspace jobs.")
model JobDetailsList {
  ...CollectionWithNextLink<JobDetails>;
}

@doc("Id of the job.")
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar JobId extends WorkspaceItemId;

alias JobIdParam = {
  @path
  @segment("jobs")
  @doc("Id of the job.")
  jobId: JobId;
};

alias JobParam = {
  @path
  @segment("jobs")
  @doc("Id of the job.")
  jobId: JobId;

  @body
  @doc("The job data.")
  job: JobDetails;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Backward compatibility with service and Swagger"
interface JobOperations {
  // @doc("Create a new job")
  // @put
  // @createsResource(JobDetails)
  // create is CreateOperation<JobDetails, JobParam>;

  // #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Backward compatibility with service and Swagger"
  // #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Backward compatibility with service and Swagger"
  // @doc("Update job properties")
  // @patch
  // @updatesResource(JobDetails)
  // patch is PatchOperation<JobDetails, JobIdParam>;

  // @doc("Request the cancellation of an existing job")
  // @delete
  // cancel is CancelOperation<JobDetails, JobIdParam>;

  @doc("Get job by its id")
  @get
  @readsResource(JobDetails)
  get is AzureStandardOperations.ResourceRead<JobDetails>;

  // @doc("List all jobs")
  // @get
  // @listsResource(JobDetails)
  // @segment("jobs")
  // list is ListOperation<JobDetailsList>;
}
