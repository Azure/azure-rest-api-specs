import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Internet Gateway Properties defines the properties of the resource.")
model InternetGatewayProperties {
  ...AnnotationResource;

  @doc("ARM Resource ID of the Internet Gateway Rule.")
  internetGatewayRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;

  @doc("IPv4 Address of Internet Gateway.")
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  @doc("Port number of Internet Gateway.")
  @visibility(Lifecycle.Read)
  port?: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "This is a valid property name."
  @doc("Gateway Type of the resource.")
  @madeOptional(Versions.v2024_06_15_preview)
  type?: GatewayType;

  @doc("Gateway Type of the resource.")
  @added(Versions.v2024_06_15_preview)
  internetGatewayType?: GatewayType;

  @doc("ARM Resource ID of the Network Fabric Controller.")
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provisioning state of resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The Internet Gateway patch resource definition.")
model InternetGatewayPatch {
  ...TagsUpdate;

  @doc("Resource properties.")
  properties?: InternetGatewayPatchProperties;
}

@doc("PatchProperties for InternetGateway ")
model InternetGatewayPatchProperties {
  @doc("ARM Resource ID of the Internet Gateway Rule.")
  internetGatewayRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;
}

@doc("Gateway Type of the resource.")
union GatewayType {
  @doc("GatewayType Infrastructure")
  Infrastructure: "Infrastructure",

  @doc("GatewayType Workload")
  Workload: "Workload",

  string,
}
