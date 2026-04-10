import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job step.
 */
@parentResource(Job)
model JobStep is Azure.ResourceManager.ProxyResource<JobStepProperties> {
  ...ResourceNameParameter<
    Resource = JobStep,
    KeyName = "stepName",
    SegmentName = "steps",
    NamePattern = ""
  >;
}

alias JobStepOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;

    /** The name of the job agent. */
    @path
    @segment("jobAgents")
    @key
    jobAgentName: string;

    /** The name of the job. */
    @path
    @segment("jobs")
    @key
    jobName: string;
  },
  {
    /** The name of the job step. */
    @path
    @segment("steps")
    @key
    stepName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface JobSteps {
  /**
   * Gets a job step in a job's current version.
   */
  @tag("JobSteps")
  get is JobStepOps.Read<JobStep>;

  /**
   * Creates or updates a job step. This will implicitly create a new job version.
   */
  @tag("JobSteps")
  createOrUpdate is JobStepOps.CreateOrUpdateSync<JobStep>;

  /**
   * Deletes a job step. This will implicitly create a new job version.
   */
  @tag("JobSteps")
  delete is JobStepOps.DeleteSync<JobStep>;

  /**
   * Gets all job steps for a job's current version.
   */
  @tag("JobSteps")
  listByJob is JobStepOps.List<JobStep>;
}
alias JobStepOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;

    /** The name of the job agent. */
    @path
    @segment("jobAgents")
    @key
    jobAgentName: string;

    /** The name of the job. */
    @path
    @segment("jobs")
    @key
    jobName: string;

    /** The version of the job to get. */
    @path
    @segment("versions")
    @key
    jobVersion: int32;
  },
  {
    /** The name of the job step. */
    @path
    @segment("steps")
    @key
    stepName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface JobStepOperationGroup {
  /**
   * Gets the specified version of a job step.
   */
  @tag("JobSteps")
  getByVersion is JobStepOperationGroupOps.Read<JobStep>;

  /**
   * Gets all job steps in the specified job version.
   */
  @tag("JobSteps")
  listByVersion is JobStepOperationGroupOps.List<JobStep>;
}

@@doc(JobStep.name, "The name of the job step.");
@@doc(JobStep.properties, "Resource properties.");
@@doc(JobSteps.createOrUpdate::parameters.resource,
  "The requested state of the job step."
);
