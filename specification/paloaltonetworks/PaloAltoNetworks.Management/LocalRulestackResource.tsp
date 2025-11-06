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
 * PaloAltoNetworks LocalRulestack
 */
model LocalRulestackResource
  is Azure.ResourceManager.TrackedResource<RulestackProperties, false> {
  ...ResourceNameParameter<
    Resource = LocalRulestackResource,
    KeyName = "localRulestackName",
    SegmentName = "localRulestacks",
    NamePattern = ""
  >;

  /**
   * The managed service identities assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: AzureResourceManagerManagedIdentityProperties;
}

@armResourceOperations
interface LocalRulestackResources {
  /**
   * Get a LocalRulestackResource
   */
  get is ArmResourceRead<LocalRulestackResource>;

  /**
   * Create a LocalRulestackResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LocalRulestackResource>;

  /**
   * Update a LocalRulestackResource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    LocalRulestackResource,
    PatchModel = LocalRulestackResourceUpdate
  >;

  /**
   * Delete a LocalRulestackResource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    LocalRulestackResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmNoContentResponse
  >;

  /**
   * List LocalRulestackResource resources by resource group
   */
  listByResourceGroup is ArmResourceListByParent<LocalRulestackResource>;

  /**
   * List LocalRulestackResource resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<LocalRulestackResource>;

  /**
   * Commit rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_commit")
  commit is ArmResourceActionAsyncBase<
    LocalRulestackResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<LocalRulestackResource>
  >;

  /**
   * Get changelog
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_getChangeLog")
  getChangeLog is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<Changelog>
  >;

  /**
   * support info for rulestack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    LocalRulestackResource,
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
   * Get the list of advanced security objects
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listAdvancedSecurityObjects")
  listAdvancedSecurityObjects is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<AdvSecurityObjectListResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("top")
      top?: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("type")
      type: AdvSecurityObjectTypeEnum;
    }
  >;

  /**
   * List of AppIds for LocalRulestack ApiVersion
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listAppIds")
  @TypeSpec.list
  listAppIds is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<ListAppIdResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("appIdVersion")
      appIdVersion?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("appPrefix")
      appPrefix?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of countries for Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listCountries")
  @list
  listCountries is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<CountriesResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List of Firewalls associated with Rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listFirewalls")
  listFirewalls is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<ListFirewallsResponse>
  >;

  /**
   * List predefined URL categories for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listPredefinedUrlCategories")
  @list
  listPredefinedUrlCategories is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<PredefinedUrlCategoriesResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("top")
      top?: int32;
    }
  >;

  /**
   * List the security services for rulestack
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_listSecurityServices")
  listSecurityServices is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    ArmResponse<SecurityServicesResponse>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("skip")
      skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("top")
      top?: int32;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("type")
      type: SecurityServicesTypeEnum;
    }
  >;

  /**
   * Revert rulestack configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LocalRulestacks_revert")
  revert is ArmResourceActionSync<
    LocalRulestackResource,
    void,
    NoContentResponse
  >;
}

@@doc(LocalRulestackResource.name, "LocalRulestack resource name");
@@doc(LocalRulestackResource.properties,
  "The resource-specific properties for this resource."
);
