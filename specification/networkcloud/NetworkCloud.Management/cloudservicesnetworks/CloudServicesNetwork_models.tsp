import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the cloud services network.
 */
union CloudServicesNetworkDetailedStatus {
  string,

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The indicator of whether the platform default endpoints are allowed for the egress traffic.
 */
union CloudServicesNetworkEnableDefaultEgressEndpoints {
  string,

  /**
   * Enable default egress endpoints.
   */
  True: "True",

  /**
   * Disable default egress endpoints.
   */
  False: "False",
}

/**
 * The provisioning state of the cloud services network.
 */
union CloudServicesNetworkProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",
}

/**
 * The indicator to enable shared storage on the cloud services network. If not specified, the allocation will align with the standard storage enablement.
 */
union CloudServicesNetworkStorageMode {
  string,

  /**
   * No shared storage.
   */
  None: "None",

  /**
   * Standard shared storage.
   */
  Standard: "Standard",
}

/**
 * The status of the storage allocation for the cloud services network.
 */
union CloudServicesNetworkStorageStatusStatus {
  string,

  /**
   * The storage allocation is available
   */
  Available: "Available",

  /**
   * The storage allocation is expanding the volume.
   */
  ExpandingVolume: "ExpandingVolume",

  /**
   * The expansion of the storage allocation has failed.
   */
  ExpansionFailed: "ExpansionFailed",
}

/**
 * CloudServicesNetworkList represents a list of cloud services networks.
 */
model CloudServicesNetworkList is Azure.Core.Page<CloudServicesNetwork>;

/**
 * CloudServicesNetworkProperties represents properties of the cloud services network.
 */
model CloudServicesNetworkProperties {
  ...CloudServicesNetworkSpec;
  ...CloudServicesNetworkStatus;

  /**
   * The provisioning state of the cloud services network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CloudServicesNetworkProvisioningState;
}

/**
 * CloudServicesNetworkSpec represents the properties that are used as an input to the operator.
 */
model CloudServicesNetworkSpec {
  /**
   * The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
   */
  @identifiers(#[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints = CloudServicesNetworkEnableDefaultEgressEndpoints.True;

  /**
   * The storage options for the cloud services network.
   */
  storageOptions?: CloudServicesNetworkStorageOptions;
}

/**
 * CloudServicesNetworkStatus represents the properties produced by the API implementing logic in the operator.
 */
model CloudServicesNetworkStatus {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this cloud services network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the cloud services network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: CloudServicesNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The full list of additional and default egress endpoints that are currently enabled.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  enabledEgressEndpoints?: EgressEndpoint[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this cloud services network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * The name of the interface that will be present in the virtual machine to represent this network.
   */
  @visibility(Lifecycle.Read)
  interfaceName?: string;

  /**
   * The storage status for the cloud services network.
   */
  @visibility(Lifecycle.Read)
  storageStatus?: CloudServicesNetworkStorageStatus;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this cloud services network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}

/**
 * EgressEndpoint represents the connection from a cloud services network to the specified endpoint for a common purpose.
 */
model EgressEndpoint {
  /**
   * The descriptive category name of endpoints accessible by the AKS agent node. For example, azure-resource-management, API server, etc. The platform egress endpoints provided by default will use the category 'default'.
   */
  category: string;

  /**
   * The list of endpoint dependencies.
   */
  @identifiers(#[])
  @minItems(1)
  endpoints: EndpointDependency[];
}

/**
 * EndpointDependency represents the definition of an endpoint, including the domain and details.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName: string;

  /**
   * The port of this endpoint.
   */
  @maxValue(65535)
  @minValue(1)
  port?: int64;
}

/**
 * CloudServicesNetworkStorageOptions represents the storage options for the cloud services network.
 */
model CloudServicesNetworkStorageOptions {
  /**
   * The indicator to enable shared storage on the cloud services network. If not specified, the allocation will align with the standard storage enablement.
   */
  mode?: CloudServicesNetworkStorageMode = CloudServicesNetworkStorageMode.Standard;

  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB?: int64;

  /**
   * The resource ID of the storage appliance that hosts the storage.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}

/**
 * CloudServicesNetworkStorageStatus represents the storage status of the cloud services network.
 */
model CloudServicesNetworkStorageStatus {
  /**
   * The indicator of if shared storage is enabled on the cloud services network.
   */
  @visibility(Lifecycle.Read)
  mode?: CloudServicesNetworkStorageMode;

  /**
   * The size in Mebibytes of the storage allocation.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  sizeMiB?: int64;

  /**
   * The status of the storage allocation for the cloud services network.
   */
  @visibility(Lifecycle.Read)
  status?: CloudServicesNetworkStorageStatusStatus;

  /**
   * The description for the status of the shared storage.
   */
  @visibility(Lifecycle.Read)
  statusMessage?: string;

  /**
   * The resource ID of the volume created to host the shared storage.
   */
  @visibility(Lifecycle.Read)
  volumeId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/volumes";
    }
  ]>;
}

/**
 * CloudServicesNetworkPatchParameters represents the body of the request to patch the cloud services network.
 */
model CloudServicesNetworkPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: CloudServicesNetworkPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * CloudServicesNetworkPatchProperties represents the properties of the cloud services network that can be updated using a patch request.
 */
model CloudServicesNetworkPatchProperties {
  /**
   * The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
   */
  @identifiers(#[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints;

  /**
   * The storage options for the cloud services network.
   */
  storageOptions?: CloudServicesNetworkStorageOptionsPatch;
}

/**
 * CloudServicesNetworkStorageOptionsPatch represents the patchable storage options for the cloud services network.
 */
model CloudServicesNetworkStorageOptionsPatch {
  /**
   * The indicator to enable shared storage on the cloud services network.
   */
  mode?: CloudServicesNetworkStorageMode;

  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB?: int64;

  /**
   * The resource ID of the storage appliance that hosts the storage.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}
