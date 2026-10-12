import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Provisioning state of an AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
union AiGatewayProvisioningState {
  string,

  /** The resource is ready. */
  Succeeded: "Succeeded",

  /** The resource operation failed. */
  Failed: "Failed",

  /** The resource operation was canceled. */
  Canceled: "Canceled",
}
