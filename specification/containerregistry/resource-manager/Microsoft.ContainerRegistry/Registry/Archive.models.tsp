using Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The type of package source for a archive.
 */
union PackageSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remote: "remote",
}

/**
 * The properties of the Debian package Archive.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DebianArchiveProperties extends ArchiveProperties {
  /**
   * Debian distribution Name.
   */
  distributionName?: string;
}

/**
 * The properties of the archive package source.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DebianArchivePackageSourceProperties
  extends ArchivePackageSourceProperties {
  /**
   * Upstream Debian distribution Name.
   */
  distributionName?: string;
}

/**
 * The properties of a archive.
 */
@added(Versions.vLatestPreview)
model ArchiveProperties {
  /**
   * The package source of the archive.
   */
  packageSource?: ArchivePackageSourceProperties;

  /**
   * The published version of the archive.
   */
  publishedVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repositoryEndpointPrefix?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  repositoryEndpoint?: string;

  /**
   * The provisioning state of the archive at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of the archive package source.
 */
@added(Versions.vLatestPreview)
model ArchivePackageSourceProperties {
  /**
   * The type of package source for a archive.
   */
  type?: PackageSourceType;

  /**
   * The external repository url.
   */
  url?: string;
}

/**
 * The parameters for updating a archive.
 */
@added(Versions.vLatestPreview)
model ArchiveUpdateParameters {
  /**
   * The properties of the connected registry update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ArchiveUpdateProperties;
}

/**
 * The properties of a package type.
 */
model PackageType {
  /**
   * The name of the package type.
   */
  name?: string;

  /**
   * The endpoint of the package type.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The properties of a archive.
 */
model ArchiveUpdateProperties {
  /**
   * The published version of the archive.
   */
  publishedVersion?: string;
}

/**
 * The result of a request to list archives for a container registry.
 */
@added(Versions.vLatestPreview)
model ArchiveListResult {
  /**
   * The list of archives. Since this list may be incomplete, the nextLink field should be used to request the next list of archives.
   */
  @pageItems
  value?: Archive[];

  /**
   * The URI that can be used to request the next list of archives.
   */
  @nextLink
  nextLink?: string;
}
