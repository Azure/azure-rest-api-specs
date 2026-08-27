namespace AzureDevCompute {
  /** ContentPackageListResponse wire model. */
  model ContentPackageListResponse {
    /** value value. */
    value: ContentPackageResponse[];
  }

  /** ContentPackageResponse wire model. */
  model ContentPackageResponse {
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
