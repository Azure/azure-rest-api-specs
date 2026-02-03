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

namespace Microsoft.App;
/**
 * Container Apps Job execution.
 */
@parentResource(Job)
model JobExecution
  is Azure.ResourceManager.ProxyResource<JobExecutionProperties> {
  ...ResourceNameParameter<
    Resource = JobExecution,
    KeyName = "jobExecutionName",
    SegmentName = "executions",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface JobExecutions {}

@@doc(JobExecution.name, "Job execution name.");
@@doc(JobExecution.properties,
  "Container Apps Job execution specific properties."
);
