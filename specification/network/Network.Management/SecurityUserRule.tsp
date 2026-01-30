import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityUserRuleCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Network security user rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@parentResource(SecurityUserRuleCollection)
@Http.Private.includeInapplicableMetadataInPayload(false)
model SecurityUserRule extends ChildResource {
  properties?: SecurityUserRulePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ruleName")
  @segment("rules")
  @pattern("^[a-zA-Z0-9_.-]*$")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

@armResourceOperations
interface SecurityUserRules {
  /**
   * Gets a security user rule.
   */
  get is ArmResourceRead<SecurityUserRule, Error = CloudError>;

  /**
   * Creates or updates a security user rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SecurityUserRule,
    Error = CloudError
  >;

  /**
   * Deletes a security user rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SecurityUserRule,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Security User Rules in a rule collection.
   */
  list is ArmResourceListByParent<
    SecurityUserRule,
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
}

@@doc(SecurityUserRule.name, "The name of the rule.");
@@doc(SecurityUserRule.properties,
  "Indicates the properties of the security user rule"
);
@@doc(SecurityUserRules.createOrUpdate::parameters.resource,
  "The security user rule to create or update"
);
