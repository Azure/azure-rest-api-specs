namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Shared device capability types
// Shared across data-plane (DeviceRegistry.DataPlane) and
// control-plane (DeviceRegistry.Management).
// ──────────────────────────────────────────────

/** Properties of a device capability resource. */
@discriminator("capabilityType")
model DeviceCapabilityProperties {
  /** The type of this device capability resource. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  capabilityType: CapabilityType;

  /** The provisioning status of this capability. */
  @visibility(Lifecycle.Read)
  provisioningState?: CapabilityProvisioningState;

  /** Whether a capability is enabled or disabled. */
  enablementState: DeviceCapabilityEnablementState;
}

/** Whether a capability is enabled or disabled. */
union DeviceCapabilityEnablementState {
  string,

  /** The capability is enabled. */
  Enabled: "Enabled",

  /** The capability is disabled. All PUT/PATCH/POST APIs on the resource will be blocked. */
  Disabled: "Disabled",

  /** The capability is disabled because the parent device has been disabled. All PUT/PATCH/POST APIs on the resource will be blocked. */
  DisabledByParent: "DisabledByParent",
}

/** The device capability properties for an IoTHub capability */
model IotHubDeviceCapabilityProperties extends DeviceCapabilityProperties {
  /** Discriminator for IoT Hub capability. */
  capabilityType: CapabilityType.IoTHub;

  /** The full ARM Resource ID for the IoT Hub's authentication profile. This must be a sibling resource under the same device. */
  authenticationProfileResourceId: string;

  /** The messaging endpoint name as returned by the GetNamespace API. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  messagingEndpointName: string;
}

/** The device capabilities properties for an update capability. */
model UpdateDeviceCapabilityProperties extends DeviceCapabilityProperties {
  /** Discriminator for Update capability. */
  capabilityType: CapabilityType.SoftwareUpdate;
}

/** The provisioning state of a device capability. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Shared read-only projection: the device capability provisioning lifecycle (Linking/Succeeded/Failed/Deleting) intentionally does not include 'Canceled'; the control-plane only exposes read (GET/LIST)."
union CapabilityProvisioningState {
  string,

  /** The capability is being linked. */
  Linking: "Linking",

  /** The capability has been successfully provisioned. */
  Succeeded: "Succeeded",

  /** The capability provisioning has failed. */
  Failed: "Failed",

  /** The capability is being deleted. */
  Deleting: "Deleting",
}

/** The type of a device capability. */
union CapabilityType {
  string,

  /** IoT Hub connection. */
  IoTHub: "Microsoft.IoTHub",

  /** Device Update connection. */
  SoftwareUpdate: "Microsoft.SoftwareUpdate",
}
