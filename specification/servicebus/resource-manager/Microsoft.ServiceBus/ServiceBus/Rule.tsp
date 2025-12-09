import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
/**
 * Description of Rule Resource.
 */
@parentResource(SBSubscription)
model Rule is Azure.ResourceManager.ProxyResource<Ruleproperties> {
  ...ResourceNameParameter<
    Resource = Rule,
    KeyName = "ruleName",
    SegmentName = "rules",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Rules {
  /**
   * Retrieves the description for the specified rule.
   */
  get is ArmResourceRead<Rule, Error = ErrorResponse>;

  /**
   * Creates a new rule and updates an existing rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Rule,
    Response = ArmResourceUpdatedResponse<Rule>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing rule.
   */
  delete is ArmResourceDeleteSync<Rule, Error = ErrorResponse>;

  /**
   * List all the rules within given topic-subscription
   */
  listBySubscriptions is ArmResourceListByParent<
    Rule,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@maxLength(Rule.name, 50);
@@minLength(Rule.name, 1);
@@doc(Rule.name, "The rule name.");
@@doc(Rule.properties, "Properties of Rule resource");
@@doc(Rules.createOrUpdate::parameters.resource,
  "Parameters supplied to create a rule."
);
