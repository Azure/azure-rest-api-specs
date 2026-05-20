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
 * A managed instance Advanced Threat Protection.
 */
@parentResource(ManagedInstance)
model ManagedInstanceAdvancedThreatProtection
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceAdvancedThreatProtection,
    KeyName = "advancedThreatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = AdvancedThreatProtectionName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ManagedInstanceAdvancedThreatProtections {
  /**
   * Get a managed instance's Advanced Threat Protection state.
   */
  @tag("ManagedInstanceAdvancedThreatProtectionSettings")
  get is ArmResourceRead<ManagedInstanceAdvancedThreatProtection>;

  /**
   * Creates or updates Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedInstanceAdvancedThreatProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceAdvancedThreatProtection,
    Response = ArmResourceUpdatedResponse<ManagedInstanceAdvancedThreatProtection> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceAdvancedThreatProtection> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Get the managed instance's Advanced Threat Protection settings.
   */
  @tag("ManagedInstanceAdvancedThreatProtectionSettings")
  listByInstance is ArmResourceListByParent<ManagedInstanceAdvancedThreatProtection>;
}

@@doc(ManagedInstanceAdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(ManagedInstanceAdvancedThreatProtection.properties,
  "Resource properties."
);
@@doc(ManagedInstanceAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The managed instance Advanced Threat Protection state."
);
