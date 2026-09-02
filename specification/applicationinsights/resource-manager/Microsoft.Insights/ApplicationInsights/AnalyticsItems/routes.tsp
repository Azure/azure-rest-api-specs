// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace AnalyticsItems;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AnalyticsItemsOperationGroup {
  /**
   * Gets a list of Analytics Items defined within an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
     */
    @path
    scopePath: ItemScopePath,

    /**
     * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
     */
    @query("scope")
    scope?: ItemScope = ItemScope.shared,

    /**
     * Enum indicating the type of the Analytics item.
     */
    @query("type")
    type?: ItemTypeParameter = ItemTypeParameter.none,

    /**
     * Flag indicating whether or not to return the content of each applicable item. If false, only return the item information.
     */
    @query("includeContent")
    includeContent?: boolean,
  ): ArmResponse<ApplicationInsightsComponentAnalyticsItem[]>;

  /**
   * Gets a specific Analytics Items defined within an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}/item")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
     */
    @path
    scopePath: ItemScopePath,

    /**
     * The Id of a specific item defined in the Application Insights component
     */
    @query("id")
    id?: string,

    /**
     * The name of a specific item defined in the Application Insights component
     */
    @query("name")
    name?: string,
  ): ArmResponse<ApplicationInsightsComponentAnalyticsItem>;
  /**
   * Adds or Updates a specific Analytics Item within an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}/item")
  @put
  put(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
     */
    @path
    scopePath: ItemScopePath,

    /**
     * Flag indicating whether or not to force save an item. This allows overriding an item if it already exists.
     */
    @query("overrideItem")
    overrideItem?: boolean,

    /**
     * Properties that need to be specified to create a new item and add it to an Application Insights component.
     */
    @body
    itemProperties: ApplicationInsightsComponentAnalyticsItem,
  ): ArmResponse<ApplicationInsightsComponentAnalyticsItem>;
  /**
   * Deletes a specific Analytics Items defined within an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/components/{resourceName}/{scopePath}/item")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
     */
    @path
    scopePath: ItemScopePath,

    /**
     * The Id of a specific item defined in the Application Insights component
     */
    @query("id")
    id?: string,

    /**
     * The name of a specific item defined in the Application Insights component
     */
    @query("name")
    name?: string,
  ): OkResponse;
}
