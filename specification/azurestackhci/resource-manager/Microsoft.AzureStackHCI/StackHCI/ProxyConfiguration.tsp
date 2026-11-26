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
@added(Versions.v2027_01_15_preview)
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
@added(Versions.v2027_01_15_preview)
@armResourceOperations
interface ProxyConfigurations {
  /** Get the proxy configuration of an Edge Machine. */
  get is ArmResourceRead<ProxyConfiguration>;

  /** List proxy configuration resources by Edge Machine. */
  list is ArmResourceListByParent<ProxyConfiguration>;
}

/** A job that mutates the proxy configuration on an edge machine. */
@added(Versions.v2027_01_15_preview)
@parentResource(ProxyConfiguration)
model ProxyConfigurationJob
  is Azure.ResourceManager.ProxyResource<ProxyConfigurationJobProperties> {
  ...ResourceNameParameter<
    Resource = ProxyConfigurationJob,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9_-]{3,63}$"
  >;
}

/**
 * CRUD operations for Proxy Configuration Jobs.
 */
@added(Versions.v2027_01_15_preview)
@armResourceOperations
interface ProxyConfigurationJobs {
  /** Get a specific proxy configuration job. */
  get is ArmResourceRead<ProxyConfigurationJob>;

  /** List proxy configuration jobs. */
  list is ArmResourceListByParent<ProxyConfigurationJob>;

  /** Create or update a proxy configuration job. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProxyConfigurationJob>;

  /** Delete a proxy configuration job. */
  delete is ArmResourceDeleteWithoutOkAsync<ProxyConfigurationJob>;
}
