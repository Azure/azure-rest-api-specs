// -----------------------------------------------------------------------
// <copyright file="VirtualDesktopInfrastructure.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("Properties for all Virtual Desktop Infrastructure resources.")
model VirtualDesktopInfrastructureProperties {
  @doc("The network level for the service.")
  hostNetworkLevel: string;

  @doc("Additional details.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
