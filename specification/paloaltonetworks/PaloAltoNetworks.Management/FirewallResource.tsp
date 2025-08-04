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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: AzureResourceManagerManagedIdentityProperties;
}

@armResourceOperations
interface FirewallResources {
  /**
   * Get a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_Get")
  get is ArmResourceRead<FirewallResource>;

  /**
   * Create a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallResource>;

  /**
   * Update a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    FirewallResource,
    PatchModel = FirewallResourceUpdate
  >;

  /**
   * Delete a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Firewalls_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List FirewallResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FirewallResource>;

  /**
   * List FirewallResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_ListBySubscription")
  listBySubscription is ArmListBySubscription<FirewallResource>;

  /**
   * Get Global Rulestack associated with the Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_getGlobalRulestack")
  getGlobalRulestack is ArmResourceActionSync<
    FirewallResource,
    void,
    ArmResponse<GlobalRulestackInfo>
  >;

  /**
   * Log Profile for Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Firewalls_getLogProfile")
  getLogProfile is ArmResourceActionSync<
    FirewallResource,
    void,
    ArmResponse<LogSettings>
  >;

  /**
   * support info for firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
