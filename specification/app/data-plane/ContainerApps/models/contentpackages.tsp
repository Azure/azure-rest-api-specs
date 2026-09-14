#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
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
