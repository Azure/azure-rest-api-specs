import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

namespace Microsoft.AzureCis;

@doc("The claim provisionings for a service client identity group.")
model ClaimProvisioningsForGroup {
  @doc("The claim identity instance. Required.")
  claimInstance: Claim;

  @doc("Flag to indicate if the claim is unscoped. If the claim needs to work for all service accounts set the IsUnscoped to true, but the claim's type and value will need to be previously added a as global claim to dSCM. Optional.")
  isUnscoped?: boolean;

  @doc("Scoped to service account group id. If IsUnscoped is false, set the ScopedToServiceAccountGroupId to the ID of group the claim will apply to. If IsUnscoped is true, you can omit the ScopedToServiceAccountGroupId. Optional.")
  scopedToServiceAccountGroupId?: string;

  @doc("Scoped to service account group name. Optional.")
  scopedToServiceAccountGroup?: string;

  @doc("Scoped to service account group service tree id. Optional.")
  scopedToServiceAccountGroupServiceTreeId?: string;
}

@doc("Authentication requirement.")
model AuthenticationRequirement {
  @doc("Authentication requirement value. E.g. SAWEnforcement or PTH. Required.")
  value: string;

  @doc("List of required IP ranges. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  requiredIpRanges?: Array<RequiredIpRange>;
}

@doc("Claim expansion for the service client identity group.")
model ClaimExpansion {
  @doc("Expanded claim instance. Required.")
  expandedClaim: Claim;

  @doc("Service account name. Optional.")
  serviceAccountName?: string;

  @doc("Container id. Optional.")
  containerId?: string;

  @doc("DSTS instance. Optional.")
  dstsInstance?: string;

  @doc("Cloud id. Optional.")
  cloudId?: CloudId;

  @doc("Service account group name. Optional.")
  serviceAccountGroup?: string;

  @doc("Service account group service tree id. Optional.")
  serviceAccountGroupServiceTreeId?: string;

  @doc("Flag to indicate if the claim is regional enforced or not. Optional.")
  isRegionalEnforced?: boolean;
}

@doc("Cloud Id")
union CloudId {
  string,

  @doc("Public cloud")
  Public: "Public",

  @doc("BlackForest cloud")
  BlackForest: "BlackForest",

  @doc("Bleu cloud")
  Bleu: "Bleu",

  @doc("Delos cloud")
  Delos: "Delos",

  @doc("Fairfax cloud")
  Fairfax: "Fairfax",

  @doc("GovSG cloud")
  GovSG: "GovSG",

  @doc("Mooncake cloud")
  Mooncake: "Mooncake",

  @doc("USNat cloud")
  USNat: "USNat",

  @doc("USSec cloud")
  USSec: "USSec",
}
