import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Artifact store properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Publisher)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ArtifactStorePropertiesFormat
)
model ArtifactStore extends TrackedResourceBase {
  /**
   * The name of the artifact store.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("artifactStoreName")
  @segment("artifactStores")
  @visibility("read")
  name: string;

  /**
   * ArtifactStores properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ArtifactStorePropertiesFormat;
}

@armResourceOperations
interface ArtifactStores {
  /**
   * Gets information about the specified artifact store.
   */
  get is ArmResourceRead<ArtifactStore>;

  /**
   * Creates or updates a artifact store.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ArtifactStore,
    BaseParameters<ArtifactStore>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update artifact store resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ArtifactStore, TagsObject>;

  /**
   * Deletes the specified artifact store.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArtifactStore,
    BaseParameters<ArtifactStore>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information of the ArtifactStores under publisher.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ArtifactStores_ListByPublisher")
  listByPublisher is ArmResourceListByParent<ArtifactStore>;

  /**
   * Lists all the available artifacts in the parent Artifact Store.
   */
  // FIXME: ProxyArtifact_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProxyArtifact_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifacts")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the publisher.
       */
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      publisherName: string;

      /**
       * The name of the artifact store.
       */
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      artifactStoreName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ProxyArtifactOverviewListResult
  >;

  /**
   * Get a Artifact overview information.
   */
  // FIXME: ProxyArtifact_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProxyArtifact_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactVersions")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the publisher.
       */
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      publisherName: string;

      /**
       * The name of the artifact store.
       */
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      artifactStoreName: string;

      /**
       * The name of the artifact.
       */
      @maxLength(64)
      @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
      @query("artifactName")
      artifactName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ProxyArtifactVersionsOverviewListResult
  >;
}

@@projectedName(ArtifactStores.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ArtifactStores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ArtifactStores.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update application group operation."
);
@@projectedName(ArtifactStores.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ArtifactStores.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ArtifactStores.update::parameters.properties,
  "Parameters supplied to the create or update application group operation."
);
