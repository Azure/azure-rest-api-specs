// -----------------------------------------------------------------------
// <copyright file="AzureVirtualDesktop.tsp" company="Microsoft Corporation">
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
import "./VirtualDesktopInfrastructure.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("An Azure Virtual Desktop Resource.")
@parentResource(AccessPointAccount)
model AzureVirtualDesktop is ProxyResource<AzureVirtualDesktopProperties> {
  ...ResourceNameParameter<
    AzureVirtualDesktop,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$"
  >;
}

@doc("Azure Virtual Desktop Properties")
model AzureVirtualDesktopProperties is VirtualDesktopInfrastructureProperties {
  @doc("Indicates whether audio output is enabled.")
  audioOutputEnabled?: boolean;

  @doc("Indicates whether audio input is enabled.")
  audioInputEnabled?: boolean;

  @doc("Indicates whether the camera is enabled.")
  cameraEnabled?: boolean;

  @doc("The application id for the service.")
  applicationId: string;

  @doc("The redirect URL for the service.")
  redirectUrl: url;
}

@armResourceOperations
interface AzureVirtualDesktopOperations {
  get is ArmResourceRead<AzureVirtualDesktop>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzureVirtualDesktop>;
  update is ArmResourcePatchSync<
    AzureVirtualDesktop,
    AzureVirtualDesktopProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AzureVirtualDesktop>;
  listByParent is ArmResourceListByParent<AzureVirtualDesktop>;
}
