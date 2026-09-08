import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/** Proxy configuration for an Edge Machine. */
@added(Versions.v2026_10_15_preview)
@parentResource(EdgeMachine)
@singleton("default")
model ProxyConfiguration
  is Azure.ResourceManager.ProxyResource<ProxyConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = ProxyConfiguration,
    KeyName = "proxyConfigurationName",
    SegmentName = "proxyConfigurations",
    NamePattern = ""
  >;
}

/** Read operations for Edge Machine Proxy Configuration. */
@added(Versions.v2026_10_15_preview)
@armResourceOperations
interface ProxyConfigurations {
  /** Get the proxy configuration of an Edge Machine. */
  get is ArmResourceRead<ProxyConfiguration>;

  /** List proxy configuration resources by Edge Machine. */
  list is ArmResourceListByParent<ProxyConfiguration>;
}
