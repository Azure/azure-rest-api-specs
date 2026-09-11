namespace ContainerAppsSandbox {
  /** Content-package list response body. */
  model ContentPackageListResponse {
    /** value value. */
    value: ContentPackage[];
  }

  /** ContentPackage wire model. */
  model ContentPackage {
    /** id value. */
    id: ContentPackageId;

    /** size value. */
    size: Bytes;

    /** labels value. */
    labels: Record<string>;

    /** contentType value. */
    contentType?: string;

    /** createdOn value. */
    createdOn?: utcDateTime;
  }
}
