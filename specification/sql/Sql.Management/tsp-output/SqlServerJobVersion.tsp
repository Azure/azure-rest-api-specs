import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
// FIXME: SqlServerJobVersion has no properties property
@doc("A job version.")
@parentResource(SqlServerJob)
model SqlServerJobVersion is ProxyResource<{}> {
  @doc("The version of the job to get.")
  @path
  @key("jobVersion")
  @segment("versions")
  name: int32;
}

@armResourceOperations
interface SqlServerJobVersions {
  @doc("Gets a job version.")
  get is ArmResourceRead<SqlServerJobVersion>;
  @doc("Gets all versions of a job.")
  listByJob is ArmResourceListByParent<SqlServerJobVersion>;
}
