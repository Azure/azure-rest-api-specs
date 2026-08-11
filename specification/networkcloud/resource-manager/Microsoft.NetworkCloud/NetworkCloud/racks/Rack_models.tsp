import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the rack.
 */
union RackDetailedStatus {
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
 * The provisioning state of the rack resource.
 */
union RackProvisioningState {
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
 * RackList represents a list of racks.
 */
model RackList is Azure.Core.Page<Rack>;

/**
 * RacksPatchProperties represents the properties of the rack during patching.
 */
model RacksPatchProperties {
  /**
   * The free-form description of the rack location. (e.g. "DTN Datacenter, Floor 3, Isle 9, Rack 2B")
   */
  @maxLength(256)
  rackLocation?: string;

  /**
   * The globally unique identifier for the rack.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber?: string;
}

/**
 * RackPatchParameters represents the body of the request to patch the rack properties.
 */
model RackPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: RacksPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * RackProperties represents the properties of the rack.
 */
model RackProperties {
  ...RackSpec;
  ...RackStatus;

  /**
   * The provisioning state of the rack resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RackProvisioningState;
}

/**
 * RackSpec represents the properties that are used as an input to the operator.
 */
model RackSpec {
  /**
   * The value that will be used for machines in this rack to represent the availability zones that can be referenced by Hybrid AKS Clusters for node arrangement.
   */
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone: string;

  /**
   * The free-form description of the rack location. (e.g. "DTN Datacenter, Floor 3, Isle 9, Rack 2B")
   */
  @maxLength(256)
  rackLocation: string;

  /**
   * The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  /**
   * The SKU for the rack.
   */
  rackSkuId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/rackSkus";
    }
  ]>;
}

/**
 * RackStatus represents the properties produced by the API implementing logic in the operator.
 */
model RackStatus {
  /**
   * The resource ID of the cluster the rack is created for. This value is set when the rack is created by the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the rack.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: RackDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;
}
