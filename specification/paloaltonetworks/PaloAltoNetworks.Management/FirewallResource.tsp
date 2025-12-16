import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * PaloAltoNetworks Firewall
 */
model FirewallResource
  is Azure.ResourceManager.TrackedResource<
    FirewallDeploymentProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = FirewallResource,
    KeyName = "firewallName",
    SegmentName = "firewalls",
    NamePattern = "^(?![-_])(?!.*[-_]{2})(?!.*[-_]$)[a-zA-Z0-9][a-zA-Z0-9-]{0,127}$"
  >;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: AzureResourceManagerManagedIdentityProperties;
}

@armResourceOperations
interface FirewallResources {
  /**
   * Get a FirewallResource
   */
  get is ArmResourceRead<FirewallResource>;

  /**
   * Create a FirewallResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallResource>;

  /**
   * Update a FirewallResource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    FirewallResource,
    PatchModel = FirewallResourceUpdate
  >;

  /**
   * Delete a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List FirewallResource resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<FirewallResource>;

  /**
   * List FirewallResource resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<FirewallResource>;

  /**
   * Get Global Rulestack associated with the Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Firewalls_getGlobalRulestack")
  getGlobalRulestack is ArmResourceActionSync<
    FirewallResource,
    void,
    ArmResponse<GlobalRulestackInfo>
  >;

  /**
   * Log Profile for Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Firewalls_getLogProfile")
  getLogProfile is ArmResourceActionSync<
    FirewallResource,
    void,
    ArmResponse<LogSettings>
  >;

  /**
   * support info for firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Firewalls_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    FirewallResource,
    void,
    ArmResponse<SupportInfo>,
    Parameters = {
      /**
       * email address on behalf of which this API called
       */
      @query("email")
      email?: string;
    }
  >;

  /**
   * Log Profile for Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Firewalls_saveLogProfile")
  saveLogProfile is ArmResourceActionSync<
    FirewallResource,
    LogSettings,
    NoContentResponse,
    OptionalRequestBody = true
  >;
}

@@doc(FirewallResource.name, "Firewall resource name");
@@doc(FirewallResource.properties,
  "The resource-specific properties for this resource."
);
@@doc(FirewallResources.saveLogProfile::parameters.body, "");
