using Rest;

namespace ContainerAppsSandbox {
  /** A container image reference including an optional registry and tag. */
  scalar ContainerImageUrlWithTag extends string;

  /** The supported disk image source types. */
  union CreateDiskImageSourceKind {
    string,

    /** A container registry source. */
    Registry: "registry",

    /** A blob source. */
    Blob: "blob",
  }

  /** The source used to create a disk image. */
  @discriminator("kind")
  model CreateDiskImageSource {
    /** The disk image source type. */
    kind: CreateDiskImageSourceKind;
  }

  /** A disk image source stored in Azure Blob Storage. */
  model CreateDiskImageSourceBlobSource extends CreateDiskImageSource {
    /** The blob source type. */
    kind: "blob";

    /** A URI that grants access to the source blob. */
    @secret
    blobSourceUri: url;
  }

  /** A disk image source pulled from a container registry. */
  model CreateDiskImageSourceRegistrySource extends CreateDiskImageSource {
    /** The container registry source type. */
    kind: "registry";

    /** The container image reference to import. */
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

  /** A service-managed disk image shared across sandbox groups. */
  @resource("diskimages/public")
  @parentResource(SandboxGroupScope)
  model PublicDiskImage {
    /** The public image name. */
    @key("name")
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    name: string;

    /** The current status of the public image. */
    status: DiskImageStatus;
  }

  /** Username and token credentials for a container registry. */
  model RegistryCredentials {
    /** The registry username. */
    username: string;

    /** The registry access token or password. */
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
  @resource("diskimages")
  @parentResource(SandboxGroupScope)
  model DiskImage {
    /** Disk image identifier assigned by the service. */
    @key("id")
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
    sizeInMb?: int64;
  }

  /** The provisioning status of a disk image. */
  model DiskImageStatus {
    /** The current provisioning state. */
    state: string;

    /** The failure message when provisioning did not succeed. */
    errorMessage?: string;

    /** The time when provisioning started. */
    createdAt: utcDateTime;

    /** The time when the status was last updated. */
    updatedAt: utcDateTime;
  }

  /** Resolved container image metadata for a disk image. */
  model DiskImageImage {
    /** The resolved base image reference. */
    base: string;

    /** The container entrypoint. */
    entrypoint?: string[];

    /** The default command arguments. */
    cmd?: string[];
  }
}
