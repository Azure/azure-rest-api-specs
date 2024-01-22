import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NewRelicMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace NewRelic.Observability;
/**
 * A tag rule belonging to NewRelic account
 */
@parentResource(NewRelicMonitorResource)
model TagRule is ProxyResource<MonitoringTagRulesProperties> {
  /**
   * Name of the TagRule
   */
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;
}

@armResourceOperations
interface TagRules {
  /**
   * Get a TagRule
   */
  get is ArmResourceRead<TagRule>;

  /**
   * Create a TagRule
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TagRule,
    BaseParameters<TagRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a TagRule
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<TagRule, TagRuleUpdate>;

  /**
   * Delete a TagRule
   */
  delete is ArmResourceDeleteAsync<
    TagRule,
    BaseParameters<TagRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * List TagRule resources by NewRelicMonitorResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TagRules_ListByNewRelicMonitorResource")
  listByNewRelicMonitorResource is ArmResourceListByParent<TagRule>;
}
