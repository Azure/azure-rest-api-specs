import "./Configuration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface ConnectivityConfigurations {
  get is ArmResourceRead<ConnectivityConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectivityConfiguration>;
  update is ArmResourcePatchSync<
    ConnectivityConfiguration,
    ConnectivityConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<ConnectivityConfiguration>;
  listByConfiguration is ArmResourceListByParent<ConnectivityConfiguration>;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ConnectivityConfiguration Resource")
@parentResource(Configuration)
model ConnectivityConfiguration
  is ProxyResource<ConnectivityConfigurationProperties> {
  ...ResourceNameParameter<
    ConnectivityConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ConnectivityConfigurationProperties Properties")
model ConnectivityConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Scenario in which this configuration is used")
  scenario: Scenario;

  @doc("Connectivity type")
  connectivityType: ConnectivityType;

  @doc("Proxy URL and Port Configuration")
  proxyConfiguration?: ProxyConfiguration;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("Connectivity Types")
union ConnectivityType {
  @doc("Connectivity type as Public")
  Public: "Public",

  @doc("Connectivity type as Proxy")
  Proxy: "Proxy",

  string,
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("Proxy Configuration")
model ProxyConfiguration {
  @doc("Proxy Url")
  url: url;

  @doc("Proxy port")
  port: int32;

  @doc("Bypass urls from proxy")
  bypassUrls?: url[];
}
