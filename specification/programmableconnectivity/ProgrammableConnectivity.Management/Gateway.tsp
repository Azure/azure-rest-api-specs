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
 * A Programmable Connectivity Gateway resource
 */
model Gateway is Azure.ResourceManager.TrackedResource<GatewayProperties> {
  /**
   * Azure Programmable Connectivity Gateway Name
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("gatewayName")
  @segment("gateways")
  @visibility("read")
  name: string;
}

/**
 * Gateway resource properties
 */
model GatewayProperties {
  /**
   * List of Operator API Connections selected by the user
   */
  @visibility("read")
  operatorApiConnections?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiConnections";
    }
  ]>[];

  /**
   * Base URL of the Gateway resource. This is the URL that the users would use to make Open API Gateway requests to the Operators via Azure.
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
 * Details about the Application Owner (i.e.e organization) that would use the Operator's Network APIs.
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
   * ID number for official identification of the organization
   */
  organizationIdentificationId: string;

  /**
   * Issuing organization of the ID for official identification of the organization
   */
  organizationIdentificationIssuer: string;

  /**
   * Contact email address for the use of Network APIs at the company
   */
  contactEmailAddress: string;

  /**
   * Legal representative of the organization
   */
  legalRepresentative: Person;

  /**
   * Privacy manager of the organization
   */
  privacyManager: Person;

  /**
   * Registered Geographic address
   */
  registeredGeographicAddress: GeographicAddress;
}

/**
 * Details about the Application that would use the Operator's Network APIs.
 */
model ApplicationProperties {
  /**
   * Name of the application. Example: Contoso App.
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
   * Privacy rights request email address.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  privacyRightsRequestEmailAddress: string;

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
 * Model defining a contactable person
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model Person {
  /**
   * Family name of the contactable person.
   */
  familyName: string;

  /**
   * Given name of the contactable person
   */
  givenName: string;

  /**
   * Email address of the contactable person
   */
  emailAddress: string;
}

/**
 * Model defining a geographic address
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
model GeographicAddress {
  /**
   * Street Number of the address
   */
  streetNumber?: string;

  /**
   * Street Name of the address
   */
  streetName: string;

  /**
   * Locality of the address
   */
  locality?: string;

  /**
   * City of the address
   */
  city: string;

  /**
   * Postal code of the address
   */
  postalCode?: string;

  /**
   * Country code of the address
   */
  @pattern("[A-Z]{2}", "Provide 2 letter country code")
  countryCode: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Category {
  artAndDesign: "Art and Design",
  autoAndVehicle: "Auto and Vehicle",
  beauty: "Beauty",
  booksAndReference: "Books and Reference",
  business: "Business",
  developerTools: "Developer tools",
  education: "Education",
  eventsAndEntertainment: "Events and Entertainment",
  finance: "Finance",
  foodAndDrink: "Food and Drink",
  games: "Games",
  healthAndFitness: "Health and Fitness",
  kids: "Kids",
  librariesAndDemo: "Libraries and Demo",
  lifestyle: "Lifestyle",
  mapsAndNavigation: "Maps and Navigation",
  medical: "Medical",
  musicAndAudio: "Music and Audio",
  newsAndMagazines: "News and Magazines",
  photoAndVideo: "Photo and Video",
  productivity: "Productivity",
  shopping: "Shopping",
  socialNetworkingAndCommunications: "Social Networking and Communications",
  sports: "Sports",
  utilities: "Utilities",
  travelAndLocal: "Travel and Local",
  weather: "Weather",
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
