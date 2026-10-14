import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./aioApplicationConfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

/**
 * AioConnectorApplicationConfiguration resource.
 */
@parentResource(AioApplicationProfileResource)
@added(Versions.`2026-11-01-preview`)
model AioConnectorApplicationConfigurationResource
  is ProxyResource<AioConnectorApplicationConfigurationProperties> {
  /** Name of the AioConnectorApplicationConfiguration resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioConnectorApplicationConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriConnectorApplicationConfigurations")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/**
 * AioConnectorConfiguration resource. The parent AioApplicationDefinition must
 * have applicationType set to connector.
 */
@parentResource(AioApplicationDefinitionResource)
@added(Versions.`2026-11-01-preview`)
model AioConnectorConfigurationResource
  is ProxyResource<AioConnectorConfigurationProperties> {
  /** Name of the AioConnectorConfiguration resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioConnectorConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("aioConnectorConfigurations")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/**
 * Defines the customer-owned operational configuration for an application.
 */
@added(Versions.`2026-11-01-preview`)
model AioConnectorApplicationConfigurationProperties {
  ...AioApplicationConfigurationProperties;

  /** The device inbound endpoints served by the application and their allocation. */
  deviceConfiguration: AioConnectorApplicationDeviceConfiguration;
}

/**
 * Defines the customer-owned operational configuration for a connector application.
 */
@added(Versions.`2026-11-01-preview`)
model AioConnectorConfigurationProperties {
  ...AioApplicationConfigurationProperties;

  /** The device inbound endpoints served by the application and their allocation. */
  deviceConfiguration: AioConnectorApplicationDeviceConfiguration;
}

/** Device inbound endpoints and allocation settings for the application. */
@added(Versions.`2026-11-01-preview`)
model AioConnectorApplicationDeviceConfiguration {
  /** How device inbound endpoints are distributed across application instances. */
  allocation: AioConnectorApplicationAllocation;

  /** The device inbound endpoint types served by the application. */
  @identifiers(#["endpointType", "version"])
  @minItems(1)
  deviceInboundEndpointTypes: AioConnectorApplicationDeviceInboundEndpointType[];
}

/** A device inbound endpoint type served by the application. */
@added(Versions.`2026-11-01-preview`)
model AioConnectorApplicationDeviceInboundEndpointType {
  /** The display name of the device inbound endpoint. */
  displayName?: string;

  /** The type of the device inbound endpoint. */
  endpointType: NonEmptyString;

  /** The version of the device inbound endpoint. */
  version?: NonEmptyString;
}

/** Allocation settings for application device inbound endpoints. */
@added(Versions.`2026-11-01-preview`)
@discriminator("policy")
model AioConnectorApplicationAllocation {
  /** The allocation policy type. */
  policy: AioConnectorApplicationAllocationPolicy;
}

/** Bucketized allocation settings. */
@added(Versions.`2026-11-01-preview`)
model AioConnectorApplicationBucketizedAllocation
  extends AioConnectorApplicationAllocation {
  /** The allocation policy type. */
  policy: Bucketized;

  /** The number of device inbound endpoints assigned to each application instance. */
  @minValue(1)
  @maxValue(100)
  bucketSize?: int32 = 1;
}

/** Allocation policy types. */
@added(Versions.`2026-11-01-preview`)
union AioConnectorApplicationAllocationPolicy {
  string,

  /** Bucketized allocation policy. */
  Bucketized,
}
