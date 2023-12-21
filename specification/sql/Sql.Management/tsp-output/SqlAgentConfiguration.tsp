import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A recoverable managed database resource.")
@singleton("current")
@parentResource(ManagedInstance)
model SqlAgentConfiguration is ProxyResource<SqlAgentConfigurationProperties> {
  @key("current")
  @segment("sqlAgent")
  name: string;
}

@armResourceOperations
interface SqlAgent {
  @doc("Gets current instance sql agent configuration.")
  get is ArmResourceRead<SqlAgentConfiguration>;
  @doc("Puts new sql agent configuration to instance.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlAgentConfiguration>;
}
