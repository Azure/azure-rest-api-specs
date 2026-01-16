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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model FirewallPolicy extends Resource {
  properties?: FirewallPolicyPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("firewallPolicyName")
  @segment("firewallPolicies")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The identity of the firewall policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    },
    Error = CloudError
  >;

  /**
   * Creates or updates the specified Firewall Policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallPolicy,
    Error = CloudError
  >;

  /**
   * Updates tags of a Azure Firewall Policy resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    FirewallPolicy,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified Firewall Policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Firewall Policies in a resource group.
   */
  list is ArmResourceListByParent<FirewallPolicy, Error = CloudError>;

  /**
   * Gets all the Firewall Policies in a subscription.
   */
  listAll is ArmListBySubscription<FirewallPolicy, Error = CloudError>;

  /**
   * Retrieves the current status of IDPS signatures for the relevant policy. Maximal amount of returned signatures is 1000.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("FirewallPolicyIdpsSignatures_List")
  @action("listIdpsSignatures")
  firewallPolicyIdpsSignaturesList is ArmResourceActionSync<
    FirewallPolicy,
    IdpsQueryObject,
    ArmResponse<QueryResults>,
    Error = CloudError
  >;

  /**
   * Retrieves the current filter values for the signatures overrides
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("FirewallPolicyIdpsSignaturesFilterValues_List")
  @action("listIdpsFilterOptions")
  firewallPolicyIdpsSignaturesFilterValuesList is ArmResourceActionSync<
    FirewallPolicy,
    SignatureOverridesFilterValuesQuery,
    ArmResponse<SignatureOverridesFilterValuesResponse>,
    Error = CloudError
  >;

  /**
   * Deploys the firewall policy draft and child rule collection group drafts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("FirewallPolicyDeployments_Deploy")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  deploy is ArmResourceActionAsyncBase<
    FirewallPolicy,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<FirewallPolicy>,
    Error = CloudError
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
