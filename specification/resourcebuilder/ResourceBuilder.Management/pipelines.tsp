import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Pipeline resource */
@parentResource(Workspace)
model Pipeline is ProxyResource<PipelineProperties> {
  /** The name of the pipeline. */
  @segment("pipelines")
  @key("pipelineName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;

  /**
   * Gets or sets tags of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppressing error expected"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress expected ARM error"
  tags?: Record<string>;
}

/** Pipeline properties */
model PipelineProperties {
  /** Provisioning state of the pipeline. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** Pipeline state. */
  state: PipelineState;

  /** Pipeline activities. */
  activities?: PipelineActivity[];

  /** Pipeline recurrence schedule. */
  recurrence?: PipelineRecurrence;
}

/** Pipeline state */
union PipelineState {
  /** Enabled state. */
  Enabled: "Enabled",

  /** Disabled state. */
  Disabled: "Disabled",

  string,
}

/** Pipeline activity */
model PipelineActivity {
  /** Activity name. */
  name: string;

  /** Job associated with the activity. */
  job: PipelineJobBase;

  /** Activities this activity depends on. */
  @identifiers(#["activity"])
  dependsOn?: PipelineActivityDependency[];

  /** Activity policy. */
  policy?: PipelineActivityPolicy;
}

/** Pipeline job base */
@discriminator("type")
model PipelineJobBase {
  /** Job type discriminator */
  type: PipelineJobType;
}

/** Pipeline job type */
union PipelineJobType {
  /** Reference job type. */
  Reference: "Reference",

  /** Inline job type. */
  Inline: "Inline",

  string,
}

/** Inline pipeline job */
model InlinePipelineJob extends PipelineJobBase {
  /** Job type. */
  type: "Inline";

  /** Job definition. */
  definition: Job;
}

/** Reference pipeline job */
model ReferencePipelineJob extends PipelineJobBase {
  /** Job type. */
  type: "Reference";

  /** Job name reference. */
  name: string;
}

/** Pipeline activity dependency */
model PipelineActivityDependency {
  /** Name of the activity this depends on. */
  activity: string;

  /** Dependency conditions. */
  dependencyConditions?: PipelineDependencyCondition[];
}

/** Pipeline dependency condition */
union PipelineDependencyCondition {
  /** Succeeded condition. */
  Succeeded: "Succeeded",

  string,
}

/** Pipeline activity policy */
model PipelineActivityPolicy {
  /** Timeout for the activity. */
  timeout?: string;
}

/** Pipeline recurrence */
model PipelineRecurrence {
  /** Recurrence type. */
  type: ScheduleType;

  /** Periodicity of the recurrence. */
  periodicity?: string;

  /** Timeout for the recurrence. */
  timeout?: string;
}

/** Schedule type */
union ScheduleType {
  /** Periodic schedule type. */
  Periodic: "Periodic",

  /** Manual trigger schedule type. */
  ManualTrigger: "ManualTrigger",

  string,
}

@armResourceOperations
interface Pipelines {
  get is ArmResourceRead<Pipeline>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Pipeline>;
  delete is ArmResourceDeleteSync<Pipeline>;
  list is ArmResourceListByParent<Pipeline>;
}
