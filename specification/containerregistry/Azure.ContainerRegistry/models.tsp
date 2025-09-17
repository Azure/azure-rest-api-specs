import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AzureContainerRegistry;

/**
 * The artifact platform's architecture.
 */
union ArtifactArchitecture {
  string,

  /**
   * i386
   */
  I386: "386",

  /**
   * AMD64
   */
  Amd64: "amd64",

  /**
   * ARM
   */
  Arm: "arm",

  /**
   * ARM64
   */
  Arm64: "arm64",

  /**
   * MIPS
   */
  Mips: "mips",

  /**
   * MIPSLE
   */
  MipsLe: "mipsle",

  /**
   * MIPS64
   */
  Mips64: "mips64",

  /**
   * MIPS64LE
   */
  Mips64Le: "mips64le",

  /**
   * PPC64
   */
  Ppc64: "ppc64",

  /**
   * PPC64LE
   */
  Ppc64Le: "ppc64le",

  /**
   * RISCv64
   */
  RiscV64: "riscv64",

  /**
   * s390x
   */
  S390x: "s390x",

  /**
   * Wasm
   */
  Wasm: "wasm",
}

union ArtifactOperatingSystem {
  string,
  Aix: "aix",
  Android: "android",
  Darwin: "darwin",
  Dragonfly: "dragonfly",
  FreeBsd: "freebsd",
  Illumos: "illumos",
  iOS: "ios",
  JS: "js",
  Linux: "linux",
  NetBsd: "netbsd",
  OpenBsd: "openbsd",
  Plan9: "plan9",
  Solaris: "solaris",
  Windows: "windows",
}

/**
 * Can take a value of access_token_refresh_token, or access_token, or
 * refresh_token
 */
union PostContentSchemaGrantType {
  string,
  access_token_refresh_token: "access_token_refresh_token",
  access_token: "access_token",
  refresh_token: "refresh_token",
}

/**
 * Grant type is expected to be refresh_token
 */
enum TokenGrantType {
  refresh_token,
  password,
}

/**
 * Sort options for ordering tags in a collection.
 */
enum ArtifactTagOrderBy {
  /**
   * Do not provide an orderby value in the request.
   */
  None: "none",

  /**
   * Order tags by LastUpdatedOn field, from most recently updated to least recently
   * updated.
   */
  LastUpdatedOnDescending: "timedesc",

  /**
   * Order tags by LastUpdatedOn field, from least recently updated to most recently
   * updated.
   */
  LastUpdatedOnAscending: "timeasc",
}

/**
 * Sort options for ordering manifests in a collection.
 */
enum ArtifactManifestOrderBy {
  /**
   * Do not provide an orderby value in the request.
   */
  None: "none",

  /**
   * Order manifests by LastUpdatedOn field, from most recently updated to least
   * recently updated.
   */
  LastUpdatedOnDescending: "timedesc",

  /**
   * Order manifest by LastUpdatedOn field, from least recently updated to most
   * recently updated.
   */
  LastUpdatedOnAscending: "timeasc",
}

/**
 * Acr error response describing why the operation failed
 */
@error
model AcrErrors {
  /**
   * Array of detailed error
   */
  errors?: AcrErrorInfo[];
}

/**
 * Error information
 */
model AcrErrorInfo {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Error details
   */
  detail?: Record<unknown>;
}

/**
 * Returns the requested manifest file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManifestWrapper extends Manifest {
  /**
   * Media type for this Manifest
   */
  mediaType?: string;

  /**
   * (ManifestList, OCIIndex) List of V2 image layer information
   */
  manifests?: ManifestListAttributes[];

  /**
   * (V2, OCI) Image config descriptor
   */
  config?: Descriptor;

  /**
   * (V2, OCI) List of V2 image layer information
   */
  layers?: Descriptor[];

  /**
   * (OCI, OCIIndex) Additional metadata
   */
  annotations?: Annotations;

  /**
   * (V1) CPU architecture
   */
  architecture?: string;

  /**
   * (V1) Image name
   */
  name?: string;

  /**
   * (V1) Image tag
   */
  tag?: string;

  /**
   * (V1) List of layer information
   */
  fsLayers?: FsLayer[];

  /**
   * (V1) Image history
   */
  history?: History[];

  /**
   * (V1) Image signature
   */
  signatures?: ImageSignature[];
}

model ManifestListAttributes {
  /**
   * The MIME type of the referenced object. This will generally be
   * application/vnd.docker.image.manifest.v2+json, but it could also be
   * application/vnd.docker.image.manifest.v1+json
   */
  mediaType?: string;

  /**
   * The size in bytes of the object
   */
  size?: int64;

  /**
   * The digest of the content, as defined by the Registry V2 HTTP API Specification
   */
  digest?: string;

  /**
   * The platform object describes the platform which the image in the manifest runs
   * on. A full list of valid operating system and architecture values are listed in
   * the Go language documentation for $GOOS and $GOARCH
   */
  platform?: Platform;
}

/**
 * The platform object describes the platform which the image in the manifest runs
 * on. A full list of valid operating system and architecture values are listed in
 * the Go language documentation for $GOOS and $GOARCH
 */
model Platform {
  /**
   * Specifies the CPU architecture, for example amd64 or ppc64le.
   */
  architecture?: string;

  /**
   * The os field specifies the operating system, for example linux or windows.
   */
  os?: string;

  /**
   * The optional os.version field specifies the operating system version, for
   * example 10.0.10586.
   */
  `os.version`?: string;

  /**
   * The optional os.features field specifies an array of strings, each listing a
   * required OS feature (for example on Windows win32k
   */
  `os.features`?: string[];

  /**
   * The optional variant field specifies a variant of the CPU, for example armv6l
   * to specify a particular CPU variant of the ARM CPU.
   */
  variant?: string;

  /**
   * The optional features field specifies an array of strings, each listing a
   * required CPU feature (for example sse4 or aes
   */
  features?: string[];
}

/**
 * Docker V2 image layer descriptor including config and layers
 */
model Descriptor {
  /**
   * Layer media type
   */
  mediaType?: string;

  /**
   * Layer size
   */
  size?: int64;

  /**
   * Layer digest
   */
  digest?: string;

  /**
   * Specifies a list of URIs from which this object may be downloaded.
   */
  urls?: string[];

  /**
   * Additional information provided through arbitrary metadata.
   */
  annotations?: Annotations;
}

/**
 * Additional information provided through arbitrary metadata.
 */
model Annotations {
  ...Record<Record<unknown>>;

  /**
   * Date and time on which the image was built (string, date-time as defined by
   * https://tools.ietf.org/html/rfc3339#section-5.6)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  `org.opencontainers.image.created`?: utcDateTime;

  /**
   * Contact details of the people or organization responsible for the image.
   */
  `org.opencontainers.image.authors`?: string;

  /**
   * URL to find more information on the image.
   */
  `org.opencontainers.image.url`?: string;

  /**
   * URL to get documentation on the image.
   */
  `org.opencontainers.image.documentation`?: string;

  /**
   * URL to get source code for building the image.
   */
  `org.opencontainers.image.source`?: string;

  /**
   * Version of the packaged software. The version MAY match a label or tag in the
   * source code repository, may also be Semantic versioning-compatible
   */
  `org.opencontainers.image.version`?: string;

  /**
   * Source control revision identifier for the packaged software.
   */
  `org.opencontainers.image.revision`?: string;

  /**
   * Name of the distributing entity, organization or individual.
   */
  `org.opencontainers.image.vendor`?: string;

  /**
   * License(s) under which contained software is distributed as an SPDX License
   * Expression.
   */
  `org.opencontainers.image.licenses`?: string;

  /**
   * Name of the reference for a target.
   */
  `org.opencontainers.image.ref.name`?: string;

  /**
   * Human-readable title of the image
   */
  `org.opencontainers.image.title`?: string;

  /**
   * Human-readable description of the software packaged in the image
   */
  `org.opencontainers.image.description`?: string;
}

/**
 * Image layer information
 */
model FsLayer {
  /**
   * SHA of an image layer
   */
  blobSum?: string;
}

/**
 * A list of unstructured historical data for v1 compatibility
 */
model History {
  /**
   * The raw v1 compatibility information
   */
  v1Compatibility?: string;
}

/**
 * Signature of a signed manifest
 */
model ImageSignature {
  /**
   * A JSON web signature
   */
  header?: JWK;

  /**
   * A signature for the image manifest, signed by a libtrust private key
   */
  signature?: string;

  /**
   * The signed protected header
   */
  protected?: string;
}

/**
 * A JSON web signature
 */
model JWK {
  /**
   * JSON web key parameter
   */
  jwk?: JWKHeader;

  /**
   * The algorithm used to sign or encrypt the JWT
   */
  alg?: string;
}

/**
 * JSON web key parameter
 */
model JWKHeader {
  /**
   * crv value
   */
  crv?: string;

  /**
   * kid value
   */
  kid?: string;

  /**
   * kty value
   */
  kty?: string;

  /**
   * x value
   */
  x?: string;

  /**
   * y value
   */
  y?: string;
}

/**
 * Returns the requested manifest file
 */
model Manifest {
  /**
   * Schema version
   */
  schemaVersion?: int32;
}

/**
 * List of repositories
 */
model Repositories {
  /**
   * Repository names
   */
  @pageItems
  repositories?: string[];

  @nextLink
  link?: string;
}

/**
 * Properties of this repository.
 */
model ContainerRepositoryProperties {
  /**
   * Registry login server name. This is likely to be similar to
   * {registry-name}.azurecr.io.
   */
  @visibility(Lifecycle.Read)
  registry: string;

  /**
   * Image name
   */
  @visibility(Lifecycle.Read)
  imageName: string;

  /**
   * Image created time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime: utcDateTime;

  /**
   * Image last update time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime: utcDateTime;

  /**
   * Number of the manifests
   */
  @visibility(Lifecycle.Read)
  manifestCount: int32;

  /**
   * Number of the tags
   */
  @visibility(Lifecycle.Read)
  tagCount: int32;

  /**
   * Writeable properties of the resource
   */
  changeableAttributes: RepositoryWriteableProperties;
}

/**
 * Changeable attributes for Repository
 */
model RepositoryWriteableProperties {
  /**
   * Delete enabled
   */
  deleteEnabled?: boolean;

  /**
   * Write enabled
   */
  writeEnabled?: boolean;

  /**
   * List enabled
   */
  listEnabled?: boolean;

  /**
   * Read enabled
   */
  readEnabled?: boolean;
}

/**
 * Deleted repository
 */
model DeleteRepositoryResult {
  /**
   * SHA of the deleted image
   */
  @visibility(Lifecycle.Read)
  manifestsDeleted?: string[];

  /**
   * Tag of the deleted image
   */
  @visibility(Lifecycle.Read)
  tagsDeleted?: string[];
}

/**
 * List of tag details
 */
model TagList {
  /**
   * Registry login server name. This is likely to be similar to
   * {registry-name}.azurecr.io.
   */
  registry: string;

  /**
   * Image name
   */
  imageName: string;

  /**
   * List of tag attribute details
   */
  @pageItems
  tags: TagAttributesBase[];

  @nextLink
  link?: string;
}

/**
 * Tag attribute details
 */
model TagAttributesBase {
  /**
   * Tag name
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Tag digest
   */
  @visibility(Lifecycle.Read)
  digest: string;

  /**
   * Tag created time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime: utcDateTime;

  /**
   * Tag last update time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime: utcDateTime;

  /**
   * Is signed
   */
  signed?: boolean;

  /**
   * Writeable properties of the resource
   */
  changeableAttributes: TagWriteableProperties;
}

/**
 * Changeable attributes
 */
model TagWriteableProperties {
  /**
   * Delete enabled
   */
  deleteEnabled?: boolean;

  /**
   * Write enabled
   */
  writeEnabled?: boolean;

  /**
   * List enabled
   */
  listEnabled?: boolean;

  /**
   * Read enabled
   */
  readEnabled?: boolean;
}

/**
 * Tag attributes
 */
model ArtifactTagProperties {
  /**
   * Registry login server name. This is likely to be similar to
   * {registry-name}.azurecr.io.
   */
  @visibility(Lifecycle.Read)
  registry: string;

  /**
   * Image name
   */
  @visibility(Lifecycle.Read)
  imageName: string;

  /**
   * List of tag attribute details
   */
  @visibility(Lifecycle.Read)
  tag: TagAttributesBase;
}

/**
 * Manifest attributes
 */
model AcrManifests {
  /**
   * Registry login server name. This is likely to be similar to
   * {registry-name}.azurecr.io.
   */
  registry?: string;

  /**
   * Image name
   */
  imageName?: string;

  /**
   * List of manifests
   */
  @pageItems
  manifests?: ManifestAttributesBase[];

  @nextLink
  link?: string;
}

/**
 * Manifest details
 */
model ManifestAttributesBase {
  /**
   * Manifest
   */
  @visibility(Lifecycle.Read)
  digest: string;

  /**
   * Image size
   */
  @visibility(Lifecycle.Read)
  imageSize?: int64;

  /**
   * Created time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime: utcDateTime;

  /**
   * Last update time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime: utcDateTime;

  /**
   * CPU architecture
   */
  @visibility(Lifecycle.Read)
  architecture?: ArtifactArchitecture;

  /**
   * Operating system
   */
  @visibility(Lifecycle.Read)
  os?: ArtifactOperatingSystem;

  /**
   * List of artifacts that are referenced by this manifest list, with information
   * about the platform each supports.  This list will be empty if this is a leaf
   * manifest and not a manifest list.
   */
  @visibility(Lifecycle.Read)
  references?: ArtifactManifestPlatform[];

  /**
   * Config blob media type
   */
  configMediaType?: string;

  /**
   * List of tags
   */
  @visibility(Lifecycle.Read)
  tags?: string[];

  /**
   * Writeable properties of the resource
   */
  changeableAttributes?: ManifestWriteableProperties;
}

/**
 * The artifact's platform, consisting of operating system and architecture.
 */
model ArtifactManifestPlatform {
  /**
   * Manifest digest
   */
  @visibility(Lifecycle.Read)
  digest: string;

  /**
   * CPU architecture
   */
  @visibility(Lifecycle.Read)
  architecture?: ArtifactArchitecture;

  /**
   * Operating system
   */
  @visibility(Lifecycle.Read)
  os?: ArtifactOperatingSystem;
}

/**
 * Changeable attributes
 */
model ManifestWriteableProperties {
  /**
   * Delete enabled
   */
  deleteEnabled?: boolean;

  /**
   * Write enabled
   */
  writeEnabled?: boolean;

  /**
   * List enabled
   */
  listEnabled?: boolean;

  /**
   * Read enabled
   */
  readEnabled?: boolean;
}

/**
 * Manifest attributes details
 */
model ArtifactManifestProperties {
  /**
   * Registry login server name. This is likely to be similar to
   * {registry-name}.azurecr.io.
   */
  @visibility(Lifecycle.Read)
  registry?: string;

  /**
   * Repository name
   */
  @visibility(Lifecycle.Read)
  imageName?: string;

  /**
   * Manifest attributes
   */
  @visibility(Lifecycle.Read)
  manifest: ManifestAttributesBase;
}

model AcrRefreshToken {
  /**
   * The refresh token to be used for generating access tokens
   */
  refresh_token?: string;
}

model AcrAccessToken {
  /**
   * The access token for performing authenticated requests
   */
  access_token?: string;
}

/**
 * Result of the request to list tags of the image
 */
model RepositoryTags {
  /**
   * Name of the image
   */
  name?: string;

  /**
   * List of tags
   */
  tags?: string[];
}

/**
 * Tag
 */
model TagAttributesTag {
  /**
   * SignatureRecord value
   */
  signatureRecord?: string;
}

/**
 * List of manifest attributes
 */
model ManifestAttributesManifest {
  /**
   * List of manifest attributes details
   */
  references?: ArtifactManifestPlatform[];
}

/**
 * Returns the requested Docker multi-arch-manifest file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManifestList extends Manifest {
  /**
   * Media type for this Manifest
   */
  mediaType?: string;

  /**
   * List of V2 image layer information
   */
  manifests?: ManifestListAttributes[];
}

/**
 * Returns the requested Docker V2 Manifest file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model V2Manifest extends Manifest {
  /**
   * Media type for this Manifest
   */
  mediaType?: string;

  /**
   * V2 image config descriptor
   */
  config?: Descriptor;

  /**
   * List of V2 image layer information
   */
  layers?: Descriptor[];
}

/**
 * Returns the requested OCI Manifest file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OCIManifest extends Manifest {
  /**
   * V2 image config descriptor
   */
  config?: Descriptor;

  /**
   * List of V2 image layer information
   */
  layers?: Descriptor[];

  /**
   * Additional information provided through arbitrary metadata.
   */
  annotations?: Annotations;
}

/**
 * Returns the requested OCI index file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OCIIndex extends Manifest {
  /**
   * List of OCI image layer information
   */
  manifests?: ManifestListAttributes[];

  /**
   * Additional information provided through arbitrary metadata.
   */
  annotations?: Annotations;
}

/**
 * Returns the requested V1 manifest file
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model V1Manifest extends Manifest {
  /**
   * CPU architecture
   */
  architecture?: string;

  /**
   * Image name
   */
  name?: string;

  /**
   * Image tag
   */
  tag?: string;

  /**
   * List of layer information
   */
  fsLayers?: FsLayer[];

  /**
   * Image history
   */
  history?: History[];

  /**
   * Image signature
   */
  signatures?: ImageSignature[];
}

model Paths108HwamOauth2ExchangePostRequestbodyContentApplicationXWwwFormUrlencodedSchema {
  /**
   * Can take a value of access_token_refresh_token, or access_token, or
   * refresh_token
   */
  grant_type: PostContentSchemaGrantType;

  /**
   * Indicates the name of your Azure container registry.
   */
  service: string;

  /**
   * AAD tenant associated to the AAD credentials.
   */
  tenant?: string;

  /**
   * AAD refresh token, mandatory when grant_type is access_token_refresh_token or
   * refresh_token
   */
  refresh_token?: string;

  /**
   * AAD access token, mandatory when grant_type is access_token_refresh_token or
   * access_token.
   */
  access_token?: string;
}

model PathsV3R3RxOauth2TokenPostRequestbodyContentApplicationXWwwFormUrlencodedSchema {
  /**
   * Indicates the name of your Azure container registry.
   */
  service: string;

  /**
   * Which is expected to be a valid scope, and can be specified more than once for
   * multiple scope requests. You obtained this from the Www-Authenticate response
   * header from the challenge.
   */
  scope: string;

  /**
   * Must be a valid ACR refresh token
   */
  refresh_token: string;

  /**
   * Grant type is expected to be refresh_token
   */
  grant_type: TokenGrantType;
}
