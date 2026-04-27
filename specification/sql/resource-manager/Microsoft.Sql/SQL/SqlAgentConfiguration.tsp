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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface SqlAgentConfigurations {
  /**
   * Gets current instance sql agent configuration.
   */
  @tag("SqlAgent")
  get is ArmResourceRead<SqlAgentConfiguration>;

  /**
   * Puts new sql agent configuration to instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("SqlAgent")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SqlAgentConfiguration,
    Response = ArmResourceUpdatedResponse<SqlAgentConfiguration>
  >;
}

@@doc(SqlAgentConfiguration.name, "");
@@doc(SqlAgentConfiguration.properties, "Resource properties.");
@@doc(SqlAgentConfigurations.createOrUpdate::parameters.resource, "");
