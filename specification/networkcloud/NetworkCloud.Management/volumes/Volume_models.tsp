import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the volume.
 */
union VolumeDetailedStatus {
  string,

  /**
   * The Active status.
   */
  Active: "Active",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the volume.
 */
union VolumeProvisioningState {
  string,

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",
}

/**
 * VolumeList represents a list of volumes.
 */
model VolumeList is Azure.Core.Page<Volume>;

/**
 * VolumePatchParameters represents the body of the request to patch the volume resource.
 */
model VolumePatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * VolumeProperties represents properties of the volume resource.
 */
model VolumeProperties {
  ...VolumeSpec;
  ...VolumeStatus;

  /**
   * The provisioning state of the volume.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: VolumeProvisioningState;
}

/**
 * VolumeSpec represents the properties that are used as an input to the operator.
 */
model VolumeSpec {
  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB: int64;

  /**
   * The resource ID of the storage appliance that hosts the volume.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}

/**
 * VolumeStatus represents the properties produced by the API implementing logic in the operator.
 */
model VolumeStatus {
  /**
   * The allocated size of the volume in Mebibytes.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  allocatedSizeMiB?: int64;

  /**
   * The list of resource IDs that attach the volume. It may include virtual machines and Hybrid AKS clusters.
   */
  @visibility(Lifecycle.Read)
  attachedTo?: string[];

  /**
   * The more detailed status of the volume.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: VolumeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The unique identifier of the volume.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;
}
