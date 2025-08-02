import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server Advanced Threat Protection.
 */
@parentResource(Server)
model ServerAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  /**
   * The name of the Advanced Threat Protection state.
   */
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ServerAdvancedThreatProtections {
  /**
   * Get a server's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<ServerAdvancedThreatProtection>;

  /**
   * Creates or updates an Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerAdvancedThreatProtection>;

  /**
   * Get a list of the server's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerAdvancedThreatProtectionSettings_ListByServer")
  listByServer is ArmResourceListByParent<ServerAdvancedThreatProtection>;
}

@@projectedName(ServerAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The server Advanced Threat Protection state."
);
