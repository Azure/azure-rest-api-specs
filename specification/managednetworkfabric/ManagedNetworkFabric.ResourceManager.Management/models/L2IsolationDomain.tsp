import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * L2Isolation Domain Properties defines the properties of the resource.
 */
model L2IsolationDomainProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * ARM Resource ID of the Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * Vlan Identifier of the Network Fabric. Example: 501.
   */
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
}

/**
 * The L2 Isolation Domain patch resource definition.
 */
model L2IsolationDomainPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Resource properties.
   */
  properties?: L2IsolationDomainPatchProperties;
}

/**
 * L2 Isolation Domain Patch Properties defines the patchable properties of the resource.
 */
@withoutDefaultValues
model L2IsolationDomainPatchProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;
}
