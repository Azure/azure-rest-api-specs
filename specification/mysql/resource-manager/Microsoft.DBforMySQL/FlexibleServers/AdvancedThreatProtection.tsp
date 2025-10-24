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

namespace Microsoft.DBforMySQL;
/**
 * A server's Advanced Threat Protection.
 */
@parentResource(Server)
model AdvancedThreatProtection
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = AdvancedThreatProtection,
    KeyName = "advancedThreatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = AdvancedThreatProtectionName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AdvancedThreatProtectionSettings {
  /**
   * Get a server's Advanced Threat Protection state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<AdvancedThreatProtection>;

  /**
   * Updates a server's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AdvancedThreatProtectionSettings_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<
    AdvancedThreatProtection,
    Response = ArmResourceUpdatedResponse<AdvancedThreatProtection> | ArmResourceCreatedResponse<
      AdvancedThreatProtection,
      ArmLroLocationHeader<FinalResult = AdvancedThreatProtection> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a server's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("AdvancedThreatProtectionSettings_Update")
  update is ArmCustomPatchAsync<
    AdvancedThreatProtection,
    PatchModel = AdvancedThreatProtectionForUpdate
  >;

  /**
   * Gets a list of server's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AdvancedThreatProtectionSettings_List")
  list is ArmResourceListByParent<
    AdvancedThreatProtection,
    Response = ArmResponse<AdvancedThreatProtectionListResult>
  >;
}

@@doc(AdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(AdvancedThreatProtection.properties, "Resource properties.");
@@doc(AdvancedThreatProtectionSettings.updatePut::parameters.resource,
  "The server's Advanced Threat Protection body to update."
);
@@doc(AdvancedThreatProtectionSettings.update::parameters.properties,
  "The server's Advanced Threat Protection body to update."
);
