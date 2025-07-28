// -----------------------------------------------------------------------
// <copyright file="Device.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common/base.tsp";
import "./AccessPointAccount.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("An Access Point Device Resource")
@parentResource(AccessPointAccount)
model Device is TrackedResource<DeviceProperties> {
  ...ResourceNameParameter<
    Device,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$"
  >;
}

@doc("Device Properties.")
model DeviceProperties {
  // Standard MAC address format
  // 00:00:00:00:00:00
  // lowercase, uppercase letters, 6 groups of 2 hex digits, separated by colons
  @doc("The unique MAC address of the device.")
  @pattern("^[a-fA-F0-9]{2}(:[a-fA-F0-9]{2}){5}$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  mac: string;

  @doc("The unique serial number of the device.")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  serial: string;

  @doc("Indicates whether the device is enabled.")
  enabled: boolean;

  @doc("The fully qualified ARM URI of the associated Update Group resource.")
  updateGroupId: armResourceIdentifier;

  @doc("The fully qualified ARM URI of the associated Network resource.")
  networkId: armResourceIdentifier;

  @doc("The IP address of the device that belongs to the attached network.")
  ipAddress: ipV4Address;

  @doc("The label associated with the device.")
  label: string;

  @doc("Additional details.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

// Suppress because we have no custom properties for the response,
// but the ArmResourceActionAsync requires a response model to generate the correct response types.
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@doc("The base response for all device actions.")
model DeviceActionResponse {}

@doc("The request body for the displayMessage device action.")
model DisplayMessageRequest {
  @doc("The message to be displayed on the device.")
  message: string;
}

@armResourceOperations
interface DeviceOperations {
  get is ArmResourceRead<Device>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Device>;
  update is ArmResourcePatchSync<Device, DeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByParent is ArmResourceListByParent<Device>;

  // Device actions
  @doc("Displays a provided messages on a device.")
  displayMessage is ArmResourceActionAsync<
    Device,
    DisplayMessageRequest,
    ArmResponse<DeviceActionResponse>
  >;

  @doc("Refreshes the connection of a device.")
  refreshConnection is ArmResourceActionAsync<
    Device,
    void,
    ArmResponse<DeviceActionResponse>
  >;

  @doc("Revokes device certificates.")
  revokeCertificates is ArmResourceActionAsync<
    Device,
    void,
    ArmResponse<DeviceActionResponse>
  >;

  @doc("Sends a restart command to a device.")
  reboot is ArmResourceActionAsync<
    Device,
    void,
    ArmResponse<DeviceActionResponse>
  >;

  @doc("Sends a shutdown command to a device.")
  shutdown is ArmResourceActionAsync<
    Device,
    void,
    ArmResponse<DeviceActionResponse>
  >;

  @doc("Sends a user log off command to a device.")
  logOffUser is ArmResourceActionAsync<
    Device,
    void,
    ArmResponse<DeviceActionResponse>
  >;
}
