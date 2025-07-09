import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.MessagingConnectors.Models.EventHubConfig;

@doc("Basic info for EventHub")
model EventHubConfig {
  @doc("namespace of the EventHub.")
  namespaceHostName: string;

  @doc("name of the EventHub.")
  eventHubName: string;

  @doc("Auth of Eventhub")
  authentication: Models.Auth.Authentication;
}
