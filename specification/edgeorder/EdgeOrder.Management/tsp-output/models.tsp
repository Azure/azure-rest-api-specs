import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EdgeOrder;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Type of address.
 */
enum AddressType {
  /**
   * Address type not known.
   */
  None,

  /**
   * Residential Address.
   */
  Residential,

  /**
   * Commercial Address.
   */
  Commercial,
}

/**
 * Status of address validation
 */
enum AddressValidationStatus {
  /**
   * Address provided is valid.
   */
  Valid,

  /**
   * Address provided is invalid or not supported.
   */
  Invalid,

  /**
   * Address provided is ambiguous, please choose one of the alternate addresses returned.
   */
  Ambiguous,
}

/**
 * Type of product filter.
 */
enum SupportedFilterTypes {
  /**
   * Ship to country
   */
  ShipToCountries,

  /**
   * Double encryption status
   */
  DoubleEncryptionStatus,
}

/**
 * Unit for the dimensions of length, height and width.
 */
enum LengthHeightUnit {
  /**
   * Inch, applicable for West US.
   */
  IN,

  /**
   * Centimeter.
   */
  CM,
}

/**
 * Unit for the dimensions of weight.
 */
enum WeightMeasurementUnit {
  /**
   * Pounds.
   */
  LBS,

  /**
   * Kilograms.
   */
  KGS,
}

/**
 * Type of description.
 */
enum DescriptionType {
  /**
   * Base description.
   */
  Base,
}

/**
 * Type of link
 */
enum LinkType {
  /**
   * Generic link.
   */
  Generic,

  /**
   * Terms and conditions link.
   */
  TermsAndConditions,

  /**
   * Link to product specification.
   */
  Specification,

  /**
   * Link to product documentation
   */
  Documentation,

  /**
   * Link to know more
   */
  KnowMore,

  /**
   * Link to sign up for products
   */
  SignUp,
}

/**
 * Type of the image
 */
enum ImageType {
  /**
   * Main image.
   */
  MainImage,

  /**
   * Bullet image.
   */
  BulletImage,

  /**
   * Generic image.
   */
  GenericImage,
}

/**
 * Represents billing type.
 */
enum BillingType {
  /**
   * PaV2 billing.
   */
  Pav2,

  /**
   * Purchase billing.
   */
  Purchase,
}

/**
 * Charging type.
 */
enum ChargingType {
  /**
   * Per order charging type.
   */
  PerOrder,

  /**
   * Per device charging type.
   */
  PerDevice,
}

/**
 * Represents Metering type (eg one-time or recurrent)
 */
enum MeteringType {
  /**
   * One time billing.
   */
  OneTime,

  /**
   * Recurring billing.
   */
  Recurring,

  /**
   * Adhoc billing.
   */
  Adhoc,
}

/**
 * Current availability stage of the product. Availability stage
 */
enum AvailabilityStage {
  /**
   * Product is available.
   */
  Available,

  /**
   * Product is coming soon.
   */
  ComingSoon,

  /**
   * Product is in preview.
   */
  Preview,

  /**
   * Product is deprecated.
   */
  Deprecated,

  /**
   * Product is available only on signup.
   */
  Signup,

  /**
   * Product is not available.
   */
  Unavailable,
}

/**
 * Reason why the product is disabled.
 */
enum DisabledReason {
  /**
   * Not disabled.
   */
  None,

  /**
   * Not available in the requested country.
   */
  Country,

  /**
   * Not available to push data to the requested Azure region.
   */
  Region,

  /**
   * Required features are not enabled.
   */
  Feature,

  /**
   * Subscription does not have required offer types.
   */
  OfferType,

  /**
   * Subscription has not registered to Microsoft.DataBox and Service does not have the subscription notification.
   */
  NoSubscriptionInfo,

  /**
   * The product is not yet available.
   */
  NotAvailable,

  /**
   * The product is out of stock.
   */
  OutOfStock,
}

/**
 * Stage status.
 */
enum StageStatus {
  /**
   * No status available yet.
   */
  None,

  /**
   * Stage is in progress.
   */
  InProgress,

  /**
   * Stage has succeeded.
   */
  Succeeded,

  /**
   * Stage has failed.
   */
  Failed,

  /**
   * Stage has been cancelled.
   */
  Cancelled,

  /**
   * Stage is cancelling.
   */
  Cancelling,
}

/**
 * Stage name
 */
enum StageName {
  /**
   * Currently in draft mode and can still be cancelled
   */
  Placed,

  /**
   * Order is currently in draft mode and can still be cancelled
   */
  InReview,

  /**
   * Order is confirmed
   */
  Confirmed,

  /**
   * Order is ready to ship
   */
  ReadyToShip,

  /**
   * Order is in transit to customer
   */
  Shipped,

  /**
   * Order is delivered to customer
   */
  Delivered,

  /**
   * Order is in use at customer site
   */
  InUse,

  /**
   * Return has been initiated by customer.
   */
  ReturnInitiated,

  /**
   * Order is in transit from customer to microsoft.
   */
  ReturnPickedUp,

  /**
   * Order has been received back to microsoft.
   */
  ReturnedToMicrosoft,

  /**
   * Return has now completed.
   */
  ReturnCompleted,

  /**
   * Order has been cancelled.
   */
  Cancelled,
}

/**
 * Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.
 */
enum DoubleEncryptionStatus {
  /**
   * Double encryption is disabled
   */
  Disabled,

  /**
   * Double encryption is enabled
   */
  Enabled,
}

/**
 * Order item type.
 */
enum OrderItemType {
  /**
   * Purchase OrderItem.
   */
  Purchase,

  /**
   * Rental OrderItem.
   */
  Rental,
}

/**
 * Name of the stage.
 */
enum NotificationStageName {
  /**
   * Notification at order item shipped from microsoft datacenter.
   */
  Shipped,

  /**
   * Notification at order item delivered to customer.
   */
  Delivered,
}

/**
 * Indicates Shipment Logistics type that the customer preferred.
 */
enum TransportShipmentTypes {
  /**
   * Shipment Logistics is handled by the customer.
   */
  CustomerManaged,

  /**
   * Shipment Logistics is handled by Microsoft.
   */
  MicrosoftManaged,
}

/**
 * Describes whether the order item is cancellable or not.
 */
enum OrderItemCancellationEnum {
  /**
   * Order item can be cancelled without fee.
   */
  Cancellable,

  /**
   * Order item can be cancelled with fee.
   */
  CancellableWithFee,

  /**
   * Order item not cancellable.
   */
  NotCancellable,
}

/**
 * Describes whether the order item is deletable or not.
 */
enum ActionStatusEnum {
  /**
   * Allowed flag.
   */
  Allowed,

  /**
   * Not Allowed flag.
   */
  NotAllowed,
}

/**
 * Describes whether the order item is returnable or not.
 */
enum OrderItemReturnEnum {
  /**
   * Order item can be returned without fee.
   */
  Returnable,

  /**
   * Order item can be returned with fee.
   */
  ReturnableWithFee,

  /**
   * Order item not returnable.
   */
  NotReturnable,
}

/**
 * Address Properties
 */
model AddressProperties {
  /**
   * Shipping details for the address
   */
  shippingAddress?: ShippingAddress;

  /**
   * Contact details for the address
   */
  contactDetails: ContactDetails;

  /**
   * Status of address validation
   */
  @visibility("read")
  addressValidationStatus?: AddressValidationStatus;
}

/**
 * Shipping address where customer wishes to receive the device.
 */
model ShippingAddress {
  /**
   * Street Address line 1.
   */
  streetAddress1: string;

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
  contactName: string;

  /**
   * Phone number of the contact person.
   */
  phone: string;

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
  emailList: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The filters for showing the product families.
 */
model ProductFamiliesRequest {
  /**
   * Dictionary of filterable properties on product family.
   */
  filterableProperties: Record<FilterableProperty[]>;

  /**
   * Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details
   */
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
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
 * Holds Customer subscription details. Clients can display available products to unregistered customers by explicitly passing subscription details
 */
model CustomerSubscriptionDetails {
  /**
   * List of registered feature flags for subscription
   */
  registeredFeatures?: CustomerSubscriptionRegisteredFeatures[];

  /**
   * Location placement Id of a subscription
   */
  locationPlacementId?: string;

  /**
   * Quota ID of a subscription
   */
  quotaId: string;
}

/**
 * Represents subscription registered features
 */
model CustomerSubscriptionRegisteredFeatures {
  /**
   * Name of subscription registered feature
   */
  name?: string;

  /**
   * State of subscription registered feature
   */
  state?: string;
}

/**
 * The list of product families.
 */
model ProductFamilies is Azure.Core.Page<ProductFamily>;

/**
 * Product Family
 */
model ProductFamily {
  /**
   * Properties of product family
   */
  @visibility("read")
  properties?: ProductFamilyProperties;
}

/**
 * Properties of product family
 */
model ProductFamilyProperties extends CommonProperties {
  /**
   * List of product lines supported in the product family
   */
  @visibility("read")
  productLines?: ProductLine[];

  /**
   * Contains details related to resource provider
   */
  resourceProviderDetails?: ResourceProviderDetails[];
}

/**
 * Product line
 */
model ProductLine {
  /**
   * Properties of product line
   */
  @visibility("read")
  properties?: ProductLineProperties;
}

/**
 * Properties of product line
 */
model ProductLineProperties extends CommonProperties {
  /**
   * List of products in the product line
   */
  @visibility("read")
  products?: EdgeOrderProduct[];
}

/**
 * List of Products
 */
model EdgeOrderProduct {
  /**
   * Properties of product
   */
  @visibility("read")
  properties?: ProductProperties;
}

/**
 * Properties of products
 */
model ProductProperties extends CommonProperties {
  /**
   * List of configurations for the product
   */
  @visibility("read")
  configurations?: ProductConfiguration[];
}

/**
 * Configuration object.
 */
model ProductConfiguration {
  /**
   * Properties of configuration
   */
  @visibility("read")
  properties?: ConfigurationProperties;
}

/**
 * Properties of configuration
 */
model ConfigurationProperties extends CommonProperties {
  /**
   * Specifications of the configuration
   */
  @visibility("read")
  specifications?: ProductSpecification[];

  /**
   * Dimensions of the configuration
   */
  @visibility("read")
  dimensions?: ProductDimensions;
}

/**
 * Specifications of the configurations
 */
model ProductSpecification {
  /**
   * Name of the specification
   */
  @visibility("read")
  name?: string;

  /**
   * Value of the specification
   */
  @visibility("read")
  value?: string;
}

/**
 * Dimensions of a configuration.
 */
model ProductDimensions {
  /**
   * Length of the device.
   */
  @visibility("read")
  length?: float64;

  /**
   * Height of the device.
   */
  @visibility("read")
  height?: float64;

  /**
   * Width of the device.
   */
  @visibility("read")
  width?: float64;

  /**
   * Unit for the dimensions of length, height and width.
   */
  @visibility("read")
  lengthHeightUnit?: LengthHeightUnit;

  /**
   * Weight of the device.
   */
  @visibility("read")
  weight?: float64;

  /**
   * Depth of the device.
   */
  @visibility("read")
  depth?: float64;

  /**
   * Unit for the dimensions of weight.
   */
  @visibility("read")
  weightUnit?: WeightMeasurementUnit;
}

/**
 * Represents common properties across product hierarchy
 */
model CommonProperties extends BasicInformation {
  /**
   * list of filters supported for a product
   */
  @visibility("read")
  filterableProperties?: FilterableProperty[];
}

/**
 * Basic information for any product system
 */
model BasicInformation {
  /**
   * Display Name for the product system.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Description related to the product system.
   */
  @visibility("read")
  description?: ProductDescription;

  /**
   * Image information for the product system.
   */
  @visibility("read")
  imageInformation?: ImageInformation[];

  /**
   * Cost information for the product system.
   */
  @visibility("read")
  costInformation?: CostInformation;

  /**
   * Availability information of the product system.
   */
  @visibility("read")
  availabilityInformation?: AvailabilityInformation;

  /**
   * Hierarchy information of a product.
   */
  @visibility("read")
  hierarchyInformation?: HierarchyInformation;
}

/**
 * Description related properties of a product system.
 */
model ProductDescription {
  /**
   * Type of description.
   */
  @visibility("read")
  descriptionType?: DescriptionType;

  /**
   * Short description of the product system.
   */
  @visibility("read")
  shortDescription?: string;

  /**
   * Long description of the product system.
   */
  @visibility("read")
  longDescription?: string;

  /**
   * Keywords for the product system.
   */
  @visibility("read")
  keywords?: string[];

  /**
   * Attributes for the product system.
   */
  @visibility("read")
  attributes?: string[];

  /**
   * Links for the product system.
   */
  @visibility("read")
  links?: ProductLink[];
}

/**
 * Returns link related to the product
 */
model ProductLink {
  /**
   * Type of link
   */
  @visibility("read")
  linkType?: LinkType;

  /**
   * Url of the link
   */
  @visibility("read")
  linkUrl?: string;
}

/**
 * Image for the product
 */
model ImageInformation {
  /**
   * Type of the image
   */
  @visibility("read")
  imageType?: ImageType;

  /**
   * Url of the image
   */
  @visibility("read")
  imageUrl?: string;
}

/**
 * Cost information for the product system
 */
model CostInformation {
  /**
   * Details on the various billing aspects for the product system.
   */
  @visibility("read")
  billingMeterDetails?: BillingMeterDetails[];

  /**
   * Default url to display billing information
   */
  @visibility("read")
  billingInfoUrl?: string;
}

/**
 * Holds billing meter details for each type of billing
 */
model BillingMeterDetails {
  /**
   * Represents Billing type name
   */
  @visibility("read")
  name?: string;

  /**
   * Represents MeterDetails
   */
  @visibility("read")
  meterDetails?: MeterDetails;

  /**
   * Represents Metering type (eg one-time or recurrent)
   */
  @visibility("read")
  meteringType?: MeteringType;

  /**
   * Frequency of recurrence
   */
  @visibility("read")
  frequency?: string;
}

/**
 * Holds details about billing type and its meter guids
 */
@discriminator("billingType")
model MeterDetails {
  /**
   * Billing unit applicable for Pav2 billing
   */
  @visibility("read")
  multiplier?: float64;

  /**
   * Charging type.
   */
  @visibility("read")
  chargingType?: ChargingType;
}

/**
 * Availability information of a product system.
 */
model AvailabilityInformation {
  /**
   * Current availability stage of the product. Availability stage
   */
  @visibility("read")
  availabilityStage?: AvailabilityStage;

  /**
   * Reason why the product is disabled.
   */
  @visibility("read")
  disabledReason?: DisabledReason;

  /**
   * Message for why the product is disabled.
   */
  @visibility("read")
  disabledReasonMessage?: string;
}

/**
 * Holds details about product hierarchy information
 */
model HierarchyInformation {
  /**
   * Represents product family name that uniquely identifies product family
   */
  productFamilyName?: string;

  /**
   * Represents product line name that uniquely identifies product line
   */
  productLineName?: string;

  /**
   * Represents product name that uniquely identifies product
   */
  productName?: string;

  /**
   * Represents configuration name that uniquely identifies configuration
   */
  configurationName?: string;
}

/**
 * Management RP details
 */
model ResourceProviderDetails {
  /**
   * Resource provider namespace
   */
  @visibility("read")
  resourceProviderNamespace?: string;
}

/**
 * Configuration request object.
 */
model ConfigurationsRequest {
  /**
   * Holds details about product hierarchy information and filterable property.
   */
  configurationFilters: ConfigurationFilters[];

  /**
   * Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details
   */
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
}

/**
 * Configuration filters
 */
model ConfigurationFilters {
  /**
   * Product hierarchy information
   */
  hierarchyInformation: HierarchyInformation;

  /**
   * Filters specific to product
   */
  filterableProperty?: FilterableProperty[];
}

/**
 * The list of configurations.
 */
model ProductConfigurations is Azure.Core.Page<ProductConfiguration>;

/**
 * Holds details about product family metadata
 */
model ProductFamiliesMetadata
  is Azure.Core.Page<ProductFamiliesMetadataDetails>;

/**
 * Product families metadata details.
 */
model ProductFamiliesMetadataDetails {
  /**
   * Product family properties
   */
  @visibility("read")
  properties?: ProductFamilyProperties;
}

/**
 * List of orders.
 */
model OrderResourceList is Azure.Core.Page<OrderResource>;

/**
 * Represents order details.
 */
model OrderProperties {
  /**
   * List of order item ARM Ids which are part of an order.
   */
  @visibility("read")
  orderItemIds?: string[];

  /**
   * Order current status.
   */
  @visibility("read")
  currentStage?: StageDetails;

  /**
   * Order status history.
   */
  @visibility("read")
  orderStageHistory?: StageDetails[];
}

/**
 * Resource stage details.
 */
model StageDetails {
  /**
   * Stage status.
   */
  @visibility("read")
  stageStatus?: StageStatus;

  /**
   * Stage name
   */
  @visibility("read")
  stageName?: StageName;

  /**
   * Display name of the resource stage.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Stage start time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * Represents order item details.
 */
model OrderItemProperties {
  /**
   * Represents order item details.
   */
  orderItemDetails: OrderItemDetails;

  /**
   * Represents shipping and return address for order item
   */
  addressDetails: AddressDetails;

  /**
   * Start time of order item
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Id of the order to which order item belongs to
   */
  orderId: string;
}

/**
 * Order item details
 */
model OrderItemDetails {
  /**
   * Unique identifier for configuration.
   */
  productDetails: ProductDetails;

  /**
   * Order item type.
   */
  orderItemType: OrderItemType;

  /**
   * Current Order item Status
   */
  @visibility("read")
  currentStage?: StageDetails;

  /**
   * Order item status history
   */
  @visibility("read")
  orderItemStageHistory?: StageDetails[];

  /**
   * Customer notification Preferences
   */
  preferences?: OrderItemPreferences;

  /**
   * Forward Package Shipping details
   */
  @visibility("read")
  forwardShippingDetails?: ForwardShippingDetails;

  /**
   * Reverse Package Shipping details
   */
  @visibility("read")
  reverseShippingDetails?: ReverseShippingDetails;

  /**
   * Additional notification email list
   */
  notificationEmailList?: string[];

  /**
   * Cancellation reason.
   */
  @visibility("read")
  cancellationReason?: string;

  /**
   * Describes whether the order item is cancellable or not.
   */
  @visibility("read")
  cancellationStatus?: OrderItemCancellationEnum;

  /**
   * Describes whether the order item is deletable or not.
   */
  @visibility("read")
  deletionStatus?: ActionStatusEnum;

  /**
   * Return reason.
   */
  @visibility("read")
  returnReason?: string;

  /**
   * Describes whether the order item is returnable or not.
   */
  @visibility("read")
  returnStatus?: OrderItemReturnEnum;

  /**
   * Parent RP details - this returns only the first or default parent RP from the entire list
   */
  @visibility("read")
  managementRpDetails?: ResourceProviderDetails;

  /**
   * List of parent RP details supported for configuration.
   */
  @visibility("read")
  managementRpDetailsList?: ResourceProviderDetails[];

  /**
   * Top level error for the job.
   */
  @visibility("read")
  error?: ErrorDetail;
}

/**
 * Represents product details
 */
model ProductDetails {
  /**
   * Display details of the product
   */
  displayInfo?: DisplayInfo;

  /**
   * Hierarchy of the product which uniquely identifies the product
   */
  hierarchyInformation: HierarchyInformation;

  /**
   * Quantity of the product
   */
  @visibility("read")
  count?: int32;

  /**
   * Double encryption status of the configuration. Read-only field.
   */
  @visibility("read")
  productDoubleEncryptionStatus?: DoubleEncryptionStatus;

  /**
   * list of device details
   */
  @visibility("read")
  deviceDetails?: DeviceDetails[];
}

/**
 * Describes product display information
 */
model DisplayInfo {
  /**
   * Product family display name
   */
  @visibility("read")
  productFamilyDisplayName?: string;

  /**
   * Configuration display name
   */
  @visibility("read")
  configurationDisplayName?: string;
}

/**
 * Device details.
 */
model DeviceDetails {
  /**
   * device serial number
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Management Resource Id
   */
  @visibility("read")
  managementResourceId?: string;

  /**
   * Management Resource Tenant ID
   */
  @visibility("read")
  managementResourceTenantId?: string;
}

/**
 * Preferences related to the order
 */
model OrderItemPreferences {
  /**
   * Notification preferences.
   */
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
 * Preferences related to the shipment logistics of the sku
 */
model TransportPreferences {
  /**
   * Indicates Shipment Logistics type that the customer preferred.
   */
  preferredShipmentType: TransportShipmentTypes;
}

/**
 * Preferences related to the double encryption
 */
model EncryptionPreferences {
  /**
   * Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.
   */
  doubleEncryptionStatus?: DoubleEncryptionStatus;
}

/**
 * Management resource preference to link device
 */
model ManagementResourcePreferences {
  /**
   * Customer preferred Management resource ARM ID
   */
  preferredManagementResourceId?: string;
}

/**
 * Forward shipment details.
 */
model ForwardShippingDetails {
  /**
   * Name of the carrier.
   */
  @visibility("read")
  carrierName?: string;

  /**
   * Carrier Name for display purpose. Not to be used for any processing.
   */
  @visibility("read")
  carrierDisplayName?: string;

  /**
   * TrackingId of the package
   */
  @visibility("read")
  trackingId?: string;

  /**
   * TrackingUrl of the package.
   */
  @visibility("read")
  trackingUrl?: string;
}

/**
 * Reverse shipment details.
 */
model ReverseShippingDetails {
  /**
   * SAS key to download the reverse shipment label of the package.
   */
  @visibility("read")
  sasKeyForLabel?: string;

  /**
   * Name of the carrier.
   */
  @visibility("read")
  carrierName?: string;

  /**
   * Carrier Name for display purpose. Not to be used for any processing.
   */
  @visibility("read")
  carrierDisplayName?: string;

  /**
   * TrackingId of the package
   */
  @visibility("read")
  trackingId?: string;

  /**
   * TrackingUrl of the package.
   */
  @visibility("read")
  trackingUrl?: string;
}

/**
 * Address details for an order item.
 */
model AddressDetails {
  /**
   * Customer address and contact details. It should be address resource
   */
  forwardAddress: AddressProperties;

  /**
   * Return shipping address
   */
  @visibility("read")
  returnAddress?: AddressProperties;
}

/**
 * The Address update parameters
 */
model AddressUpdateParameter {
  /**
   * Properties of a address to be updated.
   */
  properties?: AddressUpdateProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  tags?: Record<string>;
}

/**
 * Address Properties
 */
model AddressUpdateProperties {
  /**
   * Shipping details for the address
   */
  shippingAddress?: ShippingAddress;

  /**
   * Contact details for the address
   */
  contactDetails?: ContactDetails;
}

/**
 * Updates order item parameters.
 */
model OrderItemUpdateParameter {
  /**
   * Order item update properties
   */
  properties?: OrderItemUpdateProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  tags?: Record<string>;
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
  preferences?: OrderItemPreferences;

  /**
   * Additional notification email list.
   */
  notificationEmailList?: string[];
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
 * Return order item request body
 */
model ReturnOrderItemDetails {
  /**
   * customer return address.
   */
  returnAddress?: AddressProperties;

  /**
   * Return Reason.
   */
  returnReason: string;

  /**
   * Service tag (located on the bottom-right corner of the device)
   */
  serviceTag?: string;

  /**
   * Shipping Box required
   */
  shippingBoxRequired?: boolean;
}

/**
 * Billing type PAV2 meter details
 */
model Pav2MeterDetails extends MeterDetails {
  /**
   * Validation status of requested data center and transport.
   */
  @visibility("read")
  meterGuid?: string;

  /**
   * Represents billing type.
   */
  billingType: "Pav2";
}

/**
 * Billing type Purchase meter details
 */
model PurchaseMeterDetails extends MeterDetails {
  /**
   * Product Id
   */
  @visibility("read")
  productId?: string;

  /**
   * Sku Id
   */
  @visibility("read")
  skuId?: string;

  /**
   * Term Id
   */
  @visibility("read")
  termId?: string;

  /**
   * Represents billing type.
   */
  billingType: "Purchase";
}

/**
 * Msi identity details of the resource
 */
model ResourceIdentity {
  /**
   * Identity type
   */
  type?: string;

  /**
   * Service Principal Id backing the Msi
   */
  @visibility("read")
  principalId?: string;

  /**
   * Home Tenant Id
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Package shipping details
 */
model ShippingDetails {
  /**
   * Name of the carrier.
   */
  @visibility("read")
  carrierName?: string;

  /**
   * Carrier Name for display purpose. Not to be used for any processing.
   */
  @visibility("read")
  carrierDisplayName?: string;

  /**
   * TrackingId of the package
   */
  @visibility("read")
  trackingId?: string;

  /**
   * TrackingUrl of the package.
   */
  @visibility("read")
  trackingUrl?: string;
}
