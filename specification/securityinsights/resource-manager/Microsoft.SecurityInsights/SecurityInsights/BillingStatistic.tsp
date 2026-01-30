import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: BillingStatistic has no properties property
/**
 * Billing statistic
 */
model BillingStatistic is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = BillingStatistic,
    KeyName = "billingStatisticName",
    SegmentName = "billingStatistics",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;

  /**
   * The kind of the billing statistic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: BillingStatisticKind;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "workspaceName"
>;

@armResourceOperations
interface BillingStatistics {
  /**
   * Gets a billing statistic
   */
  get is Extension.Read<workspaceExternalResource, BillingStatistic>;

  /**
   * Gets all Microsoft Sentinel billing statistics.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    BillingStatistic,
    Response = ArmResponse<BillingStatisticList>
  >;
}

@@doc(BillingStatistic.name, "The name of the billing statistic");
