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

@doc("Type of address.")
enum AddressType {
  @doc("Address type not known.") None,
  @doc("Residential Address.") Residential,
  @doc("Commercial Address.") Commercial,
}

@doc("Status of address validation")
enum AddressValidationStatus {
  @doc("Address provided is valid.") Valid,
  @doc("Address provided is invalid or not supported.") Invalid,
  @doc("Address provided is ambiguous, please choose one of the alternate addresses returned.")
  Ambiguous,
}

@doc("Type of product filter.")
enum SupportedFilterTypes {
  @doc("Ship to country") ShipToCountries,
  @doc("Double encryption status") DoubleEncryptionStatus,
}

@doc("Unit for the dimensions of length, height and width.")
enum LengthHeightUnit {
  @doc("Inch, applicable for West US.") IN,
  @doc("Centimeter.") CM,
}

@doc("Unit for the dimensions of weight.")
enum WeightMeasurementUnit {
  @doc("Pounds.") LBS,
  @doc("Kilograms.") KGS,
}

@doc("Type of description.")
enum DescriptionType {
  @doc("Base description.") Base,
}

@doc("Type of link")
enum LinkType {
  @doc("Generic link.") Generic,
  @doc("Terms and conditions link.") TermsAndConditions,
  @doc("Link to product specification.") Specification,
  @doc("Link to product documentation") Documentation,
  @doc("Link to know more") KnowMore,
  @doc("Link to sign up for products") SignUp,
}

@doc("Type of the image")
enum ImageType {
  @doc("Main image.") MainImage,
  @doc("Bullet image.") BulletImage,
  @doc("Generic image.") GenericImage,
}

@doc("Represents billing type.")
enum BillingType {
  @doc("PaV2 billing.") Pav2,
  @doc("Purchase billing.") Purchase,
}

@doc("Charging type.")
enum ChargingType {
  @doc("Per order charging type.") PerOrder,
  @doc("Per device charging type.") PerDevice,
}

@doc("Represents Metering type (eg one-time or recurrent)")
enum MeteringType {
  @doc("One time billing.") OneTime,
  @doc("Recurring billing.") Recurring,
  @doc("Adhoc billing.") Adhoc,
}

@doc("Current availability stage of the product. Availability stage")
enum AvailabilityStage {
  @doc("Product is available.") Available,
  @doc("Product is coming soon.") ComingSoon,
  @doc("Product is in preview.") Preview,
  @doc("Product is deprecated.") Deprecated,
  @doc("Product is available only on signup.") Signup,
  @doc("Product is not available.") Unavailable,
}

@doc("Reason why the product is disabled.")
enum DisabledReason {
  @doc("Not disabled.") None,
  @doc("Not available in the requested country.") Country,
  @doc("Not available to push data to the requested Azure region.") Region,
  @doc("Required features are not enabled.") Feature,
  @doc("Subscription does not have required offer types.") OfferType,
  @doc("Subscription has not registered to Microsoft.DataBox and Service does not have the subscription notification.")
  NoSubscriptionInfo,
  @doc("The product is not yet available.") NotAvailable,
  @doc("The product is out of stock.") OutOfStock,
}

@doc("Stage status.")
enum StageStatus {
  @doc("No status available yet.") None,
  @doc("Stage is in progress.") InProgress,
  @doc("Stage has succeeded.") Succeeded,
  @doc("Stage has failed.") Failed,
  @doc("Stage has been cancelled.") Cancelled,
  @doc("Stage is cancelling.") Cancelling,
}

@doc("Stage name")
enum StageName {
  @doc("Currently in draft mode and can still be cancelled") Placed,
  @doc("Order is currently in draft mode and can still be cancelled") InReview,
  @doc("Order is confirmed") Confirmed,
  @doc("Order is ready to ship") ReadyToShip,
  @doc("Order is in transit to customer") Shipped,
  @doc("Order is delivered to customer") Delivered,
  @doc("Order is in use at customer site") InUse,
  @doc("Return has been initiated by customer.") ReturnInitiated,
  @doc("Order is in transit from customer to microsoft.") ReturnPickedUp,
  @doc("Order has been received back to microsoft.") ReturnedToMicrosoft,
  @doc("Return has now completed.") ReturnCompleted,
  @doc("Order has been cancelled.") Cancelled,
}

@doc("Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.")
enum DoubleEncryptionStatus {
  @doc("Double encryption is disabled") Disabled,
  @doc("Double encryption is enabled") Enabled,
}

@doc("Order item type.")
enum OrderItemType {
  @doc("Purchase OrderItem.") Purchase,
  @doc("Rental OrderItem.") Rental,
}

@doc("Name of the stage.")
enum NotificationStageName {
  @doc("Notification at order item shipped from microsoft datacenter.") Shipped,
  @doc("Notification at order item delivered to customer.") Delivered,
}

@doc("Indicates Shipment Logistics type that the customer preferred.")
enum TransportShipmentTypes {
  @doc("Shipment Logistics is handled by the customer.") CustomerManaged,
  @doc("Shipment Logistics is handled by Microsoft.") MicrosoftManaged,
}

@doc("Describes whether the order item is cancellable or not.")
enum OrderItemCancellationEnum {
  @doc("Order item can be cancelled without fee.") Cancellable,
  @doc("Order item can be cancelled with fee.") CancellableWithFee,
  @doc("Order item not cancellable.") NotCancellable,
}

@doc("Describes whether the order item is deletable or not.")
enum ActionStatusEnum {
  @doc("Allowed flag.") Allowed,
  @doc("Not Allowed flag.") NotAllowed,
}

@doc("Describes whether the order item is returnable or not.")
enum OrderItemReturnEnum {
  @doc("Order item can be returned without fee.") Returnable,
  @doc("Order item can be returned with fee.") ReturnableWithFee,
  @doc("Order item not returnable.") NotReturnable,
}

@doc("Address Properties")
model AddressProperties {
  @doc("Shipping details for the address")
  shippingAddress?: ShippingAddress;

  @doc("Contact details for the address")
  contactDetails: ContactDetails;

  @doc("Status of address validation")
  @visibility("read")
  addressValidationStatus?: AddressValidationStatus;
}

@doc("Shipping address where customer wishes to receive the device.")
model ShippingAddress {
  @doc("Street Address line 1.")
  streetAddress1: string;

  @doc("Street Address line 2.")
  streetAddress2?: string;

  @doc("Street Address line 3.")
  streetAddress3?: string;

  @doc("Name of the City.")
  city?: string;

  @doc("Name of the State or Province.")
  stateOrProvince?: string;

  @doc("Name of the Country.")
  country: string;

  @doc("Postal code.")
  postalCode?: string;

  @doc("Extended Zip Code.")
  zipExtendedCode?: string;

  @doc("Name of the company.")
  companyName?: string;

  @doc("Type of address.")
  addressType?: AddressType;
}

@doc("Contact Details.")
model ContactDetails {
  @doc("Contact name of the person.")
  contactName: string;

  @doc("Phone number of the contact person.")
  phone: string;

  @doc("Phone extension number of the contact person.")
  phoneExtension?: string;

  @doc("Mobile number of the contact person.")
  mobile?: string;

  @doc("List of Email-ids to be notified about job progress.")
  emailList: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("The filters for showing the product families.")
model ProductFamiliesRequest {
  @doc("Dictionary of filterable properties on product family.")
  filterableProperties: Record<FilterableProperty[]>;

  @doc("Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details")
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
}

@doc("Different types of filters supported and its values.")
model FilterableProperty {
  @doc("Type of product filter.")
  type: SupportedFilterTypes;

  @doc("Values to be filtered.")
  supportedValues: string[];
}

@doc("Holds Customer subscription details. Clients can display available products to unregistered customers by explicitly passing subscription details")
model CustomerSubscriptionDetails {
  @doc("List of registered feature flags for subscription")
  registeredFeatures?: CustomerSubscriptionRegisteredFeatures[];

  @doc("Location placement Id of a subscription")
  locationPlacementId?: string;

  @doc("Quota ID of a subscription")
  quotaId: string;
}

@doc("Represents subscription registered features")
model CustomerSubscriptionRegisteredFeatures {
  @doc("Name of subscription registered feature")
  name?: string;

  @doc("State of subscription registered feature")
  state?: string;
}

@doc("The list of product families.")
model ProductFamilies is Azure.Core.Page<ProductFamily>;

@doc("Product Family")
model ProductFamily {
  @doc("Properties of product family")
  @visibility("read")
  properties?: ProductFamilyProperties;
}

@doc("Properties of product family")
model ProductFamilyProperties extends CommonProperties {
  @doc("List of product lines supported in the product family")
  @visibility("read")
  productLines?: ProductLine[];

  @doc("Contains details related to resource provider")
  resourceProviderDetails?: ResourceProviderDetails[];
}

@doc("Product line")
model ProductLine {
  @doc("Properties of product line")
  @visibility("read")
  properties?: ProductLineProperties;
}

@doc("Properties of product line")
model ProductLineProperties extends CommonProperties {
  @doc("List of products in the product line")
  @visibility("read")
  products?: EdgeOrderProduct[];
}

@doc("List of Products")
model EdgeOrderProduct {
  @doc("Properties of product")
  @visibility("read")
  properties?: ProductProperties;
}

@doc("Properties of products")
model ProductProperties extends CommonProperties {
  @doc("List of configurations for the product")
  @visibility("read")
  configurations?: ProductConfiguration[];
}

@doc("Configuration object.")
model ProductConfiguration {
  @doc("Properties of configuration")
  @visibility("read")
  properties?: ConfigurationProperties;
}

@doc("Properties of configuration")
model ConfigurationProperties extends CommonProperties {
  @doc("Specifications of the configuration")
  @visibility("read")
  specifications?: ProductSpecification[];

  @doc("Dimensions of the configuration")
  @visibility("read")
  dimensions?: ProductDimensions;
}

@doc("Specifications of the configurations")
model ProductSpecification {
  @doc("Name of the specification")
  @visibility("read")
  name?: string;

  @doc("Value of the specification")
  @visibility("read")
  value?: string;
}

@doc("Dimensions of a configuration.")
model ProductDimensions {
  @doc("Length of the device.")
  @visibility("read")
  length?: float32;

  @doc("Height of the device.")
  @visibility("read")
  height?: float32;

  @doc("Width of the device.")
  @visibility("read")
  width?: float32;

  @doc("Unit for the dimensions of length, height and width.")
  @visibility("read")
  lengthHeightUnit?: LengthHeightUnit;

  @doc("Weight of the device.")
  @visibility("read")
  weight?: float32;

  @doc("Depth of the device.")
  @visibility("read")
  depth?: float32;

  @doc("Unit for the dimensions of weight.")
  @visibility("read")
  weightUnit?: WeightMeasurementUnit;
}

@doc("Represents common properties across product hierarchy")
model CommonProperties extends BasicInformation {
  @doc("list of filters supported for a product")
  @visibility("read")
  filterableProperties?: FilterableProperty[];
}

@doc("Basic information for any product system")
model BasicInformation {
  @doc("Display Name for the product system.")
  @visibility("read")
  displayName?: string;

  @doc("Description related to the product system.")
  @visibility("read")
  description?: ProductDescription;

  @doc("Image information for the product system.")
  @visibility("read")
  imageInformation?: ImageInformation[];

  @doc("Cost information for the product system.")
  @visibility("read")
  costInformation?: CostInformation;

  @doc("Availability information of the product system.")
  @visibility("read")
  availabilityInformation?: AvailabilityInformation;

  @doc("Hierarchy information of a product.")
  @visibility("read")
  hierarchyInformation?: HierarchyInformation;
}

@doc("Description related properties of a product system.")
model ProductDescription {
  @doc("Type of description.")
  @visibility("read")
  descriptionType?: DescriptionType;

  @doc("Short description of the product system.")
  @visibility("read")
  shortDescription?: string;

  @doc("Long description of the product system.")
  @visibility("read")
  longDescription?: string;

  @doc("Keywords for the product system.")
  @visibility("read")
  keywords?: string[];

  @doc("Attributes for the product system.")
  @visibility("read")
  attributes?: string[];

  @doc("Links for the product system.")
  @visibility("read")
  links?: ProductLink[];
}

@doc("Returns link related to the product")
model ProductLink {
  @doc("Type of link")
  @visibility("read")
  linkType?: LinkType;

  @doc("Url of the link")
  @visibility("read")
  linkUrl?: string;
}

@doc("Image for the product")
model ImageInformation {
  @doc("Type of the image")
  @visibility("read")
  imageType?: ImageType;

  @doc("Url of the image")
  @visibility("read")
  imageUrl?: string;
}

@doc("Cost information for the product system")
model CostInformation {
  @doc("Details on the various billing aspects for the product system.")
  @visibility("read")
  billingMeterDetails?: BillingMeterDetails[];

  @doc("Default url to display billing information")
  @visibility("read")
  billingInfoUrl?: string;
}

@doc("Holds billing meter details for each type of billing")
model BillingMeterDetails {
  @doc("Represents Billing type name")
  @visibility("read")
  name?: string;

  @doc("Represents MeterDetails")
  @visibility("read")
  meterDetails?: MeterDetails;

  @doc("Represents Metering type (eg one-time or recurrent)")
  @visibility("read")
  meteringType?: MeteringType;

  @doc("Frequency of recurrence")
  @visibility("read")
  frequency?: string;
}

@doc("Holds details about billing type and its meter guids")
@discriminator("billingType")
model MeterDetails {
  @doc("Billing unit applicable for Pav2 billing")
  @visibility("read")
  multiplier?: float32;

  @doc("Charging type.")
  @visibility("read")
  chargingType?: ChargingType;
}

@doc("Availability information of a product system.")
model AvailabilityInformation {
  @doc("Current availability stage of the product. Availability stage")
  @visibility("read")
  availabilityStage?: AvailabilityStage;

  @doc("Reason why the product is disabled.")
  @visibility("read")
  disabledReason?: DisabledReason;

  @doc("Message for why the product is disabled.")
  @visibility("read")
  disabledReasonMessage?: string;
}

@doc("Holds details about product hierarchy information")
model HierarchyInformation {
  @doc("Represents product family name that uniquely identifies product family")
  productFamilyName?: string;

  @doc("Represents product line name that uniquely identifies product line")
  productLineName?: string;

  @doc("Represents product name that uniquely identifies product")
  productName?: string;

  @doc("Represents configuration name that uniquely identifies configuration")
  configurationName?: string;
}

@doc("Management RP details")
model ResourceProviderDetails {
  @doc("Resource provider namespace")
  @visibility("read")
  resourceProviderNamespace?: string;
}

@doc("Configuration request object.")
model ConfigurationsRequest {
  @doc("Holds details about product hierarchy information and filterable property.")
  configurationFilters: ConfigurationFilters[];

  @doc("Customer subscription properties. Clients can display available products to unregistered customers by explicitly passing subscription details")
  customerSubscriptionDetails?: CustomerSubscriptionDetails;
}

@doc("Configuration filters")
model ConfigurationFilters {
  @doc("Product hierarchy information")
  hierarchyInformation: HierarchyInformation;

  @doc("Filters specific to product")
  filterableProperty?: FilterableProperty[];
}

@doc("The list of configurations.")
model ProductConfigurations is Azure.Core.Page<ProductConfiguration>;

@doc("Holds details about product family metadata")
model ProductFamiliesMetadata
  is Azure.Core.Page<ProductFamiliesMetadataDetails>;

@doc("Product families metadata details.")
model ProductFamiliesMetadataDetails {
  @doc("Product family properties")
  @visibility("read")
  properties?: ProductFamilyProperties;
}

@doc("List of orders.")
model OrderResourceList is Azure.Core.Page<OrderResource>;

@doc("Represents order details.")
model OrderProperties {
  @doc("List of order item ARM Ids which are part of an order.")
  @visibility("read")
  orderItemIds?: string[];

  @doc("Order current status.")
  @visibility("read")
  currentStage?: StageDetails;

  @doc("Order status history.")
  @visibility("read")
  orderStageHistory?: StageDetails[];
}

@doc("Resource stage details.")
model StageDetails {
  @doc("Stage status.")
  @visibility("read")
  stageStatus?: StageStatus;

  @doc("Stage name")
  @visibility("read")
  stageName?: StageName;

  @doc("Display name of the resource stage.")
  @visibility("read")
  displayName?: string;

  @doc("Stage start time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

@doc("Represents order item details.")
model OrderItemProperties {
  @doc("Represents order item details.")
  orderItemDetails: OrderItemDetails;

  @doc("Represents shipping and return address for order item")
  addressDetails: AddressDetails;

  @doc("Start time of order item")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Id of the order to which order item belongs to")
  orderId: string;
}

@doc("Order item details")
model OrderItemDetails {
  @doc("Unique identifier for configuration.")
  productDetails: ProductDetails;

  @doc("Order item type.")
  orderItemType: OrderItemType;

  @doc("Current Order item Status")
  @visibility("read")
  currentStage?: StageDetails;

  @doc("Order item status history")
  @visibility("read")
  orderItemStageHistory?: StageDetails[];

  @doc("Customer notification Preferences")
  preferences?: OrderItemPreferences;

  @doc("Forward Package Shipping details")
  @visibility("read")
  forwardShippingDetails?: ForwardShippingDetails;

  @doc("Reverse Package Shipping details")
  @visibility("read")
  reverseShippingDetails?: ReverseShippingDetails;

  @doc("Additional notification email list")
  notificationEmailList?: string[];

  @doc("Cancellation reason.")
  @visibility("read")
  cancellationReason?: string;

  @doc("Describes whether the order item is cancellable or not.")
  @visibility("read")
  cancellationStatus?: OrderItemCancellationEnum;

  @doc("Describes whether the order item is deletable or not.")
  @visibility("read")
  deletionStatus?: ActionStatusEnum;

  @doc("Return reason.")
  @visibility("read")
  returnReason?: string;

  @doc("Describes whether the order item is returnable or not.")
  @visibility("read")
  returnStatus?: OrderItemReturnEnum;

  @doc("Parent RP details - this returns only the first or default parent RP from the entire list")
  @visibility("read")
  managementRpDetails?: ResourceProviderDetails;

  @doc("List of parent RP details supported for configuration.")
  @visibility("read")
  managementRpDetailsList?: ResourceProviderDetails[];

  @doc("Top level error for the job.")
  @visibility("read")
  error?: ErrorDetail;
}

@doc("Represents product details")
model ProductDetails {
  @doc("Display details of the product")
  displayInfo?: DisplayInfo;

  @doc("Hierarchy of the product which uniquely identifies the product")
  hierarchyInformation: HierarchyInformation;

  @doc("Quantity of the product")
  @visibility("read")
  count?: int32;

  @doc("Double encryption status of the configuration. Read-only field.")
  @visibility("read")
  productDoubleEncryptionStatus?: DoubleEncryptionStatus;

  @doc("list of device details")
  @visibility("read")
  deviceDetails?: DeviceDetails[];
}

@doc("Describes product display information")
model DisplayInfo {
  @doc("Product family display name")
  @visibility("read")
  productFamilyDisplayName?: string;

  @doc("Configuration display name")
  @visibility("read")
  configurationDisplayName?: string;
}

@doc("Device details.")
model DeviceDetails {
  @doc("device serial number")
  @visibility("read")
  serialNumber?: string;

  @doc("Management Resource Id")
  @visibility("read")
  managementResourceId?: string;

  @doc("Management Resource Tenant ID")
  @visibility("read")
  managementResourceTenantId?: string;
}

@doc("Preferences related to the order")
model OrderItemPreferences {
  @doc("Notification preferences.")
  notificationPreferences?: NotificationPreference[];

  @doc("Preferences related to the shipment logistics of the order.")
  transportPreferences?: TransportPreferences;

  @doc("Preferences related to the Encryption.")
  encryptionPreferences?: EncryptionPreferences;

  @doc("Preferences related to the Management resource.")
  managementResourcePreferences?: ManagementResourcePreferences;
}

@doc("Notification preference for a job stage.")
model NotificationPreference {
  @doc("Name of the stage.")
  stageName: NotificationStageName;

  @doc("Notification is required or not.")
  sendNotification: boolean;
}

@doc("Preferences related to the shipment logistics of the sku")
model TransportPreferences {
  @doc("Indicates Shipment Logistics type that the customer preferred.")
  preferredShipmentType: TransportShipmentTypes;
}

@doc("Preferences related to the double encryption")
model EncryptionPreferences {
  @doc("Double encryption status as entered by the customer. It is compulsory to give this parameter if the 'Deny' or 'Disabled' policy is configured.")
  doubleEncryptionStatus?: DoubleEncryptionStatus;
}

@doc("Management resource preference to link device")
model ManagementResourcePreferences {
  @doc("Customer preferred Management resource ARM ID")
  preferredManagementResourceId?: string;
}

@doc("Forward shipment details.")
model ForwardShippingDetails {
  @doc("Name of the carrier.")
  @visibility("read")
  carrierName?: string;

  @doc("Carrier Name for display purpose. Not to be used for any processing.")
  @visibility("read")
  carrierDisplayName?: string;

  @doc("TrackingId of the package")
  @visibility("read")
  trackingId?: string;

  @doc("TrackingUrl of the package.")
  @visibility("read")
  trackingUrl?: string;
}

@doc("Reverse shipment details.")
model ReverseShippingDetails {
  @doc("SAS key to download the reverse shipment label of the package.")
  @visibility("read")
  sasKeyForLabel?: string;

  @doc("Name of the carrier.")
  @visibility("read")
  carrierName?: string;

  @doc("Carrier Name for display purpose. Not to be used for any processing.")
  @visibility("read")
  carrierDisplayName?: string;

  @doc("TrackingId of the package")
  @visibility("read")
  trackingId?: string;

  @doc("TrackingUrl of the package.")
  @visibility("read")
  trackingUrl?: string;
}

@doc("Address details for an order item.")
model AddressDetails {
  @doc("Customer address and contact details. It should be address resource")
  forwardAddress: AddressProperties;

  @doc("Return shipping address")
  @visibility("read")
  returnAddress?: AddressProperties;
}

@doc("The Address update parameters")
model AddressUpdateParameter {
  @doc("Properties of a address to be updated.")
  properties?: AddressUpdateProperties;

  @doc("The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).")
  tags?: Record<string>;
}

@doc("Address Properties")
model AddressUpdateProperties {
  @doc("Shipping details for the address")
  shippingAddress?: ShippingAddress;

  @doc("Contact details for the address")
  contactDetails?: ContactDetails;
}

@doc("Updates order item parameters.")
model OrderItemUpdateParameter {
  @doc("Order item update properties")
  properties?: OrderItemUpdateProperties;

  @doc("The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).")
  tags?: Record<string>;
}

@doc("Order item update properties.")
model OrderItemUpdateProperties {
  @doc("Updates forward shipping address and contact details.")
  forwardAddress?: AddressProperties;

  @doc("Customer preference.")
  preferences?: OrderItemPreferences;

  @doc("Additional notification email list.")
  notificationEmailList?: string[];
}

@doc("Reason for cancellation.")
model CancellationReason {
  @doc("Reason for cancellation.")
  reason: string;
}

@doc("Return order item request body")
model ReturnOrderItemDetails {
  @doc("customer return address.")
  returnAddress?: AddressProperties;

  @doc("Return Reason.")
  returnReason: string;

  @doc("Service tag (located on the bottom-right corner of the device)")
  serviceTag?: string;

  @doc("Shipping Box required")
  shippingBoxRequired?: boolean;
}

@doc("Billing type PAV2 meter details")
model Pav2MeterDetails extends MeterDetails {
  @doc("Validation status of requested data center and transport.")
  @visibility("read")
  meterGuid?: string;

  @doc("Represents billing type.")
  billingType: "Pav2";
}

@doc("Billing type Purchase meter details")
model PurchaseMeterDetails extends MeterDetails {
  @doc("Product Id")
  @visibility("read")
  productId?: string;

  @doc("Sku Id")
  @visibility("read")
  skuId?: string;

  @doc("Term Id")
  @visibility("read")
  termId?: string;

  @doc("Represents billing type.")
  billingType: "Purchase";
}

@doc("Msi identity details of the resource")
model ResourceIdentity {
  @doc("Identity type")
  type?: string;

  @doc("Service Principal Id backing the Msi")
  @visibility("read")
  principalId?: string;

  @doc("Home Tenant Id")
  @visibility("read")
  tenantId?: string;
}

@doc("Package shipping details")
model ShippingDetails {
  @doc("Name of the carrier.")
  @visibility("read")
  carrierName?: string;

  @doc("Carrier Name for display purpose. Not to be used for any processing.")
  @visibility("read")
  carrierDisplayName?: string;

  @doc("TrackingId of the package")
  @visibility("read")
  trackingId?: string;

  @doc("TrackingUrl of the package.")
  @visibility("read")
  trackingUrl?: string;
}
