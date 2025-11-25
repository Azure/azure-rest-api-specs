import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * FirewallPolicy Resource.
 */
model FirewallPolicy
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<FirewallPolicyPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = FirewallPolicy,
    KeyName = "firewallPolicyName",
    SegmentName = "firewallPolicies",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * The identity of the firewall policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface FirewallPolicies {
  /**
   * Gets the specified Firewall Policy.
   */
  get is ArmResourceRead<
    FirewallPolicy,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates the specified Firewall Policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallPolicy>;

  /**
   * Updates tags of a Azure Firewall Policy resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<FirewallPolicy, PatchModel = TagsObject>;

  /**
   * Deletes the specified Firewall Policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Firewall Policies in a resource group.
   */
  list is ArmResourceListByParent<FirewallPolicy>;

  /**
   * Gets all the Firewall Policies in a subscription.
   */
  listAll is ArmListBySubscription<FirewallPolicy>;

  /**
   * Retrieves the current status of IDPS signatures for the relevant policy. Maximal amount of returned signatures is 1000.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FirewallPolicyIdpsSignatures_List")
  @action("listIdpsSignatures")
  firewallPolicyIdpsSignaturesList is ArmResourceActionSync<
    FirewallPolicy,
    IdpsQueryObject,
    ArmResponse<QueryResults>
  >;

  /**
   * Retrieves the current filter values for the signatures overrides
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FirewallPolicyIdpsSignaturesFilterValues_List")
  @action("listIdpsFilterOptions")
  firewallPolicyIdpsSignaturesFilterValuesList is ArmResourceActionSync<
    FirewallPolicy,
    SignatureOverridesFilterValuesQuery,
    ArmResponse<SignatureOverridesFilterValuesResponse>
  >;

  /**
   * Deploys the firewall policy draft and child rule collection group drafts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FirewallPolicyDeployments_Deploy")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  deploy is ArmResourceActionAsyncBase<
    FirewallPolicy,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<FirewallPolicy>
  >;
}

@@doc(FirewallPolicy.name, "The name of the Firewall Policy.");
@@doc(FirewallPolicy.properties, "Properties of the firewall policy.");
@@doc(FirewallPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Firewall Policy operation."
);
@@doc(FirewallPolicies.updateTags::parameters.properties,
  "Parameters supplied to update Azure Firewall Policy tags."
);
@@doc(FirewallPolicies.firewallPolicyIdpsSignaturesList::parameters.body, "");
@@doc(FirewallPolicies.firewallPolicyIdpsSignaturesFilterValuesList::parameters.body,
  ""
);
