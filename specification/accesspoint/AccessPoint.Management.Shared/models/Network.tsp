// -----------------------------------------------------------------------
// <copyright file="Network.tsp" company="Microsoft Corporation">
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

@doc("An Access Point Network Resource")
@parentResource(AccessPointAccount)
model Network is ProxyResource<NetworkProperties> {
  @doc("The name of the Network")
  @key("networkName")
  @segment("networks")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("Network Properties.")
model NetworkProperties {
  @doc("The user friendly name for a network.")
  siteName: string;

  @doc("The starting IP address in the range.")
  startingIpAddress: ipV4Address;

  @doc("The size of the network, specified as a CIDR netmask or number of IP addresses.")
  size: string;

  @doc("The Maximum Transmission Unit (MTU) of the network.")
  mtu: int32;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface NetworkOperations {
  get is ArmResourceRead<Network>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Network>;
  update is ArmResourcePatchSync<Network, NetworkProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Network>;
  listByParent is ArmResourceListByParent<Network>;
}
