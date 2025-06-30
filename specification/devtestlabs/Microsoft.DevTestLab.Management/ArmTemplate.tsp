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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(ArtifactSource)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ArmTemplate extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("armtemplates")
  name: string;

  properties: ArmTemplateProperties;
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
