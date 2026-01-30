import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Template resource definition.
 */
model ProductTemplateModel
  is Azure.ResourceManager.ProxyResource<ProductTemplateProperties> {
  ...ResourceNameParameter<
    Resource = ProductTemplateModel,
    KeyName = "templateId",
    SegmentName = "contentProductTemplates",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface ProductTemplateModelsOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.OperationalInsights",

        /**
         * The name of the workspace.
         */
        @segment("workspaces")
        @key
        @path
        @minLength(1)
        @maxLength(90)
        @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
        workspaceName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ProductTemplateModel>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ProductTemplateModel>,

        /**
         * template Id
         */
        @path
        @key
        @segment("contentproducttemplates")
        templateId: string,
      }
    > {}

@armResourceOperations
interface ProductTemplateModels {
  /**
   * Gets a template by its identifier.
   */
  get is ProductTemplateModelsOps.Read<
    ProductTemplateModel,
    ErrorType = CloudError
  >;

  /**
   * Gets all templates in the catalog.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    ProductTemplateModel,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Searches for a substring in the response. Optional.
       */
      @query("$search")
      $search?: string;

      /**
       * Instructs the server to return only object count without actual body. Optional.
       */
      @query("$count")
      $count?: boolean;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Used to skip n elements in the OData query (offset). Returns a nextLink to the next page of results if there are any left.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ProductTemplateList>,
    Error = CloudError
  >;
}

@@doc(ProductTemplateModel.name, "template Id");
@@doc(ProductTemplateModel.properties, "template properties");
