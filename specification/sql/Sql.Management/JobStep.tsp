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

@armResourceOperations
interface JobSteps {
  /**
   * Gets a job step in a job's current version.
   */
  get is JobStepOps.Read<JobStep>;

  /**
   * Creates or updates a job step. This will implicitly create a new job version.
   */
  createOrUpdate is JobStepOps.CreateOrUpdateSync<JobStep>;

  /**
   * Deletes a job step. This will implicitly create a new job version.
   */
  delete is JobStepOps.DeleteSync<JobStep>;

  /**
   * Gets all job steps for a job's current version.
   */
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
    jobVersion: string;
  },
  {
    /** The name of the job step. */
    @path
    @segment("steps")
    @key
    stepName: string;
  }
>;

@armResourceOperations
interface JobStepOperationGroup {
  /**
   * Gets the specified version of a job step.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobSteps_GetByVersion")
  getByVersion is JobStepOperationGroupOps.Read<JobStep>;

  /**
   * Gets all job steps in the specified job version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobSteps_ListByVersion")
  listByVersion is JobStepOperationGroupOps.List<JobStep>;
}

@@doc(JobStep.name, "The name of the job step.");
@@doc(JobStep.properties, "Resource properties.");
@@doc(JobSteps.createOrUpdate::parameters.resource,
  "The requested state of the job step."
);
