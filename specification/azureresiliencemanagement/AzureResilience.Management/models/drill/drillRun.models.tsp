import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./drillRunChildJob.models.tsp";
import "./drillRunResources.models.tsp";
import "./drillRunChaosJob.models.tsp";
import "./drillRunChaosJobResources.models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the DrillRun Object.
 */
@parentResource(Drill)
@doc("DrillRun resource.")
model DrillRun is ProxyResource<DrillRunProperties> {
  @doc("The name of the DrillRun")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("drillRunName")
  @segment("drillRuns")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of the Resiliency DrillRun.")
model DrillRunProperties extends JobProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobType: JobType.DrillRun;

  @doc("Parent Drill resource.")
  @visibility(Lifecycle.Read)
  drillUrl: armResourceIdentifier<[
    {
      type: "Microsoft.Resiliency/drills";
    }
  ]>;

  @doc("Measured aggregated Metric value.")
  @visibility(Lifecycle.Read)
  metricValue: string;

  @doc("Drill mode.")
  @visibility(Lifecycle.Read)
  drillMode: DrillMode;

  @doc("Attestation of this Drill Run.")
  @visibility(Lifecycle.Read)
  attestation: DrillAttestation;

  @doc("Notes for this Drill.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  notes: string[];
}

@doc("Request body for AddNotes API.")
model DrillRunAddNotesRequest {
  @doc("The notes string.")
  notes: string;

  @doc("System generated current Timestamp.")
  @visibility(Lifecycle.Read)
  timestamp: utcDateTime;

  @doc("System generated Object Id of the notes author.")
  @visibility(Lifecycle.Read)
  author: string;
}

@doc("Request body for Failover API.")
model DrillRunFailoverRequest {
  @doc("The failover properties.")
  failoverProperties: FailoverRequest;
}

@doc("Request body for TestFailover API.")
model DrillRunTestFailoverRequest {
  @doc("The failover properties.")
  failoverProperties: FailoverRequest;
}

@doc("Request body for TestFailoverCleanup API.")
model DrillRunTestFailoverCleanupRequest {
  @doc("Comments for the request.")
  comments?: string;
}

@doc("Request body for TestFailoverCleanup API.")
model DrillRunActionResponse {
  @doc("JobId of the RO job.")
  @visibility(Lifecycle.Read)
  jobId: armResourceIdentifier<[
    {
      type: "Microsoft.Resiliency/jobs";
    }
  ]>;
}

@doc("Request body for MarkAsComplete API.")
model MarkAsCompleteRequest {
  @doc("State of the Drill Run.")
  drillRunStage: DrillRunStages;
}

@doc("Response body for MarkAsComplete API.")
model MarkAsCompleteResponse {
  @doc("Matrix of Actions supported on Operations.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedVerbsForStage: SupportedVerbsForStage[];
}

@doc("Model for supported verbs for stage.")
model SupportedVerbsForStage {
  @doc("Name of stage.")
  drillRunStage: DrillRunStages;

  @doc("Supported Verbs for stage.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedVerbs: DrillRunOperationVerbs[];
}
