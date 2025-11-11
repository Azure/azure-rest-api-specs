import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

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
    SegmentName = "contentproducttemplates",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias ProductTemplateWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface ProductTemplateModels {
  /**
   * Gets a template by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductTemplate_Get")
  get is ArmResourceRead<ProductTemplateModel>;

  /**
   * Gets all templates in the catalog.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductTemplates_List")
  list is ArmResourceListByParent<
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
    Response = ArmResponse<ProductTemplateList>
  >;
}

@@doc(ProductTemplateModel.name, "template Id");
@@doc(ProductTemplateModel.properties, "template properties");
