import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Job model.
 */
@parentResource(VaultModel)
model JobModel is Azure.ResourceManager.ProxyResource<JobModelProperties> {
  ...ResourceNameParameter<
    Resource = JobModel,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@armResourceOperations
interface Job {
  /**
   * Gets the details of the job.
   */
  get is ArmResourceRead<JobModel>;

  /**
   * Gets the list of jobs in the given vault.
   */
  list is ArmResourceListByParent<
    JobModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<JobModel>;

      /**
       * OData options.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing list.odataOptions retains the odataOptions query parameter; preserve wire compatibility."
      @query("odataOptions")
      odataOptions?: string;

      /**
       * Continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing list.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Page size.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing list.pageSize retains the pageSize query parameter; preserve wire compatibility."
      @query("pageSize")
      pageSize?: int32;
    }
  >;
}

@@doc(JobModel.name, "The job name.");
