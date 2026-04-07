import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Namespace resource (shared root)
// ──────────────────────────────────────────────

/** A device registry namespace. */
@resource("namespaces")
model Namespace {
  /** The unique identifier of the namespace. */
  @key("namespaceUuid")
  @visibility(Lifecycle.Read)
  namespaceUuid: string;

  // TODO: Add namespace properties
}
