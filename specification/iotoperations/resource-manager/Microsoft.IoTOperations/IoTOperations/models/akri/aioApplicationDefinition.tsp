import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

/** AioApplicationProfile resource. */
@parentResource(InstanceResource)
@added(Versions.`2026-11-01-preview`)
model AioApplicationProfileResource
  is ProxyResource<AioApplicationDefinitionProperties> {
  /** Name of the AioApplicationProfile resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioApplicationProfileName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriApplicationProfiles")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** AioApplicationDefinition resource. */
@parentResource(InstanceResource)
@added(Versions.`2026-11-01-preview`)
model AioApplicationDefinitionResource
  is ProxyResource<AioApplicationDefinitionProperties> {
  /** Name of the AioApplicationDefinition resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioApplicationDefinitionName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("aioApplicationDefinitions")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** Defines an application image and the constraints under which it runs. */
@added(Versions.`2026-11-01-preview`)
@renamedFrom(Versions.`2026-11-01-preview`, "AioApplicationProfileProperties")
model AioApplicationDefinitionProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The AIO version range supported by the application image. */
  aioMetadata?: AioApplicationDefinitionMetadata;

  /** A reference to the application metadata document in a container registry. */
  applicationMetadataRef: string;

  /** The image and the settings used to resolve and pull it. */
  imageDetails: AioApplicationDefinitionImage;

  /** The source of the application deployment. This value cannot be changed after creation. */
  @added(Versions.`2026-11-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  applicationSource: AioApplicationSource;

  /** The application type. Connector configurations require a parent definition with applicationType set to connector. This value cannot be changed after creation. */
  @added(Versions.`2026-11-01-preview`)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  applicationType: AioApplicationType;

  /** The compute resources for the application container. */
  resources?: AioApplicationDefinitionResources;
}

/** The source of an application deployment. */
@added(Versions.`2026-11-01-preview`)
union AioApplicationSource {
  string,

  /** An application deployed from Azure Marketplace. */
  Marketplace: "Marketplace",

  /** An application defined by the user. */
  UserDefined: "UserDefined",
}

/** The type of application defined by an application definition. */
@added(Versions.`2026-11-01-preview`)
union AioApplicationType {
  string,

  /** An AIO application. */
  AioApplication: "AioApplication",

  /** A connector application. */
  Connector: "Connector",
}

/** AIO version metadata for the application image. */
@added(Versions.`2026-11-01-preview`)
@renamedFrom(Versions.`2026-11-01-preview`, "AioApplicationProfileMetadata")
model AioApplicationDefinitionMetadata {
  ...AkriAioMetadata;
}

/** Image settings for the application. */
@added(Versions.`2026-11-01-preview`)
@renamedFrom(Versions.`2026-11-01-preview`, "AioApplicationProfileImage")
model AioApplicationDefinitionImage {
  /** The image name without any registry reference, tag, or digest. */
  imageName: string;

  /** The registry settings for the image. You can omit this field if using the default docker hub repository or using a local image. */
  registrySettings?: AkriConnectorsRegistrySettings;

  /** Optional image tag or digest. If not specified, the default tag is `latest`. */
  tagDigestSettings?: AkriConnectorsTagDigestSettings;
}

/** Compute resources for the application container. */
@added(Versions.`2026-11-01-preview`)
@renamedFrom(Versions.`2026-11-01-preview`, "AioApplicationProfileResources")
model AioApplicationDefinitionResources {
  /** The minimum compute resources reserved for the application container. */
  @typeChangedFrom(
    Versions.`2026-11-01-preview`,
    AioApplicationDefinitionResourceRequirements
  )
  requests?: AioApplicationResourceQuantities;
}

/** CPU and memory requirements for the application container. */
@added(Versions.`2026-11-01-preview`)
@removed(Versions.`2026-11-01-preview`)
@renamedFrom(
  Versions.`2026-11-01-preview`,
  "AioApplicationProfileResourceRequirements"
)
model AioApplicationDefinitionResourceRequirements {
  /** The CPU quantity in cores or thousandths of a core, such as `1` or `250m`. */
  cpu?: string;

  /** The memory quantity, such as `512Mi` or `1Gi`. */
  memory?: string;
}
