import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Firmware.tsp";
import "./BinaryHardeningResource.tsp";
import "./CryptoCertificateResource.tsp";
import "./CryptoKeyResource.tsp";
import "./CveResource.tsp";
import "./PasswordHashResource.tsp";
import "./SbomComponentResource.tsp";
import "./SummaryResource.tsp";
import "./Workspace.tsp";
import "./UsageMetric.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Firmware & IoT Security REST API
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armProviderNamespace
@service(#{ title: "Iot Firmware Defense" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.IoTFirmwareDefense;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-08-07 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_08_07: "2025-04-01-preview",
}
