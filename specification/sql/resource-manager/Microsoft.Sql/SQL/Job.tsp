import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(JobAgent)
@Azure.ResourceManager.Legacy.feature(Features.Jobs)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Jobs {
  /**
   * Gets a job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Jobs")
  @Azure.ResourceManager.Legacy.feature(Features.Jobs)
  get is ArmResourceRead<Job>;

  /**
   * Creates or updates a job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Jobs")
  @Azure.ResourceManager.Legacy.feature(Features.Jobs)
  createOrUpdate is ArmResourceCreateOrReplaceSync<Job>;

  /**
   * Deletes a job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Jobs")
  @Azure.ResourceManager.Legacy.feature(Features.Jobs)
  delete is ArmResourceDeleteSync<Job>;

  /**
   * Gets a list of jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Jobs")
  @Azure.ResourceManager.Legacy.feature(Features.Jobs)
  listByAgent is ArmResourceListByParent<Job>;

  /**
   * Starts an elastic job execution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("JobExecutions")
  @action("start")
  @Azure.ResourceManager.Legacy.feature(Features.JobExecutions)
  create is ArmResourceActionAsync<Job, void, Response = JobExecution>;
}

@@doc(Job.name, "The name of the job to get.");
@@doc(Job.properties, "Resource properties.");
@@doc(Jobs.createOrUpdate::parameters.resource, "The requested job state.");
