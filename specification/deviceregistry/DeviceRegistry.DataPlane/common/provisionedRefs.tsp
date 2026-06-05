namespace Microsoft.DeviceRegistry;

/** Reference to a provisioned RPaaS resource: its ARM name, system-assigned UUID, and the etag observed at the final write performed during provisioning. */
model ProvisionedResourceRef {
  /** The ARM resource name. */
  name: string;

  /** The system-assigned UUID of the resource. */
  uuid: string;

  /** The etag observed at the final write performed by the orchestration against this resource. */
  etag: string;
}

/** Reference to a provisioned Device resource. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance is required to mirror C# class hierarchy emitted by @typespec/http-server-csharp; no polymorphic dispatch."
model ProvisionedDeviceRef extends ProvisionedResourceRef {
  /** The IoT Hub device id (equal to the originating request's iotHubDeviceId). */
  externalDeviceId: string;
}

/** Reference to a provisioned AuthenticationProfile resource, including the id of the underlying credential. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance is required to mirror C# class hierarchy emitted by @typespec/http-server-csharp; no polymorphic dispatch."
model ProvisionedAuthProfileRef extends ProvisionedResourceRef {
  /** GUID identifying the underlying credential. Only set for CertificateAuthority authentication; omitted otherwise. */
  credentialId?: string;
}

/** Reference to the messaging endpoint the device was provisioned against. */
model ProvisionedEndpointRef {
  /** Display name of the target endpoint. */
  name: string;

  /** IoT Hub service endpoint address (e.g. myhub.azure-devices.net), echoed from the originating request. */
  address: string;
}
