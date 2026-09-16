using Rest;

namespace ContainerAppsSandbox {
  /** Content-package list response body. */
  model ContentPackageListResponse {
    /** value value. */
    value: ContentPackage[];
  }

  /** ContentPackage wire model. */
  @resource("contentpackages")
  @parentResource(SandboxGroupScope)
  model ContentPackage {
    /** id value. */
    @key("id")
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    id: ContentPackageId;

    /** size value. */
    size: int64;

    /** labels value. */
    labels: Record<string>;

    /** contentType value. */
    contentType?: string;

    /** createdOn value. */
    createdOn?: utcDateTime;
  }
}
