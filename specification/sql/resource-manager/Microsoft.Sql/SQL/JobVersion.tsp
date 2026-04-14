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
// FIXME: JobVersion has no properties property
/**
 * A job version.
 */
@parentResource(Job)
model JobVersion is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = JobVersion,
    KeyName = "jobVersion",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias JobVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    /** The version of the job to get. */
    @path
    @segment("versions")
    @key
    jobVersion: int32;
  }
>;

@armResourceOperations
interface JobVersions {
  /**
   * Gets a job version.
   */
  get is JobVersionOps.Read<JobVersion>;

  /**
   * Gets all versions of a job.
   */
  listByJob is ArmResourceListByParent<JobVersion>;
}

@@doc(JobVersion.name, "The version of the job to get.");
