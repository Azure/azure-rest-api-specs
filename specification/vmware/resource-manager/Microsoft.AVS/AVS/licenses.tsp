namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
@added(Versions.v2025_09_01)
interface Licenses {
  list is ArmResourceListByParent<License>;

  get is ArmResourceRead<License>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<License>;

  delete is ArmResourceDeleteWithoutOkAsync<License>;

  getProperties is ArmResourceActionSyncNoRequestBody<
    License,
    LicenseProperties
  >;
}

@doc("A license resource")
@parentResource(PrivateCloud)
model License is ProxyResource<LicenseProperties> {
  @doc("Name of the license.")
  @pattern("^[-\\w\\._]+$")
  @key("licenseName")
  @path
  @segment("licenses")
  name: LicenseName;
}

@doc("The name of the license.")
union LicenseName {
  string,

  @doc("VMware Firewall license")
  VmwareFirewall: "VmwareFirewall",
}

@doc("The kind of license.")
union LicenseKind {
  string,
  VmwareFirewall: "VmwareFirewall",
}

@doc("The properties of a license")
@discriminator("kind")
model LicenseProperties {
  @doc("License kind")
  kind: LicenseKind;

  @doc("The state of the license provisioning")
  @visibility(Lifecycle.Read)
  provisioningState?: LicenseProvisioningState;
}

@doc("provisioning state of the license")
union LicenseProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a VMware Firewall license")
model VmwareFirewallLicenseProperties extends LicenseProperties {
  @doc("License kind")
  kind: LicenseKind.VmwareFirewall;

  @doc("License key")
  @secret
  licenseKey?: string;

  @doc("Number of cores included in the license, measured per hour")
  cores: int32;

  @doc("UTC datetime when the license expires")
  endDate: utcDateTime;

  @doc("The Broadcom site ID associated with the license.")
  broadcomSiteId?: string;

  @doc("The Broadcom contract number associated with the license.")
  broadcomContractNumber?: string;

  @doc("Additional labels passed through for license reporting.")
  @identifiers(#["key"])
  labels?: Label[];
}

@doc("A key-value pair representing a label.")
model Label {
  @doc("The key of the label.")
  @minLength(1)
  key: string;

  @doc("The value of the label.")
  @minLength(1)
  value: string;
}

@doc("The kind of license.")
union VcfLicenseKind {
  string,

  @doc("A VMware Cloud Foundation (VCF) 5.0 license")
  Vcf5: "vcf5",
}

@doc("A VMware Cloud Foundation license")
@discriminator("kind")
model VcfLicense {
  @doc("License kind")
  kind: VcfLicenseKind;

  @doc("The state of the license provisioning")
  @visibility(Lifecycle.Read)
  provisioningState?: LicenseProvisioningState;
}

@doc("A VMware Cloud Foundation (VCF) 5.0 license")
model Vcf5License extends VcfLicense {
  @doc("License kind")
  kind: VcfLicenseKind.Vcf5;

  @doc("License key")
  @secret
  licenseKey?: string;

  @doc("Number of cores included in the license")
  cores: int32;

  @doc("UTC datetime when the license expires")
  endDate: utcDateTime;

  @doc("The Broadcom site ID associated with the license.")
  broadcomSiteId?: string;

  @doc("The Broadcom contract number associated with the license.")
  broadcomContractNumber?: string;

  @doc("Additional labels passed through for license reporting.")
  @identifiers(#["key"])
  labels?: Label[];
}
