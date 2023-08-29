import "../Common/SqlEnums.tsp";
import "../Common/CommonModels.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("SQL Assessment options web model object.")
@parentResource(AssessmentProject)
model SqlAssessmentOptions is ProxyResource<SqlAssessmentOptionsProperties> {
    @doc("Sql assessment options ARM name. Accepted values is 'default'")
    @key("assessmentOptionsName")
    @segment("sqlAssessmentOptions")
    @path
    name: string;
}

@doc("SQL Assessment options properties Web model object.")
model SqlAssessmentOptionsProperties extends AzureResourceProperties {
  @doc("Gets the list of VM families.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  vmFamilies?: VmFamilyOptions[];

  @doc("Gets the Reserved Instance VM Families list.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  reservedInstanceVmFamilies?: AzureVmFamily[];

  @doc("Gets the Premium disk VM Families list.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  premiumDiskVmFamilies?: AzureVmFamily[];

  @doc("Gets or sets the Premium disk VM Families list.")
  @extension("x-ms-identifiers", [])
  savingsPlanVmFamilies?: AzureVmFamily[];

  @doc("Gets or sets the list of Azure locations supporting Saving Plans for IAAS.")
  @extension("x-ms-identifiers", [])
  savingsPlanSupportedLocations?: AzureLocation[];

  @doc("Gets or sets the list of Azure locations supporting Saving Plans for PAAS.")
  @extension("x-ms-identifiers", [])
  savingsPlanSupportedLocationsForPaas?: AzureLocation[];

  @doc("Gets or sets the list of Azure locations supporting Reserved Instances for IAAS.")
  @extension("x-ms-identifiers", [])
  reservedInstanceSupportedLocationsForIaas?: AzureLocation[];

  @doc("Gets or sets the list of Azure Offers supporting Saving Plans.")
  @extension("x-ms-identifiers", [])
  savingsPlanSupportedOffers?: AzureOfferCode[];

  @doc("Gets or sets the list of SQL target SKU properties for dropdowns.")
  @extension("x-ms-identifiers", [])
  sqlSkus?: SqlPaaSTargetOptions[];

  @doc("Gets or sets the Reserved Instance SQL target types.")
  @extension("x-ms-identifiers", [])
  reservedInstanceSqlTargets?: TargetType[];

  @doc("Gets or sets the list of Azure locations supporting Reserved Instances.")
  @extension("x-ms-identifiers", [])
  reservedInstanceSupportedLocations?: AzureLocation[];

  @doc("Gets or sets the list of currencies supported for Reserved Instances.")
  @extension("x-ms-identifiers", [])
  reservedInstanceSupportedCurrencies?: AzureCurrency[];

  @doc("Gets or sets the list of offers supported for Reserved Instances.")
  @extension("x-ms-identifiers", [])
  reservedInstanceSupportedOffers?: AzureOfferCode[];

  @doc("Gets or sets the list of offers supported for SQL assessments.")
  @extension("x-ms-identifiers", [])
  supportedOffers?: AzureOfferCode[];
}