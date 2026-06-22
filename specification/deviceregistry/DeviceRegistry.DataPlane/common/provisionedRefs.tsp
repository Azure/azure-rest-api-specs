import "@typespec/versioning";
import "../models.tsp";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

/** Reference to a provisioned RPaaS resource: its ARM name, system-assigned UUID, and the etag observed at the final write performed during provisioning. */
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
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
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model ProvisionedDeviceRef extends ProvisionedResourceRef {
  /** The IoT Hub device id (equal to the originating request's iotHubDeviceId). */
  externalDeviceId: string;
}

/** Reference to a provisioned AuthenticationProfile resource, including the id of the underlying credential. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance is required to mirror C# class hierarchy emitted by @typespec/http-server-csharp; no polymorphic dispatch."
@added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
model ProvisionedAuthProfileRef extends ProvisionedResourceRef {
  /** GUID identifying the underlying credential. Only set for CertificateAuthority authentication; omitted otherwise. */
  credentialId?: string;
}
