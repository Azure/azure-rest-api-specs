import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.GuestConfiguration;

// ============================================================================
// External target resources
// ============================================================================

/**
 * External reference to a Microsoft.Compute virtual machine, used as the
 * target of VM-scoped inventory extension operations.
 */
alias VirtualMachine = Azure.ResourceManager.Extension.ExternalResource<
  "Microsoft.Compute",
  "virtualMachines",
  "vmName",
  "^[a-zA-Z0-9](?:[-a-zA-Z0-9_.]*[a-zA-Z0-9])?$",
  string,
  "The name of the virtual machine."
>;

/**
 * Name of an Arc-enabled machine.
 */
@maxLength(54)
scalar HybridComputeMachineName extends string;

/**
 * External reference to a Microsoft.HybridCompute Arc-enabled machine, used
 * as the target of Arc-scoped inventory extension operations.
 */
alias HybridComputeMachine = Azure.ResourceManager.Extension.ExternalResource<
  "Microsoft.HybridCompute",
  "machines",
  "machineName",
  "^[a-zA-Z0-9](?:[-a-zA-Z0-9_.]*[a-zA-Z0-9])?$",
  HybridComputeMachineName,
  "The name of the ARC machine."
>;

// ============================================================================
// VM-scoped interfaces (list-only, read-only)
// ============================================================================

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmApplications {
  /**
   * Get a specific application inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    Application,
    Response = ArmResponse<Application>
  >;

  /**
   * List all application inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    Application,
    Response = ArmResponse<ApplicationList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmCertificates {
  /**
   * Get a specific certificate inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    Certificate,
    Response = ArmResponse<Certificate>
  >;

  /**
   * List all certificate inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    Certificate,
    Response = ArmResponse<CertificateList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmWindowsRoles {
  /**
   * Get a specific windows role inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    WindowsRole,
    Response = ArmResponse<WindowsRole>
  >;

  /**
   * List all windows role inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    WindowsRole,
    Response = ArmResponse<WindowsRoleList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmUsers {
  /**
   * Get a specific user account inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    User,
    Response = ArmResponse<User>
  >;

  /**
   * List all user account inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    User,
    Response = ArmResponse<UserList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmServices {
  /**
   * Get a specific service inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    Service,
    Response = ArmResponse<Service>
  >;

  /**
   * List all service inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    Service,
    Response = ArmResponse<ServiceList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmGroups {
  /**
   * Get a specific group inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    Group,
    Response = ArmResponse<Group>
  >;

  /**
   * List all group inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    Group,
    Response = ArmResponse<GroupList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmDeviceInfos {
  /**
   * Get a specific device info inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    DeviceInfo,
    Response = ArmResponse<DeviceInfo>
  >;

  /**
   * List all device info inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    DeviceInfo,
    Response = ArmResponse<DeviceInfoList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface VmFirmwareResources {
  /**
   * Get a specific firmware inventory item for a virtual machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    VirtualMachine,
    FirmwareResource,
    Response = ArmResponse<FirmwareResource>
  >;

  /**
   * List all firmware inventory items for a virtual machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    VirtualMachine,
    FirmwareResource,
    Response = ArmResponse<FirmwareResourceList>
  >;
}

// ============================================================================
// Arc (HybridCompute) scoped interfaces (list-only, read-only)
// ============================================================================

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcApplications {
  /**
   * Get a specific application inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    Application,
    Response = ArmResponse<Application>
  >;

  /**
   * List all application inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    Application,
    Response = ArmResponse<ApplicationList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcCertificates {
  /**
   * Get a specific certificate inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    Certificate,
    Response = ArmResponse<Certificate>
  >;

  /**
   * List all certificate inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    Certificate,
    Response = ArmResponse<CertificateList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcWindowsRoles {
  /**
   * Get a specific windows role inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    WindowsRole,
    Response = ArmResponse<WindowsRole>
  >;

  /**
   * List all windows role inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    WindowsRole,
    Response = ArmResponse<WindowsRoleList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcUsers {
  /**
   * Get a specific user account inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    User,
    Response = ArmResponse<User>
  >;

  /**
   * List all user account inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    User,
    Response = ArmResponse<UserList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcServices {
  /**
   * Get a specific service inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    Service,
    Response = ArmResponse<Service>
  >;

  /**
   * List all service inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    Service,
    Response = ArmResponse<ServiceList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcGroups {
  /**
   * Get a specific group inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    Group,
    Response = ArmResponse<Group>
  >;

  /**
   * List all group inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    Group,
    Response = ArmResponse<GroupList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcDeviceInfos {
  /**
   * Get a specific device info inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    DeviceInfo,
    Response = ArmResponse<DeviceInfo>
  >;

  /**
   * List all device info inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    DeviceInfo,
    Response = ArmResponse<DeviceInfoList>
  >;
}

@armResourceOperations(#{ allowStaticRoutes: true })
interface ArcFirmwareResources {
  /**
   * Get a specific firmware inventory item for an Arc machine.
   */
  get is Azure.ResourceManager.Extension.Read<
    HybridComputeMachine,
    FirmwareResource,
    Response = ArmResponse<FirmwareResource>
  >;

  /**
   * List all firmware inventory items for an Arc machine.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    HybridComputeMachine,
    FirmwareResource,
    Response = ArmResponse<FirmwareResourceList>
  >;
}
