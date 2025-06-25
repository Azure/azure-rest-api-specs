import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * Properties of an artifact source.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ArtifactSource extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("artifactsources")
  artifactSourceName: string;

  properties: ArtifactSourceProperties;
}

@armResourceOperations
interface ArtifactSources {
  /**
   * Get artifact source.
   */
  get is ArmResourceRead<
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<ArtifactSource>;

  /**
   * Allows modifying tags of artifact sources. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "ArtifactSourceFragment contains tags as expected by the patch operation."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ArtifactSource,
    PatchModel = ArtifactSourceFragment
  >;

  /**
   * Delete artifact source.
   */
  delete is ArmResourceDeleteSync<ArtifactSource>;

  /**
   * List artifact sources in a given lab.
   */
  list is ArmResourceListByParent<
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

@@doc(ArtifactSource.artifactSourceName, "The name of the artifact source.");
@@doc(ArtifactSource.properties, "The properties of the resource.");
@@doc(ArtifactSources.createOrUpdate::parameters.resource,
  "Properties of an artifact source."
);
@@doc(ArtifactSources.update::parameters.properties,
  "Properties of an artifact source."
);
@@doc(ArtifactSource.tags, "The tags of the resource.");
@@doc(ArtifactSource.location, "The location of the resource.");
