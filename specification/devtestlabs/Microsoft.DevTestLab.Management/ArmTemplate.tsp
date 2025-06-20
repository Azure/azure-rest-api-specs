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
    KeyName = "name",
    SegmentName = "armtemplates",
    NamePattern = ""
  >;

  /**
   * The location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  location?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to avoid SDK breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Required to avoid SDK breaking change."
  tags?: Record<string>;
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
@@doc(ArmTemplate.tags, "The tags of the resource.");
@@doc(ArmTemplate.location, "The location of the resource.");
