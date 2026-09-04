#suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire property names are preserved from the source contract; C# names can be customized separately in client.tsp."
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
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
    @secret
    blobSourceUri: BlobUri;
  }

  /** CreateDiskImageSourceRegistrySource wire model. */
  model CreateDiskImageSourceRegistrySource extends CreateDiskImageSource {
    /** The container registry source type. */
    kind: "registry";

    /** imageUrl value. */
    imageUrl: ContainerImageUrlWithTag;

    /** Authentication used to access the registry. */
    authentication?: RegistryAuthentication;
  }

  /** Registry authentication options. Exactly one option must be supplied. */
  model RegistryAuthentication {
    /** Username and token authentication. */
    @secret
    registryCredentials?: RegistryCredentials;

    /** Managed identity authentication. */
    identity?: ManagedIdentityAuthentication;
  }

  /** Disk-image operation response body. */
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

  /** Request body for creating a disk image. */
  model CreateDiskImageContent {
    /** Source used to create the disk image. */
    source: CreateDiskImageSource;

    /** Disk image name. */
    name?: string;

    /** Customer-defined labels. */
    labels?: Record<string>;

    /** VNet connection used while creating the disk image. */
    vnetConnectionName?: string;
  }

  /** Customer-facing disk image resource returned by the service. */
  model DiskImage {
    /** Disk image identifier assigned by the service. */
    @visibility(Lifecycle.Read)
    id: DiskImageId;

    /** Disk image name. */
    name?: string;

    /** Customer-defined labels. */
    labels: Record<string>;

    /** Resolved image metadata assigned by the service. */
    @visibility(Lifecycle.Read)
    image: DiskImageImage;

    /** Current disk-image status. */
    @visibility(Lifecycle.Read)
    status: DiskImageStatus;

    /** Disk-image size assigned by the service. */
    @visibility(Lifecycle.Read)
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
