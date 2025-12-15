import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.AzureCis;

@added(Versions.v2024_06_24_preview)
@doc("Authentication requirement.")
model AuthenticationRequirement {
  @doc("The authentication requirement value. E.g. 'SAWEnforcement' or 'PTH'.")
  value: string;

  @doc("A list of required IP ranges.")
  @Azure.ResourceManager.identifiers(#[])
  requiredIpRanges: Array<RequiredIpRange>;
}

@added(Versions.v2024_06_24_preview)
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

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  @doc("Flag to indicate if the claim is regional enforced or not. Optional.")
  isRegionalEnforced?: string | "False" | "True";
}

@added(Versions.v2024_06_24_preview)
@doc("The claim provisionings for a service client identity group.")
model ClaimProvisioningsForGroup {
  @doc("The claim identity instance. Required.")
  claimInstance: Claim;

  @doc("Scoped to service account group name. Optional.")
  scopedToServiceAccountGroup?: string;

  @doc("Scoped to service account group service tree id. Optional.")
  scopedToServiceAccountGroupServiceTreeId?: string;
}

@added(Versions.v2024_06_24_preview)
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

@doc("Realm information of the account.")
model DstsRealm {
  @doc("Realm's name. This is case-insensitive. E.g. \"svc://crpadmin@%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)/\".")
  name: string;

  @doc("Realm's redirection URL. This is case-insensitive. E.g. \"https://%(ArmRegionName).acs.%($CS.ComputeDnsSuffix)/\".")
  redirectionUrl?: string;
}

@doc("This model represents an IP range in SCI.")
model RequiredIpRange {
  @doc("Gets or sets the start of IP range. E.g. \"172.1.1.1\".")
  fromIpAddress: string;

  @doc("Gets or sets the end of IP range. E.g. \"172.1.1.5\".")
  toIpAddress: string;
}
