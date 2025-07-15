import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";
import "./Commons.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
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
@doc("Connectivity Types")
union ConnectivityType {
  @doc("Connectivity type as Public")
  Public: "Public",

  @doc("Connectivity type as Proxy")
  Proxy: "Proxy",

  string,
}

@removed(Versions.v2025_06_01)
@doc("Proxy Configuration")
model ProxyConfiguration {
  @doc("Proxy Url")
  url: url;

  @doc("Proxy port")
  port: int32;

  @doc("Bypass urls from proxy")
  bypassUrls?: url[];
}
