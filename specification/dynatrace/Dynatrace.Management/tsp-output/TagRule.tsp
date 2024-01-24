import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Tag rules for a monitor resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MonitorResource)
@Azure.ResourceManager.Private.armResourceInternal(MonitoringTagRulesProperties)
@includeInapplicableMetadataInPayload(false)
model TagRule extends ProxyResourceBase {
  /**
   * Monitor resource name
   */
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: MonitoringTagRulesProperties;
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
   * List all TagRule by monitorName
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TagRules_List")
  list is ArmResourceListByParent<TagRule>;
}

@@projectedName(TagRules.update::parameters.properties, "json", "resource");
@@extension(TagRules.update::parameters.properties,
  "x-ms-client-name",
  "resource"
);
