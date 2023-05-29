import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessment options resource.")
@parentResource(AssessmentProject)
model AssessmentOptions is ProxyResource<AssessmentOptionsProperties> {
    @doc(" assessment options ARM name. Accepted value is 'default'")
    @key("assessmentOptionsName")
    @segment("assessmentOptions")
    @path
    name: string;
}

@doc("Assessment options properties.")
model AssessmentOptionsProperties extends AzureResourceProperties {
    @doc("""
Dictionary of VM families grouped by vm family name describing the targeted
azure locations of VM family and the category of the family.
""")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    vmFamilies?: VmFamilyOptions[];

    @doc("List of supported VM Families.")
    @visibility("read")
    reservedInstanceVmFamilies?: string[];

    @doc("List of supported Azure regions for reserved instances.")
    @visibility("read")
    reservedInstanceSupportedLocations?: string[];

    @doc("List of supported currencies for reserved instances.")
    @visibility("read")
    reservedInstanceSupportedCurrencies?: string[];

    @doc("List of supported Azure offer codes for reserved instances.")
    @visibility("read")
    reservedInstanceSupportedOffers?: string[];

    @doc("Ultra disk related assessment options.")
    @visibility("read")
    @added(ApiVersions.v2020_01_01)
    @extension("x-ms-identifiers", [])
    ultraDiskVmFamilies?: UltraDiskAssessmentOptions[];

    @doc("List of VM Families that support premium disks for assessments.")
    @visibility("read")
    @added(ApiVersions.v2020_01_01)
    premiumDiskVmFamilies?: string[];

    @doc("List of VM Families that support Savings plan offer for assessments.")
    @visibility("read")
    @added(ApiVersions.v2020_01_01)
    savingsPlanVmFamilies?: string[];

    @doc("List of Azure locations that support Savings plan offer for assessments.")
    @visibility("read")
    @added(ApiVersions.v2020_01_01)
    savingsPlanSupportedLocations?: string[];
}

@doc("""
VM family name, the list of targeted azure locations and the category of the
family.
""")
model VmFamilyOptions {
    @doc("Name of the VM family.")
    @visibility("read")
    familyName?: string;

    @doc("List of Azure regions.")
    @visibility("read")
    targetLocations?: string[];

    @doc("Category of the VM family.")
    @visibility("read")
    category?: string[];
}

@doc("Assessment options for Ultra disk type.")
model UltraDiskAssessmentOptions {
    @doc("Family name.")
    familyName?: string;

    @doc("List of locations where ultra disk is supported for this VMfamily.")
    targetLocations?: string[];
}
