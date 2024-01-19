import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A recoverable managed database resource.")
@singleton("current")
@parentResource(ManagedInstance)
model SqlAgentConfiguration is ProxyResource<SqlAgentConfigurationProperties> {
  @key("sqlAgent")
  @segment("sqlAgent")
  name: string;
}

@armResourceOperations
interface SqlAgentConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets current instance sql agent configuration.")
  @operationId("SqlAgent_Get")
  get is ArmResourceRead<SqlAgentConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts new sql agent configuration to instance.")
  @operationId("SqlAgent_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlAgentConfiguration>;
}

@@projectedName(SqlAgentConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SqlAgentConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SqlAgentConfigurations.createOrUpdate::parameters.resource, "");
