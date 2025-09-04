import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Artifact store properties.
 */
@parentResource(Publisher)
model ArtifactStore
  is Azure.ResourceManager.TrackedResource<ArtifactStorePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ArtifactStore,
    KeyName = "artifactStoreName",
    SegmentName = "artifactStores",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ArtifactStore>;

  /**
   * Update artifact store resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ArtifactStore, PatchModel = TagsObject>;

  /**
   * Deletes the specified artifact store.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ArtifactStore>;

  /**
   * Gets information of the ArtifactStores under publisher.
   */
  listByPublisher is ArmResourceListByParent<ArtifactStore>;

  /**
   * Add network fabric controllers to artifact stores
   */
  addNetworkFabricControllerEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStoreNetworkFabricControllerEndPoints,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * Delete network fabric controllers on artifact stores
   */
  deleteNetworkFabricControllerEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStoreNetworkFabricControllerEndPoints,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * List network fabric controllers to artifact stores
   */
  @list
  listNetworkFabricControllerPrivateEndPoints is ArmResourceActionAsync<
    ArtifactStore,
    void,
    ArmResponse<ArtifactStoreNetworkFabricControllerEndPointsList>
  >;

  /**
   * Approve manual private endpoints on artifact stores
   */
  approvePrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStorePrivateEndPointsFormat,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * Remove manual private endpoints on artifact stores
   */
  removePrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStorePrivateEndPointsFormat,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * List manual private endpoints on artifact stores
   */
  @list
  listPrivateEndPoints is ArmResourceActionAsync<
    ArtifactStore,
    void,
    ArmResponse<ArtifactStorePrivateEndPointsListResult>
  >;

  /**
   * Lists all the available artifacts in the parent Artifact Store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProxyArtifact_List")
  @list
  @get
  @action("artifacts")
  list is ArmResourceActionSync<
    ArtifactStore,
    void,
    ArmResponse<ResourceListResult<ProxyArtifactListOverview>>
  >;

  /**
   * Get a Artifact overview information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProxyArtifact_Get")
  @list
  @get
  @action("artifactVersions")
  proxyArtifactGet is ArmResourceActionSync<
    ArtifactStore,
    void,
    ArmResponse<ResourceListResult<ProxyArtifactVersionsListOverview>>,
    Parameters = {
      /**
       * The name of the artifact.
       */
      @maxLength(64)
      @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
      @query("artifactName")
      artifactName: string;
    }
  >;

  /**
   * Change artifact state defined in artifact store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProxyArtifact_UpdateState")
  @patch
  @action("{artifactVersionName}")
  updateState is ArmResourceActionAsync<
    ArtifactStore,
    ArtifactChangeState,
    ArmResponse<ProxyArtifactVersionsListOverview>,
    Parameters = {
      /**
       * The name of the artifact.
       */
      @maxLength(64)
      @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
      @query("artifactName")
      artifactName: string;

      /**
       * The name of the artifact version.
       */
      @maxLength(64)
      @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
      @path
      artifactVersionName: string;
    }
  >;
}

@@maxLength(ArtifactStore.name, 64);
@@doc(ArtifactStore.name, "The name of the artifact store.");
@@doc(ArtifactStore.properties, "ArtifactStores properties.");
@@doc(ArtifactStores.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update application group operation."
);
@@doc(ArtifactStores.update::parameters.properties,
  "Parameters supplied to the create or update application group operation."
);
@@doc(ArtifactStores.addNetworkFabricControllerEndPoints::parameters.body,
  "Parameters supplied to the create or update application group operation."
);
@@doc(ArtifactStores.deleteNetworkFabricControllerEndPoints::parameters.body,
  "Parameters supplied to the create or update application group operation."
);
@@doc(ArtifactStores.approvePrivateEndPoints::parameters.body,
  "Parameters supplied to approve private endpoints."
);
@@doc(ArtifactStores.removePrivateEndPoints::parameters.body,
  "Parameters supplied to the create or update application group operation."
);
@@doc(ArtifactStores.updateState::parameters.body,
  "Parameters supplied to update the state of artifact manifest."
);
