using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire property names are preserved from the source contract; C# names can be customized separately in client.tsp."
namespace AzureDevCompute {
  /** AsyncOperationId wire model. */
  scalar AsyncOperationId extends string;

  /** Status of an asynchronous operation. IMPORTANT: Always use explicit integer values. Never reorder or reassign existing values. */
  @Azure.Core.lroStatus
  union AsyncOperationStatus {
    /** StringValue variant. */
    StringValue: string,

    /** Pending variant. */
    Pending: "Pending",

    /** InProgress variant. */
    InProgress: "InProgress",

    /** Succeeded variant. */
    @Azure.Core.lroSucceeded
    Succeeded: "Succeeded",

    /** Failed variant. */
    @Azure.Core.lroFailed
    Failed: "Failed",
  }

  /** A strongly-typed blob URI (with or without SAS token). */
  scalar BlobUri extends string;

  /** BuildDiskImageFromDockerfileRequest wire model. */
  @removed(ApiVersions.v2026_09_01)
  model BuildDiskImageFromDockerfileRequest {
    /** name value. */
    @removed(ApiVersions.v2026_09_01)
    name: string;

    /** dockerfile value. */
    @removed(ApiVersions.v2026_09_01)
    dockerfile: string;

    /** vmmType value. */
    @removed(ApiVersions.v2026_09_01)
    vmmType?: VmmType;

    /** labels value. */
    @removed(ApiVersions.v2026_09_01)
    labels?: Record<string>;

    /** buildArgs value. */
    @removed(ApiVersions.v2026_09_01)
    buildArgs?: Record<string>;

    /** secrets value. */
    @removed(ApiVersions.v2026_09_01)
    secrets?: Record<string>;

    /** contextContentPackageId value. */
    @removed(ApiVersions.v2026_09_01)
    contextContentPackageId?: ContentPackageId;
  }

  /** ContainerImageUrlWithTag wire model. */
  scalar ContainerImageUrlWithTag extends string;

  /** CreateDiskImageRequest wire model. */
  @added(ApiVersions.v2026_09_01)
  model CreateDiskImageRequest {
    /** source value. */
    @added(ApiVersions.v2026_09_01)
    source: CreateDiskImageSource;

    /** name value. */
    @added(ApiVersions.v2026_09_01)
    name?: string;

    /** labels value. */
    @added(ApiVersions.v2026_09_01)
    labels?: Record<string>;

    /** vnetConnectionName value. */
    @added(ApiVersions.v2026_09_01)
    vnetConnectionName?: string;
  }

  /** The supported disk image source types. */
  @added(ApiVersions.v2026_09_01)
  union CreateDiskImageSourceKind {
    string,

    /** A container registry source. */
    Registry: "registry",

    /** A blob source. */
    Blob: "blob",
  }

  /** CreateDiskImageSource wire model. */
  @added(ApiVersions.v2026_09_01)
  @discriminator("kind")
  model CreateDiskImageSource {
    /** The disk image source type. */
    @added(ApiVersions.v2026_09_01)
    kind: CreateDiskImageSourceKind;
  }

  /** CreateDiskImageSourceBlobSource wire model. */
  @added(ApiVersions.v2026_09_01)
  model CreateDiskImageSourceBlobSource extends CreateDiskImageSource {
    /** The blob source type. */
    @added(ApiVersions.v2026_09_01)
    kind: "blob";

    /** blobSourceUri value. */
    @added(ApiVersions.v2026_09_01)
    blobSourceUri: BlobUri;
  }

  /** CreateDiskImageSourceRegistrySource wire model. */
  @added(ApiVersions.v2026_09_01)
  model CreateDiskImageSourceRegistrySource extends CreateDiskImageSource {
    /** The container registry source type. */
    @added(ApiVersions.v2026_09_01)
    kind: "registry";

    /** imageUrl value. */
    @added(ApiVersions.v2026_09_01)
    imageUrl: ContainerImageUrlWithTag;

    /** registryCredentials value. */
    @added(ApiVersions.v2026_09_01)
    registryCredentials?: RegistryCredentials;

    /** managedIdentityClientId value. */
    @added(ApiVersions.v2026_09_01)
    managedIdentityClientId?: string;
  }

  /** CreateDiskImageV2Request wire model. */
  @removed(ApiVersions.v2026_09_01)
  model CreateDiskImageV2Request {
    /** source value. */
    @removed(ApiVersions.v2026_09_01)
    source: CreateDiskImageV2Source;

    /** name value. */
    @removed(ApiVersions.v2026_09_01)
    name?: string;

    /** vmmType value. */
    @removed(ApiVersions.v2026_09_01)
    vmmType?: VmmType;

    /** labels value. */
    @removed(ApiVersions.v2026_09_01)
    labels?: Record<string>;

    /** vnetConnectionName value. */
    @removed(ApiVersions.v2026_09_01)
    vnetConnectionName?: string;

    /** customerVnetConnectionName value. */
    @removed(ApiVersions.v2026_09_01)
    customerVnetConnectionName?: string;
  }

  /** The supported V2 disk image source types. */
  @removed(ApiVersions.v2026_09_01)
  union CreateDiskImageV2SourceKind {
    string,

    /** A container registry source. */
    Registry: "registry",

    /** A blob source. */
    Blob: "blob",

    /** A Dockerfile source. */
    Dockerfile: "dockerfile",
  }

  /** CreateDiskImageV2Source wire model. */
  @removed(ApiVersions.v2026_09_01)
  @discriminator("kind")
  model CreateDiskImageV2Source {
    /** The V2 disk image source type. */
    @removed(ApiVersions.v2026_09_01)
    kind: CreateDiskImageV2SourceKind;
  }

  /** CreateDiskImageV2SourceBlobSource wire model. */
  @removed(ApiVersions.v2026_09_01)
  model CreateDiskImageV2SourceBlobSource extends CreateDiskImageV2Source {
    /** The blob source type. */
    @removed(ApiVersions.v2026_09_01)
    kind: "blob";

    /** blobSourceUri value. */
    @removed(ApiVersions.v2026_09_01)
    blobSourceUri: BlobUri;
  }

  /** CreateDiskImageV2SourceDockerfileSource wire model. */
  @removed(ApiVersions.v2026_09_01)
  model CreateDiskImageV2SourceDockerfileSource
    extends CreateDiskImageV2Source {
    /** The Dockerfile source type. */
    @removed(ApiVersions.v2026_09_01)
    kind: "dockerfile";

    /** dockerfileContent value. */
    @removed(ApiVersions.v2026_09_01)
    dockerfileContent: string;

    /** buildArgs value. */
    @removed(ApiVersions.v2026_09_01)
    buildArgs: Record<string>;

    /** secrets value. */
    @removed(ApiVersions.v2026_09_01)
    secrets: Record<string>;

    /** A strongly-typed blob URI (with or without SAS token). */
    @removed(ApiVersions.v2026_09_01)
    contextBlobUri?: string;

    /** contextContentPackageId value. */
    @removed(ApiVersions.v2026_09_01)
    contextContentPackageId?: string;
  }

  /** CreateDiskImageV2SourceRegistrySource wire model. */
  @removed(ApiVersions.v2026_09_01)
  model CreateDiskImageV2SourceRegistrySource extends CreateDiskImageV2Source {
    /** The container registry source type. */
    @removed(ApiVersions.v2026_09_01)
    kind: "registry";

    /** imageUrl value. */
    @removed(ApiVersions.v2026_09_01)
    imageUrl: ContainerImageUrlWithTag;

    /** isPlatformImage value. */
    @removed(ApiVersions.v2026_09_01)
    isPlatformImage?: boolean;

    /** registryCredentials value. */
    @removed(ApiVersions.v2026_09_01)
    registryCredentials?: RegistryCredentials;

    /** managedIdentityClientId value. */
    @removed(ApiVersions.v2026_09_01)
    managedIdentityClientId?: string;
  }

  /** DiskImageOperationResponse wire model. */
  model DiskImageOperationResponse {
    /** operationId value. */
    @Azure.Core.pollingOperationParameter("operationId")
    operationId: AsyncOperationId;

    /** status value. */
    status: AsyncOperationStatus;

    /** errorMessage value. */
    @Azure.Core.lroErrorResult
    errorMessage?: string;

    /** diskImage value. */
    @Azure.Core.lroResult
    diskImage?: DiskImageResponse;

    /** createdAt value. */
    createdAt: utcDateTime;

    /** updatedAt value. */
    updatedAt: utcDateTime;
  }

  /** DiskImageRequest wire model. */
  @removed(ApiVersions.v2026_09_01)
  model DiskImageRequest {
    /** name value. */
    @removed(ApiVersions.v2026_09_01)
    name?: string;

    /** labels value. */
    @removed(ApiVersions.v2026_09_01)
    labels?: Record<string>;

    /** vmmType value. */
    @removed(ApiVersions.v2026_09_01)
    vmmType?: VmmType;

    /** image value. */
    @removed(ApiVersions.v2026_09_01)
    image: DiskImageImage;

    /** registryCredentials value. */
    @removed(ApiVersions.v2026_09_01)
    registryCredentials?: RegistryCredentials;
  }

  /** PublicDiskImageResponse wire model. */
  model PublicDiskImageResponse {
    /** name value. */
    name: string;

    /** status value. */
    status: DiskImageStatus;
  }

  /** RegistryCredentials wire model. */
  model RegistryCredentials {
    /** username value. */
    username: string;

    /** token value. */
    token: string;
  }

  /** DiskImageResponse wire model. */
  model DiskImageResponse {
    /** id value. */
    id: DiskImageId;

    /** name value. */
    name?: string;

    /** labels value. */
    labels: Record<string>;

    /** image value. */
    image: DiskImageImage;

    /** status value. */
    status: DiskImageStatus;

    /** sizeInMB value. */
    @encodedName("application/json", "sizeInMB")
    sizeInMb?: MegaBytes;

    /** dockerfileContent value. */
    @removed(ApiVersions.v2026_09_01)
    dockerfileContent?: string;
  }

  /** DiskImageStatus wire model. */
  model DiskImageStatus {
    /** state value. */
    state: string;

    /** errorMessage value. */
    errorMessage?: string;

    /** createdAt value. */
    createdAt: utcDateTime;

    /** updatedAt value. */
    updatedAt: utcDateTime;
  }

  /** DiskImageImage wire model. */
  model DiskImageImage {
    /** base value. */
    base: string;

    /** entrypoint value. */
    entrypoint?: string[];

    /** cmd value. */
    cmd?: string[];
  }
}
