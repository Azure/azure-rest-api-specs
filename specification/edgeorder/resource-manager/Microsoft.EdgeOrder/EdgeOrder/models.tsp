import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EdgeOrder;

/**
 * Type of address based on its usage context.
 */
union AddressClassification {
  string,

  /**
   * Shipping address for the order.
   */
  Shipping: "Shipping",

  /**
   * Site Address.
   */
  Site: "Site",
}

/**
 * Type of address.
 */
union AddressType {
  string,

  /**
   * Address type not known.
   */
  None: "None",

  /**
   * Residential Address.
   */
  Residential: "Residential",

  /**
   * Commercial Address.
   */
  Commercial: "Commercial",
}

/**
 * Status of address validation.
 */
union AddressValidationStatus {
  string,

  /**
   * Address provided is valid.
   */
  Valid: "Valid",

  /**
   * Address provided is invalid or not supported.
   */
  Invalid: "Invalid",

  /**
   * Address provided is ambiguous, please choose one of the alternate addresses returned.
   */
  Ambiguous: "Ambiguous",
}

/**
 * Provisioning state
 */
union ProvisioningState {
  string,

  /**
   * Creating state.
   */
  Creating: "Creating",

  /**
   * Succeeded state.
   */
  Succeeded: "Succeeded",

  /**
   * Failed state.
   */
  Failed: "Failed",

  /**
   * Canceled state.
   */
  Canceled: "Canceled",
}

/**
 * Type of product filter.
 */
union SupportedFilterTypes {
  string,

  /**
   * Ship to country.
   */
  ShipToCountries: "ShipToCountries",

  /**
   * Double encryption status.
   */
  DoubleEncryptionStatus: "DoubleEncryptionStatus",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ChildConfigurationType {
  string,

  /**
   * Child configuration is a device configuration.
   */
  DeviceConfiguration: "DeviceConfiguration",

  /**
   * Child configuration is an additional configuration.
   */
  AdditionalConfiguration: "AdditionalConfiguration",
}

/**
 * Unit for the dimensions of length, height and width.
 */
union LengthHeightUnit {
  string,

  /**
   * Inch, applicable for West US.
   */
  IN: "IN",

  /**
   * Centimeter.
   */
  CM: "CM",
}

/**
 * Unit for the dimensions of weight.
 */
union WeightMeasurementUnit {
  string,

  /**
   * Pounds.
   */
  LBS: "LBS",

  /**
   * Kilograms.
   */
  KGS: "KGS",
}

/**
 * Determining nature of provisioning that the configuration supports.
 */
union ProvisioningSupport {
  string,

  /**
   * The configuration can be provisioned from the cloud.
   */
  CloudBased: "CloudBased",

  /**
   * The configuration need to be provisioned manually by the end user.
   */
  Manual: "Manual",
}

/**
 * Type of link.
 */
union LinkType {
  string,

  /**
   * Generic link.
   */
  Generic: "Generic",

  /**
   * Terms and conditions link.
   */
  TermsAndConditions: "TermsAndConditions",

  /**
   * Link to product specification.
   */
  Specification: "Specification",

  /**
   * Link to product documentation.
   */
  Documentation: "Documentation",

  /**
   * Link to know more.
   */
  KnowMore: "KnowMore",

  /**
   * Link to sign up for products.
   */
  SignUp: "SignUp",

  /**
   * Link to order the product from another source and not from Azure Edge Hardware Center.
   */
  Discoverable: "Discoverable",
}

/**
 * Type of description.
 */
union DescriptionType {
  string,

  /**
   * Base description.
   */
  Base: "Base",
}

/**
 * Type of the image.
 */
union ImageType {
  string,

  /**
   * Main image.
   */
  MainImage: "MainImage",

  /**
   * Bullet image.
   */
  BulletImage: "BulletImage",

  /**
   * Generic image.
   */
  GenericImage: "GenericImage",
}

/**
 * Represents billing type.
 */
union BillingType {
  string,

  /**
   * PaV2 billing.
   */
  Pav2: "Pav2",

  /**
   * Purchase billing.
   */
  Purchase: "Purchase",
}

/**
 * Charging type.
 */
union ChargingType {
  string,

  /**
   * Per order charging type.
   */
  PerOrder: "PerOrder",

  /**
   * Per device charging type.
   */
  PerDevice: "PerDevice",
}

/**
 * Represents Metering type (eg one-time or recurrent).
 */
union MeteringType {
  string,

  /**
   * One time billing.
   */
  OneTime: "OneTime",

  /**
   * Recurring billing.
   */
  Recurring: "Recurring",

  /**
   * Adhoc billing.
   */
  Adhoc: "Adhoc",
}

/**
 * Term Commitment Type
 */
union TermCommitmentType {
  string,

  /**
   * Pay as you go Term Commitment Model.
   */
  None: "None",

  /**
   * Trial Term Commitment Model.
   */
  Trial: "Trial",

  /**
   * Time based Term Commitment Model.
   */
  Timed: "Timed",
}

/**
 * Current availability stage of the product.
 */
union AvailabilityStage {
  string,

  /**
   * Product is available.
   */
  Available: "Available",

  /**
   * Product is in preview.
   */
  Preview: "Preview",

  /**
   * Product is available only on signup.
   */
  Signup: "Signup",

  /**
   * Product is not available in our service but can be discovered from other sources.
   */
  Discoverable: "Discoverable",

  /**
   * Product is coming soon.
   */
  ComingSoon: "ComingSoon",

  /**
   * Product is not available.
   */
  Unavailable: "Unavailable",

  /**
   * Product is deprecated.
   */
  Deprecated: "Deprecated",
}

/**
 * Reason why the product is disabled.
 */
union DisabledReason {
  string,

  /**
   * Not disabled.
   */
  None: "None",

  /**
   * Not available in the requested country.
   */
  Country: "Country",

  /**
   * Not available to push data to the requested Azure region.
   */
  Region: "Region",

  /**
   * Required features are not enabled.
   */
  Feature: "Feature",

  /**
   * Subscription does not have required offer types.
   */
  OfferType: "OfferType",

  /**
   * Subscription has not registered to Microsoft.DataBox and Service does not have the subscription notification.
   */
  NoSubscriptionInfo: "NoSubscriptionInfo",

  /**
   * The product is not yet available.
   */
  NotAvailable: "NotAvailable",

  /**
   * The product is out of stock.
   */
  OutOfStock: "OutOfStock",
}

/**
 * The entity responsible for fulfillment of the item at the given hierarchy level.
 */
union FulfillmentType {
  string,

  /**
   * The fulfillment (the whole journey of the product offering) is handled by microsoft.
   */
  Microsoft: "Microsoft",

  /**
   * The fulfillment (the whole journey of the product offering) is handled by external third party entities.
   */
  External: "External",
}

/**
 * Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.
 */
union DoubleEncryptionStatus {
  string,

  /**
   * Double encryption is disabled.
   */
  Disabled: "Disabled",

  /**
   * Double encryption is enabled.
   */
  Enabled: "Enabled",
}

/**
 * Identification type of the configuration.
 */
union IdentificationType {
  string,

  /**
   * Product does not have any explicit identifier.
   */
  NotSupported: "NotSupported",

  /**
   * Product is identifiable by serial number.
   */
  SerialNumber: "SerialNumber",
}

/**
 * Auto Provisioning Details.
 */
union AutoProvisioningStatus {
  string,

  /**
   * Provisioning Enabled. Will act as pre-approved, and arc extension will be enabled as soon as the device is verified to be at the right edge location.
   */
  Enabled: "Enabled",

  /**
   * Provisioning Disabled.
   */
  Disabled: "Disabled",
}

/**
 * Proof of possession status.
 */
union DevicePresenceVerificationStatus {
  string,

  /**
   * The device has not yet been verified to be with the right edge operator or at the right location.
   */
  NotInitiated: "NotInitiated",

  /**
   * Confirms that the device is verified to be with the right edge operator or at the right location.
   */
  Completed: "Completed",
}

/**
 * Order item type.
 */
union OrderItemType {
  string,

  /**
   * Purchase OrderItem.
   */
  Purchase: "Purchase",

  /**
   * Rental OrderItem.
   */
  Rental: "Rental",

  /**
   * Orders placed outside of azure.
   */
  External: "External",
}

/**
 * Defines the mode of the Order item.
 */
union OrderMode {
  string,

  /**
   * Default Order mode.
   */
  Default: "Default",

  /**
   * Mode in which the Order will not be fulfilled.
   */
  DoNotFulfill: "DoNotFulfill",
}

/**
 * Stage status.
 */
union StageStatus {
  string,

  /**
   * No status available yet.
   */
  None: "None",

  /**
   * Stage is in progress.
   */
  InProgress: "InProgress",

  /**
   * Stage has succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Stage has failed.
   */
  Failed: "Failed",

  /**
   * Stage has been cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * Stage is cancelling.
   */
  Cancelling: "Cancelling",
}

/**
 * Stage name.
 */
union StageName {
  string,

  /**
   * Currently in draft mode and can still be cancelled.
   */
  Placed: "Placed",

  /**
   * Order is currently in draft mode and can still be cancelled.
   */
  InReview: "InReview",

  /**
   * Order is confirmed.
   */
  Confirmed: "Confirmed",

  /**
   * Order is ready to ship.
   */
  ReadyToShip: "ReadyToShip",

  /**
   * Order is in transit to customer.
   */
  Shipped: "Shipped",

  /**
   * Order is delivered to customer.
   */
  Delivered: "Delivered",

  /**
   * Order is ready to get cloud connected.
   */
  ReadyToSetup: "ReadyToSetup",

  /**
   * Order is in use at customer site.
   */
  InUse: "InUse",

  /**
   * Return has been initiated by customer.
   */
  ReturnInitiated: "ReturnInitiated",

  /**
   * Order is in transit from customer to Microsoft.
   */
  ReturnPickedUp: "ReturnPickedUp",

  /**
   * Order has been received back to Microsoft.
   */
  ReturnedToMicrosoft: "ReturnedToMicrosoft",

  /**
   * Return has now completed.
   */
  ReturnCompleted: "ReturnCompleted",

  /**
   * Order has been cancelled.
   */
  Cancelled: "Cancelled",
}

/**
 * Name of the stage.
 */
union NotificationStageName {
  string,

  /**
   * Notification at order item shipped from microsoft datacenter.
   */
  Shipped: "Shipped",

  /**
   * Notification at order item delivered to customer.
   */
  Delivered: "Delivered",
}

/**
 * Indicates Shipment Logistics type that the customer preferred.
 */
union TransportShipmentTypes {
  string,

  /**
   * Shipment Logistics is handled by the customer.
   */
  CustomerManaged: "CustomerManaged",

  /**
   * Shipment Logistics is handled by Microsoft.
   */
  MicrosoftManaged: "MicrosoftManaged",
}

/**
 * Describes whether the order item is cancellable or not.
 */
union OrderItemCancellationEnum {
  string,

  /**
   * Order item can be cancelled without fee.
   */
  Cancellable: "Cancellable",

  /**
   * Order item can be cancelled with fee.
   */
  CancellableWithFee: "CancellableWithFee",

  /**
   * Order item not cancellable.
   */
  NotCancellable: "NotCancellable",
}

/**
 * Describes whether the order item is deletable or not.
 */
union ActionStatusEnum {
  string,

  /**
   * Allowed flag.
   */
  Allowed: "Allowed",

  /**
   * Not Allowed flag.
   */
  NotAllowed: "NotAllowed",
}

/**
 * Describes whether the order item is returnable or not.
 */
union OrderItemReturnEnum {
  string,

  /**
   * Order item can be returned without fee.
   */
  Returnable: "Returnable",

  /**
   * Order item can be returned with fee.
   */
  ReturnableWithFee: "ReturnableWithFee",

  /**
   * Order item not returnable.
   */
  NotReturnable: "NotReturnable",
}

/**
 * Address Resource Collection.
 */
model AddressResourceList is Azure.Core.Page<AddressResource>;
@@visibility(AddressResourceList.value, Lifecycle.Read);

/**
 * Address Properties.
 */
model AddressProperties {
  /**
   * Type of address based on its usage context.
   */
  addressClassification?: AddressClassification;

  /**
   * Shipping details for the address.
   */
  shippingAddress?: ShippingAddress;

  /**
   * Contact details for the address.
   */
  contactDetails?: ContactDetails;

  /**
   * Status of address validation.
   */
  @visibility(Lifecycle.Read)
  addressValidationStatus?: AddressValidationStatus;

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Shipping address where customer wishes to receive the device.
 */
model ShippingAddress {
  /**
   * Street Address line 1.
   */
  streetAddress1?: string;

  /**
   * Street Address line 2.
   */
  streetAddress2?: string;

  /**
   * Street Address line 3.
   */
  streetAddress3?: string;

  /**
   * Name of the City.
   */
  city?: string;

  /**
   * Name of the State or Province.
   */
  stateOrProvince?: string;

  /**
   * Name of the Country.
   */
  country: string;

  /**
   * Postal code.
   */
  postalCode?: string;

  /**
   * Extended Zip Code.
   */
  zipExtendedCode?: string;

  /**
   * Name of the company.
   */
  companyName?: string;

  /**
   * Type of address.
   */
  addressType?: AddressType;
}

/**
 * Contact Details.
 */
model ContactDetails {
  /**
   * Contact name of the person.
   */
  contactName?: string;

  /**
   * Phone number of the contact person.
   */
  phone?: string;

  /**
   * Phone extension number of the contact person.
   */
  phoneExtension?: string;

  /**
   * Mobile number of the contact person.
   */
  mobile?: string;

  /**
   * List of Email-ids to be notified about job progress.
   */
  emailList?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Configuration request object.
 */
model ConfigurationsRequest {
  /**
   * Holds details about product hierarchy information and filterable property.
   */
  configurationFilter?: ConfigurationFilter;

  /**
   * Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details.
   */
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
}

/**
 * Configuration filters.
 */
model ConfigurationFilter {
  /**
   * Product hierarchy information.
   */
  hierarchyInformation: HierarchyInformation;

  /**
   * Filters specific to product.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  filterableProperty?: FilterableProperty[];

  /**
   * Filter to fetch specific child configurations that exist in the configuration. This must be passed to either fetch a list of specific child configurations, or all child configurations of specific types of child configurations.
   */
  childConfigurationFilter?: ChildConfigurationFilter;
}

/**
 * Holds details about product hierarchy information.
 */
model HierarchyInformation {
  /**
   * Represents product family name that uniquely identifies product family.
   */
  productFamilyName?: string;

  /**
   * Represents product line name that uniquely identifies product line.
   */
  productLineName?: string;

  /**
   * Represents product name that uniquely identifies product.
   */
  productName?: string;

  /**
   * Represents configuration name that uniquely identifies configuration.
   */
  configurationName?: string;

  /**
   * Represents Model Display Name.
   */
  configurationIdDisplayName?: string;
}

/**
 * Different types of filters supported and its values.
 */
model FilterableProperty {
  /**
   * Type of product filter.
   */
  type: SupportedFilterTypes;

  /**
   * Values to be filtered.
   */
  supportedValues: string[];
}

/**
 * Child configuration filter.
 */
model ChildConfigurationFilter {
  /**
   * The list of child configuration hierarchy customer wants to filter for the given configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  hierarchyInformations?: HierarchyInformation[];

  /**
   * Filter to fetch all child configurations belonging to the given list of configuration types.
   */
  childConfigurationTypes?: ChildConfigurationType[];
}

/**
 * Holds Customer subscription details. Clients can display available products to unregistered customers by explicitly passing subscription details.
 */
model CustomerSubscriptionDetails {
  /**
   * List of registered feature flags for subscription.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  registeredFeatures?: CustomerSubscriptionRegisteredFeatures[];

  /**
   * Location placement Id of a subscription.
   */
  locationPlacementId?: string;

  /**
   * Quota ID of a subscription.
   */
  quotaId: string;
}

/**
 * Represents subscription registered features.
 */
model CustomerSubscriptionRegisteredFeatures {
  /**
   * Name of subscription registered feature.
   */
  name?: string;

  /**
   * State of subscription registered feature.
   */
  state?: string;
}

/**
 * The list of configurations.
 */
model Configurations is Azure.Core.Page<Configuration>;
@@visibility(Configurations.value, Lifecycle.Read);

/**
 * Configuration object.
 */
model Configuration {
  /**
   * Properties of configuration.
   */
  @visibility(Lifecycle.Read)
  properties?: ConfigurationProperties;
}

/**
 * Properties of configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationProperties extends CommonProperties {
  /**
   * Specifications of the configuration.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  specifications?: Specification[];

  /**
   * Dimensions of the configuration.
   */
  @visibility(Lifecycle.Read)
  dimensions?: Dimensions;

  /**
   * Determining nature of provisioning that the configuration supports.
   */
  @visibility(Lifecycle.Read)
  provisioningSupport?: ProvisioningSupport;

  /**
   * Different types of child configurations which exist for this configuration, these can be used to populate the child configuration filter.
   */
  @visibility(Lifecycle.Read)
  childConfigurationTypes?: ChildConfigurationType[];

  /**
   * Child configurations present for the configuration after applying child configuration filter, grouped by the category name of the child configuration.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  groupedChildConfigurations?: GroupedChildConfigurations[];

  /**
   * The Term Commitment Durations that are supported for a configuration.
   */
  @visibility(Lifecycle.Read)
  supportedTermCommitmentDurations?: duration[];
}

/**
 * Specification of the configurations.
 */
model Specification {
  /**
   * Name of the specification.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Value of the specification.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Dimensions of a configuration.
 */
model Dimensions {
  /**
   * Length of the device.
   */
  @visibility(Lifecycle.Read)
  length?: float64;

  /**
   * Height of the device.
   */
  @visibility(Lifecycle.Read)
  height?: float64;

  /**
   * Width of the device.
   */
  @visibility(Lifecycle.Read)
  width?: float64;

  /**
   * Unit for the dimensions of length, height and width.
   */
  @visibility(Lifecycle.Read)
  lengthHeightUnit?: LengthHeightUnit;

  /**
   * Weight of the device.
   */
  @visibility(Lifecycle.Read)
  weight?: float64;

  /**
   * Depth of the device.
   */
  @visibility(Lifecycle.Read)
  depth?: float64;

  /**
   * Unit for the dimensions of weight.
   */
  @visibility(Lifecycle.Read)
  weightUnit?: WeightMeasurementUnit;
}

/**
 * Grouped child configuration object.
 */
model GroupedChildConfigurations {
  /**
   * Category information.
   */
  @visibility(Lifecycle.Read)
  categoryInformation?: CategoryInformation;

  /**
   * List of child configurations.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  childConfigurations?: ChildConfiguration[];
}

/**
 * Category related properties of a child configuration.
 */
model CategoryInformation {
  /**
   * Category name of the child configuration.
   */
  categoryName?: string;

  /**
   * Category display name of the child configuration.
   */
  categoryDisplayName?: string;

  /**
   * Description text for the category.
   */
  description?: string;

  /**
   * Links for the category.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  links?: Link[];
}

/**
 * Returns link related to the product.
 */
model Link {
  /**
   * Type of link.
   */
  @visibility(Lifecycle.Read)
  linkType?: LinkType;

  /**
   * Url of the link.
   */
  @visibility(Lifecycle.Read)
  linkUrl?: string;
}

/**
 * Child configuration object.
 */
model ChildConfiguration {
  /**
   * Properties of child configuration.
   */
  @visibility(Lifecycle.Read)
  properties?: ChildConfigurationProperties;
}

/**
 * Properties of child configuration.
 */
model ChildConfigurationProperties {
  /**
   * Child configuration type.
   */
  @visibility(Lifecycle.Read)
  childConfigurationType?: ChildConfigurationType;

  /**
   * Flag to indicate if the child configuration is part of the base configuration, which means the customer need not pass this configuration in OptInAdditionalConfigurations while placing an order, it will be shipped by default.
   */
  @visibility(Lifecycle.Read)
  isPartOfBaseConfiguration?: boolean;

  /**
   * Minimum quantity a customer can order while choosing this configuration.
   */
  @visibility(Lifecycle.Read)
  minimumQuantity?: int32;

  /**
   * Maximum quantity a customer can order while choosing this configuration.
   */
  @visibility(Lifecycle.Read)
  maximumQuantity?: int32;

  /**
   * Specifications of the configuration.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  specifications?: Specification[];

  /**
   * Dimensions of the configuration.
   */
  @visibility(Lifecycle.Read)
  dimensions?: Dimensions;

  /**
   * Determining nature of provisioning that the configuration supports.
   */
  @visibility(Lifecycle.Read)
  provisioningSupport?: ProvisioningSupport;

  /**
   * Different types of child configurations which exist for this configuration, these can be used to populate the child configuration filter.
   */
  @visibility(Lifecycle.Read)
  childConfigurationTypes?: ChildConfigurationType[];

  /**
   * Child configurations present for the configuration after applying child configuration filter, grouped by the category name of the child configuration.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  groupedChildConfigurations?: GroupedChildConfigurations[];

  /**
   * The Term Commitment Durations that are supported for a configuration.
   */
  @visibility(Lifecycle.Read)
  supportedTermCommitmentDurations?: duration[];

  /**
   * List of filters supported for a product.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  filterableProperties?: FilterableProperty[];

  /**
   * Display Name for the product system.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description related to the product system.
   */
  @visibility(Lifecycle.Read)
  description?: Description;

  /**
   * Image information for the product system.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  imageInformation?: ImageInformation[];

  /**
   * Cost information for the product system.
   */
  @visibility(Lifecycle.Read)
  costInformation?: CostInformation;

  /**
   * Availability information of the product system.
   */
  @visibility(Lifecycle.Read)
  availabilityInformation?: AvailabilityInformation;

  /**
   * Hierarchy information of a product.
   */
  @visibility(Lifecycle.Read)
  hierarchyInformation?: HierarchyInformation;

  /**
   * The entity responsible for fulfillment of the item at the given hierarchy level.
   */
  @visibility(Lifecycle.Read)
  fulfilledBy?: FulfillmentType;
}

/**
 * Description related properties of a product system.
 */
model Description {
  /**
   * Type of description.
   */
  @visibility(Lifecycle.Read)
  descriptionType?: DescriptionType;

  /**
   * Short description of the product system.
   */
  @visibility(Lifecycle.Read)
  shortDescription?: string;

  /**
   * Long description of the product system.
   */
  @visibility(Lifecycle.Read)
  longDescription?: string;

  /**
   * Keywords for the product system.
   */
  @visibility(Lifecycle.Read)
  keywords?: string[];

  /**
   * Attributes for the product system.
   */
  @visibility(Lifecycle.Read)
  attributes?: string[];

  /**
   * Links for the product system.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  links?: Link[];
}

/**
 * Image for the product.
 */
model ImageInformation {
  /**
   * Type of the image.
   */
  @visibility(Lifecycle.Read)
  imageType?: ImageType;

  /**
   * Url of the image.
   */
  @visibility(Lifecycle.Read)
  imageUrl?: string;
}

/**
 * Cost information for the product system.
 */
model CostInformation {
  /**
   * Details on the various billing aspects for the product system.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  billingMeterDetails?: BillingMeterDetails[];

  /**
   * Default url to display billing information.
   */
  @visibility(Lifecycle.Read)
  billingInfoUrl?: string;
}

/**
 * Holds billing meter details for each type of billing.
 */
model BillingMeterDetails {
  /**
   * Represents Billing type name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Represents MeterDetails.
   */
  @visibility(Lifecycle.Read)
  meterDetails?: MeterDetails;

  /**
   * Represents Metering type (eg one-time or recurrent).
   */
  @visibility(Lifecycle.Read)
  meteringType?: MeteringType;

  /**
   * Frequency of recurrence.
   */
  @visibility(Lifecycle.Read)
  frequency?: string;

  /**
   * Represent Term Type details.
   */
  @visibility(Lifecycle.Read)
  termTypeDetails?: TermTypeDetails;
}

/**
 * Holds details about billing type and its meter guids.
 */
@discriminator("billingType")
model MeterDetails {
  /**
   * Represents billing type.
   */
  billingType: BillingType;

  /**
   * Billing unit applicable for Pav2 billing.
   */
  @visibility(Lifecycle.Read)
  multiplier?: float64;

  /**
   * Charging type.
   */
  @visibility(Lifecycle.Read)
  chargingType?: ChargingType;
}

/**
 * Holds details about term type and duration.
 */
model TermTypeDetails {
  /**
   * Term Commitment Type
   */
  termType: TermCommitmentType;

  /**
   * Duration for the term type.
   */
  termTypeDuration: duration;
}

/**
 * Availability information of a product system.
 */
model AvailabilityInformation {
  /**
   * Current availability stage of the product.
   */
  @visibility(Lifecycle.Read)
  availabilityStage?: AvailabilityStage;

  /**
   * Reason why the product is disabled.
   */
  @visibility(Lifecycle.Read)
  disabledReason?: DisabledReason;

  /**
   * Message for why the product is disabled.
   */
  @visibility(Lifecycle.Read)
  disabledReasonMessage?: string;
}

/**
 * Represents common properties across product hierarchy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CommonProperties extends BasicInformation {
  /**
   * List of filters supported for a product.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  filterableProperties?: FilterableProperty[];
}

/**
 * Basic information for any product system.
 */
model BasicInformation {
  /**
   * Display Name for the product system.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description related to the product system.
   */
  @visibility(Lifecycle.Read)
  description?: Description;

  /**
   * Image information for the product system.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  imageInformation?: ImageInformation[];

  /**
   * Cost information for the product system.
   */
  @visibility(Lifecycle.Read)
  costInformation?: CostInformation;

  /**
   * Availability information of the product system.
   */
  @visibility(Lifecycle.Read)
  availabilityInformation?: AvailabilityInformation;

  /**
   * Hierarchy information of a product.
   */
  @visibility(Lifecycle.Read)
  hierarchyInformation?: HierarchyInformation;

  /**
   * The entity responsible for fulfillment of the item at the given hierarchy level.
   */
  @visibility(Lifecycle.Read)
  fulfilledBy?: FulfillmentType;
}

/**
 * The filters for showing the product families.
 */
model ProductFamiliesRequest {
  /**
   * Dictionary of filterable properties on product family.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filterableProperties: Record<FilterableProperty[]>;

  /**
   * Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details.
   */
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
}

/**
 * The list of product families.
 */
model ProductFamilies is Azure.Core.Page<ProductFamily>;
@@visibility(ProductFamilies.value, Lifecycle.Read);

/**
 * Product Family.
 */
model ProductFamily {
  /**
   * Properties of product family.
   */
  @visibility(Lifecycle.Read)
  properties?: ProductFamilyProperties;
}

/**
 * Properties of product family.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductFamilyProperties extends CommonProperties {
  /**
   * List of product lines supported in the product family.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  productLines?: ProductLine[];

  /**
   * Contains details related to resource provider.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  resourceProviderDetails?: ResourceProviderDetails[];
}

/**
 * Product line.
 */
model ProductLine {
  /**
   * Properties of product line.
   */
  @visibility(Lifecycle.Read)
  properties?: ProductLineProperties;
}

/**
 * Properties of product line.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductLineProperties extends CommonProperties {
  /**
   * List of products in the product line.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  products?: Product[];
}

/**
 * Represents a product.
 */
model Product {
  /**
   * Properties of product.
   */
  @visibility(Lifecycle.Read)
  properties?: ProductProperties;
}

/**
 * Properties of product.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductProperties extends CommonProperties {
  /**
   * List of configurations for the product.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  configurations?: Configuration[];
}

/**
 * Management RP details.
 */
model ResourceProviderDetails {
  /**
   * Resource provider namespace.
   */
  @visibility(Lifecycle.Read)
  resourceProviderNamespace?: string;
}

/**
 * List of order items.
 */
model OrderItemResourceList is Azure.Core.Page<OrderItemResource>;
@@visibility(OrderItemResourceList.value, Lifecycle.Read);

/**
 * Represents order item properties.
 */
model OrderItemProperties {
  /**
   * Represents order item details.
   */
  orderItemDetails: OrderItemDetails;

  /**
   * Represents shipping and return address for order item.
   */
  addressDetails?: AddressDetails;

  /**
   * Start time of order item.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Id of the order to which order item belongs to.
   */
  orderId: string;

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Order item details.
 */
model OrderItemDetails {
  /**
   * Represents product details.
   */
  productDetails: ProductDetails;

  /**
   * Order item type.
   */
  orderItemType: OrderItemType;

  /**
   * Defines the mode of the Order item.
   */
  orderItemMode?: OrderMode;

  /**
   * Site Related Details.
   */
  siteDetails?: SiteDetails;

  /**
   * Current Order item Status.
   */
  @visibility(Lifecycle.Read)
  currentStage?: StageDetails;

  /**
   * Order item status history.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  orderItemStageHistory?: StageDetails[];

  /**
   * Customer notification Preferences.
   */
  preferences?: Preferences;

  /**
   * Forward Package Shipping details.
   */
  @visibility(Lifecycle.Read)
  forwardShippingDetails?: ForwardShippingDetails;

  /**
   * Reverse Package Shipping details.
   */
  @visibility(Lifecycle.Read)
  reverseShippingDetails?: ReverseShippingDetails;

  /**
   * Additional notification email list.
   */
  notificationEmailList?: string[];

  /**
   * Cancellation reason.
   */
  @visibility(Lifecycle.Read)
  cancellationReason?: string;

  /**
   * Describes whether the order item is cancellable or not.
   */
  @visibility(Lifecycle.Read)
  cancellationStatus?: OrderItemCancellationEnum;

  /**
   * Describes whether the order item is deletable or not.
   */
  @visibility(Lifecycle.Read)
  deletionStatus?: ActionStatusEnum;

  /**
   * Return reason.
   */
  @visibility(Lifecycle.Read)
  returnReason?: string;

  /**
   * Describes whether the order item is returnable or not.
   */
  @visibility(Lifecycle.Read)
  returnStatus?: OrderItemReturnEnum;

  /**
   * List of parent RP details supported for configuration.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  managementRpDetailsList?: ResourceProviderDetails[];

  /**
   * Top level error for the job.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorDetail;
}

/**
 * Represents product details.
 */
model ProductDetails {
  /**
   * Display details of the product.
   */
  displayInfo?: DisplayInfo;

  /**
   * Hierarchy of the product which uniquely identifies the product.
   */
  hierarchyInformation: HierarchyInformation;

  /**
   * Double encryption status of the configuration. Read-only field.
   */
  @visibility(Lifecycle.Read)
  productDoubleEncryptionStatus?: DoubleEncryptionStatus;

  /**
   * Identification type of the configuration.
   */
  @visibility(Lifecycle.Read)
  identificationType?: IdentificationType;

  /**
   * Device details of the parent configuration.
   */
  @visibility(Lifecycle.Read)
  parentDeviceDetails?: DeviceDetails;

  /**
   * Device Provisioning Details for Parent.
   */
  parentProvisioningDetails?: ProvisioningDetails;

  /**
   * List of additional configurations customer wants in the order item apart from the ones included in the base configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  optInAdditionalConfigurations?: AdditionalConfiguration[];

  /**
   * Details of all child configurations that are part of the order item.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  childConfigurationDeviceDetails?: ConfigurationDeviceDetails[];

  /**
   * Term Commitment Information of the Device.
   */
  @visibility(Lifecycle.Read)
  termCommitmentInformation?: TermCommitmentInformation;
}

/**
 * Describes product display information.
 */
model DisplayInfo {
  /**
   * Product family display name.
   */
  @visibility(Lifecycle.Read)
  productFamilyDisplayName?: string;

  /**
   * Configuration display name.
   */
  @visibility(Lifecycle.Read)
  configurationDisplayName?: string;
}

/**
 * Device details.
 */
model DeviceDetails {
  /**
   * Device serial number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Device serial number to be displayed.
   */
  @visibility(Lifecycle.Read)
  displaySerialNumber?: string;

  /**
   * Management Resource Id.
   */
  @visibility(Lifecycle.Read)
  managementResourceId?: string;

  /**
   * Management Resource Tenant ID.
   */
  @visibility(Lifecycle.Read)
  managementResourceTenantId?: string;

  /**
   * Determining nature of provisioning that the configuration supports.
   */
  @visibility(Lifecycle.Read)
  provisioningSupport?: ProvisioningSupport;

  /**
   * Provisioning Details for the device.
   */
  @visibility(Lifecycle.Read)
  provisioningDetails?: ProvisioningDetails;
}

/**
 * Details Related To Provision Resource.
 */
model ProvisioningDetails {
  /**
   * Quantity of the devices.
   */
  @minValue(0)
  quantity?: int32 = 0;

  /**
   * Provisioning Resource Arm ID.
   */
  provisioningArmId?: Azure.Core.armResourceIdentifier;

  /**
   * Provisioning End Point.
   */
  provisioningEndPoint?: string;

  /**
   * Serial Number for the Device.
   */
  serialNumber?: string;

  /**
   * Vendor Name for the Device , (for 1P devices - Microsoft).
   */
  vendorName?: string;

  /**
   * Arc Enabled Resource Arm id.
   */
  readyToConnectArmId?: Azure.Core.armResourceIdentifier;

  /**
   * Management Resource ArmId.
   */
  managementResourceArmId?: Azure.Core.armResourceIdentifier;

  /**
   * Unique Identity for a Device.
   */
  @visibility(Lifecycle.Read)
  uniqueDeviceIdentifier?: string;

  /**
   * Auto Provisioning Details.
   */
  autoProvisioningStatus?: AutoProvisioningStatus;

  /**
   * Proof of possession details.
   */
  devicePresenceVerification?: DevicePresenceVerificationDetails;
}

/**
 * Proof of possession details.
 */
model DevicePresenceVerificationDetails {
  /**
   * Proof of possession status.
   */
  @visibility(Lifecycle.Read)
  status?: DevicePresenceVerificationStatus;

  /**
   * Insights on current status.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Additional Configuration details.
 */
model AdditionalConfiguration {
  /**
   * Hierarchy of the product which uniquely identifies the configuration.
   */
  hierarchyInformation: HierarchyInformation;

  /**
   * Quantity of the product.
   */
  quantity: int32;

  /**
   * List Provisioning Details for Devices in Additional Config.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  provisioningDetails?: ProvisioningDetails[];
}

/**
 * Device details for configuration.
 */
model ConfigurationDeviceDetails {
  /**
   * Display details of the product.
   */
  displayInfo?: DisplayInfo;

  /**
   * Hierarchy of the product which uniquely identifies the configuration.
   */
  @visibility(Lifecycle.Read)
  hierarchyInformation?: HierarchyInformation;

  /**
   * Quantity of the product.
   */
  @visibility(Lifecycle.Read)
  quantity?: int32;

  /**
   * Identification type of the configuration.
   */
  @visibility(Lifecycle.Read)
  identificationType?: IdentificationType;

  /**
   * List of device details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  deviceDetails?: DeviceDetails[];

  /**
   * Term Commitment Information of the Device.
   */
  @visibility(Lifecycle.Read)
  termCommitmentInformation?: TermCommitmentInformation;
}

/**
 * Term Commitment Information.
 */
model TermCommitmentInformation {
  /**
   * Term Commitment Type
   */
  termCommitmentType: TermCommitmentType;

  /**
   * Term Commitment Duration. Currently Supporting P365D, P1095D
   */
  @visibility(Lifecycle.Read)
  termCommitmentTypeDuration?: duration;

  /**
   * Number of Days Pending for Term Commitment
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  pendingDaysForTerm?: int32 = 0;
}

/**
 * Represents Site Related Details.
 */
model SiteDetails {
  /**
   * Unique Id, Identifying A Site.
   */
  siteId: string;
}

/**
 * Resource stage details.
 */
model StageDetails {
  /**
   * Stage status.
   */
  @visibility(Lifecycle.Read)
  stageStatus?: StageStatus;

  /**
   * Stage name.
   */
  @visibility(Lifecycle.Read)
  stageName?: StageName;

  /**
   * Display name of the resource stage.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Stage start time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * Preferences related to the order.
 */
model Preferences {
  /**
   * Notification preferences.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  notificationPreferences?: NotificationPreference[];

  /**
   * Preferences related to the shipment logistics of the order.
   */
  transportPreferences?: TransportPreferences;

  /**
   * Preferences related to the Encryption.
   */
  encryptionPreferences?: EncryptionPreferences;

  /**
   * Preferences related to the Management resource.
   */
  managementResourcePreferences?: ManagementResourcePreferences;

  /**
   * Preferences related to the Term commitment.
   */
  termCommitmentPreferences?: TermCommitmentPreferences;
}

/**
 * Notification preference for a job stage.
 */
model NotificationPreference {
  /**
   * Name of the stage.
   */
  stageName: NotificationStageName;

  /**
   * Notification is required or not.
   */
  sendNotification: boolean;
}

/**
 * Preferences related to the shipment logistics of the sku.
 */
model TransportPreferences {
  /**
   * Indicates Shipment Logistics type that the customer preferred.
   */
  preferredShipmentType: TransportShipmentTypes;
}

/**
 * Preferences related to the double encryption.
 */
model EncryptionPreferences {
  /**
   * Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.
   */
  doubleEncryptionStatus?: DoubleEncryptionStatus;
}

/**
 * Management resource preference to link device.
 */
model ManagementResourcePreferences {
  /**
   * Customer preferred Management resource ARM ID.
   */
  preferredManagementResourceId?: string;
}

/**
 * Term Commitment preference received from customer.
 */
model TermCommitmentPreferences {
  /**
   * Term Commitment Type
   */
  preferredTermCommitmentType: TermCommitmentType;

  /**
   * Customer preferred Term Duration.
   */
  preferredTermCommitmentDuration?: duration;
}

/**
 * Forward shipment details.
 */
model ForwardShippingDetails {
  /**
   * Name of the carrier.
   */
  @visibility(Lifecycle.Read)
  carrierName?: string;

  /**
   * Carrier Name for display purpose. Not to be used for any processing.
   */
  @visibility(Lifecycle.Read)
  carrierDisplayName?: string;

  /**
   * TrackingId of the package.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * TrackingUrl of the package.
   */
  @visibility(Lifecycle.Read)
  trackingUrl?: string;
}

/**
 * Reverse shipment details.
 */
model ReverseShippingDetails {
  /**
   * SAS key to download the reverse shipment label of the package.
   */
  @visibility(Lifecycle.Read)
  sasKeyForLabel?: string;

  /**
   * Name of the carrier.
   */
  @visibility(Lifecycle.Read)
  carrierName?: string;

  /**
   * Carrier Name for display purpose. Not to be used for any processing.
   */
  @visibility(Lifecycle.Read)
  carrierDisplayName?: string;

  /**
   * TrackingId of the package.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;

  /**
   * TrackingUrl of the package.
   */
  @visibility(Lifecycle.Read)
  trackingUrl?: string;
}

/**
 * Address details for an order item.
 */
model AddressDetails {
  /**
   * Customer address and contact details.
   */
  forwardAddress: AddressProperties;

  /**
   * Return shipping address.
   */
  @visibility(Lifecycle.Read)
  returnAddress?: AddressProperties;
}

/**
 * Msi identity details of the resource
 */
model ResourceIdentity {
  /**
   * Identity type
   */
  type?: string = "None";

  /**
   * Service Principal Id backing the Msi
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Home Tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * User Assigned Identities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity | null>;
}

/**
 * List of orders.
 */
model OrderResourceList is Azure.Core.Page<OrderResource>;
@@visibility(OrderResourceList.value, Lifecycle.Read);

/**
 * Represents order details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OrderProperties {
  /**
   * List of order item ARM Ids which are part of an order.
   */
  @visibility(Lifecycle.Read)
  orderItemIds?: string[];

  /**
   * Order current status.
   */
  @visibility(Lifecycle.Read)
  currentStage?: StageDetails;

  /**
   * Order status history.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  orderStageHistory?: StageDetails[];

  /**
   * Order mode.
   */
  @visibility(Lifecycle.Read)
  orderMode?: OrderMode;
}

/**
 * Holds details about product family metadata.
 */
model ProductFamiliesMetadata
  is Azure.Core.Page<ProductFamiliesMetadataDetails>;
@@visibility(ProductFamiliesMetadata.value, Lifecycle.Read);

/**
 * Product families metadata details.
 */
model ProductFamiliesMetadataDetails {
  /**
   * Product family properties.
   */
  @visibility(Lifecycle.Read)
  properties?: ProductFamilyProperties;
}

/**
 * The Address update parameters.
 */
model AddressUpdateParameter {
  /**
   * Properties of an address to be updated.
   */
  properties?: AddressUpdateProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Address Update Properties.
 */
model AddressUpdateProperties {
  /**
   * Shipping details for the address.
   */
  shippingAddress?: ShippingAddress;

  /**
   * Contact details for the address.
   */
  contactDetails?: ContactDetails;
}

/**
 * Updates order item parameters.
 */
model OrderItemUpdateParameter {
  /**
   * Order item update properties.
   */
  properties?: OrderItemUpdateProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Msi identity of the resource
   */
  identity?: ResourceIdentity;
}

/**
 * Order item update properties.
 */
model OrderItemUpdateProperties {
  /**
   * Updates forward shipping address and contact details.
   */
  forwardAddress?: AddressProperties;

  /**
   * Customer preference.
   */
  preferences?: Preferences;

  /**
   * Additional notification email list.
   */
  notificationEmailList?: string[];

  /**
   * Represents order item details.
   */
  orderItemDetails?: OrderItemDetailsUpdateParameter;
}

/**
 * Order item details Patchable Properties.
 */
model OrderItemDetailsUpdateParameter {
  /**
   * Represents product details.
   */
  productDetails?: ProductDetailsUpdateParameter;

  /**
   * Site Related Details.
   */
  siteDetails?: SiteDetails;
}

/**
 * Represents product details patchable properties.
 */
model ProductDetailsUpdateParameter {
  /**
   * Device Provisioning Details for Parent.
   */
  parentProvisioningDetails?: ProvisioningDetails;
}

/**
 * Reason for cancellation.
 */
model CancellationReason {
  /**
   * Reason for cancellation.
   */
  reason: string;
}

/**
 * Return order item request body.
 */
model ReturnOrderItemDetails {
  /**
   * Customer return address.
   */
  returnAddress?: AddressProperties;

  /**
   * Return Reason.
   */
  returnReason: string;

  /**
   * Service tag (located on the bottom-right corner of the device).
   */
  serviceTag?: string;

  /**
   * Shipping Box required.
   */
  shippingBoxRequired?: boolean = false;
}

/**
 * Billing type PAV2 meter details.
 */
model Pav2MeterDetails extends MeterDetails {
  /**
   * Validation status of requested data center and transport.
   */
  @visibility(Lifecycle.Read)
  meterGuid?: string;

  /**
   * Represents billing type.
   */
  billingType: "Pav2";
}

/**
 * Billing type Purchase meter details.
 */
model PurchaseMeterDetails extends MeterDetails {
  /**
   * Product Id.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * Sku Id.
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * Term Id.
   */
  @visibility(Lifecycle.Read)
  termId?: string;

  /**
   * Represents billing type.
   */
  billingType: "Purchase";
}

/**
 * Resource move request body.
 */
model ResourceMoveRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetResourceGroup?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resources?: string[];
}
