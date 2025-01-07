import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Tap Properties defines the properties of the resource.")
model NetworkTapProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  @doc("ARM resource ID of the Network Packet Broker.")
  @visibility("read", "create")
  networkPacketBrokerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  @doc("Source Tap Rule Id. ARM Resource ID of the Network Tap Rule.")
  @visibility("read")
  sourceTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;

  @doc("List of destinations to send the filter traffic.")
  @OpenAPI.extension("x-ms-identifiers", [])
  destinations: DestinationProperties[];

  @doc("Polling type.")
  pollingType?: PollingType = PollingType.Pull;

  @doc("Gets the configurations state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of Network Tap provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource. Example -Enabled/Disabled")
  @visibility("read")
  administrativeState?: AdministrativeState;
}

@doc("The network tap destination properties.")
model DestinationProperties {
  @doc("Destination name.")
  @minLength(1)
  name: string;

  @doc("Type of destination. Input can be IsolationDomain or Direct.")
  destinationType: DestinationType;

  @doc("The destination Id. ARM Resource ID of either NNI or Internal Networks.")
  destinationId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  @doc("Isolation Domain Properties.")
  isolationDomainProperties?: IsolationDomainProperties;

  @doc("ARM Resource ID of destination Tap Rule that contains match configurations.")
  destinationTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

@doc("The network tap destination properties.")
model DestinationPatchProperties {
  @doc("Destination name.")
  @minLength(1)
  name?: string;

  @doc("Type of destination. Input can be IsolationDomain or Direct.")
  destinationType?: DestinationType;

  @doc("The destination Id. ARM Resource ID of either NNI or Internal Networks.")
  destinationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  @doc("Isolation Domain Properties.")
  isolationDomainProperties?: IsolationDomainPatchProperties;

  @doc("ARM Resource ID of destination Tap Rule that contains match configurations.")
  destinationTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

@doc("Isolation Domain Properties.")
model IsolationDomainProperties {
  @doc("Type of encapsulation.")
  encapsulation?: Encapsulation;

  @doc("List of Neighbor Group IDs.")
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    }
  ]>[];
}

@doc("Isolation Domain Properties.")
model IsolationDomainPatchProperties is IsolationDomainProperties;

@doc("The NetworkFabric resource definition.")
model NetworkTapPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  @doc("Resource properties.")
  properties?: NetworkTapPatchProperties;
}

@doc("The Network Tap resource patch definition.")
model NetworkTapPatchProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  @doc("Polling type.")
  pollingType?: PollingType;

  @doc("List of destination properties to send the filter traffic.")
  @OpenAPI.extension("x-ms-identifiers", [])
  destinations?: DestinationPatchProperties[];
}

@doc("Type of destination. Input can be IsolationDomain or Direct.")
union DestinationType {
  @doc("DestinationType-IsolationDomain")
  IsolationDomain: "IsolationDomain",

  @doc("DestinationType-Direct")
  Direct: "Direct",

  string,
}

@doc("Type of encapsulation.")
union Encapsulation {
  @doc("Encapsulation-None")
  None: "None",

  @doc("Encapsulation-GRE")
  GRE: "GRE",

  string,
}
