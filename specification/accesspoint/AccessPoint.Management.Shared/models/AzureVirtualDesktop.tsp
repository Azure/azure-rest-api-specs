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
  @doc("Selected capability for audio output.")
  audioOutputCapability: AudioOutputCapability;

  @doc("Selected capability for audio input.")
  audioInputCapability: AudioInputCapability;

  @doc("Selected capability for camera.")
  cameraCapability: CameraCapability;

  @doc("The Entra Application (client) ID to associate with this service instance.")
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

@doc("Audio output options for Azure Virtual Desktop.")
union AudioOutputCapability {
  @doc("Audio output is disabled.")
  Disabled: "Disabled",

  @doc("Audio output is enabled.")
  Enabled: "Enabled",

  string,
}

@doc("Audio input options for Azure Virtual Desktop.")
union AudioInputCapability {
  @doc("Audio input is disabled.")
  Disabled: "Disabled",

  @doc("Audio input is enabled.")
  Enabled: "Enabled",

  string,
}

@doc("Camera options for Azure Virtual Desktop.")
union CameraCapability {
  @doc("Camera is disabled.")
  Disabled: "Disabled",

  @doc("Camera is enabled.")
  Enabled: "Enabled",

  string,
}
