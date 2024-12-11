import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProgrammableConnectivity;
/**
 * A Programmable Connectivity Gateway resource.
 */
model Gateway is Azure.ResourceManager.TrackedResource<GatewayProperties> {
  /**
   * Azure Programmable Connectivity Gateway Name.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("gatewayName")
  @segment("gateways")
  @visibility("read")
  name: string;
}

/**
 * Gateway resource properties.
 */
model GatewayProperties {
  /**
   * List of Operator API Connections selected by the user.
   */
  @visibility("read")
  operatorApiConnections?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiConnections";
    }
  ]>[];

  /**
   * Base URL of the Gateway resource. This is the URL that the users would use to make Network API requests to the Operators via Azure.
   */
  @visibility("read")
  gatewayBaseUrl?: string;

  /**
   * The status of the last operation on the Gateway resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Details about the Application that would use the Operator's Network APIs.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  configuredApplication: ApplicationProperties;

  /**
   * Details about the Organization owning the Application that would use the Operator's Network APIs.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  configuredApplicationOwner: ApplicationOwnerProperties;
}

/**
 * Details about the Application Owner (i.e. organization) that would use the Operator's Network APIs.
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model ApplicationOwnerProperties {
  /**
   * Common name of the organization owning the application.
   */
  name: string;

  /**
   * Legal name of the organization owning the application.
   */
  legalName: string;

  /**
   * Trading name of the organization owning the application.
   */
  tradingName: string;

  /**
   * A description of the organization owning the application.
   */
  organizationDescription: string;

  /**
   * Unique Tax Number for the user's organization in the country/region the APC Gateway is being purchased.
   */
  taxNumber: string;

  /**
   * The type of organization that the Application Owner is.
   */
  organizationType: OrganizationType;

  /**
   * ID number for official identification of the organization.
   */
  organizationIdentificationId: string;

  /**
   * Issuing organization of the ID for official identification of the organization.
   */
  organizationIdentificationIssuer: string;

  /**
   * Type of official identification of the organization.
   */
  organizationIdentificationType: string;

  /**
   * Email address for the person responsible for the use of Network APIs in this application.
   */
  contactEmailAddress: string;

  /**
   * Legal representative of the organization.
   */
  legalRepresentative: Person;

  /**
   * Privacy manager of the organization.
   */
  privacyManager: Person;

  /**
   * Registered Geographic address.
   */
  registeredGeographicAddress: GeographicAddress;

  /**
   * URL for the organization's privacy policy.
   */
  privacyPolicyUrl: url;

  /**
   * List of local representatives.
   */
  @OpenAPI.extension("x-ms-identifiers", ["countryCode"])
  localRepresentatives: LocalRepresentative[];
}

/**
 * Details about the Application that would use the Operator's Network APIs.
 */
model ApplicationProperties {
  /**
   * Name of the application.
   */
  @TypeSpec.Versioning.madeRequired(Versions.v2024_11_01_preview)
  name: string;

  /**
   * Description of the application.
   */
  @TypeSpec.Versioning.madeRequired(Versions.v2024_11_01_preview)
  applicationDescription: string;

  /**
   * The category that describes the application.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  applicationType?: string;

  /**
   * The category of the application.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  category: Category;

  /**
   * Commercial name of the application.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  commercialName: string;

  /**
   * Privacy rights request email address.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  privacyRightsRequestEmailAddress: string;

  /**
   * URL for the organization's privacy policy.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  privacyPolicyUrl: url;

  /**
   * Legal name of the organization owning the application.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  legalName?: string;

  /**
   * A description of the organization owning the application.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  organizationDescription?: string;

  /**
   * Unique Tax Number for the user's organization in the country/region the APC Gateway is being purchased.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  taxNumber?: string;

  /**
   * Email address of the Privacy contact or Data Protection officer of the organization.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  privacyContactEmailAddress?: string;
}

/**
 * Model defining a contactable person.
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model Person {
  /**
   * Family name of the contactable person.
   */
  familyName: string;

  /**
   * Given name of the contactable person.
   */
  givenName: string;

  /**
   * Email address of the contactable person.
   */
  emailAddress: string;
}

/**
 * Model defining a geographic address.
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model GeographicAddress {
  /**
   * Street Number of the address.
   */
  streetNumber?: string;

  /**
   * Street Name of the address.
   */
  streetName?: string;

  /**
   * Locality of the address.
   */
  locality?: string;

  /**
   * City of the address.
   */
  city?: string;

  /**
   * Postal code of the address.
   */
  postalCode?: string;

  /**
   * Country code of the address.
   */
  @pattern("[A-Z]{2}", "Provide 2 letter country code")
  countryCode: string;
}

/**
 * Model defining a local representative for a country/region.
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model LocalRepresentative {
  /**
   * Country code for the country/region the local representative is representing.
   */
  @pattern("[A-Z]{2}", "Provide 2 letter country code")
  countryCode: string;

  /**
   * Local representative for this country/region.
   */
  localRepresentativePerson: Person;
}

/**
 * Valid values for category based on https://www.tmforum.org/oda/open-apis/directory/open-gateway-onboarding-and-ordering-component-suite-TMF931
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Category {
  agriculture: "Agriculture",
  artAndDesign: "Art and design",
  autoAndVehicle: "Auto and vehicle",
  beauty: "Beauty",
  booksAndReference: "Books and reference",
  business: "Business",
  construction: "Construction",
  defense: "Defense",
  developerTools: "Developer tools",
  education: "Education",
  engineering: "Engineering",
  eventsAndEntertainment: "Events and entertainment",
  finance: "Finance",
  foodAndDrink: "Food and drink",
  games: "Games",
  healthAndFitness: "Health and fitness",
  healthcare: "Healthcare",
  information: "Information",
  kids: "Kids",
  librariesAndDemo: "Libraries and demo",
  lifestyle: "Lifestyle",
  manufacturing: "Manufacturing",
  mapsAndNavigation: "Maps and navigation",
  media: "Media",
  medical: "Medical",
  mining: "Mining",
  musicAndAudio: "Music and audio",
  newsAndMagazines: "News and magazines",
  organizations: "Organizations",
  other: "Other",
  photoAndVideo: "Photo and video",
  productivity: "Productivity",
  publicService: "Public service",
  realEstate: "Real estate",
  shopping: "Shopping",
  socialNetworkingAndCommunications: "Social networking and communications",
  sports: "Sports",
  tourism: "Tourism",
  utilities: "Utilities",
  trading: "Trading",
  transportation: "Transportation",
  travelAndLocal: "Travel and local",
  water: "Water",
  weather: "Weather",
  string,
}

/**
 * Valid values for the Organization Type based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union OrganizationType {
  dpvAcademicScientificOrganisation: "Academic scientific organization",
  dpvForProfitOrganisation: "For profit organization",
  dpvGovernmentalOrganisation: "Governmental organization",
  dpvIndustryConsortium: "Industry consortium",
  dpvInternationalOrganisation: "International organization",
  dpvNonGovernmentalOrganisation: "Non-governmental organization",
  dpvNonProfitOrganisation: "Non-profit organization",
  dpvOrganisationalUnit: "Organizational unit",
  string,
}

@armResourceOperations
interface Gateways {
  /**
   * Get a Gateway resource by name.
   */
  get is ArmResourceRead<Gateway>;

  /**
   * Create or update an APC Gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Gateway>;

  /**
   * Update Gateway tags.
   */
  update is ArmTagsPatchSync<Gateway>;

  /**
   * Delete a Gateway.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Gateway>;

  /**
   * List Gateway resources by resource group.
   */
  //#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  //@operationId("Gateways_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Gateway>;

  /**
   * List Gateway resources by subscription ID.
   */
  listBySubscription is ArmListBySubscription<Gateway>;
}
