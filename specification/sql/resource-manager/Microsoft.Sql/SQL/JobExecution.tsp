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
 * An execution of a job
 */
@parentResource(Job)
model JobExecution
  is Azure.ResourceManager.ProxyResource<JobExecutionProperties> {
  ...ResourceNameParameter<
    Resource = JobExecution,
    KeyName = "jobExecutionId",
    SegmentName = "executions",
    NamePattern = ""
  >;
}

alias JobExecutionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    /** The id of the job execution */
    @path
    @segment("executions")
    @key
    jobExecutionId: Azure.Core.uuid;
  }
>;

@armResourceOperations
interface JobExecutions {
  /**
   * Gets a job execution.
   */
  get is JobExecutionOps.Read<JobExecution>;

  /**
   * Creates or updates a job execution.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is JobExecutionOps.CreateOrUpdateAsync<
    JobExecution,
    Request = void,
    Response = ArmResourceUpdatedResponse<JobExecution> | ArmResourceCreatedResponse<
      JobExecution,
      ArmLroLocationHeader<FinalResult = JobExecution> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Requests cancellation of a job execution.
   */
  cancel is JobExecutionOps.ActionSync<
    JobExecution,
    void,
    Response = OkResponse
  >;

  /**
   * Lists a job's executions.
   */
  listByJob is JobExecutionOps.List<
    JobExecution,
    Parameters = {
      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;
    }
  >;
}

alias JobStepExecutionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the job to get. */
    @path
    @segment("jobs")
    @key
    jobName: string;

    /** The unique id of the job execution */
    @path
    @segment("executions")
    @key
    jobExecutionId: Azure.Core.uuid;
  },
  {
    /** The name of the step. */
    @path
    @segment("steps")
    @key
    stepName: string;
  }
>;

@armResourceOperations
interface JobStepExecutions {
  /**
   * Gets a step execution of a job execution.
   */
  get is JobStepExecutionOps.Read<JobExecution>;

  /**
   * Lists the step executions of a job execution.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ListByJobExecution is JobStepExecutionOps.List<
    JobExecution,
    Parameters = {
      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;
    }
  >;
}

alias JobTargetExecutionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the job to get. */
    @path
    @segment("jobs")
    @key
    jobName: string;

    /** The unique id of the job execution */
    @path
    @segment("executions")
    @key
    jobExecutionId: Azure.Core.uuid;

    /** The name of the step. */
    @path
    @segment("steps")
    @key
    stepName: string;
  },
  {
    /** The target id. */
    @path
    @segment("targets")
    @key
    targetId: Azure.Core.uuid;
  }
>;

@armResourceOperations
interface JobTargetExecutions {
  /**
   * Gets a target execution.
   */
  get is JobTargetExecutionOps.Read<JobExecution>;

  /**
   * Lists the target executions of a job step execution.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ListByStep is JobTargetExecutionOps.List<
    JobExecution,
    Parameters = {
      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;
    }
  >;

  /**
   * Lists target executions for all steps of a job execution.
   */
  @list
  @get
  @action("targets")
  listByJobExecution is JobExecutionOps.ActionSync<
    JobExecution,
    void,
    ArmResponse<ResourceListResult<JobExecution>>,
    Parameters = {
      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(JobExecution.name, "uuid");
@@doc(JobExecution.name, "The id of the job execution");
@@doc(JobExecution.properties, "Resource properties.");
