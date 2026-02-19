import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NetworkSite.tsp";
import "./NetworkAgent.tsp";
import "./NsxManager.tsp";
import "./NsxTier0Gateway.tsp";
import "./NsxTier1Gateway.tsp";
import "./NsxSegment.tsp";
import "./NsxGroup.tsp";
import "./NsxGatewayFirewallPolicy.tsp";
import "./NsxGatewayFirewallRule.tsp";
import "./NsxLoadBalancer.tsp";
import "./NsxNatRule.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The Microsoft.ApplicationMigration Rest API spec.
 */
@armProviderNamespace
@service(#{ title: "Microsoft.ApplicationMigration management service" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ApplicationMigration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-01-01-preview API version.
   */
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
