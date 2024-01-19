import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: JobVersion has no properties property
@doc("A job version.")
@parentResource(Job)
model JobVersion is ProxyResource<{}> {
  @doc("The version of the job to get.")
  @path
  @key("jobVersion")
  @segment("versions")
  name: int32;
}

@armResourceOperations
interface JobVersions {
  @doc("Gets a job version.")
  get is ArmResourceRead<JobVersion>;

  @doc("Gets all versions of a job.")
  listByJob is ArmResourceListByParent<JobVersion>;
}
