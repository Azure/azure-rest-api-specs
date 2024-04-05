import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("The state of this packet core control plane version.")
enum VersionState {
  @doc("The state of this version is unknown.")
  Unknown,

  @doc("This version is a preview and is not suitable for production use.")
  Preview,

  @doc("This version is currently being validated.")
  Validating,

  @doc("This version failed validation.")
  ValidationFailed,

  @doc("This version is active and suitable for production use.")
  Active,

  @doc("This version is deprecated and is no longer supported.")
  Deprecated,
}

@doc("Indicates whether this is the recommended version to use for new packet core control plane deployments.")
enum RecommendedVersion {
  @doc("This is the recommended version to use for new packet core control plane deployments.")
  Recommended,

  @doc("This is not the recommended version to use for new packet core control plane deployments.")
  NotRecommended,
}

@doc("Indicates whether this version is obsolete.")
enum ObsoleteVersion {
  @doc("This version is obsolete for use in new packet core control plane deployments.")
  Obsolete,

  @doc("This version is not obsolete for use in new packet core control plane deployments.")
  NotObsolete,
}

@doc("Packet core control plane version properties.")
model PacketCoreControlPlaneVersionPropertiesFormat {
  @doc("The provisioning state of the packet core control plane version resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Platform specific packet core control plane version properties.")
  @extension("x-ms-identifiers", ["platformType"])
  platforms?: Platform[];
}

@doc("Platform specific packet core control plane version properties.")
model Platform {
  @doc("The platform type where this version can be deployed.")
  platformType?: PlatformType;

  @doc("The state of this packet core control plane version on this platform.")
  versionState?: VersionState;

  @doc("The minimum software version of the platform where this packet core version can be deployed.")
  minimumPlatformSoftwareVersion?: string;

  @doc("The maximum software version of the platform where this packet core version can be deployed.")
  maximumPlatformSoftwareVersion?: string;

  @doc("Indicates whether this is the recommended version for this platform.")
  recommendedVersion?: RecommendedVersion;

  @doc("Indicates whether this version is obsoleted for this platform.")
  obsoleteVersion?: ObsoleteVersion;
}
