import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using TypeSpec.Rest;

namespace Common;

/* Provides the standard '$expand' query parameter. */
model $ExpandQueryParameter<T = string> {
  /** The expand expression to apply on the operation. */
  @query("$expand")
  $expand?: T;
}

/**
 * Api error.
 */
model ApiError {
  /**
   * The Api error details
   */
  @Azure.ResourceManager.identifiers(#["message", "target"])
  details?: ApiErrorBase[];

  /**
   * The Api inner error
   */
  innererror?: InnerError;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Api error base.
 */
model ApiErrorBase {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Inner error details.
 */
model InnerError {
  /**
   * The exception type.
   */
  exceptiontype?: string;

  /**
   * The internal error message or exception dump.
   */
  errordetail?: string;
}

/**
 * An error response from the Compute service.
 */
@error
model CloudError {
  /**
   * Api error.
   */
  error?: ApiError;
}

/**
 * The Resource model definition with location property as optional.
 */
model ResourceWithOptionalLocation {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@doc("Concrete proxy resource types can be created by aliasing this type using a specific property type.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.customAzureResource
model ProxySubResourceReadOnly<Properties extends {}>
  extends SubResourceReadOnly {
  @doc("The resource-specific properties for this resource.")
  properties?: Properties;

  /**
   * The name of the parent resource.
   */
  @path
  @visibility(Lifecycle.Read)
  @segment("parents")
  parentName: string;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZone: "EdgeZone",
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
 * The hypervisor generation of the Virtual Machine.
 */
union HyperVGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemTypes {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux,
}

/**
 * The OS State. For managed images, use Generalized.
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

/**
 * The type of identity used for the virtual machine scale set. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine scale set.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned, UserAssigned`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None,
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
