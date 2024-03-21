// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

using TypeSpec.Http;
using OpenAPI;

/** The type of the job. */
enum JobType {
  /** Unknown job type. */
  Unknown,

  /** Quantum Computing job type. */
  QuantumComputing,

  /** Optimization job type. */
  Optimization,
}

/** The status of the job. */
enum JobStatus {
  /** The job is waiting in the queue to be executed. */
  Waiting,

  /** The job is being executed. */
  Executing,

  /** The job completed with success. */
  Succeeded,

  /** The job completed with failure. */
  Failed,

  /** The job was cancelled. */
  Cancelled,
}

/** Quantum computing data. */
model QuantumComputingData {
  /** The number of quantum computing items in the job. */
  @visibility("read")
  count: int64;
}

/** A job to be run in the workspace. */
// Notes:
// - The generated Swagger is not automatically adding the x-ms-discriminator-value
//   so we are adding it manually.
@extension("x-ms-discriminator-value", ItemType.Job)
@resource("jobs")
@parentResource(QuantumWorkspace)
model JobDetails extends ItemDetails {
  /** Id of the job. */
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "False-positive"
  @key("jobId")
  @visibility("read")
  id: WorkspaceItemId;

  /** Type of the Quantum Workspace item is Job. */
  @visibility("read", "create")
  itemType: ItemType.Job;

  /** The type of job. */
  @visibility("read", "create")
  jobType?: JobType;

  /** The ID of the session that the job is part of. */
  @visibility("read", "create")
  sessionId?: string;

  /** The blob container SAS uri, the container is used to host job data. */
  @visibility("read", "create")
  containerUri: string;

  /** The input blob URI, if specified, it will override the default input blob in the container. */
  @visibility("read", "create")
  inputDataUri?: string;

  /** The format of the input data. */
  @visibility("read", "create")
  inputDataFormat?: string;

  /** The status of the job. */
  @visibility("read")
  status?: JobStatus;

  /** The job metadata. Metadata provides client the ability to store client-specific information */
  @visibility("read", "create", "update")
  metadata?: {};

  /** The time when a job was successfully cancelled. */
  @visibility("read")
  cancellationTime?: utcDateTime;

  /** List of user-supplied tags associated with the job. */
  @visibility("read", "create", "update")
  tags?: string[];

  /** Quantum computing data. */
  @visibility("read")
  quantumComputingData?: QuantumComputingData;

  /** The input parameters for the job. JSON object used by the target solver. It is expected that the size of this object is small and only used to specify parameters for the execution target, not the input data. */
  @visibility("read", "create")
  inputParams?: {};

  /** The output blob uri. When a job finishes successfully, results will be uploaded to this blob. */
  @visibility("read", "create")
  outputDataUri?: string;

  /** The format of the output data. */
  @visibility("read", "create")
  outputDataFormat?: string;
}

@useDependency(DefaultAzureCoreVersion)
namespace Quantum.Workspace.Operations {
  using Quantum.Workspace.BaseOperations;
  interface JobOperations {
    /** Create a new job. */
    create is CreateOperation<JobDetails>;

    /** Update job properties. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The Azure.Core.ResourceUpdate does not support NoContentResponse and the JsonPatchDocument request body"
    update is PatchOperation<JobDetails>;

    /** Request the cancellation of an existing job. */
    cancel is CancelOperation<JobDetails>;

    /** Get job by its id. */
    get is GetOperation<JobDetails>;

    /** List all jobs. */
    list is ListOperation<JobDetails>;
  }
}
