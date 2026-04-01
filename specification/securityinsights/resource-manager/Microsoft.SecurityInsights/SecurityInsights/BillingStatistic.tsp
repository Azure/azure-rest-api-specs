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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model BillingStatistic
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<BillingStatisticKind> {
  ...ResourceNameParameter<
    Resource = BillingStatistic,
    KeyName = "billingStatisticName",
    SegmentName = "billingStatistics",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "workspaceName",
  NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$",
  Description = "The name of the workspace."
>;

@armResourceOperations(#{ omitTags: true })
interface BillingStatistics {
  /**
   * Gets a billing statistic
   */
  @tag("billingStatistics")
  get is Extension.Read<workspaceExternalResource, BillingStatistic>;

  /**
   * Gets all Microsoft Sentinel billing statistics.
   */
  @tag("billingStatistics")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    BillingStatistic,
    Response = ArmResponse<BillingStatisticList>
  >;
}

@@doc(BillingStatistic.name, "The name of the billing statistic");
@@minLength(Extension.ExternalResource.name, 1);
@@maxLength(Extension.ExternalResource.name, 90);
