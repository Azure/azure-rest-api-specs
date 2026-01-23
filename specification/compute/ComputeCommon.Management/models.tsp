import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Shared models for Compute and Disk management services
 */
namespace Microsoft.Compute;

/**
 * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
 */
union HyperVGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * The state of snapshot which determines the access availability of the snapshot.
 */
union SnapshotAccessState {
  string,

  /**
   * Default value.
   */
  Unknown: "Unknown",

  /**
   * The snapshot cannot be used for restore, copy or download to offline.
   */
  Pending: "Pending",

  /**
   * The snapshot can be used for restore, copy to different region, and download to offline.
   */
  Available: "Available",

  /**
   * The snapshot can be used for restoring disks with fast performance but cannot be copied or downloaded.
   */
  InstantAccess: "InstantAccess",

  /**
   * The snapshot can be used for restoring disks with fast performance, copied and downloaded.
   */
  AvailableWithInstantAccess: "AvailableWithInstantAccess",
}

/**
 * The Operating System type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * CPU architecture supported by an OS disk.
 */
union Architecture {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x64: "x64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Arm64: "Arm64",
}

/**
 * The type of identity used for the virtual machine scale set. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine scale set.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * This property allows the user to specify whether the virtual machines created under this image are 'Generalized' or 'Specialized'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemStateTypes {
  /**
   * Generalized image. Needs to be provisioned during deployment time.
   */
  Generalized,

  /**
   * Specialized image. Contains already provisioned OS Disk.
   */
  Specialized,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}