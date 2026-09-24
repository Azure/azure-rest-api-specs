using Rest;

namespace ContainerAppsSandbox {
  /** A binary content package available to sandboxes in a sandbox group. */
  @resource("contentpackages")
  @parentResource(SandboxGroupScope)
  model ContentPackage {
    /** The content package identifier. */
    @key("id")
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    id: ContentPackageId;

    /** The package size in bytes. */
    size: int64;

    /** Customer-defined labels for the package. */
    labels: Record<string>;

    /** The media type of the uploaded content. */
    contentType?: string;

    /** The time when the package was created. */
    createdOn?: utcDateTime;
  }
}
