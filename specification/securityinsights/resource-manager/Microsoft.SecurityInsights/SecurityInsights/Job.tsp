import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkspaceManagerAssignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * The assignment job
 */
@parentResource(WorkspaceManagerAssignment)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets a job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagerAssignmentJobs_Get")
  get is Extension.Read<workspaceExternalResource, Job>;

  /**
   * Deletes the specified job from the specified workspace manager assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagerAssignmentJobs_Delete")
  delete is Extension.DeleteSync<workspaceExternalResource, Job>;

  /**
   * Get all jobs for the specified workspace manager assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagerAssignmentJobs_List")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    Job,
    Parameters = {
      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<JobList>
  >;
}

@@doc(Job.name, "The job name");
@@doc(Job.properties, "The job object");
