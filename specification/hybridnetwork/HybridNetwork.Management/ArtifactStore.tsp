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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ArtifactStore,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Update artifact store resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ArtifactStore, PatchModel = TagsObject>;

  /**
   * Deletes the specified artifact store.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArtifactStore,
    LroHeaders = ArmLroLocationHeader,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">
  >;

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
    ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * Delete network fabric controllers on artifact stores
   */
  deleteNetworkFabricControllerEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStoreNetworkFabricControllerEndPoints,
    ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * List network fabric controllers to artifact stores
   */
  @list
  listNetworkFabricControllerPrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    void,
    ArmResponse<ArtifactStoreNetworkFabricControllerEndPointsList> | ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader<FinalResult = ArtifactStoreNetworkFabricControllerEndPointsList>
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * Approve manual private endpoints on artifact stores
   */
  approvePrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStorePrivateEndPointsFormat,
    ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * Remove manual private endpoints on artifact stores
   */
  removePrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    ArtifactStorePrivateEndPointsFormat,
    ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;

  /**
   * List manual private endpoints on artifact stores
   */
  @list
  listPrivateEndPoints is ArmResourceActionAsyncBase<
    ArtifactStore,
    void,
    ArmResponse<ArtifactStorePrivateEndPointsListResult> | ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader<FinalResult = ArtifactStorePrivateEndPointsListResult>
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ArtifactStore>
  >;
}

@armResourceOperations
interface ProxyArtifact {
  /**
   * Lists all the available artifacts in the parent Artifact Store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @list
  @get
  @action("artifacts")
  list is ArmResourceActionSync<
    ArtifactStore,
    void,
    ArmResponse<ProxyArtifactOverviewListResult>
  >;

  /**
   * Get a Artifact overview information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @list
  @get
  @action("artifactVersions")
  proxyArtifactGet is ArmResourceActionSync<
    ArtifactStore,
    void,
    ArmResponse<ProxyArtifactVersionsOverviewListResult>,
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateState(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...Azure.ResourceManager.Legacy.Provider,

    /**
     * The name of the publisher.
     */
    @path
    @maxLength(64)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
    @segment("publishers")
    publisherName: string,

    /**
     * The name of the artifact store.
     */
    @path
    @maxLength(64)
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
    @segment("artifactStores")
    artifactStoreName: string,

    /**
     * The name of the artifact version.
     */
    @path
    @maxLength(64)
    @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
    @segment("artifactVersions")
    artifactVersionName: string,

    /**
     * The name of the artifact.
     */
    @maxLength(64)
    @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
    @query("artifactName")
    artifactName: string,

    @body
    body: ArtifactChangeState,
  ): ArmResponse<ProxyArtifactVersionsListOverview> | ArmAcceptedLroResponse<
    "Request of updating artifact state is accepted.",
    ArmLroLocationHeader<FinalResult = ProxyArtifactVersionsListOverview>
  > | ErrorResponse;
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
@@doc(ProxyArtifact.updateState::parameters.body,
  "Parameters supplied to update the state of artifact manifest."
);
