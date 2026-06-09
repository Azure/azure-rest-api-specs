import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2026_11_02_preview)
@parentResource(Namespace)
@doc("Job definition.")
model Job is TrackedResource<JobProperties> {
  @doc("The name of the job.")
  @key("jobName")
  @segment("jobs")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;
}

// NOTE: JobProperties is polymorphic on `jobType` so future variants
// (Action, State) can be added in a backward-compatible way. v1 ships
// the `Update` and `RecoveryUpdate` variants; additional discriminator
// values (Action, State) are reserved for v2 and intentionally not
// declared here.
//
// `target` is intentionally NOT on the base. Each variant declares its
// own target shape because targeting is variant-specific: `Update`
// targets an ADR group (`JobTarget`), while `RecoveryUpdate` has no
// target at all -- "all compatible devices" is inherent to the type and
// resolved at serve time from the device's presented compatibility
// properties.
//
// `scheduling` is likewise NOT on the base. Each variant declares its
// own scheduling enum inside `definition` because the set of valid
// scheduling types is variant-specific (e.g. Update is continuous-only;
// Action/State in v2 will allow on-demand and timed schedules).
@added(Versions.v2026_11_02_preview)
@doc("The job properties.")
@discriminator("jobType")
model JobProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("The type of the job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: JobTypeEnum;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_02_preview)
@doc("Job properties for an Update job.")
model UpdateJobProperties extends JobProperties {
  jobType: JobTypeEnum.Update;

  @doc("The target of the job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: JobTarget;

  @doc("The update definition for the job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: UpdateJobDefinition;
}

// NOTE: A recovery update job (Day0) targets all compatible devices --
// including devices not yet registered in ADR -- and is served
// exclusively via the Day0 recovery device endpoint. It has no `target`:
// eligibility is evaluated at serve time from the device's presented
// compatibility properties + agent profile, so the job needs no
// per-target binding. Creating a recovery job persists the definition
// only; device-class generation and deployment materialization happen
// later when the job is scheduled and runs.
@added(Versions.v2026_11_02_preview)
@doc("Job properties for a recovery update job (Day0).")
model RecoveryUpdateJobProperties extends JobProperties {
  jobType: JobTypeEnum.RecoveryUpdate;

  @doc("The update definition for the recovery job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: RecoveryUpdateJobDefinition;
}

// NOTE: `Update` and `RecoveryUpdate` are shipped in v1. `Action` and
// `State` are reserved values in the design and will be added as
// additional discriminator values (with corresponding subtypes) in v2.
@added(Versions.v2026_11_02_preview)
@doc("The type of the job.")
union JobTypeEnum {
  string,

  @doc("An update job. Targets a group of registered devices for ADU deployments.")
  Update: "Update",

  @doc("A recovery update job. Targets all compatible devices -- including devices not yet registered in ADR -- served exclusively via the Day0 recovery device endpoint.")
  RecoveryUpdate: "RecoveryUpdate",
}

@added(Versions.v2026_11_02_preview)
@doc("The target of a job.")
model JobTarget {
  @doc("The Azure resource ID of the target group. Must reference a Microsoft.DeviceRegistry/namespaces/groups resource.")
  targetResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/groups";
    }
  ]>;
}

@added(Versions.v2026_11_02_preview)
@doc("Update-job definition. Used when jobType is Update.")
model UpdateJobDefinition {
  @doc("The scheduling type for the Update job. Update jobs are always continuous: ADU deployments target the group until superseded, canceled, or the parent job is deleted.")
  schedulingType: UpdateJobSchedulingType;

  @doc("The update definition for the job.")
  update: JobUpdateDefinition;
}

@added(Versions.v2026_11_02_preview)
@doc("Scheduling types supported by an Update job. Only continuous is supported.")
union UpdateJobSchedulingType {
  string,

  @doc("The job runs continuously against the target group until superseded, canceled, or the parent job is deleted.")
  Continuous: "continuous",
}

@added(Versions.v2026_11_02_preview)
@doc("Recovery-update-job definition. Used when jobType is RecoveryUpdate.")
model RecoveryUpdateJobDefinition {
  @doc("The update definition for the job.")
  update: JobUpdateDefinition;
}

@added(Versions.v2026_11_02_preview)
@doc("The update definition for a job.")
model JobUpdateDefinition {
  @doc("The Azure Device Update (ADU) update identity to deploy.")
  updateId: JobUpdateId;
}

@added(Versions.v2026_11_02_preview)
@doc("Identifier of an Azure Device Update (ADU) update.")
model JobUpdateId {
  @doc("The provider of the update.")
  provider: string;

  @doc("The name of the update.")
  name: string;

  @doc("The version of the update.")
  version: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Request body for scheduling a job.")
model JobScheduleRequest {
  @doc("The time at which the job should be scheduled to run.")
  scheduledTime?: utcDateTime;

  @doc("The timeout duration for the job execution (ISO 8601 duration format).")
  timeout?: duration;
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface Jobs {
  get is ArmResourceRead<Job>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Job>;
  // PATCH is restricted to tags-only. Job spec properties (jobType, target,
  // definition) are immutable after create because mutating them would have
  // unintended effects on already-scheduled runs. Tags-only PATCH satisfies
  // the ARM tracked-resource requirement (RPC-Patch-V1-03).
  update is ArmTagsPatchSync<Job>;
  delete is ArmResourceDeleteWithoutOkAsync<Job>;
  listByNamespace is ArmResourceListByParent<Job>;

  @doc("Schedule the job for execution.")
  schedule is ArmResourceActionNoResponseContentAsync<Job, JobScheduleRequest>;
}
