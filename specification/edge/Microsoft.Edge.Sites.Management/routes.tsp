import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation. Adding the interface is creating wrong endpoint."
interface SitesOperations {
  /**
   * List Site resources by ResourceGroup
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation. Adding the interface is creating wrong endpoint."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;
    },
    ResourceListResult<Site>
  >;

  /**
   * Get a Site at Resource Group scope
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation. Adding the interface is creating wrong endpoint."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @get
  getByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * Name of Site
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      siteName: string;
    },
    Site
  >;

  /**
   * Create a Site at Resource Group scope
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation. Adding the interface is creating wrong endpoint."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @put
  createOrUpdateByResourceGroup is Azure.Core.Foundations.Operation<
    Azure.Core.StandardListQueryParameters & {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * Name of Site
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      siteName: string;

      /**
       * Resource create parameters.
       */
      @body
      site: Site;
    },
    Site
  >;

  /**
   * Update a Site at Resource Group scope
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation. Adding the interface is creating wrong endpoint."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @patch
  updateByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * Name of Site
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      siteName: string;

      /**
       * The resource properties to be updated.
       */
      @body
      site: SiteUpdate;
    },
    Site
  >;

  /**
   * Delete a Site at ResourceGroup scope
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Custom operation. Adding the interface is creating wrong endpoint."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @delete
  deleteByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * Name of Site
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      siteName: string;
    },
    void
  >;
}
