using Rest;

namespace ContainerAppsSandbox {
  /** Content-package list response body. */
  model ContentPackageListResponse {
    /** Content packages returned by the request. */
    @pageItems
    value: ContentPackage[];

    /** Link to the next page of content packages, if one is available. */
    @nextLink
    nextLink?: string;
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
