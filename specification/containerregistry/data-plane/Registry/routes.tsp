import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Foundations;

namespace ContainerRegistry;

/**
 * Custom operation template that uses AcrErrors for error responses
 * instead of Azure.Core.Foundations.ErrorResponse
 */
op AcrOperation<
  TParams extends TypeSpec.Reflection.Model = {},
  TResponse extends TypeSpec.Reflection.Model | void = void,
  TTraits extends TypeSpec.Reflection.Model = {}
> is Foundations.Operation<TParams, TResponse, TTraits, AcrErrors>;

interface ContainerRegistry {
  /**
   * Tells whether this Docker Registry instance supports Docker Registry HTTP API v2
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/v2/")
  @get
  checkDockerV2Support is AcrOperation<
    {},
    {
      @statusCode statusCode: 200;
    }
  >;

  /**
   * Get the manifest identified by `name` and `reference` where `reference` can be
   * a tag or digest.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/v2/{name}/manifests/{reference}")
  @get
  getManifest is AcrOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/v2/{name}/manifests/{reference}")
  @put
  createManifest is AcrOperation<
    {
      /**
       * Content type for the manifest
       */
      @header("Content-Type")
      contentType: "application/vnd.docker.distribution.manifest.v2+json";

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
    {
      @statusCode statusCode: 201;
      @header("Location") location: string;
      @header("Content-Length") contentLength: int64;
      @header("Docker-Content-Digest") dockerContentDigest: string;
    }
  >;

  /**
   * Delete the manifest identified by `name` and `reference`. Note that a manifest
   * can _only_ be deleted by `digest`.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/v2/{name}/manifests/{reference}")
  @delete
  deleteManifest is AcrOperation<
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
    TypeSpec.Http.AcceptedResponse | NotFoundResponse
  >;

  /**
   * List repositories
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @route("/acr/v1/_catalog")
  @list
  getRepositories is AcrOperation<
    {
      /** Query parameter for the last item in previous query. Result set will include values lexically after last. */
      @query("last")
      last?: string;

      /** Query parameter for max number of items */
      @query("n")
      n?: int32;
    },
    {
      /** next paginated result */
      @header("Link")
      link?: string;

      @bodyRoot
      body: Repositories;
    }
  >;

  /**
   * Get repository attributes
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}")
  @get
  getProperties is AcrOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}")
  @delete
  deleteRepository is AcrOperation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;
    },
    {
      /** The repository is deleted */
      @statusCode statusCode: 202;
    } | {
      /** The repository was not found */
      @statusCode statusCode: 404;
    }
  >;

  /**
   * Update the attribute identified by `name` where `reference` is the name of the
   * repository.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}")
  @patch(#{ implicitOptionality: true })
  updateProperties is AcrOperation<
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
      value?: RepositoryChangeableAttributes;
    },
    ContainerRepositoryProperties
  >;

  /**
   * List tags of a repository
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_tags")
  @get
  getTags is AcrOperation<
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
      orderby?: ArtifactTagOrder;

      /**
       * filter by digest
       */
      @query("digest")
      digest?: string;
    },
    {
      /** next paginated result */
      @header("Link")
      link?: string;

      @bodyRoot
      body: TagList;
    }
  >;

  /**
   * Get tag attributes by tag
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_tags/{reference}")
  @get
  getTagProperties is AcrOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_tags/{reference}")
  @patch(#{ implicitOptionality: true })
  updateTagAttributes is AcrOperation<
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
      value?: TagChangeableAttributes;
    },
    ArtifactTagProperties
  >;

  /**
   * Delete tag
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_tags/{reference}")
  @delete
  deleteTag is AcrOperation<
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
    {
      @statusCode statusCode: 202;
    } | NotFoundResponse
  >;

  /**
   * List manifests of a repository
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_manifests")
  @get
  getManifests is AcrOperation<
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
      orderby?: ArtifactManifestOrder;
    },
    {
      /** next paginated result */
      @header("Link")
      link?: string;

      @bodyRoot
      body: AcrManifests;
    }
  >;

  /**
   * Get manifest attributes
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_manifests/{digest}")
  @get
  getManifestProperties is AcrOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/acr/v1/{name}/_manifests/{digest}")
  @patch(#{ implicitOptionality: true })
  updateManifestProperties is AcrOperation<
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
      value?: ManifestChangeableAttributes;
    },
    ArtifactManifestProperties
  >;
}

interface ContainerRegistryBlob {
  /**
   * Retrieve the blob from the registry identified by digest.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @get
  getBlob is AcrOperation<
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
    {
      /** The blob identified by digest is available. The blob content will be present in the body of the response. */
      @statusCode statusCode: 200;

      /** The length of the requested blob content. */
      @header("Content-Length") contentLength: int64;

      /** Digest of the targeted content for the request. */
      @header("Docker-Content-Digest") dockerContentDigest: string;

      /** blob binary data */
      @bodyRoot body: bytes;
    } | {
      /** The blob identified by digest is available at the provided location. */
      @statusCode statusCode: 307;

      /** The location where the layer should be accessible. */
      @header("Location") location: string;
    }
  >;

  /**
   * Same as GET, except only the headers are returned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @head
  checkBlobExists is AcrOperation<
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
    {
      /** The blob identified by digest is available. The blob content will be present in the body of the response. */
      @statusCode statusCode: 200;

      /** The length of the requested blob content. */
      @header("Content-Length") contentLength: int64;

      /** Digest of the targeted content for the request. */
      @header("Docker-Content-Digest") dockerContentDigest: string;
    } | {
      /** The blob identified by digest is available at the provided location. */
      @statusCode statusCode: 307;

      /** The location where the layer should be accessible. */
      @header("Location") location: string;
    }
  >;

  /**
   * Removes an already uploaded blob.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/v2/{name}/blobs/{digest}")
  @delete
  deleteBlob is AcrOperation<
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
    {
      /** The blob identified by digest is available. The blob content will be present in the body of the response. */
      @statusCode statusCode: 202;

      /** Digest of the targeted content for the request. */
      @header("Docker-Content-Digest") dockerContentDigest: string;
    }
  >;

  /**
   * Mount a blob identified by the `mount` parameter from another repository.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/uploads/")
  @post
  mountBlob is AcrOperation<
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
    {
      /** The blob has been created in the registry and is available at the provided location. */
      @statusCode statusCode: 201;

      /** Provided location for blob */
      @header("Location") location: string;

      /** Identifies the docker upload uuid for the current request. */
      @header("Docker-Upload-UUID") dockerUploadUuid: string;

      /** Digest of the targeted content for the request. */
      @header("Docker-Content-Digest") dockerContentDigest: string;
    }
  >;

  /**
   * Retrieve status of upload identified by uuid. The primary purpose of this
   * endpoint is to resolve the current status of a resumable upload.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/{+nextBlobUuidLink}")
  @get
  getUploadStatus is AcrOperation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path
      nextBlobUuidLink: string;
    },
    {
      /** The upload is known and in progress. The last received offset is available in the Range header. */
      @statusCode statusCode: 204;

      /** Range indicating the current progress of the upload. */
      @header("Range") range: string;

      @header("Docker-Upload-UUID") dockerUploadUuid: string;
    }
  >;

  /**
   * Upload a stream of data without completing the upload.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
  @route("/{+nextBlobUuidLink}")
  @patch(#{ implicitOptionality: true })
  uploadChunk is AcrOperation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path
      nextBlobUuidLink: string;

      /**
       * Raw data of blob
       */
      @bodyRoot
      value: bytes;
    },
    {
      /** The stream of data has been accepted and the current progress is available in the range header. The updated upload location is available in the Location header. */
      @statusCode statusCode: 202;

      /** Provided location for blob */
      @header("Location") location: string;

      /** Range indicating the current progress of the upload. */
      @header("Range") range: string;

      /** Identifies the docker upload uuid for the current request. */
      @header("Docker-Upload-UUID") dockerUploadUuid: string;
    }
  >;

  /**
   * Complete the upload, providing all the data in the body, if necessary. A
   * request without a body will just complete the upload with previously uploaded
   * content.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Ensuring existing operation name for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
  @route("/{+nextBlobUuidLink}")
  @put
  completeUpload is AcrOperation<
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
      @path
      nextBlobUuidLink: string;

      /**
       * Optional raw data of blob
       */
      @bodyRoot
      value?: bytes;
    },
    {
      /** The upload has been completed and accepted by the registry. */
      @statusCode statusCode: 201;

      /** Provided location for blob */
      @header("Location") location: string;

      /** Range indicating the current progress of the upload. */
      @header("Range") range: string;

      /** Digest of the targeted content for the request. */
      @header("Docker-Content-Digest") dockerContentDigest: string;
    }
  >;

  /**
   * Cancel outstanding upload processes, releasing associated resources. If this is
   * not called, the unfinished uploads will eventually timeout.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/{+nextBlobUuidLink}")
  @delete
  cancelUpload is AcrOperation<
    {
      /**
       * Link acquired from upload start or previous chunk. Note, do not include initial
       * / (must do substring(1) )
       */
      @path
      nextBlobUuidLink: string;
    },
    NoContentResponse
  >;

  /**
   * Initiate a resumable blob upload with an empty request body.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/uploads/")
  @post
  startUpload is AcrOperation<
    {
      /**
       * Name of the image (including the namespace)
       */
      @path
      name: string;
    },
    {
      /** The upload has been created. The Location header must be used to complete the upload. The response should be identical to a GET request on the contents of the returned Location header. */
      @statusCode statusCode: 202;

      /** Provided location for blob */
      @header("Location") location: string;

      /** Range indicating the current progress of the upload. */
      @header("Range") range: string;

      /** Identifies the docker upload uuid for the current request. */
      @header("Docker-Upload-UUID") dockerUploadUuid: string;
    }
  >;

  /**
   * Retrieve the blob from the registry identified by `digest`. This endpoint may
   * also support RFC7233 compliant range requests. Support can be detected by
   * issuing a HEAD request. If the header `Accept-Range: bytes` is returned, range
   * requests can be used to fetch partial content.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @get
  getChunk is AcrOperation<
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "backward compatibility"
      @header
      Range: string;
    },
    {
      /** The blob identified by digest is available. The specified chunk of blob content will be present in the body of the request. */
      @statusCode statusCode: 206;

      /** The length of the requested blob content. */
      @header("Content-Length") contentLength: int64;

      /** Content range of the blob chunk. */
      @header("Content-Range") contentRange: string;

      @body responseBody: bytes;
    }
  >;

  /**
   * Same as GET, except only the headers are returned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @sharedRoute
  @route("/v2/{name}/blobs/{digest}")
  @head
  checkChunkExists is AcrOperation<
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
      #suppress "@azure-tools/typespec-azure-core/casing-style" "backward compatibility"
      @header
      Range: string;
    },
    {
      /** The blob identified by digest is available. The specified chunk of blob content will be present in the body of the request. */
      @statusCode statusCode: 200;

      /** The length of the requested blob content. */
      @header("Content-Length") contentLength: int64;

      /** Content range of the blob chunk. */
      @header("Content-Range") contentRange: string;
    }
  >;
}

interface Authentication {
  /**
   * Exchange AAD tokens for an ACR refresh Token
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
  @route("/oauth2/exchange")
  @post
  exchangeAadAccessTokenForAcrRefreshToken(
    /** The content type */
    @header contentType: "multipart/form-data",

    /** The body of the request */
    @multipartBody body: MultipartBodyParameter,
  ): AcrRefreshToken | AcrErrors;

  /**
   * Exchange ACR Refresh token for an ACR Access Token
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  #suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
  @route("/oauth2/token")
  @post
  exchangeAcrRefreshTokenForAcrAccessToken(
    /** The content type */
    @header contentType: "multipart/form-data",

    /** The body of the request */
    @multipartBody body: MultipartBodyParameter,
  ): AcrAccessToken | AcrErrors;

  /**
   * Exchange Username, Password and Scope for an ACR Access Token
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @route("/oauth2/token")
  @get
  getAcrAccessTokenFromLogin is AcrOperation<
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
