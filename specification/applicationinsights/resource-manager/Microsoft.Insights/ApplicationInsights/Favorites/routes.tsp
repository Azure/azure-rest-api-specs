// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Favorites;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FavoritesOperationGroup {
  /**
   * Gets a list of favorites defined within an Application Insights component.
   */
  @autoRoute
  @get
  @action("favorites")
  list is ArmProviderActionSync<
    Response = {
      @bodyRoot @identifiers(#[]) _: ApplicationInsightsComponentFavorite[];
    },
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;

      /**
       * The type of favorite. Value can be either shared or user.
       */
      @query("favoriteType")
      favoriteType?: FavoriteType = FavoriteType.shared;

      /**
       * Source type of favorite to return. When left out, the source type defaults to 'other' (not present in this enum).
       */
      @query("sourceType")
      sourceType?: FavoriteSourceType;

      /**
       * Flag indicating whether or not to return the full content for each applicable favorite. If false, only return summary content for favorites.
       */
      @query("canFetchContent")
      canFetchContent?: boolean;

      /**
       * Tags that must be present on each favorite returned.
       */
      @query("tags")
      tags?: string[];
    },
    Error = never
  >;
  /**
   * Get a single favorite by its FavoriteId, defined within an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Id of a specific favorite defined in the Application Insights component
     */
    @path
    favoriteId: string,
  ): ArmResponse<ApplicationInsightsComponentFavorite> | never;

  /**
   * Adds a new favorites to an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @put
  add(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Id of a specific favorite defined in the Application Insights component
     */
    @path
    favoriteId: string,

    /**
     * Properties that need to be specified to create a new favorite and add it to an Application Insights component.
     */
    @bodyRoot
    favoriteProperties: ApplicationInsightsComponentFavorite,
  ): ArmResponse<ApplicationInsightsComponentFavorite> | never;

  /**
   * Updates a favorite that has already been added to an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @patch(#{ implicitOptionality: true })
  update(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Id of a specific favorite defined in the Application Insights component
     */
    @path
    favoriteId: string,

    /**
     * Properties that need to be specified to update the existing favorite.
     */
    @bodyRoot
    favoriteProperties: ApplicationInsightsComponentFavorite,
  ): ArmResponse<ApplicationInsightsComponentFavorite> | never;

  /**
   * Remove a favorite that is associated to an Application Insights component.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/favorites/{favoriteId}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Application Insights component resource.
     */
    @path
    resourceName: string,

    /**
     * The Id of a specific favorite defined in the Application Insights component
     */
    @path
    favoriteId: string,
  ): OkResponse | never;
}
