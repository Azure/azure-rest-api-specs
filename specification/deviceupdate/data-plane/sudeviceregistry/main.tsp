import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./updates.tsp";
import "./deviceclasses.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * Software Update for Device Registry is an Azure service that enables customers to publish updates for their IoT devices to the cloud, and then deploy that update to their devices (approve updates to groups of devices managed and provisioned in Device Registry). It leverages the proven security and reliability of the Windows Update platform, optimized for IoT devices. It works globally and knows when and how to update devices, enabling customers to focus on their business goals and let Software Update for Device Registry handle the updates.
 */
@useAuth(AzureAuth)
@service(#{ title: "DeviceRegistrySoftwareUpdateClient" })
@versioned(Versions)
@server(
  "https://{endpoint}",
  "Software Update for Device Registry is an Azure service that enables customers to publish updates for their IoT devices to the cloud, and then deploy that update to their devices (approve updates to groups of devices managed and provisioned in Device Registry). It leverages the proven security and reliability of the Windows Update platform, optimized for IoT devices. It works globally and knows when and how to update devices, enabling customers to focus on their business goals and let Software Update for Device Registry handle the updates.",
  {
    /**
     * The Software Update for Device Registry account endpoint (hostname only, no protocol).
     */
    endpoint: url,
  }
)
namespace DeviceRegistrySoftwareUpdateClient;

/**
 * Azure Active Directory OAuth2 Flow.
 *
 * Defined as an `alias` (not a `model`) so the `@azure-tools/typespec-autorest`
 * emitter does not emit it under `definitions/` (which would trigger LintDiff
 * `XmsEnumValidation` (R2018) on the synthetic inner `type: ["oauth2"]` enum
 * the OAuth2Auth template produces). The flow itself is still emitted under
 * `securityDefinitions/`, just under the template-derived key `OAuth2Auth`
 * instead of `azure_auth`. This is a cosmetic, swagger-only change with no
 * impact on the OAuth2 wire flow, scopes, or authorization URL.
 */
alias AzureAuth = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://api.adu.microsoft.com/.default"];
  }
]>;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-11-02-preview API version. First public preview of the Device
   * Software Update for Device Registry data-plane service. Exposes update (content)
   * management operations and device class operations.
   */
  @Azure.Core.previewVersion
  v2026_11_02_preview: "2026-11-02-preview",
}
