import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RoutingRuleCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Network routing rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@parentResource(RoutingRuleCollection)
@Http.Private.includeInapplicableMetadataInPayload(false)
model RoutingRule extends ChildResource {
  properties?: RoutingRulePropertiesFormat;

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
interface RoutingRules {
  /**
   * Gets a network manager routing configuration routing rule.
   */
  get is ArmResourceRead<RoutingRule, Error = CloudError>;

  /**
   * Creates or updates an routing rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    RoutingRule,
    Error = CloudError
  >;

  /**
   * Deletes a routing rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RoutingRule,
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
   * List all network manager routing configuration routing rules.
   */
  list is ArmResourceListByParent<
    RoutingRule,
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

@@doc(RoutingRule.name, "The name of the rule.");
@@doc(RoutingRule.properties, "Indicates the properties of the routing rule");
@@doc(RoutingRules.createOrUpdate::parameters.resource,
  "The routing rule to create or update"
);
