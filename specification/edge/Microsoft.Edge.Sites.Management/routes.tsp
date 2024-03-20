import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Edge;


@doc("The ApiVersion query parameter for Atlas API.")
model AtlasApiVersionParameter {
  @doc("The API version to use for this operation.")
  @query("api-version")
  @minLength(1)
  apiVersion?: string;
}

alias AtlasApiVersionParameterTraits = Azure.Core.Traits.VersionParameterTrait<AtlasApiVersionParameter>;

@armResourceOperations 
interface ListSitesOperations {
  /**
   * List Site resources by ResourceGroup
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites")
  @get
  @armResourceList(Site)
  byResourceGroup is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations 
interface SitesGetOperations {
  /**
   * Get a Site at Resource Group scope
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @get
  @armResourceRead(Site)
  byResourceGroup is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations 
interface SitesCreateOperations {
  /**
   * Create a Site at Resource Group scope
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @put
  @armResourceCreateOrUpdate(Site)
  byResourceGroup is Azure.Core.Foundations.Operation<
			Azure.Core.StandardListQueryParameters & 
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
       * Resource create parameters.
       */
      @body
      site: Site;
    },
    Site
  >;
}

@armResourceOperations 
interface SitesUpdateOperations {
  /**
   * Update a Site at Resource Group scope
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @patch
  @armResourceUpdate(Site)
  byResourceGroup is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations 
interface SitesDeleteOperations {
  /**
   * Delete a Site at ResourceGroup scope
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/sites/{siteName}")
  @delete
  @armResourceDelete(Site)
  byResourceGroup is Azure.Core.Foundations.Operation<
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
