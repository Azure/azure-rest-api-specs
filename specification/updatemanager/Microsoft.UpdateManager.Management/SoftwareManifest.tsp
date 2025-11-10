import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.UpdateManager;

@doc("Software Manifest resource representing a software definition within a collection.")
@added(Versions.v2025_08_01_preview)
@parentResource(SoftwareCollection)
model SoftwareManifest is TrackedResource<SoftwareManifestProperties> {
  @doc("Name of the software manifest")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("softwareManifestName")
  @segment("softwareManifests")
  name: string;
}

@doc("Properties of the SoftwareManifest resource.")
@added(Versions.v2025_08_01_preview)
@discriminator("softwarekind")
model SoftwareManifestProperties {
  @doc("Software kind.")
  softwarekind: SoftwareKind;

  @doc("Collection ID reference.")
  @visibility(Lifecycle.Read)
  collectionId?: string;

  @doc("Provisioning state of the software manifest.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Manual software manifest properties.")
@added(Versions.v2025_08_01_preview)
model ManualSoftwareManifestProperties extends SoftwareManifestProperties {
  @doc("The kind of software definition.")
  softwarekind: SoftwareKind.Manual;

  @doc("Name of the software.")
  softwareName: string;

  @doc("Publisher of the software.")
  publisher: string;

  @doc("Unique identifier for the software.")
  softwareId: string;

  @doc("Operating system type for the software.")
  osType: OSType;

  @doc("List of software versions.")
  @identifiers(#["version"])
  versions?: SoftwareVersion[];
}

@doc("Software kind enumeration.")
@added(Versions.v2025_08_01_preview)
union SoftwareKind {
  string,

  @doc("Manual software definition")
  Manual: "Manual",
}

@doc("Software version information.")
@added(Versions.v2025_08_01_preview)
model SoftwareVersion {
  @doc("Version string of the software.")
  version: string;

  @doc("List of installers for this version.")
  @identifiers(#["architecture"])
  installers: SoftwareInstaller[];
}

@doc("Software installer information.")
@added(Versions.v2025_08_01_preview)
model SoftwareInstaller {
  @doc("Architecture of the installer.")
  architecture: string;

  @doc("Media link URL for the installer.")
  mediaLink: string;

  @doc("Product code for the installer.")
  productCode?: string;

  @doc("Upgrade code for the installer.")
  upgradeCode?: string;

  @doc("Package family name for the installer.")
  packageFamilyName?: string;

  @doc("Installation settings for the installer.")
  settings?: InstallerSettings;
}

@doc("Installer settings configuration.")
@added(Versions.v2025_08_01_preview)
model InstallerSettings {
  @doc("Script for installation instructions.")
  installScript: string;

  @doc("File name to set when downloaded in VM.")
  softwareFileName?: string;
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface SoftwareManifests {
  get is ArmResourceRead<SoftwareManifest>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SoftwareManifest>;
  update is ArmTagsPatchAsync<SoftwareManifest>;
  delete is ArmResourceDeleteWithoutOkAsync<SoftwareManifest>;
  listByParent is ArmResourceListByParent<SoftwareManifest>;
}
