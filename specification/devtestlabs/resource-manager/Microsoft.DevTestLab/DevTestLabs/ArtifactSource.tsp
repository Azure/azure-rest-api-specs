import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * Properties of an artifact source.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ArtifactSource extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("artifactsources")
  name: string;

  properties: ArtifactSourceProperties;
}

@armResourceOperations
interface ArtifactSourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ArtifactSource,
        KeyName = "name",
        SegmentName = "artifactsources",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ArtifactSources {
  /**
   * Get artifact source.
   */
  get is ArtifactSourceOps.Read<
    ArtifactSource,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=displayName)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing artifact source.
   */
  createOrUpdate is ArtifactSourceOps.CreateOrUpdateSync<ArtifactSource>;

  /**
   * Allows modifying tags of artifact sources. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "ArtifactSourceFragment contains tags as expected by the patch operation."
  @patch(#{ implicitOptionality: false })
  update is ArtifactSourceOps.CustomPatchSync<
    ArtifactSource,
    PatchModel = ArtifactSourceFragment
  >;

  /**
   * Delete artifact source.
   */
  delete is ArtifactSourceOps.DeleteSync<ArtifactSource>;

  /**
   * List artifact sources in a given lab.
   */
  list is ArtifactSourceOps.List<
    ArtifactSource,
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
    Response = ArmResponse<ArtifactSourceList>
  >;
}

@@doc(ArtifactSource.name, "The name of the artifact source.");
@@doc(ArtifactSource.properties, "The properties of the resource.");
@@doc(ArtifactSources.createOrUpdate::parameters.resource,
  "Properties of an artifact source."
);
@@doc(ArtifactSources.update::parameters.properties,
  "Properties of an artifact source."
);
