import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Tap Properties defines the properties of the resource.
 */
model NetworkTapProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * ARM resource ID of the Network Packet Broker.
   */
  @visibility("read", "create")
  networkPacketBrokerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * Source Tap Rule Id. ARM Resource ID of the Network Tap Rule.
   */
  @visibility("read")
  sourceTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;

  /**
   * List of destinations to send the filter traffic.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  destinations: DestinationProperties[];

  /**
   * Polling type.
   */
  pollingType?: PollingType = PollingType.Pull;

  /**
   * Gets the configurations state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of Network Tap provisioning.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource. Example -Enabled/Disabled
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
}

/**
 * The network tap destination properties.
 */
model DestinationProperties {
  /**
   * Destination name.
   */
  @minLength(1)
  name: string;

  /**
   * Type of destination. Input can be IsolationDomain or Direct.
   */
  destinationType: DestinationType;

  /**
   * The destination Id. ARM Resource ID of either NNI or Internal Networks.
   */
  destinationId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  /**
   * Isolation Domain Properties.
   */
  isolationDomainProperties?: IsolationDomainProperties;

  /**
   * ARM Resource ID of destination Tap Rule that contains match configurations.
   */
  destinationTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

/**
 * The network tap destination properties.
 */
model DestinationPatchProperties {
  /**
   * Destination name.
   */
  @minLength(1)
  name?: string;

  /**
   * Type of destination. Input can be IsolationDomain or Direct.
   */
  destinationType?: DestinationType;

  /**
   * The destination Id. ARM Resource ID of either NNI or Internal Networks.
   */
  destinationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  /**
   * Isolation Domain Properties.
   */
  isolationDomainProperties?: IsolationDomainPatchProperties;

  /**
   * ARM Resource ID of destination Tap Rule that contains match configurations.
   */
  destinationTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

/**
 * Isolation Domain Properties.
 */
model IsolationDomainProperties {
  /**
   * Type of encapsulation.
   */
  encapsulation?: Encapsulation;

  /**
   * List of Neighbor Group IDs.
   */
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    }
  ]>[];
}

@doc("Isolation Domain Properties.")
model IsolationDomainPatchProperties is IsolationDomainProperties;

/**
 * The NetworkFabric resource definition.
 */
model NetworkTapPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Resource properties.
   */
  properties?: NetworkTapPatchProperties;
}

/**
 * The Network Tap resource patch definition.
 */
model NetworkTapPatchProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Polling type.
   */
  pollingType?: PollingType;

  /**
   * List of destination properties to send the filter traffic.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  destinations?: DestinationPatchProperties[];
}

/**
 * Type of destination. Input can be IsolationDomain or Direct.
 */
union DestinationType {
  @doc("DestinationType-IsolationDomain")
  IsolationDomain: "IsolationDomain",

  @doc("DestinationType-Direct")
  Direct: "Direct",

  string,
}

/**
 * Type of encapsulation.
 */
union Encapsulation {
  @doc("Encapsulation-None")
  None: "None",

  @doc("Encapsulation-GRE")
  GRE: "GRE",

  string,
}
