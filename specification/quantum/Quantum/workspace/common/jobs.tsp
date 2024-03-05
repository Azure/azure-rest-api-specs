// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/http";
import "./items.tsp";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Rest.Resource;
using OpenAPI;

@doc("The type of the job.")
enum JobType {
  Unknown,
  QuantumComputing,
  Optimization,
}

@doc("The status of the job.")
enum JobStatus {
  Waiting,
  Executing,
  Succeeded,
  Failed,
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
model JobDetails extends ItemDetails {
  @visibility("read", "create")
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
model JobDetailsList extends CollectionWithNextLink<JobDetails> {}

@doc("Id of the job.")
@pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
@maxLength(36)
scalar JobId extends WorkspaceItemId;

alias JobIdParam = {
  @path
  @segment("jobs")
  jobId: JobId;
};

alias JobParam = {
  @path
  @segment("jobs")
  jobId: JobId;

  @body
  @doc("The job data.")
  job: JobDetails;
};

interface JobOperations {
  @doc("Create a new job")
  @put
  @createsResource(JobDetails)
  @operationId("Jobs_Create")
  create is CreateOperation<JobDetails, JobParam>;

  @doc("Update job properties")
  @patch
  @updatesResource(JobDetails)
  @operationId("Jobs_Patch")
  patch is PatchOperation<JobDetails, JobIdParam>;

  @doc("Request the cancellation of an existing job")
  @delete
  @operationId("Jobs_Cancel")
  cancel is CancelOperation<JobDetails, JobIdParam>;

  @doc("Get job by its id")
  @get
  @readsResource(JobDetails)
  @operationId("Jobs_Get")
  get is GetOperation<JobDetails, JobIdParam>;

  @doc("List all jobs")
  @get
  @listsResource(JobDetails)
  @operationId("Jobs_List")
  @segment("jobs")
  list is ListOperation<JobDetailsList>;
}
