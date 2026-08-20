using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** Specifies how a content package should be delivered to the container. */
union ContentPackageAction {
  "Download",
  "Mount",
}

scalar ContentPackageId;

model ContentPackageListResponseView {
  value: ContentPackageResponseView[];
}

model ContentPackageResponseView {
  id: ContentPackageId;
  size: Bytes;
  labels: Record<string>;
  contentType?: null | string;
  createdOn?: null | utcDateTime;
}

model DownloadContentPackageToSandboxRequestView {
  contentPackageId: ContentPackageId;
  targetPath: AbsoluteFilePath;
}

/**
 * Pod-level content package declaration. Declares a content package that the pod uses.
 * Per-container downloads reference content packages by ContentPackageId GlobalPodContentPackageView.ContentPackageId.
 */
model PodContentPackageView {
  contentPackageId: ContentPackageId;
}

/** Represents a content package to be downloaded onto a sandbox during creation. */
model SandboxContentPackageDownloadView {
  /** The content package ID to download. */
  contentPackageId: ContentPackageId;

  /**
   * The target path in the sandbox where the content package will be downloaded.
   * Must be an absolute path. Parent directories will be created if they don't exist.
   */
  targetPath: AbsoluteFilePath;

  /**
   * How the content package should be delivered: Download (default) or Mount.
   * Mount presents the package contents as a read-only FUSE filesystem at the target path.
   * Currently only supported for zip content packages.
   */
  action?: ContentPackageAction;
}
