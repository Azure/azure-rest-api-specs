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
@parentResource(NspProfile)
model NspAccessRule
  is Azure.ResourceManager.ProxyResource<NspAccessRuleProperties> {
  ...ResourceNameParameter<
    Resource = NspAccessRule,
    KeyName = "accessRuleName",
    SegmentName = "accessRules",
    NamePattern = "(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface NspAccessRules {
  /**
   * Gets the specified NSP access rule by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAccessRules_Get")
  get is ArmResourceRead<NspAccessRule>;

  /**
   * Creates or updates a network access rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAccessRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NspAccessRule>;

  /**
   * Deletes an NSP access rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAccessRules_Delete")
  delete is ArmResourceDeleteSync<NspAccessRule>;

  /**
   * Lists the NSP access rules in the specified NSP profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Reconcile NSP access rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAccessRules_Reconcile")
  reconcile is ArmResourceActionSync<
    NspAccessRule,
    unknown,
    ArmResponse<AnyObject>
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
