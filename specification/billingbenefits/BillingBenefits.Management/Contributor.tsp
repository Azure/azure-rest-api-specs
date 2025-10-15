import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Macc.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;
/**
 * MACC contributor
 */
@added(Versions.v2025_05_01_preview)
@parentResource(Macc)
model Contributor is Azure.ResourceManager.ProxyResource<MaccModelProperties> {
  ...ResourceNameParameter<
    Resource = Contributor,
    KeyName = "contributorName",
    SegmentName = "contributors",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@added(Versions.v2025_05_01_preview)
@armResourceOperations
interface Contributors {
  /**
   * Get a contributor for primary service admin
   */
  getFromPrimary is ArmResourceRead<Contributor>;

  /**
   * List contributors under a MACC for primary service admin
   */
  listFromPrimary is ArmResourceListByParent<
    Contributor,
    Response = ArmResponse<ContributorList>
  >;
}

@@doc(Contributor.name,
  "Unique name of contributor in the format {contributorCloudSubId}_{resourceGroupName}_{nameInContributorTenant}."
);
@@doc(Contributor.properties, "MACC contributor properties");
