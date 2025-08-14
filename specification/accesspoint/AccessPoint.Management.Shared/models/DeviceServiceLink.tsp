// -----------------------------------------------------------------------
// <copyright file="DeviceServiceLink.tsp" company="Microsoft Corporation">
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

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("Represents link between a Device and a Virtual Desktop Infrastructure service.")
@parentResource(AccessPointAccount)
model DeviceServiceLink is ProxyResource<DeviceServiceLinkProperties> {
  ...ResourceNameParameter<
    DeviceServiceLink,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$"
  >;
}

@doc("Device Service Link properties")
model DeviceServiceLinkProperties {
  @doc("The Azure Resource ID of the associated Device resource.")
  // Do not allow updating this field, since it would imply a PATCH on 2 separate devices
  @visibility(Lifecycle.Create, Lifecycle.Read)
  deviceResourceId: armResourceIdentifier;

  @doc("The Azure Resource ID of the associated Virtual Desktop Infrastructure service resource.")
  serviceResourceId: armResourceIdentifier;

  ...BaseResourceProperties;
}

@armResourceOperations
interface DeviceServiceLinkOperations {
  get is ArmResourceRead<DeviceServiceLink>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeviceServiceLink>;
  update is ArmResourcePatchAsync<
    DeviceServiceLink,
    DeviceServiceLinkProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DeviceServiceLink>;
  listByParent is ArmResourceListByParent<DeviceServiceLink>;
}
