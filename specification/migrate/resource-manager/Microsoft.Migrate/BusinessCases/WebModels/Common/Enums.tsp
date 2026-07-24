import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Microsoft.Migrate;

@doc("Business case supported currency types.")
union BusinessCaseCurrency {
  @doc("Currency Unknown.")
  Unknown: "Unknown",

  @doc("Currency USD.")
  USD: "USD",

  @doc("Currency DKK.")
  DKK: "DKK",

  @doc("Currency CAD.")
  CAD: "CAD",

  @doc("Currency IDR.")
  IDR: "IDR",

  @doc("Currency JPY.")
  JPY: "JPY",

  @doc("Currency KRW.")
  KRW: "KRW",

  @doc("Currency NZD.")
  NZD: "NZD",

  @doc("Currency NOK.")
  NOK: "NOK",

  @doc("Currency RUB.")
  RUB: "RUB",

  @doc("Currency SAR.")
  SAR: "SAR",

  @doc("Currency ZAR.")
  ZAR: "ZAR",

  @doc("Currency SEK.")
  SEK: "SEK",

  @doc("Currency TRY.")
  TRY: "TRY",

  @doc("Currency GBP.")
  GBP: "GBP",

  @doc("Currency MXN.")
  MXN: "MXN",

  @doc("Currency MYR.")
  MYR: "MYR",

  @doc("Currency INR.")
  INR: "INR",

  @doc("Currency HKD.")
  HKD: "HKD",

  @doc("Currency BRL.")
  BRL: "BRL",

  @doc("Currency TWD.")
  TWD: "TWD",

  @doc("Currency EUR.")
  EUR: "EUR",

  @doc("Currency CHF.")
  CHF: "CHF",

  @doc("Currency ARS.")
  ARS: "ARS",

  @doc("Currency AUD.")
  AUD: "AUD",

  @doc("Currency CNY.")
  CNY: "CNY",

  string,
}

@doc("Business case supported Savings Option types.")
union SavingsOption {
  @doc("Unknown Savings Option.")
  Unknown: "Unknown",

  @doc("Reserved Instance 3 Year.")
  RI3Year: "RI3Year",

  @doc("Azure Savings Plan 3 Year.")
  SavingsPlan3Year: "SavingsPlan3Year",

  string,
}

@doc("Business case supported migration strategy types.")
union MigrationStrategy {
  @doc("Unknown Migration Strategy.")
  Unknown: "Unknown",

  @doc("Optimize for cost.")
  OptimizeForCost: "OptimizeForCost",

  @doc("IaaS only.")
  IaaSOnly: "IaaSOnly",

  @doc("Optimize for PaaS.")
  OptimizeForPaas: "OptimizeForPaas",

  @doc("Avs only.")
  AVSOnly: "AVSOnly",

  string,
}

@doc("Business case supported Discovery source types.")
union DiscoverySource {
  @doc("Unknown Discovery Source.")
  Unknown: "Unknown",

  @doc("Appliance Discovery Source.")
  Appliance: "Appliance",

  @doc("Import Discovery Source.")
  Import: "Import",

  string,
}

@doc("Business case supported VmWare License types.")
union LicenseType {
  @doc("Unknown License.")
  Unknown: "Unknown",

  @doc("VSphereStandard License.")
  VSphereStandard: "VSphereStandard",

  @doc("VSphereEnterprisePlus License.")
  VSphereEnterprisePlus: "VSphereEnterprisePlus",

  string,
}

@doc("Business case supported Vsphere Management License types.")
union VsphereManagementLicenseType {
  @doc("Unknown License.")
  Unknown: "Unknown",

  @doc("VSphereServerStandard License.")
  VSphereServerStandard: "VSphereServerStandard",

  string,
}

@doc("Business case supported HyperV License types.")
union HyperVLicenseType {
  @doc("Unknown HyperV License.")
  Unknown: "Unknown",

  @doc("Datacentre HyperV License.")
  Datacentre: "Datacentre",

  @doc("Standard HyperV License.")
  Standard: "Standard",

  string,
}

@doc("Business case supported SQL Server License types.")
union SqlServerLicenseType {
  @doc("Unknown Sql Server License.")
  Unknown: "Unknown",

  @doc("Enterprise Sql Server License.")
  Enterprise: "Enterprise",

  @doc("Standard Sql Server License.")
  Standard: "Standard",

  string,
}

@doc("Business case supported state types.")
union BusinessCaseState {
  @doc("Unknown State.")
  Unknown: "Unknown",

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("InProgress  State.")
  InProgress: "InProgress",

  @doc("Completed State.")
  Completed: "Completed",

  @doc("OutDated State.")
  OutDated: "OutDated",

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Invalid State.")
  Invalid: "Invalid",

  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("OutOfSync State.")
  OutOfSync: "OutOfSync",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("In progress state.")
  Started: "Started",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("In entities getting tagged on static data state.")
  Tagging: "Tagging",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("In Artifacts Created state.")
  ArtifactsCreation: "ArtifactsCreation",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("Computation of the business case.")
  Computing: "Computing",

  @doc("Failed State.")
  Failed: "Failed",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("The deleting business case state.")
  Deleting: "Deleting",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("The updating business case state.")
  Updating: "Updating",

  string,
}

@doc("Business case supported report status types.")
union ReportStatus {
  @doc("Unknown Report Status.")
  Unknown: "Unknown",

  @doc("None Report Status.")
  None: "None",

  @doc("InProgress Report Status.")
  InProgress: "InProgress",

  @doc("Failed Report Status.")
  Failed: "Failed",

  @doc("Completed Report Status.")
  Completed: "Completed",

  string,
}

@doc("Business case supported report types.")
union ReportType {
  @doc("Unknown Report Type.")
  Unknown: "Unknown",

  @doc("Excel Report Type.")
  Excel: "Excel",

  string,
}

@doc("Business case supported WebApp types.")
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
union WebAppTypes {
  @doc("Unknown WebApp Type.")
  Unknown: "Unknown",

  @doc("ASPNET Type.")
  ASPNET: "ASPNET",

  @doc("Java Tomcat Type.")
  Java: "Java",

  string,
}

@doc("Supportability Status.")
union SupportabilityStatus {
  @doc("Unknown Supportability Status.")
  Unknown: "Unknown",

  @doc("Mainstream Supportability Status.")
  Mainstream: "Mainstream",

  @doc("Extended Supportability Status.")
  Extended: "Extended",

  @doc("OutOfSupport Supportability Status.")
  OutOfSupport: "OutOfSupport",

  string,
}

@doc("Year values.")
union Year {
  @doc("Year 0.")
  Year0: "Year0",

  @doc("Year 1.")
  Year1: "Year1",

  @doc("Year 2.")
  Year2: "Year2",

  @doc("Year 3.")
  Year3: "Year3",

  string,
}

@doc("AzureArc state values.")
union AzureArcState {
  @doc("AzureArc state disabled.")
  Disabled: "Disabled",

  @doc("AzureArc state enabled.")
  Enabled: "Enabled",

  @doc("AzureArc state unknown.")
  Unknown: "Unknown",

  string,
}

@doc("Scope type.")
@added(BusinessCaseApiVersions.v2024_03_03_preview)
union ScopeType {
  @doc("Enum for Datacenter.")
  Datacenter: "Datacenter",

  @doc("Enum for ARG.")
  AzureResourceGraphQuery: "AzureResourceGraphQuery",

  string,
}

@doc("FTT and RAID Level.")
union FttAndRaidLevel {
  @doc("Unknown FTT and RAID Level.")
  Unknown: "Unknown",

  @doc("FTT 1 and RAID Level 1.")
  Ftt1Raid1: "Ftt1Raid1",

  @doc("FTT 1 and RAID Level 5.")
  Ftt1Raid5: "Ftt1Raid5",

  @doc("FTT 2 and RAID Level 1.")
  Ftt2Raid1: "Ftt2Raid1",

  @doc("FTT 2 and RAID Level 6.")
  Ftt2Raid6: "Ftt2Raid6",

  @doc("FTT 3 and RAID Level 1.")
  Ftt3Raid1: "Ftt3Raid1",

  string,
}

@doc("Different External storage skus.")
union ExternalStorageType {
  @doc("Indicates un-supported external storage.")
  Unknown: "Unknown",

  @doc("Indicates No external storage.")
  None: "None",

  @doc("ANF external storage with Standard SKU.")
  AnfStandard: "AnfStandard",

  @doc("ANF external storage with Premium SKU.")
  AnfPremium: "AnfPremium",

  @doc("ANF external storage with Ultra SKU.")
  AnfUltra: "AnfUltra",

  @doc("Azure Elastic SAN with Base SKU.")
  AzureElasticSanBase: "AzureElasticSanBase",

  @doc("Azure Elastic SAN with Capacity SKU.")
  AzureElasticSanCapacity: "AzureElasticSanCapacity",

  @added(BusinessCaseApiVersions.v2025_09_09_preview)
  @doc("ANF external storage with Flexible Service Level SKU.")
  AnfFlexibleServiceLevel: "AnfFlexibleServiceLevel",

  string,
}

@doc("Different network skus.")
union NetworkSkuType {
  @doc("Indicates un-supported network SKU.")
  Unknown: "Unknown",

  @doc("Indicates No network SKU.")
  None: "None",

  @doc("Express Route network type with Ultra SKU.")
  ExpressRouteUltra: "ExpressRouteUltra",

  @doc("Azure Private Link End Point network type.")
  AzurePrivateLinkEndPoint: "AzurePrivateLinkEndPoint",

  @doc("Azure Private Link Egress network type.")
  AzurePrivateLinkEgress: "AzurePrivateLinkEgress",

  @doc("Azure Private Link Ingress network type.")
  AzurePrivateLinkIngress: "AzurePrivateLinkIngress",

  string,
}

@doc("The licensing program.")
union LicensingProgram {
  @doc("Retail/Pay as you go.")
  Retail: "Retail",

  @doc("Not known")
  Unknown: "Unknown",

  @doc("Enterprise agreement.")
  EA: "EA",

  @doc("Microsoft customer agreement.")
  MCA: "MCA",

  string,
}
