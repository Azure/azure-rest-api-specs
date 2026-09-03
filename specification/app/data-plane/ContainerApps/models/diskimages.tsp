#suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire property names are preserved from the source contract; C# names can be customized separately in client.tsp."
namespace ContainerAppsSandbox {
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

  /** ContainerImageUrlWithTag wire model. */
  scalar ContainerImageUrlWithTag extends string;

  /** CreateDiskImageContent wire model. */
  model CreateDiskImageContent {
    /** source value. */
    source: CreateDiskImageSource;

    /** name value. */
    name?: string;

    /** labels value. */
    labels?: Record<string>;

    /** vnetConnectionName value. */
    vnetConnectionName?: string;
  }

  /** The supported disk image source types. */
  union CreateDiskImageSourceKind {
    string,

    /** A container registry source. */
    Registry: "registry",

    /** A blob source. */
    Blob: "blob",
  }

  /** CreateDiskImageSource wire model. */
  @discriminator("kind")
  model CreateDiskImageSource {
    /** The disk image source type. */
    kind: CreateDiskImageSourceKind;
  }

  /** CreateDiskImageSourceBlobSource wire model. */
  model CreateDiskImageSourceBlobSource extends CreateDiskImageSource {
    /** The blob source type. */
    kind: "blob";

    /** blobSourceUri value. */
    blobSourceUri: BlobUri;
  }

  /** CreateDiskImageSourceRegistrySource wire model. */
  model CreateDiskImageSourceRegistrySource extends CreateDiskImageSource {
    /** The container registry source type. */
    kind: "registry";

    /** imageUrl value. */
    imageUrl: ContainerImageUrlWithTag;

    /** registryCredentials value. */
    registryCredentials?: RegistryCredentials;

    /** managedIdentityClientId value. */
    managedIdentityClientId?: string;
  }

  /** DiskImageOperationResult wire model. */
  model DiskImageOperationResult {
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
    diskImage?: DiskImage;

    /** createdAt value. */
    createdAt: utcDateTime;

    /** updatedAt value. */
    updatedAt: utcDateTime;
  }

  /** PublicDiskImage wire model. */
  model PublicDiskImage {
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

  /** DiskImage wire model. */
  model DiskImage {
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
