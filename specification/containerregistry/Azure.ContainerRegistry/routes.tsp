import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace AzureContainerRegistry;

interface ContainerRegistryOperationGroup {
  /**
   * Tells whether this Docker Registry instance supports Docker Registry HTTP API v2
   */
  @operationId("ContainerRegistry_CheckDockerV2Support")
  @route("/v2/")
  @get
  checkDockerV2Support is Azure.Core.Foundations.Operation<{}, void>;

  /**
   * Get the manifest identified by `name` and `reference` where `reference` can be
   * a tag or digest.
   */
  @operationId("ContainerRegistry_GetManifest")
  @route("/v2/{name}/manifests/{reference}")
  @get
  getManifest is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * A tag or a digest, pointing to a specific image
       */
      @path
      reference: string;

      /**
       * Accept header string delimited by comma. For example,
       * application/vnd.docker.distribution.manifest.v2+json
       */
      @header
      accept?: string;
    },
    ManifestWrapper
  >;

  /**
   * Put the manifest identified by `name` and `reference` where `reference` can be
   * a tag or digest.
   */
  @operationId("ContainerRegistry_CreateManifest")
  @route("/v2/{name}/manifests/{reference}")
  @put
  createManifest is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * A tag or a digest, pointing to a specific image
       */
      @path
      reference: string;

      /**
       * Manifest body, can take v1 or v2 values depending on accept header
       */
      @bodyRoot
      payload: Manifest;
    },
    void
  >;

  /**
   * Delete the manifest identified by `name` and `reference`. Note that a manifest
   * can _only_ be deleted by `digest`.
   */
  @operationId("ContainerRegistry_DeleteManifest")
  @route("/v2/{name}/manifests/{reference}")
  @delete
  deleteManifest is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      reference: string;
    },
    void
  >;

  /**
   * List repositories
   */
  @operationId("ContainerRegistry_GetRepositories")
  @route("/acr/v1/_catalog")
  @list
  getRepositories is Azure.Core.Foundations.Operation<
    {
      @query("last")
      last?: string;

      @query("n")
      n?: int32;
    },
    Repositories
  >;

  /**
   * Get repository attributes
   */
  @operationId("ContainerRegistry_GetProperties")
  @route("/acr/v1/{name}")
  @get
  getProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;
    },
    ContainerRepositoryProperties
  >;

  /**
   * Delete the repository identified by `name`
   */
  @operationId("ContainerRegistry_DeleteRepository")
  @route("/acr/v1/{name}")
  @delete
  deleteRepository is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;
    },
    DeleteRepositoryResult
  >;

  /**
   * Update the attribute identified by `name` where `reference` is the name of the
   * repository.
   */
  @operationId("ContainerRegistry_UpdateProperties")
  @route("/acr/v1/{name}")
  @patch(#{ implicitOptionality: true })
  updateProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Repository attribute value
       */
      @bodyRoot
      value?: RepositoryWriteableProperties;
    },
    ContainerRepositoryProperties
  >;

  /**
   * List tags of a repository
   */
  @operationId("ContainerRegistry_GetTags")
  @route("/acr/v1/{name}/_tags")
  @get
  getTags is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Query parameter for the last item in previous query. Result set will include
       * values lexically after last.
       */
      @query("last")
      last?: string;

      /**
       * query parameter for max number of items
       */
      @query("n")
      n?: int32;

      /**
       * orderby query parameter
       */
      @query("orderby")
      orderby?: string;

      /**
       * filter by digest
       */
      @query("digest")
      digest?: string;
    },
    TagList
  >;

  /**
   * Get tag attributes by tag
   */
  @operationId("ContainerRegistry_GetTagProperties")
  @route("/acr/v1/{name}/_tags/{reference}")
  @get
  getTagProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Tag name
       */
      @path
      reference: string;
    },
    ArtifactTagProperties
  >;

  /**
   * Update tag attributes
   */
  @operationId("ContainerRegistry_UpdateTagAttributes")
  @route("/acr/v1/{name}/_tags/{reference}")
  @patch(#{ implicitOptionality: true })
  updateTagAttributes is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Tag name
       */
      @path
      reference: string;

      /**
       * Tag attribute value
       */
      @bodyRoot
      value?: TagWriteableProperties;
    },
    ArtifactTagProperties
  >;

  /**
   * Delete tag
   */
  @operationId("ContainerRegistry_DeleteTag")
  @route("/acr/v1/{name}/_tags/{reference}")
  @delete
  deleteTag is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Tag name
       */
      @path
      reference: string;
    },
    void
  >;

  /**
   * List manifests of a repository
   */
  @operationId("ContainerRegistry_GetManifests")
  @route("/acr/v1/{name}/_manifests")
  @get
  getManifests is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Query parameter for the last item in previous query. Result set will include
       * values lexically after last.
       */
      @query("last")
      last?: string;

      /**
       * query parameter for max number of items
       */
      @query("n")
      n?: int32;

      /**
       * orderby query parameter
       */
      @query("orderby")
      orderby?: string;
    },
    AcrManifests
  >;

  /**
   * Get manifest attributes
   */
  @operationId("ContainerRegistry_GetManifestProperties")
  @route("/acr/v1/{name}/_manifests/{digest}")
  @get
  getManifestProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;
    },
    ArtifactManifestProperties
  >;

  /**
   * Update properties of a manifest
   */
  @operationId("ContainerRegistry_UpdateManifestProperties")
  @route("/acr/v1/{name}/_manifests/{digest}")
  @patch(#{ implicitOptionality: true })
  updateManifestProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;

      /**
       * Manifest attribute value
       */
      @bodyRoot
      value?: ManifestWriteableProperties;
    },
    ArtifactManifestProperties
  >;
}

interface ContainerRegistryBlobOperationGroup {
  /**
   * Retrieve the blob from the registry identified by digest.
   */
  @operationId("ContainerRegistryBlob_GetBlob")
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @get
  getBlob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;
    },
    void
  >;

  /**
   * Same as GET, except only the headers are returned.
   */
  @operationId("ContainerRegistryBlob_CheckBlobExists")
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @head
  checkBlobExists is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;
    },
    void
  >;

  /**
   * Removes an already uploaded blob.
   */
  @operationId("ContainerRegistryBlob_DeleteBlob")
  @route("/v2/{name}/blobs/{digest}")
  @delete
  deleteBlob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;
    },
    void
  >;

  /**
   * Mount a blob identified by the `mount` parameter from another repository.
   */
  @operationId("ContainerRegistryBlob_MountBlob")
  @sharedRoute
  @route("/v2/{name}/blobs/uploads/")
  @post
  mountBlob is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Name of the source repository.
       */
      @query("from")
      from: string;

      /**
       * Digest of blob to mount from the source repository.
       */
      @query("mount")
      mount: string;
    },
    void
  >;

  /**
   * Retrieve status of upload identified by uuid. The primary purpose of this
   * endpoint is to resolve the current status of a resumable upload.
   */
  @operationId("ContainerRegistryBlob_GetUploadStatus")
  @route("/{nextBlobUuidLink}")
  @get
  getUploadStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path("nextBlobUuidLink")
      location: string;
    },
    void
  >;

  /**
   * Upload a stream of data without completing the upload.
   */
  @operationId("ContainerRegistryBlob_UploadChunk")
  @route("/{nextBlobUuidLink}")
  @patch(#{ implicitOptionality: true })
  uploadChunk is Azure.Core.Foundations.Operation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path("nextBlobUuidLink")
      location: string;

      /**
       * Raw data of blob
       */
      @bodyRoot
      value: bytes;
    },
    void
  >;

  /**
   * Complete the upload, providing all the data in the body, if necessary. A
   * request without a body will just complete the upload with previously uploaded
   * content.
   */
  @operationId("ContainerRegistryBlob_CompleteUpload")
  @route("/{nextBlobUuidLink}")
  @put
  completeUpload is Azure.Core.Foundations.Operation<
    {
      /**
       * Digest of a BLOB
       */
      @query("digest")
      digest: string;

      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path("nextBlobUuidLink")
      location: string;

      /**
       * Optional raw data of blob
       */
      @bodyRoot
      value?: bytes;
    },
    void
  >;

  /**
   * Cancel outstanding upload processes, releasing associated resources. If this is
   * not called, the unfinished uploads will eventually timeout.
   */
  @operationId("ContainerRegistryBlob_CancelUpload")
  @route("/{nextBlobUuidLink}")
  @delete
  cancelUpload is Azure.Core.Foundations.Operation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path("nextBlobUuidLink")
      location: string;
    },
    void
  >;

  /**
   * Initiate a resumable blob upload with an empty request body.
   */
  @operationId("ContainerRegistryBlob_StartUpload")
  @sharedRoute
  @route("/v2/{name}/blobs/uploads/")
  @post
  startUpload is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;
    },
    void
  >;

  /**
   * Retrieve the blob from the registry identified by `digest`. This endpoint may
   * also support RFC7233 compliant range requests. Support can be detected by
   * issuing a HEAD request. If the header `Accept-Range: bytes` is returned, range
   * requests can be used to fetch partial content.
   */
  @operationId("ContainerRegistryBlob_GetChunk")
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @get
  getChunk is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;

      /**
       * Format : bytes=<start>-<end>,  HTTP Range header specifying blob chunk.
       */
      @header
      Range: string;
    },
    void
  >;

  /**
   * Same as GET, except only the headers are returned.
   */
  @operationId("ContainerRegistryBlob_CheckChunkExists")
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @head
  checkChunkExists is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;

      /**
       * Digest of a BLOB
       */
      @path
      digest: string;

      /**
       * Format : bytes=<start>-<end>,  HTTP Range header specifying blob chunk.
       */
      @header
      Range: string;
    },
    void
  >;
}

interface AuthenticationOperationGroup {
  /**
   * Exchange AAD tokens for an ACR refresh Token
   */
  @operationId("Authentication_ExchangeAadAccessTokenForAcrRefreshToken")
  @route("/oauth2/exchange")
  @post
  exchangeAadAccessTokenForAcrRefreshToken is Azure.Core.Foundations.Operation<
    {
      /**
       * Can take a value of access_token_refresh_token, or access_token, or
       * refresh_token
       */
      @bodyRoot
      grant_type: PostContentSchemaGrantType;

      /**
       * Indicates the name of your Azure container registry.
       */
      @bodyRoot
      service: string;

      /**
       * AAD tenant associated to the AAD credentials.
       */
      @bodyRoot
      tenant?: string;

      /**
       * AAD refresh token, mandatory when grant_type is access_token_refresh_token or
       * refresh_token
       */
      @bodyRoot
      refresh_token?: string;

      /**
       * AAD access token, mandatory when grant_type is access_token_refresh_token or
       * access_token.
       */
      @bodyRoot
      access_token?: string;
    },
    AcrRefreshToken
  >;

  /**
   * Exchange ACR Refresh token for an ACR Access Token
   */
  @operationId("Authentication_ExchangeAcrRefreshTokenForAcrAccessToken")
  @route("/oauth2/token")
  @post
  exchangeAcrRefreshTokenForAcrAccessToken is Azure.Core.Foundations.Operation<
    {
      /**
       * Indicates the name of your Azure container registry.
       */
      @bodyRoot
      service: string;

      /**
       * Which is expected to be a valid scope, and can be specified more than once for
       * multiple scope requests. You obtained this from the Www-Authenticate response
       * header from the challenge.
       */
      @bodyRoot
      scope: string;

      /**
       * Must be a valid ACR refresh token
       */
      @bodyRoot
      refresh_token: string;

      /**
       * Grant type is expected to be refresh_token
       */
      @bodyRoot
      grant_type: TokenGrantType;
    },
    AcrAccessToken
  >;

  /**
   * Exchange Username, Password and Scope for an ACR Access Token
   */
  @operationId("Authentication_GetAcrAccessTokenFromLogin")
  @route("/oauth2/token")
  @get
  getAcrAccessTokenFromLogin is Azure.Core.Foundations.Operation<
    {
      /**
       * Indicates the name of your Azure container registry.
       */
      @query("service")
      service: string;

      /**
       * Expected to be a valid scope, and can be specified more than once for multiple
       * scope requests. You can obtain this from the Www-Authenticate response header
       * from the challenge.
       */
      @query("scope")
      scope: string;
    },
    AcrAccessToken
  >;
}
