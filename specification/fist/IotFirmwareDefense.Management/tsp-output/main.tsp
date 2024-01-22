import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Firmware.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The definitions and parameters in this swagger specification will be used to manage the IoT Firmware Defense resources.
 */
@armProviderNamespace
@service({
  title: "fist",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.IoTFirmwareDefense;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-02-08-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_02_08_preview: "2023-02-08-preview",
}
