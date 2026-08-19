// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace NotificationHubs.Models;

@doc("Represents an Installation PATCH request")
model InstallationPatchRequest {
  @doc("The installation ID")
  @path installationId: string,
  @doc("The installation patches")
  @body updates: JsonPatch[]
}

@resource("installation")
@discriminator("platform")
@doc("Represents an Azure Notification Hubs Installation")
model Installation {
  @key
  @doc("The installation ID")
  @visibility("create", "update")
  installationId: string;
  @doc("The user ID")
  userId?: string;
  @doc("The installation expiration time")
  @visibility("read") expirationTime?: string;
  @doc("The last updated date")
  @visibility("read") lastUpdate?: string;
  @doc("The itags for the installation")
  tags?: string[];
  @doc("The templates for the installation")
  templates?: Record<string>;
}

@doc("Represents an Azure Notification Hubs Installation Template")
model InstallationTemplate {
  @doc("The body for the installation template")
  body: string;
  @doc("The HTTP headers for the installation template")
  headers: Record<string>;
  @doc("The tags for the installation template")
  tags?: string[];
}

@doc("Represents a JSON Patch operation type")
enum JsonPatchOperation {
  @doc("The add JSON patch operation type")
  Add: "add",
  @doc("The remove JSON patch operation type")
  Remove: "remove",
  @doc("The replace JSON patch operation type")
  Replace: "replace",
}

@doc("Represents a JSON Patch operation")
model JsonPatch {
  @doc("The JSON patch operation type")
  "op": JsonPatchOperation;
  @doc("The JSON patch path")
  path: string;
  @doc("The JSON patch value")
  value?: string;
}

@doc("Represents a string based push handle Azure Notification Installation")
model SimpleInstallation {
  @doc("The string based push handle for the installation")
  pushHandle: string;
}

@doc("Represents a Web Push push handle")
model BrowserPushHandle {
  @doc("The Web Push API endpoint")
  endpoint: string;
  @doc("The Web Push API P256DH key")
  p256dh: string;
  @doc("The Web Push API auth secret")
  auth: string;
}

@doc("Represents an ADM based Azure Notification Hubs Installation")
model AdmInstallation extends SimpleInstallation {
  @doc("The platform for the installation")
  platform: "adm";
}

@doc("Represents an Apple based Azure Notification Hubs Installation")
model AppleInstallation extends SimpleInstallation {
  @doc("The platform for the installation")
  platform: "apns";
}

@doc("Represents a Baidu based Azure Notification Hubs Installation")
model BaiduInstallation extends SimpleInstallation {
  @doc("The platform for the installation")
  platform: "baidu";
}

@doc("Represents an Web Push based Azure Notification Hubs Installation")
model BrowserInstallation extends Installation {
  @doc("The platform for the installation")
  platform: "browser";
  @doc("The Web API push handle for the installation")
  pushHandle: BrowserPushHandle;
}

@doc("Represents an FCM Legacy based Azure Notification Hubs Installation")
model FcmLegacyInstallation extends Installation {
  @doc("The platform for the installation")
  platform: "gcm";
}

@doc("Represents a Xiaomi based Azure Notification Hubs Installation")
model XiaomiInstallation extends SimpleInstallation {
  @doc("The platform for the installation")
  platform: "xiaomi";
}

@doc("Represents a Windows based Azure Notification Hubs Installation")
model WindowsInstallation extends SimpleInstallation {
  @doc("The platform for the installation")
  platform: "wns";
}