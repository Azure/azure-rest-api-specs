// -----------------------------------------------------------------------
// <copyright file="device.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.EncryptedTransport;

@doc("Device Resource Type")
@parentResource(EncryptedTransportAccount)
model Device is TrackedResource<DeviceProperties> {
  @doc("The device name")
  @key("deviceName")
  @visibility(Lifecycle.Read)
  @segment("devices")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @path
  name: string;
}

@doc("Device Properties")
model DeviceProperties {
  @doc("The serial number that identifies the end-user device. This must be unique at the account scope.")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  serialNumber: string;

  @doc("Reference to an existing device profile.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  deviceProfileId: DeviceProfileId;

  @doc("The MAC address for the end user device.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  macAddress: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/* https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#using-resource-identifiers */
@doc("The device profile resource identifier of the selected device profile")
scalar DeviceProfileId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EncryptedTransport/encryptedTransportAccounts/deviceProfiles",
    }
  ]>;

@armResourceOperations
interface DeviceOperations {
  get is ArmResourceRead<Device>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Device>;
  update is ArmResourcePatchSync<Device, DeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByEncryptedTransportAccount is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
