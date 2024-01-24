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
/**
 * A recoverable managed database resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("current")
@parentResource(ManagedInstance)
@Azure.ResourceManager.Private.armResourceInternal(
  SqlAgentConfigurationProperties
)
@includeInapplicableMetadataInPayload(false)
model SqlAgentConfiguration extends ProxyResource {
  @key("sqlAgent")
  @segment("sqlAgent")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SqlAgentConfigurationProperties;
}

@armResourceOperations
interface SqlAgentConfigurations {
  /**
   * Gets current instance sql agent configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlAgent_Get")
  get is ArmResourceRead<SqlAgentConfiguration>;

  /**
   * Puts new sql agent configuration to instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
