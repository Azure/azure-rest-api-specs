import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./CopilotConnectors.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.PortalServices Resource Provider Copilot Connector management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.PortalServices" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Azure Portal Services API Reference")
namespace Microsoft.PortalServices;

@doc("Azure Portal Services Copilot Connectors Management API versions.")
enum Versions {
  /** 2025-05-15-preview version */
  @doc("Azure Portal Services Copilot Connector Management API version 2025-05-15-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_15_preview: "2025-05-15-preview",
}
