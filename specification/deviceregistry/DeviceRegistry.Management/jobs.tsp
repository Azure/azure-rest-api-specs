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

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2026_11_02_preview)
@doc("The job properties.")
model JobProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("The scheduling configuration for the job.")
  scheduling?: JobSchedule;

  @doc("The type of the job.")
  jobType?: JobTypeEnum;

  @doc("The target of the job.")
  target?: JobTarget;

  @doc("The definition of the job.")
  definition?: JobDefinition;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_02_preview)
@doc("The scheduling configuration for a job.")
model JobSchedule {
  @doc("The type of scheduling.")
  schedulingType?: JobSchedulingType;
}

@added(Versions.v2026_11_02_preview)
@doc("The type of job scheduling.")
union JobSchedulingType {
  string,

  @doc("The job runs on demand.")
  OnDemand: "ondemand",
}

@added(Versions.v2026_11_02_preview)
@doc("The type of the job.")
union JobTypeEnum {
  string,

  @doc("An action job.")
  Action: "Action",

  @doc("A state job.")
  State: "State",
}

@added(Versions.v2026_11_02_preview)
@doc("The target of a job.")
model JobTarget {
  @doc("The Azure resource ID of the target resource.")
  targetResourceId?: Azure.Core.armResourceIdentifier;
}

@added(Versions.v2026_11_02_preview)
@doc("The definition of a job.")
model JobDefinition {
  @doc("The action definition for the job. Used when jobType is Action.")
  action?: JobActionDefinition;

  @doc("The state definition for the job. Used when jobType is State.")
  state?: JobStateDefinition;
}

@added(Versions.v2026_11_02_preview)
@doc("The action definition for a job.")
model JobActionDefinition {
  @doc("The name of the action to perform.")
  actionName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("The payload for the action.")
  payload?: Record<string>;

  @doc("The response timeout for the action.")
  responseTimeout?: string;

  @doc("The connect timeout for the action.")
  connectTimeout?: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The state definition for a job.")
model JobStateDefinition {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("The tags for the state.")
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("The desired state.")
  state?: Record<string>;
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
  update is ArmResourcePatchAsync<Job, JobProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Job>;
  listByResourceGroup is ArmResourceListByParent<Job>;

  @doc("Schedule the job for execution.")
  schedule is ArmResourceActionNoResponseContentAsync<Job, JobScheduleRequest>;
}
