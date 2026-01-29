import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NspProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The NSP access rule resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NspProfile)
model NspAccessRule extends CommonProxyResource {
  /**
   * Properties of the NSP access rule.
   */
  properties?: NspAccessRuleProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("accessRuleName")
  @segment("accessRules")
  @pattern("(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)")
  name: string;
}

@@doc(NspAccessRule.name, "The name of the resource");

@armResourceOperations
interface NspAccessRules {
  /**
   * Gets the specified NSP access rule by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAccessRules_Get")
  get is ArmResourceRead<NspAccessRule, Error = CloudError>;

  /**
   * Creates or updates a network access rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAccessRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NspAccessRule,
    Error = CloudError
  >;

  /**
   * Deletes an NSP access rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAccessRules_Delete")
  delete is ArmResourceDeleteSync<NspAccessRule, Error = CloudError>;

  /**
   * Lists the NSP access rules in the specified NSP profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAccessRules_List")
  list is ArmResourceListByParent<
    NspAccessRule,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = CloudError
  >;

  /**
   * Reconcile NSP access rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAccessRules_Reconcile")
  reconcile is ArmResourceActionSync<
    NspAccessRule,
    unknown,
    ArmResponse<unknown>,
    Error = CloudError
  >;
}

@@maxLength(NspAccessRule.name, 80);
@@doc(NspAccessRule.name, "The name of the NSP access rule.");
@@doc(NspAccessRule.properties, "Properties of the NSP access rule.");
@@doc(NspAccessRules.createOrUpdate::parameters.resource,
  "Parameters that hold the NspAccessRule resource to be created/updated."
);
@@doc(NspAccessRules.reconcile::parameters.body,
  "Parameters for NSP access rule reconcile"
);
