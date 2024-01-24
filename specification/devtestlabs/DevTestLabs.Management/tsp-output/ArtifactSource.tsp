import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * Properties of an artifact source.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal(ArtifactSourceProperties)
@includeInapplicableMetadataInPayload(false)
model ArtifactSource extends Resource {
  /**
   * The name of the artifact source.
   */
  @path
  @key("name")
  @segment("artifactsources")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: ArtifactSourceProperties;
}

@armResourceOperations
interface ArtifactSources {
  /**
   * Get artifact source.
   */
  get is ArmResourceRead<
    ArtifactSource,
    {
      ...BaseParameters<ArtifactSource>;

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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ArtifactSource, ArtifactSourceFragment>;

  /**
   * Delete artifact source.
   */
  delete is ArmResourceDeleteSync<ArtifactSource>;

  /**
   * List artifact sources in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ArtifactSources_List")
  list is ArmResourceListByParent<
    ArtifactSource,
    {
      ...BaseParameters<ArtifactSource>;

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
    }
  >;
}

@@projectedName(ArtifactSources.createOrUpdate::parameters.resource,
  "json",
  "artifactSource"
);
@@extension(ArtifactSources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "artifactSource"
);
@@doc(ArtifactSources.createOrUpdate::parameters.resource,
  "Properties of an artifact source."
);
@@projectedName(ArtifactSources.update::parameters.properties,
  "json",
  "artifactSource"
);
@@extension(ArtifactSources.update::parameters.properties,
  "x-ms-client-name",
  "artifactSource"
);
@@doc(ArtifactSources.update::parameters.properties,
  "Properties of an artifact source."
);
