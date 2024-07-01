import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Internet Gateway Properties defines the properties of the resource.
 */
model InternetGatewayProperties {
  ...AnnotationResource;

  /**
   * ARM Resource ID of the Internet Gateway Rule.
   */
  internetGatewayRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;

  /**
   * IPv4 Address of Internet Gateway.
   */
  @visibility("read")
  ipv4Address?: string;

  /**
   * Port number of Internet Gateway.
   */
  @visibility("read")
  port?: int32;

  /**
   * Gateway Type of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "This is a valid property name."
  type: GatewayType;

  /**
   * ARM Resource ID of the Network Fabric Controller.
   */
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  /**
   * Provisioning state of resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The Internet Gateway patch resource definition.
 */
model InternetGatewayPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Resource properties.
   */
  properties?: InternetGatewayPatchProperties;
}

@doc("PatchProperties for InternetGateway ")
model InternetGatewayPatchProperties {
  /**
   * ARM Resource ID of the Internet Gateway Rule.
   */
  internetGatewayRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;
}

/**
 * Gateway Type of the resource.
 */
union GatewayType {
  @doc("GatewayType Infrastructure")
  Infrastructure: "Infrastructure",

  @doc("GatewayType Workload")
  Workload: "Workload",

  string,
}
