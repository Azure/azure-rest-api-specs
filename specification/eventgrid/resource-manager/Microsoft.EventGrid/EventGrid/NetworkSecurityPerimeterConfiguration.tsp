import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Network security perimeter configuration.
 */
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

/**
 * Network security perimeter configuration under a Domain.
 */
@parentResource(Domain)
model DomainNetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = DomainNetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DomainNetworkSecurityPerimeterConfigurations {
  /**
   * Get a specific network security perimeter configuration with a domain.
   */
  get is ArmResourceRead<DomainNetworkSecurityPerimeterConfiguration>;

  /**
   * Get all network security perimeter configurations associated with a domain.
   */
  list is ArmResourceListByParent<DomainNetworkSecurityPerimeterConfiguration>;

  /**
   * Reconcile a specific network security perimeter configuration for a given network security perimeter association with a domain.
   */
  reconcile is ArmResourceActionAsync<
    DomainNetworkSecurityPerimeterConfiguration,
    void,
    NetworkSecurityPerimeterConfiguration
  >;
}

/**
 * Network security perimeter configuration under a Topic.
 */
@parentResource(Topic)
model TopicNetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = TopicNetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TopicNetworkSecurityPerimeterConfigurations {
  /**
   * Get a specific network security perimeter configuration with a topic.
   */
  get is ArmResourceRead<TopicNetworkSecurityPerimeterConfiguration>;

  /**
   * Get all network security perimeter configurations associated with a topic.
   */
  list is ArmResourceListByParent<TopicNetworkSecurityPerimeterConfiguration>;

  /**
   * Reconcile a specific network security perimeter configuration for a given network security perimeter association with a topic.
   */
  reconcile is ArmResourceActionAsync<
    TopicNetworkSecurityPerimeterConfiguration,
    void,
    NetworkSecurityPerimeterConfiguration
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name, "");
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties of the network security perimeter configuration."
);
