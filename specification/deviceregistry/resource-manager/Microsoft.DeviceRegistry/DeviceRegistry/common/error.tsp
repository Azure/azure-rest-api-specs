import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@doc("Defines the error object with properties.")
@added(Versions.v2025_07_01_preview)
model Error {
  @doc("Error code for classification of errors (ex: '400', '404', '500', etc.).")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Human-readable helpful error message to provide additional context for error (e.g.,: “Capability ID 'foo' does not exist”).")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Array of error details that describe the status of each error.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: ErrorDetails[];
}

@doc("Defines the error details properties.")
@added(Versions.v2025_07_01_preview)
model ErrorDetails {
  @doc("Multi-part error code for classification and root causing of errors (ex: 400.200.100.432).")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Human-readable helpful error message to provide additional context for error (ex: “Authentication method not supported”).")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Human-readable helpful detailed text context for debugging (ex: “The following mechanisms are supported...”).")
  @visibility(Lifecycle.Read)
  info?: string;

  @doc("Unique identifier for the transaction to aid in debugging.")
  @visibility(Lifecycle.Read)
  correlationId?: string;
}
