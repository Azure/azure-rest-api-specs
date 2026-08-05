import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "../common/common.tsp";

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
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

// NOTE: JobProperties is polymorphic on `jobType` so future variants
// (Action, State) can be added in a backward-compatible way. v1 ships
// the `SoftwareUpdate` and `OnboardingUpdate` variants; additional discriminator
// values (Action, State) are reserved for v2 and intentionally not
// declared here.
//
// `target` is intentionally NOT on the base. Each variant declares its
// own target shape because targeting is variant-specific: `SoftwareUpdate`
// targets an ADR group (`JobTarget`), while `OnboardingUpdate` has no
// target at all -- "all compatible devices" is inherent to the type and
// resolved at serve time from the device's presented compatibility
// properties.
//
// `scheduling` is likewise NOT on the base. Each variant declares its
// own scheduling enum inside `definition` because the set of valid
// scheduling types is variant-specific (e.g. SoftwareUpdate is continuous-only;
// Action/State in v2 will allow on-demand and timed schedules).
@added(Versions.v2026_11_02_preview)
@doc("The job properties.")
@discriminator("jobType")
model JobProperties {
  ...DisplayProperties;

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
@doc("Job properties for a software update job.")
model SoftwareUpdateJobProperties extends JobProperties {
  jobType: JobTypeEnum.SoftwareUpdate;

  @doc("The target of the job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: JobTarget;

  @doc("The update definition for the job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: SoftwareUpdateJobDefinition;
}

// NOTE: An onboarding update job targets all compatible devices --
// including devices not yet registered in ADR -- and is served
// exclusively via the onboarding device endpoint. It has no `target`:
// eligibility is evaluated at serve time from the device's presented
// compatibility properties + agent profile, so the job needs no
// per-target binding.
@added(Versions.v2026_11_02_preview)
@doc("Job properties for an onboarding update job.")
model OnboardingUpdateJobProperties extends JobProperties {
  jobType: JobTypeEnum.OnboardingUpdate;

  @doc("The update definition for the onboarding job. Set at create time; immutable thereafter.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: OnboardingUpdateJobDefinition;
}

// NOTE: `SoftwareUpdate` and `OnboardingUpdate` are shipped in v1. `Action` and
// `State` are reserved values in the design and will be added as
// additional discriminator values (with corresponding subtypes) in v2.
@added(Versions.v2026_11_02_preview)
@doc("The type of the job.")
union JobTypeEnum {
  string,

  @doc("A software update job. Targets a group of registered devices for ADU deployments.")
  SoftwareUpdate: "SoftwareUpdate",

  @doc("An onboarding update job. Targets all compatible devices for ADU deployments -- including devices not yet registered in ADR -- served exclusively via the ADU onboarding device endpoint.")
  OnboardingUpdate: "OnboardingUpdate",
}

@added(Versions.v2026_11_02_preview)
@doc("The target of a job.")
model JobTarget {
  @doc("The Azure resource ID of the target group. Must reference a Microsoft.DeviceRegistry/namespaces/groups resource.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/groups";
    }
  ]>;
}

@added(Versions.v2026_11_02_preview)
@doc("Software-update-job definition. Used when jobType is SoftwareUpdate.")
model SoftwareUpdateJobDefinition {
  @doc("The scheduling type for the SoftwareUpdate job. SoftwareUpdate jobs are always continuous: ADU deployments target the group until superseded, canceled, or the parent job is deleted.")
  schedulingType: SoftwareUpdateJobSchedulingType;

  @doc("The update resource URI for the job.")
  updateResourceId: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Scheduling types supported by a SoftwareUpdate job. Only continuous is supported.")
union SoftwareUpdateJobSchedulingType {
  string,

  @doc("The job runs continuously against the target group until superseded, canceled, or the parent job is deleted.")
  Continuous: "Continuous",
}

@added(Versions.v2026_11_02_preview)
@doc("Onboarding-update-job definition. Used when jobType is OnboardingUpdate.")
model OnboardingUpdateJobDefinition {
  @doc("The scheduling type for the OnboardingUpdate job. OnboardingUpdate jobs are always continuous: ADU deployments target all compatible devices until superseded, canceled, or the parent job is deleted.")
  schedulingType: OnboardingUpdateJobSchedulingType;

  @doc("The update resource URI for the job.")
  updateResourceId: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Scheduling types supported by an OnboardingUpdate job. Only continuous is supported.")
union OnboardingUpdateJobSchedulingType {
  string,

  @doc("The job runs continuously against all compatible devices until superseded, canceled, or the parent job is deleted.")
  Continuous: "Continuous",
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface Jobs {
  get is ArmResourceRead<Job>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Job>;
  // PATCH is restricted to tags-only. Job spec properties (jobType and
  // definition) are immutable after create because mutating them would
  // have unintended effects on already-scheduled runs.
  // Tags-only PATCH satisfies the ARM tracked-resource requirement
  // (RPC-Patch-V1-03).
  update is ArmTagsPatchSync<Job>;
  delete is ArmResourceDeleteWithoutOkAsync<Job>;
  listByNamespace is ArmResourceListByParent<Job>;
}
