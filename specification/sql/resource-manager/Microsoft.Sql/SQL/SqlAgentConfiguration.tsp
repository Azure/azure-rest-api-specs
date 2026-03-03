import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A recoverable managed database resource.
 */
@singleton("current")
@parentResource(ManagedInstance)
model SqlAgentConfiguration
  is Azure.ResourceManager.ProxyResource<SqlAgentConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = SqlAgentConfiguration,
    KeyName = "sqlAgent",
    SegmentName = "sqlAgent",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlAgentConfigurations {
  /**
   * Gets current instance sql agent configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlAgent_Get")
  get is ArmResourceRead<SqlAgentConfiguration>;

  /**
   * Puts new sql agent configuration to instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlAgent_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SqlAgentConfiguration,
    Response = ArmResourceUpdatedResponse<SqlAgentConfiguration>
  >;
}

@@doc(SqlAgentConfiguration.name, "");
@@doc(SqlAgentConfiguration.properties, "Resource properties.");
@@doc(SqlAgentConfigurations.createOrUpdate::parameters.resource, "");
