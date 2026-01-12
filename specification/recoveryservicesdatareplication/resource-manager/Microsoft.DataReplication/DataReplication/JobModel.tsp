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
      @query("odataOptions")
      odataOptions?: string;

      /**
       * Continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Page size.
       */
      @query("pageSize")
      pageSize?: int32;
    }
  >;
}

@@doc(JobModel.name, "The job name.");
