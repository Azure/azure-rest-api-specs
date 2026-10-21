using Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The properties of an archive version.
 */
@added(Versions.vLatestPreview)
model ArchiveVersionProperties {
  /**
   * The provisioning state of the archive at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The detailed error message for the archive version in the case of failure.
   */
  archiveVersionErrorMessage?: string;
}

/**
 * The result of a request to list archive versions for a container registry.
 */
@added(Versions.vLatestPreview)
model ArchiveVersionListResult {
  /**
   * The list of archive versions. Since this list may be incomplete, the nextLink field should be used to request the next list of archive versions.
   */
  @pageItems
  value?: ArchiveVersion[];

  /**
   * The URI that can be used to request the next list of archive versions.
   */
  @nextLink
  nextLink?: string;
}
