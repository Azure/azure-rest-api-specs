import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./Server.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DBforMySQL;

@added(Versions.v2026_03_01_preview)
@doc("Customer-facing server upgrade configuration.")
model ServerUpgradeConfig {
  @doc("Maximum minutes to wait for replication lag to catch up during maintenance for a HA enabled server.")
  @minValue(5)
  @maxValue(120)
  replicationLagValidationTimeoutInMinutes?: int32;
}

@added(Versions.v2026_03_01_preview)
@armResourceOperations
interface ServerUpgradeConfigurations {
  @doc("Gets the configurations used by upgrade operations on a high availability server.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Servers_GetUpgradeConfigurations")
  @action("upgradeConfigurations")
  @get
  get is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ServerUpgradeConfig>
  >;

  @doc("Updates the configurations used by upgrade operations on a high availability server.")
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Servers_SetUpgradeConfigurations")
  @action("upgradeConfigurations")
  @patch(#{ implicitOptionality: false })
  update is ArmResourceActionSync<
    Server,
    ServerUpgradeConfig,
    ArmResponse<string>
  >;
}
