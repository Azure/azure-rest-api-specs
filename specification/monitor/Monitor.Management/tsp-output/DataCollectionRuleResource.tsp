import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * Definition of ARM tracked top level resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  DataCollectionRuleResourceProperties
)
model DataCollectionRuleResource extends TrackedResourceBase {
  /**
   * The name of the data collection rule. The name is case insensitive.
   */
  @path
  @key("dataCollectionRuleName")
  @segment("dataCollectionRules")
  @visibility("read")
  name: string;

  /**
   * The kind of the resource.
   */
  kind?: KnownDataCollectionRuleResourceKind;

  /**
   * Resource entity tag (ETag).
   */
  @visibility("read")
  etag?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataCollectionRuleResourceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DataCollectionRuleResources {
  /**
   * Returns the specified data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRules_Get")
  get is ArmResourceRead<DataCollectionRuleResource>;

  /**
   * Creates or updates a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRules_Create")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleResource>;

  /**
   * Updates part of a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DataCollectionRules_Update")
  update is ArmCustomPatchSync<DataCollectionRuleResource, ResourceForUpdate>;

  /**
   * Deletes a data collection rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRules_Delete")
  delete is ArmResourceDeleteSync<DataCollectionRuleResource>;

  /**
   * Lists all data collection rules in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DataCollectionRuleResource>;

  /**
   * Lists all data collection rules in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRules_ListBySubscription")
  listBySubscription is ArmListBySubscription<DataCollectionRuleResource>;

  /**
   * Lists associations for the specified data collection rule.
   */
  // FIXME: DataCollectionRuleAssociations_ListByRule could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataCollectionRuleAssociations_ListByRule")
  @summary("Lists associations for the specified data collection rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}/associations")
  @get
  listByRule is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the data collection rule. The name is case insensitive.
       */
      @path
      dataCollectionRuleName: string;
    },
    ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>
  >;
}

@@projectedName(DataCollectionRuleResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(DataCollectionRuleResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DataCollectionRuleResources.create::parameters.resource, "The payload");
@@projectedName(DataCollectionRuleResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(DataCollectionRuleResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DataCollectionRuleResources.update::parameters.properties, "The payload");
