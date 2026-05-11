import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.DevTestLab;
/**
 * An Azure Resource Manager template.
 */
@parentResource(ArtifactSource)
model ArmTemplate
  is Azure.ResourceManager.ProxyResource<ArmTemplateProperties, false> {
  ...ResourceNameParameter<
    Resource = ArmTemplate,
    KeyName = "armTemplateName",
    SegmentName = "armtemplates",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ArmTemplates {
  /**
   * Get azure resource manager template.
   */
  get is ArmResourceRead<
    ArmTemplate,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=displayName)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * List azure resource manager templates in a given artifact source.
   */
  @list
  list is ArmResourceListByParent<
    ArmTemplate,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=displayName)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<ArmTemplateList>
  >;
}

@@doc(ArmTemplate.name, "The name of the azure resource manager template.");
@@doc(ArmTemplate.properties, "The properties of the resource.");
