import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server Advanced Threat Protection.
 */
@parentResource(Server)
model ServerAdvancedThreatProtection
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = ServerAdvancedThreatProtection,
    KeyName = "advancedThreatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = AdvancedThreatProtectionName
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ServerAdvancedThreatProtections {
  /**
   * Get a server's Advanced Threat Protection state.
   */
  @tag("ServerAdvancedThreatProtectionSettings")
  get is ArmResourceRead<ServerAdvancedThreatProtection>;

  /**
   * Creates or updates an Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @tag("ServerAdvancedThreatProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerAdvancedThreatProtection,
    Response = ArmResourceUpdatedResponse<ServerAdvancedThreatProtection> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerAdvancedThreatProtection> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Get a list of the server's Advanced Threat Protection states.
   */
  @tag("ServerAdvancedThreatProtectionSettings")
  listByServer is ArmResourceListByParent<
    ServerAdvancedThreatProtection,
    Response = LogicalServerAdvancedThreatProtectionListResult
  >;
}

@@doc(ServerAdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(ServerAdvancedThreatProtection.properties, "Resource properties.");
@@doc(ServerAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The server Advanced Threat Protection state."
);
