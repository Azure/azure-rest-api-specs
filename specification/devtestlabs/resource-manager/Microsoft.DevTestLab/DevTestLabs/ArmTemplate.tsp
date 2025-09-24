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
interface ArmTemplatesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,

        /** The name of the artifact source. */
        @path @segment("artifactsources") artifactSourceName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ArmTemplate,
        KeyName = "name",
        SegmentName = "armtemplates",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ArmTemplates {
  /**
   * Get azure resource manager template.
   */
  get is ArmTemplatesOps.Read<
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
  list is ArmTemplatesOps.List<
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
