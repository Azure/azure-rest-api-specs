import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Monitor/Monitor.tsp";
import "./ProviderInstance/ProviderInstance.tsp";
import "./SapLandscapeMonitor/SapLandscapeMonitor.tsp";
import "./Alert/Alert.tsp";
import "./AlertTemplate/AlertTemplate.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The workload SAP monitor Client.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace
@service({
  title: "Workloads Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Workloads;
