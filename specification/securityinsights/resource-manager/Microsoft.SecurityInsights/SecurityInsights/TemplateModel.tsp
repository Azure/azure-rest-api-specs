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
model TemplateModel is Azure.ResourceManager.ProxyResource<TemplateProperties> {
  ...ResourceNameParameter<
    Resource = TemplateModel,
    KeyName = "templateId",
    SegmentName = "contentTemplates",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface TemplateModels {
  /**
   * Gets a template byt its identifier.
   * Expandable properties:
   * - properties/mainTemplate
   * - properties/dependantTemplates
   */
  get is Extension.Read<OperationalInsights, TemplateModel, Error = CloudError>;

  /**
   * Install a template.
   */
  install is Extension.CreateOrReplaceSync<
    OperationalInsights,
    TemplateModel,
    Error = CloudError
  >;

  /**
   * Delete an installed template.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    TemplateModel,
    Error = CloudError
  >;

  /**
   * Gets all installed templates.
   * Expandable properties:
   * - properties/mainTemplate
   * - properties/dependantTemplates
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    TemplateModel,
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
       * Expands the object with optional fiends that are not included by default. Optional.
       */
      @query("$expand")
      $expand?: string;

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
    Response = ArmResponse<TemplateList>,
    Error = CloudError
  >;
}

@@doc(TemplateModel.name, "template Id");
@@doc(TemplateModel.properties, "template properties");
@@doc(TemplateModels.install::parameters.resource,
  "Template installation properties"
);
