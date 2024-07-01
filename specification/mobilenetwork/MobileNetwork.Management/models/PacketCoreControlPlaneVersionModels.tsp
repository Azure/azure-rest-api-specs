import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("The state of this packet core control plane version.")
union VersionState {
  @doc("The state of this version is unknown.")
  Unknown: "Unknown",

  @doc("This version is a preview and is not suitable for production use.")
  Preview: "Preview",

  @doc("This version is currently being validated.")
  Validating: "Validating",

  @doc("This version failed validation.")
  ValidationFailed: "ValidationFailed",

  @doc("This version is active and suitable for production use.")
  Active: "Active",

  @doc("This version is deprecated and is no longer supported.")
  Deprecated: "Deprecated",

  string,
}

@doc("Indicates whether this is the recommended version to use for new packet core control plane deployments.")
union RecommendedVersion {
  @doc("This is the recommended version to use for new packet core control plane deployments.")
  Recommended: "Recommended",

  @doc("This is not the recommended version to use for new packet core control plane deployments.")
  NotRecommended: "NotRecommended",

  string,
}

@doc("Indicates whether this version is obsolete.")
union ObsoleteVersion {
  @doc("This version is obsolete for use in new packet core control plane deployments.")
  Obsolete: "Obsolete",

  @doc("This version is not obsolete for use in new packet core control plane deployments.")
  NotObsolete: "NotObsolete",

  string,
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
