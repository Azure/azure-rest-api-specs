import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Datadog;
/**
 * Capture logs and metrics of Azure resources based on ARM tags.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DatadogMonitorResource)
@Azure.ResourceManager.Private.armResourceInternal(MonitoringTagRulesProperties)
@includeInapplicableMetadataInPayload(false)
model MonitoringTagRules extends ProxyResourceBase {
  /**
   * Rule set name
   */
  @path
  @key("ruleSetName")
  @segment("tagRules")
  name: string;

  /**
   * Definition of the properties for a TagRules resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MonitoringTagRulesProperties;
}

@armResourceOperations
@projectedName("client", "MonitoringTagRules")
interface MonitoringTagRulesOperationGroup {
  /**
   * Get a tag rule set for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TagRules_Get")
  get is ArmResourceRead<MonitoringTagRules>;

  /**
   * Create or update a tag rule set for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TagRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MonitoringTagRules>;

  /**
   * List the tag rules for a given monitor resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TagRules_List")
  list is ArmResourceListByParent<MonitoringTagRules>;
}

@@projectedName(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(MonitoringTagRulesOperationGroup.createOrUpdate::parameters.resource, "");
