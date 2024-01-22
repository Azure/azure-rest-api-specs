import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Capacity;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Error code describing the reason that service is not able to process the incoming request
 */
enum ErrorResponseCode {
  NotSpecified,
  InternalServerError,
  ServerTimeout,
  AuthorizationFailed,
  BadRequest,
  ClientCertificateThumbprintNotSet,
  InvalidRequestContent,
  OperationFailed,
  HttpMethodNotSupported,
  InvalidRequestUri,
  MissingTenantId,
  InvalidTenantId,
  InvalidReservationOrderId,
  InvalidReservationId,
  ReservationIdNotInReservationOrder,
  ReservationOrderNotFound,
  InvalidSubscriptionId,
  InvalidAccessToken,
  InvalidLocationId,
  UnauthenticatedRequestsThrottled,
  InvalidHealthCheckType,
  Forbidden,
  BillingScopeIdCannotBeChanged,
  AppliedScopesNotAssociatedWithCommerceAccount,
  PatchValuesSameAsExisting,
  RoleAssignmentCreationFailed,
  ReservationOrderCreationFailed,
  ReservationOrderNotEnabled,
  CapacityUpdateScopesFailed,
  UnsupportedReservationTerm,
  ReservationOrderIdAlreadyExists,
  RiskCheckFailed,
  CreateQuoteFailed,
  ActivateQuoteFailed,
  NonsupportedAccountId,
  PaymentInstrumentNotFound,
  MissingAppliedScopesForSingle,
  NoValidReservationsToReRate,
  ReRateOnlyAllowedForEA,
  OperationCannotBePerformedInCurrentState,
  InvalidSingleAppliedScopesCount,
  InvalidFulfillmentRequestParameters,
  NotSupportedCountry,
  InvalidRefundQuantity,
  PurchaseError,
  BillingCustomerInputError,
  BillingPaymentInstrumentSoftError,
  BillingPaymentInstrumentHardError,
  BillingTransientError,
  BillingError,
  FulfillmentConfigurationError,
  FulfillmentOutOfStockError,
  FulfillmentTransientError,
  FulfillmentError,
  CalculatePriceFailed,
  AppliedScopesSameAsExisting,
  SelfServiceRefundNotSupported,
  RefundLimitExceeded,
}

/**
 * Represent the billing plans.
 */
enum ReservationBillingPlan {
  Upfront,
  Monthly,
}

/**
 * Represent the term of reservation.
 */
enum ReservationTerm {
  P1Y,
  P3Y,
  P5Y,
}

/**
 * The type of the resource that is being reserved.
 */
enum ReservedResourceType {
  VirtualMachines,
  SqlDatabases,
  SuseLinux,
  CosmosDb,
  RedHat,
  SqlDataWarehouse,
  VMwareCloudSimple,
  RedHatOsa,
  Databricks,
  AppService,
  ManagedDisk,
  BlockBlob,
  RedisCache,
  AzureDataExplorer,
  MySql,
  MariaDb,
  PostgreSql,
  DedicatedHost,
  SapHana,
  SqlAzureHybridBenefit,
  AVS,
  DataFactory,
  NetAppStorage,
  AzureFiles,
  SqlEdge,
  VirtualMachineSoftware,
}

/**
 * Type of the Applied Scope.
 */
enum AppliedScopeType {
  Single,
  Shared,
  ManagementGroup,
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
 */
enum InstanceFlexibility {
  On,
  Off,
}

/**
 * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
 */
enum PaymentStatus {
  Succeeded,
  Failed,
  Scheduled,
  Cancelled,
}

enum ReservationStatusCode {
  None,
  Pending,
  Processing,
  Active,
  PurchaseError,
  PaymentInstrumentError,
  Split,
  Merged,
  Expired,
  Succeeded,
}

/**
 * Represent the current state of the Reservation.
 */
enum ProvisioningState {
  Creating,
  PendingResourceHold,
  ConfirmedResourceHold,
  PendingBilling,
  ConfirmedBilling,
  Created,
  Succeeded,
  Cancelled,
  Expired,
  BillingFailed,
  Failed,
  Split,
  Merged,
}

/**
 * Represent savings plan term in ISO 8601 format.
 */
enum SavingsPlanTerm {
  P1Y,
  P3Y,
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
 */
enum BillingPlan {
  P1M,
}

/**
 * Commitment grain.
 */
enum CommitmentGrain {
  Hourly,
}

/**
 * Status of the operation.
 */
enum CalculateExchangeOperationResultStatus {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
}

/**
 * Status of the operation.
 */
enum ExchangeOperationResultStatus {
  Succeeded,
  Failed,
  Cancelled,
  PendingRefunds,
  PendingPurchases,
}

/**
 * Status of the individual operation.
 */
enum OperationStatus {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
}

/**
 * The resource types.
 */
enum ResourceType {
  standard,
  dedicated,
  lowPriority,
  shared,
  serviceSpecific,
}

/**
 * The quota request status.
 */
enum QuotaRequestState {
  Accepted,
  Invalid,
  Succeeded,
  Failed,
  InProgress,
}

/**
 * Represent the current display state of the reservation.
 */
enum DisplayProvisioningState {
  Succeeded,
  Expiring,
  Expired,
  Pending,
  Processing,
  Cancelled,
  Failed,
  Warning,
  NoBenefit,
}

/**
 * The applied scope type
 */
enum UserFriendlyAppliedScopeType {
  None,
  Shared,
  Single,
  ResourceGroup,
  ManagementGroup,
}

/**
 * The renew state of the reservation
 */
enum UserFriendlyRenewState {
  On,
  Off,
  Renewed,
  NotRenewed,
  NotApplicable,
}

/**
 * Available scope
 */
model AvailableScopeRequest {
  /**
   * Available scope request properties
   */
  properties?: AvailableScopeRequestProperties;
}

/**
 * Available scope request properties
 */
model AvailableScopeRequestProperties {
  scopes?: string[];
}

/**
 * The response of available scope api containing scopes and their eligibilities.
 */
model AvailableScopeProperties {
  /**
   * The scopes checked by the available scope api.
   */
  properties?: SubscriptionScopeProperties;
}

/**
 * The scopes checked by the available scope api.
 */
model SubscriptionScopeProperties {
  scopes?: ScopeProperties[];
}

/**
 * The scope and whether it is valid.
 */
model ScopeProperties {
  scope?: string;
  valid?: boolean;
}

/**
 * Error information
 */
@error
model Error {
  /**
   * Extended error information including error code and error message
   */
  error?: ExtendedErrorInfo;
}

/**
 * Extended error information including error code and error message
 */
model ExtendedErrorInfo {
  /**
   * Error code describing the reason that service is not able to process the incoming request
   */
  code?: ErrorResponseCode;

  message?: string;
}

/**
 * The list of catalogs and pagination information.
 */
model CatalogsResult is Azure.Core.Page<Catalog> {
  /**
   * The total amount of catalog items.
   */
  totalItems?: int64;
}

/**
 * Product details of a type of resource.
 */
model Catalog {
  /**
   * The type of resource the sku applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The name of sku
   */
  @visibility("read")
  name?: string;

  /**
   * The billing plan options available for this sku.
   */
  billingPlans?: Record<ReservationBillingPlan[]>;

  /**
   * Available reservation terms for this resource
   */
  @visibility("read")
  terms?: ReservationTerm[];

  @visibility("read")
  locations?: string[];

  @visibility("read")
  skuProperties?: SkuProperty[];

  /**
   * Pricing information about the sku
   */
  @visibility("read")
  msrp?: CatalogMsrp;

  @visibility("read")
  restrictions?: SkuRestriction[];

  /**
   * The tier of this sku
   */
  @visibility("read")
  tier?: string;

  /**
   * The size of this sku
   */
  @visibility("read")
  size?: string;

  @visibility("read")
  capabilities?: SkuCapability[];
}

/**
 * Property of a sku.
 */
model SkuProperty {
  /**
   * An invariant to describe the feature.
   */
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  value?: string;
}

/**
 * Pricing information about the sku
 */
model CatalogMsrp {
  /**
   * Amount in pricing currency. Tax not included.
   */
  p1Y?: Price;

  /**
   * Amount in pricing currency. Tax not included.
   */
  p3Y?: Price;

  /**
   * Amount in pricing currency. Tax not included.
   */
  p5Y?: Price;
}

/**
 * Pricing information containing the amount and the currency code
 */
model Price {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  amount?: float64;
}

/**
 * Restriction of a sku.
 */
model SkuRestriction {
  /**
   * The type of restrictions.
   */
  type?: string;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the sku is restricted.
   */
  values?: string[];

  /**
   * The reason for restriction.
   */
  reasonCode?: string;
}

/**
 * Capability of a sku.
 */
model SkuCapability {
  /**
   * An invariant to describe the feature.
   */
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  value?: string;
}

/**
 * The response for applied reservations api
 */
model AppliedReservations {
  /**
   * Identifier of the applied reservations
   */
  @visibility("read")
  id?: string;

  /**
   * Name of resource
   */
  @visibility("read")
  name?: string;

  /**
   * Type of resource. "Microsoft.Capacity/AppliedReservations"
   */
  @visibility("read")
  type?: string;

  /**
   * Properties for applied reservations returned
   */
  properties?: AppliedReservationsProperties;
}

/**
 * Properties for applied reservations returned
 */
model AppliedReservationsProperties {
  /**
   * Paginated list of applied reservations
   */
  reservationOrderIds?: AppliedReservationList;
}

/**
 * Paginated list of applied reservations
 */
model AppliedReservationList {
  value?: string[];

  /**
   * Url to get the next page of reservations
   */
  nextLink?: string;
}

/**
 * The request for reservation purchase
 */
model PurchaseRequest {
  /**
   * The name of sku
   */
  sku?: SkuName;

  /**
   * The Azure region where the reserved resource lives.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Properties of reservation purchase request
   */
  properties?: PurchaseRequestProperties;
}

/**
 * The name of sku
 */
model SkuName {
  name?: string;
}

/**
 * Properties of reservation purchase request
 */
model PurchaseRequestProperties {
  /**
   * The type of the resource that is being reserved.
   */
  reservedResourceType?: ReservedResourceType;

  /**
   * Subscription that will be charged for purchasing reservation or savings plan
   */
  billingScopeId?: string;

  /**
   * Represent the term of reservation.
   */
  term?: ReservationTerm;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Quantity of the skus that are part of the reservation.
   */
  quantity?: int32;

  /**
   * Friendly name of the reservation
   */
  displayName?: string;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * List of the subscriptions that the benefit will be applied. Do not specify if AppliedScopeType is Shared. This property will be deprecated and replaced by appliedScopeProperties instead for Single AppliedScopeType.
   */
  appliedScopes?: string[];

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Setting this to true will automatically purchase a new reservation on the expiration date time.
   */
  renew?: boolean;

  /**
   * Properties specific to each reserved resource type. Not required if not applicable.
   */
  reservedResourceProperties?: PurchaseRequestPropertiesReservedResourceProperties;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

/**
 * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
 */
model AppliedScopeProperties {
  /**
   * Tenant ID where the savings plan should apply benefit.
   */
  tenantId?: string;

  /**
   * Fully-qualified identifier of the management group where the benefit must be applied.
   */
  managementGroupId?: string;

  /**
   * Fully-qualified identifier of the subscription.
   */
  subscriptionId?: string;

  /**
   * Fully-qualified identifier of the resource group.
   */
  resourceGroupId?: string;

  /**
   * Display name
   */
  displayName?: string;
}

/**
 * Properties specific to each reserved resource type. Not required if not applicable.
 */
model PurchaseRequestPropertiesReservedResourceProperties {
  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
   */
  instanceFlexibility?: InstanceFlexibility;
}

/**
 * The response of calculate price for reservation.
 */
model CalculatePriceResponse {
  /**
   * Properties for calculate price response
   */
  properties?: CalculatePriceResponseProperties;
}

/**
 * Properties for calculate price response
 */
model CalculatePriceResponseProperties {
  /**
   * Currency and amount that customer will be charged in customer's local currency. Tax is not included.
   */
  billingCurrencyTotal?: CalculatePriceResponsePropertiesBillingCurrencyTotal;

  /**
   * Net total amount in pricing currency.
   */
  netTotal?: float64;

  /**
   * Tax amount in pricing currency.
   */
  taxTotal?: float64;

  /**
   * Total amount in pricing currency.
   */
  grandTotal?: float64;

  /**
   * Whether or not tax is included in grand total
   */
  isTaxIncluded?: boolean;

  /**
   * True if billing is managed by Microsoft Partner. Used only for CSP accounts.
   */
  isBillingPartnerManaged?: boolean;

  /**
   * GUID that represents reservation order that can be placed after calculating price.
   */
  reservationOrderId?: string;

  /**
   * Title of sku that is being purchased.
   */
  skuTitle?: string;

  /**
   * Description of sku that is being purchased.
   */
  skuDescription?: string;

  /**
   * Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included.
   */
  pricingCurrencyTotal?: CalculatePriceResponsePropertiesPricingCurrencyTotal;

  paymentSchedule?: PaymentDetail[];
}

/**
 * Currency and amount that customer will be charged in customer's local currency. Tax is not included.
 */
model CalculatePriceResponsePropertiesBillingCurrencyTotal {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  /**
   * Amount in pricing currency. Tax is not included.
   */
  amount?: float64;
}

/**
 * Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included.
 */
model CalculatePriceResponsePropertiesPricingCurrencyTotal {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  amount?: float32;
}

/**
 * Information about payment related to a reservation order.
 */
model PaymentDetail {
  /**
   * Date when the payment needs to be done.
   */
  dueDate?: plainDate;

  /**
   * Date when the transaction is completed. Is null when it is scheduled.
   */
  paymentDate?: plainDate;

  /**
   * Amount in pricing currency. Tax not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Amount charged in Billing currency. Tax not included. Is null for future payments
   */
  billingCurrencyTotal?: Price;

  /**
   * Shows the Account that is charged for this payment.
   */
  billingAccount?: string;

  /**
   * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
   */
  status?: PaymentStatus;

  extendedStatusInfo?: ExtendedStatusInfo;
}

model ExtendedStatusInfo {
  statusCode?: ReservationStatusCode;

  /**
   * The message giving detailed information about the status code.
   */
  message?: string;
}

/**
 * Properties of a reservation order.
 */
model ReservationOrderProperties {
  /**
   * Friendly name for user to easily identified the reservation.
   */
  displayName?: string;

  /**
   * This is the DateTime when the reservation was initially requested for purchase.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * This is the date when the reservation will expire.
   */
  @projectedName("json", "expiryDate")
  expireOn?: plainDate;

  /**
   * This is the date-time when the reservation will expire.
   */
  @projectedName("json", "expiryDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationExpireOn?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * Total Quantity of the skus purchased in the reservation.
   */
  originalQuantity?: int32;

  /**
   * Represent the term of reservation.
   */
  term?: ReservationTerm;

  /**
   * Current state of the reservation.
   */
  provisioningState?: ProvisioningState;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Information describing the type of billing plan for this reservation.
   */
  planInformation?: ReservationOrderBillingPlanInformation;

  reservations?: ReservationResponse[];

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

/**
 * Information describing the type of billing plan for this reservation.
 */
model ReservationOrderBillingPlanInformation {
  /**
   * Amount of money to be paid for the Order. Tax is not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Date when the billing plan has started.
   */
  startDate?: plainDate;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  nextPaymentDueDate?: plainDate;

  transactions?: PaymentDetail[];
}

/**
 * The properties of the reservations
 */
model ReservationsProperties {
  /**
   * The type of the resource that is being reserved.
   */
  reservedResourceType?: ReservedResourceType;

  /**
   * Allows reservation discount to be applied across skus within the same auto fit group. Not all skus support instance size flexibility.
   */
  instanceFlexibility?: InstanceFlexibility;

  /**
   * Friendly name for user to easily identify the reservation
   */
  displayName?: string;

  /**
   * The list of applied scopes
   */
  appliedScopes?: string[];

  /**
   * The applied scope type
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Indicates if the reservation is archived
   */
  archived?: boolean;

  /**
   * Capabilities of the reservation
   */
  capabilities?: string;

  /**
   * Quantity of the skus that are part of the reservation.
   */
  quantity?: int32;

  /**
   * Current state of the reservation.
   */
  provisioningState?: ProvisioningState;

  /**
   * DateTime of the reservation starting when this version is effective from.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * DateTime of the last time the reservation was updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateTime?: utcDateTime;

  /**
   * This is the date when the reservation will expire.
   */
  @projectedName("json", "expiryDate")
  expireOn?: plainDate;

  /**
   * This is the date-time when the reservation will expire.
   */
  @projectedName("json", "expiryDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationExpireOn?: utcDateTime;

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  /**
   * Description of the sku in english.
   */
  skuDescription?: string;

  /**
   * The message giving detailed information about the status code.
   */
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * The billing plan options available for this sku.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * The provisioning state of the reservation for display, e.g. Succeeded
   */
  @visibility("read")
  displayProvisioningState?: string;

  /**
   * The provisioning sub-state of the reservation, e.g. Succeeded
   */
  @visibility("read")
  provisioningSubState?: string;

  /**
   * This is the date when the reservation was purchased.
   */
  @projectedName("json", "purchaseDate")
  purchaseOn?: plainDate;

  /**
   * This is the date-time when the reservation was purchased.
   */
  @projectedName("json", "purchaseDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationPurchaseOn?: utcDateTime;

  /**
   * Properties of reservation split
   */
  splitProperties?: ReservationSplitProperties;

  /**
   * Properties of reservation merge
   */
  mergeProperties?: ReservationMergeProperties;

  /**
   * Properties of reservation swap
   */
  swapProperties?: ReservationSwapProperties;

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Subscription that will be charged for purchasing reservation or savings plan
   */
  billingScopeId?: string;

  /**
   * Setting this to true will automatically purchase a new reservation on the expiration date time.
   */
  renew?: boolean;

  /**
   * Reservation Id of the reservation from which this reservation is renewed. Format of the resource Id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}.
   */
  renewSource?: string;

  /**
   * Reservation Id of the reservation which is purchased because of renew. Format of the resource Id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}.
   */
  renewDestination?: string;

  /**
   * The renew properties for a reservation.
   */
  renewProperties?: RenewPropertiesResponse;

  /**
   * Represent the term of reservation.
   */
  term?: ReservationTerm;

  /**
   * The applied scope type of the reservation for display, e.g. Shared
   */
  @visibility("read")
  userFriendlyAppliedScopeType?: string;

  /**
   * The renew state of the reservation for display, e.g. On
   */
  @visibility("read")
  userFriendlyRenewState?: string;

  /**
   * Reservation utilization
   */
  @visibility("read")
  utilization?: ReservationsPropertiesUtilization;
}

/**
 * Properties of reservation split
 */
model ReservationSplitProperties {
  /**
   * List of destination resource id that are created due to split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  splitDestinations?: string[];

  /**
   * Resource id of the reservation from which this is split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  splitSource?: string;
}

/**
 * Properties of reservation merge
 */
model ReservationMergeProperties {
  /**
   * Reservation resource id Created due to the merge. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  mergeDestination?: string;

  /**
   * Resource ids of the source reservation's merged to form this reservation. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  mergeSources?: string[];
}

/**
 * Properties of reservation swap
 */
model ReservationSwapProperties {
  /**
   * Resource id of the source reservation that gets swapped. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  swapSource?: string;

  /**
   * Reservation resource id that the original resource gets swapped to. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  swapDestination?: string;
}

/**
 * The renew properties for a reservation.
 */
model RenewPropertiesResponse {
  /**
   * The request for reservation purchase
   */
  purchaseProperties?: PurchaseRequest;

  /**
   * Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included. This is locked price 30 days before expiry.
   */
  pricingCurrencyTotal?: RenewPropertiesResponsePricingCurrencyTotal;

  /**
   * Currency and amount that customer will be charged in customer's local currency for renewal purchase. Tax is not included.
   */
  billingCurrencyTotal?: RenewPropertiesResponseBillingCurrencyTotal;
}

/**
 * Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included. This is locked price 30 days before expiry.
 */
model RenewPropertiesResponsePricingCurrencyTotal {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  amount?: float32;
}

/**
 * Currency and amount that customer will be charged in customer's local currency for renewal purchase. Tax is not included.
 */
model RenewPropertiesResponseBillingCurrencyTotal {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  amount?: float32;
}

/**
 * Reservation utilization
 */
model ReservationsPropertiesUtilization {
  /**
   * last 7 day utilization trend for a reservation
   */
  @visibility("read")
  trend?: string;

  /**
   * The array of aggregates of a reservation's utilization
   */
  aggregates?: ReservationUtilizationAggregates[];
}

/**
 * The aggregate values of reservation utilization
 */
model ReservationUtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility("read")
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility("read")
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility("read")
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility("read")
  valueUnit?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The request for reservation split
 */
model SplitRequest {
  /**
   * Properties for reservation split
   */
  properties?: SplitProperties;
}

/**
 * Properties for reservation split
 */
model SplitProperties {
  /**
   * List of the quantities in the new reservations to create.
   */
  quantities?: int32[];

  /**
   * Resource id of the reservation to be split. Format of the resource id should be /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  reservationId?: string;
}

/**
 * The request for reservation merge
 */
model MergeRequest {
  /**
   * Properties for reservation merge
   */
  properties?: MergeProperties;
}

/**
 * Properties for reservation merge
 */
model MergeProperties {
  /**
   * Format of the resource id should be /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  sources?: string[];
}

/**
 * The request for reservation patch
 */
model Patch {
  /**
   * Properties for reservation patch
   */
  properties?: PatchProperties;
}

/**
 * Properties for reservation patch
 */
model PatchProperties {
  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * List of the subscriptions that the benefit will be applied. Do not specify if AppliedScopeType is Shared. This property will be deprecated and replaced by appliedScopeProperties instead for Single AppliedScopeType.
   */
  appliedScopes?: string[];

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
   */
  instanceFlexibility?: InstanceFlexibility;

  /**
   * Display name of the reservation
   */
  name?: string;

  /**
   * Setting this to true will automatically purchase a new reservation on the expiration date time.
   */
  renew?: boolean;

  renewProperties?: PatchPropertiesRenewProperties;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

model PatchPropertiesRenewProperties {
  /**
   * The request for reservation purchase
   */
  purchaseProperties?: PurchaseRequest;
}

/**
 * Request containing information needed for calculating refund.
 */
model CalculateRefundRequest {
  /**
   * Fully qualified identifier of the reservation order being returned
   */
  id?: string;

  /**
   * Properties needed for calculate refund including the scope and the reservation to be returned.
   */
  properties?: CalculateRefundRequestProperties;
}

/**
 * Properties needed for calculate refund including the scope and the reservation to be returned.
 */
model CalculateRefundRequestProperties {
  /**
   * The scope of the refund, e.g. Reservation
   */
  scope?: string;

  /**
   * Reservation to return
   */
  reservationToReturn?: ReservationToReturn;
}

/**
 * Reservation to return
 */
model ReservationToReturn {
  /**
   * Fully qualified identifier of the reservation being returned
   */
  reservationId?: string;

  /**
   * Quantity to be returned. Must be greater than zero.
   */
  quantity?: int32;
}

/**
 * The response of calculate refund containing refund information of reservation
 */
model CalculateRefundResponse {
  /**
   * Fully qualified identifier of the reservation being returned
   */
  id?: string;

  /**
   * The refund properties of reservation
   */
  properties?: RefundResponseProperties;
}

/**
 * The refund properties of reservation
 */
model RefundResponseProperties {
  /**
   * Refund session identifier
   */
  sessionId?: string;

  /**
   * Quantity to be returned
   */
  quantity?: int32;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingRefundAmount?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  pricingRefundAmount?: Price;

  /**
   * Refund policy result
   */
  policyResult?: RefundPolicyResult;

  /**
   * billing information
   */
  billingInformation?: RefundBillingInformation;
}

/**
 * Refund policy result
 */
model RefundPolicyResult {
  /**
   * Refund policy result property
   */
  properties?: RefundPolicyResultProperty;
}

/**
 * Refund policy result property
 */
model RefundPolicyResultProperty {
  /**
   * Pricing information containing the amount and the currency code
   */
  consumedRefundsTotal?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  maxRefundLimit?: Price;

  /**
   * Refund Policy errors
   */
  policyErrors?: RefundPolicyError[];
}

/**
 * error details
 */
model RefundPolicyError {
  /**
   * Error code describing the reason that service is not able to process the incoming request
   */
  code?: ErrorResponseCode;

  message?: string;
}

/**
 * billing information
 */
model RefundBillingInformation {
  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * The number of completed transactions in this reservation's payment
   */
  completedTransactions?: int32;

  /**
   * The number of total transactions in this reservation's payment
   */
  totalTransactions?: int32;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotalPaidAmount?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyProratedAmount?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyRemainingCommitmentAmount?: Price;
}

/**
 * Request containing information needed for returning reservation.
 */
model RefundRequest {
  /**
   * Properties needed for refund request including the session id from calculate refund, the scope, the reservation to be returned and the return reason.
   */
  properties?: RefundRequestProperties;
}

/**
 * Properties needed for refund request including the session id from calculate refund, the scope, the reservation to be returned and the return reason.
 */
model RefundRequestProperties {
  /**
   * SessionId that was returned by CalculateRefund API.
   */
  sessionId?: string;

  /**
   * The scope of the refund, e.g. Reservation
   */
  scope?: string;

  /**
   * Reservation to return
   */
  reservationToReturn?: ReservationToReturn;

  /**
   * The reason of returning the reservation
   */
  returnReason?: string;
}

/**
 * The response of refund request containing refund information of reservation
 */
model RefundResponse {
  /**
   * Fully qualified identifier of the reservation being returned
   */
  id?: string;

  /**
   * The refund properties of reservation
   */
  properties?: RefundResponseProperties;
}

/**
 * Calculate exchange request
 */
model CalculateExchangeRequest {
  /**
   * Calculate exchange request properties
   */
  properties?: CalculateExchangeRequestProperties;
}

/**
 * Calculate exchange request properties
 */
model CalculateExchangeRequestProperties {
  /**
   * List of reservations that are being purchased in this exchange.
   */
  reservationsToPurchase?: PurchaseRequest[];

  /**
   * List of savings plans that are being purchased in this exchange.
   */
  savingsPlansToPurchase?: SavingsPlanPurchaseRequest[];

  /**
   * List of reservations that are being returned in this exchange.
   */
  reservationsToExchange?: ReservationToReturn[];
}

/**
 * Request body for savings plan purchase
 */
model SavingsPlanPurchaseRequest {
  /**
   * The name of sku
   */
  sku?: SkuName;

  /**
   * Properties of a savings plan purchase
   */
  properties?: SavingsPlanPurchaseRequestProperties;
}

/**
 * Properties of a savings plan purchase
 */
model SavingsPlanPurchaseRequestProperties {
  /**
   * Friendly name of the savings plan
   */
  displayName?: string;

  /**
   * Subscription that will be charged for purchasing reservation or savings plan
   */
  billingScopeId?: string;

  /**
   * Represent savings plan term in ISO 8601 format.
   */
  term?: SavingsPlanTerm;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;
}

/**
 * Commitment towards the benefit.
 */
model Commitment extends Price {
  /**
   * Commitment grain.
   */
  grain?: CommitmentGrain;
}

/**
 * CalculateExchange operation result
 */
model CalculateExchangeOperationResultResponse {
  /**
   * It should match what is used to GET the operation result.
   */
  id?: string;

  /**
   * It must match the last segment of the id field, and will typically be a GUID / system generated value.
   */
  name?: string;

  /**
   * Status of the operation.
   */
  status?: CalculateExchangeOperationResultStatus;

  /**
   * CalculateExchange response properties
   */
  properties?: CalculateExchangeResponseProperties;

  /**
   * Required if status == failed or status == canceled.
   */
  error?: OperationResultError;
}

/**
 * CalculateExchange response properties
 */
model CalculateExchangeResponseProperties {
  /**
   * Exchange session identifier
   */
  sessionId?: string;

  /**
   * Pricing information containing the amount and the currency code
   */
  netPayable?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  refundsTotal?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  purchasesTotal?: Price;

  /**
   * Details of the reservations being purchased
   */
  reservationsToPurchase?: ReservationToPurchaseCalculateExchange[];

  /**
   * Details of the savings plans being purchased
   */
  savingsPlansToPurchase?: SavingsPlanToPurchaseCalculateExchange[];

  /**
   * Details of the reservations being returned
   */
  reservationsToExchange?: ReservationToExchange[];

  /**
   * Exchange policy errors
   */
  policyResult?: ExchangePolicyErrors;
}

/**
 * Reservation purchase details
 */
model ReservationToPurchaseCalculateExchange {
  /**
   * The request for reservation purchase
   */
  properties?: PurchaseRequest;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotal?: Price;
}

/**
 * Savings plan purchase details
 */
model SavingsPlanToPurchaseCalculateExchange {
  /**
   * Request body for savings plan purchase
   */
  properties?: SavingsPlanPurchaseRequest;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotal?: Price;
}

/**
 * Reservation refund details
 */
model ReservationToExchange {
  /**
   * Fully qualified id of the reservation being returned.
   */
  reservationId?: string;

  /**
   * Quantity to be returned
   */
  quantity?: int32;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingRefundAmount?: Price;

  /**
   * billing information
   */
  billingInformation?: BillingInformation;
}

/**
 * billing information
 */
model BillingInformation {
  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotalPaidAmount?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyProratedAmount?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyRemainingCommitmentAmount?: Price;
}

/**
 * Exchange policy errors
 */
model ExchangePolicyErrors {
  /**
   * Exchange Policy errors
   */
  policyErrors?: ExchangePolicyError[];
}

/**
 * error details
 */
model ExchangePolicyError {
  code?: string;
  message?: string;
}

/**
 * Required if status == failed or status == canceled.
 */
model OperationResultError {
  /**
   * Required if status == failed or status == cancelled. If status == failed, provide an invariant error code used for error troubleshooting, aggregation, and analysis.
   */
  code?: string;

  /**
   * Required if status == failed. Localized. If status == failed, provide an actionable error message indicating what error occurred, and what the user can do to address the issue.
   */
  message?: string;
}

/**
 * Exchange request
 */
model ExchangeRequest {
  /**
   * Exchange request properties
   */
  properties?: ExchangeRequestProperties;
}

/**
 * Exchange request properties
 */
model ExchangeRequestProperties {
  /**
   * SessionId that was returned by CalculateExchange API.
   */
  sessionId?: string;
}

/**
 * Exchange operation result
 */
model ExchangeOperationResultResponse {
  /**
   * It should match what is used to GET the operation result.
   */
  id?: string;

  /**
   * It must match the last segment of the id field, and will typically be a GUID / system generated value.
   */
  name?: string;

  /**
   * Status of the operation.
   */
  status?: ExchangeOperationResultStatus;

  /**
   * Exchange response properties
   */
  properties?: ExchangeResponseProperties;

  /**
   * Required if status == failed or status == canceled.
   */
  error?: OperationResultError;
}

/**
 * Exchange response properties
 */
model ExchangeResponseProperties {
  /**
   * Exchange session identifier
   */
  sessionId?: string;

  /**
   * Pricing information containing the amount and the currency code
   */
  netPayable?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  refundsTotal?: Price;

  /**
   * Pricing information containing the amount and the currency code
   */
  purchasesTotal?: Price;

  /**
   * Details of the reservations being purchased
   */
  reservationsToPurchase?: ReservationToPurchaseExchange[];

  /**
   * Details of the savings plans being purchased
   */
  savingsPlansToPurchase?: SavingsPlanToPurchaseExchange[];

  /**
   * Details of the reservations being returned
   */
  reservationsToExchange?: ReservationToReturnForExchange[];

  /**
   * Exchange policy errors
   */
  policyResult?: ExchangePolicyErrors;
}

/**
 * Reservation purchase details
 */
model ReservationToPurchaseExchange {
  /**
   * Fully qualified id of the reservationOrder being purchased
   */
  reservationOrderId?: string;

  /**
   * Fully qualified id of the reservation being purchased. This value is only guaranteed to be non-null if the purchase is successful.
   */
  reservationId?: string;

  /**
   * The request for reservation purchase
   */
  properties?: PurchaseRequest;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotal?: Price;

  /**
   * Status of the individual operation.
   */
  status?: OperationStatus;
}

/**
 * Savings plan purchase details
 */
model SavingsPlanToPurchaseExchange {
  /**
   * Fully qualified id of the savings plan order being purchased
   */
  savingsPlanOrderId?: string;

  /**
   * Fully qualified id of the savings plan being purchased. This value is only guaranteed to be non-null if the purchase is successful.
   */
  savingsPlanId?: string;

  /**
   * Request body for savings plan purchase
   */
  properties?: SavingsPlanPurchaseRequest;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingCurrencyTotal?: Price;

  /**
   * Status of the individual operation.
   */
  status?: OperationStatus;
}

/**
 * Reservation refund details
 */
model ReservationToReturnForExchange {
  /**
   * Fully qualified id of the reservation being returned.
   */
  reservationId?: string;

  /**
   * Quantity to be returned
   */
  quantity?: int32;

  /**
   * Pricing information containing the amount and the currency code
   */
  billingRefundAmount?: Price;

  /**
   * billing information
   */
  billingInformation?: BillingInformation;

  /**
   * Status of the individual operation.
   */
  status?: OperationStatus;
}

/**
 * The roll up count summary of reservations in each state
 */
model ReservationSummary {
  /**
   * The number of reservation in Succeeded state
   */
  @visibility("read")
  succeededCount?: float32;

  /**
   * The number of reservation in Failed state
   */
  @visibility("read")
  failedCount?: float32;

  /**
   * The number of reservation in Expiring state
   */
  @visibility("read")
  expiringCount?: float32;

  /**
   * The number of reservation in Expired state
   */
  @visibility("read")
  expiredCount?: float32;

  /**
   * The number of reservation in Pending state
   */
  @visibility("read")
  pendingCount?: float32;

  /**
   * The number of reservation in Cancelled state
   */
  @visibility("read")
  cancelledCount?: float32;

  /**
   * The number of reservation in Processing state
   */
  @visibility("read")
  processingCount?: float32;

  /**
   * The number of reservation in Warning state
   */
  @visibility("read")
  warningCount?: float32;

  /**
   * The number of reservation in NoBenefit state
   */
  @visibility("read")
  noBenefitCount?: float32;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility("read")
  target?: string;
}

/**
 * Request body for change directory of a reservation.
 */
model ChangeDirectoryRequest {
  /**
   * Tenant id GUID that reservation order is to be transferred to
   */
  destinationTenantId?: string;
}

/**
 * Change directory response
 */
model ChangeDirectoryResponse {
  /**
   * Change directory result for reservation order or reservation
   */
  reservationOrder?: ChangeDirectoryResult;

  reservations?: ChangeDirectoryResult[];
}

/**
 * Change directory result for reservation order or reservation
 */
model ChangeDirectoryResult {
  /**
   * Identifier of the reservation order or reservation
   */
  id?: string;

  /**
   * Name of the reservation order or reservation
   */
  name?: string;

  /**
   * True if change directory operation succeeded on this reservation order or reservation
   */
  isSucceeded?: boolean;

  /**
   * Error reason if operation failed. Null otherwise
   */
  error?: string;
}

/**
 * Quota properties for the resource.
 */
model QuotaProperties {
  /**
   * Quota properties.
   */
  limit?: int32;

  /**
   * Current usage value for the resource.
   */
  @visibility("read")
  currentValue?: int32;

  /**
   *  The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.
   */
  unit?: string;

  /**
   * Name of the resource provide by the resource provider. Use this property for quotaRequests resource operations.
   */
  name?: ResourceName;

  /**
   * The name of the resource type.
   */
  resourceType?: ResourceType;

  /**
   * The time period over which the quota usage values are summarized. For example, P1D (per one day), PT1M (per one minute), and PT1S (per one second). This parameter is optional because, for some resources such as compute, the time period is irrelevant.
   */
  @visibility("read")
  quotaPeriod?: string;

  /**
   * Additional properties for the specified resource provider.
   */
  properties?: Record<unknown>;
}

/**
 * Resource name provided by the resource provider. Use this property for quotaRequest parameter.
 */
model ResourceName {
  /**
   * Resource name.
   */
  value?: string;

  /**
   * Resource display localized name.
   */
  @visibility("read")
  localizedValue?: string;
}

/**
 * The API error.
 */
@error
model ExceptionResponse {
  /**
   * The API error details.
   */
  error?: ServiceError;
}

/**
 * The API error details.
 */
model ServiceError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message text.
   */
  message?: string;

  /**
   * The list of error details.
   */
  @visibility("read")
  details?: ServiceErrorDetail[];
}

/**
 * The error details.
 */
model ServiceErrorDetail {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;
}

/**
 * Response with request ID that the quota request was accepted.
 */
model QuotaRequestSubmitResponse201 {
  /**
   * The quota request ID. Use the requestId parameter to check the request status.
   */
  @visibility("read")
  id?: string;

  /**
   * Operation ID
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Quota request status.
   */
  properties?: QuotaRequestStatusDetails;
}

/**
 * Quota request status details.
 */
model QuotaRequestStatusDetails {
  /**
   * The details of the quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * A user friendly message.
   */
  @visibility("read")
  message?: string;
}

/**
 * The details of quota request.
 */
model QuotaRequestProperties {
  /**
   * The quota request status.
   */
  provisioningState?: QuotaRequestState;

  /**
   * User friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * The quotaRequests.
   */
  value?: SubRequest[];
}

/**
 * The sub-request submitted with the quota request.
 */
model SubRequest {
  /**
   * Quota (resource limit).
   */
  @visibility("read")
  limit?: int32;

  /**
   * The resource name.
   */
  name?: ResourceName;

  /**
   * Resource type for which the quota check was made.
   */
  @visibility("read")
  resourceType?: string;

  /**
   *  The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.
   */
  unit?: string;

  /**
   * The quota request status.
   */
  provisioningState?: QuotaRequestState;

  /**
   * User-friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * Sub request ID for individual request.
   */
  @visibility("read")
  subRequestId?: string;
}

/**
 * Paginated list of operations
 */
model OperationList {
  value?: OperationResponse[];

  /**
   * Url to get the next page of items.
   */
  nextLink?: string;
}

/**
 * The response containing operation information
 */
model OperationResponse {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: Record<unknown>;
}

/**
 * Current quota limits.
 */
model CurrentQuotaLimit {
  /**
   * Quota details.
   */
  quotaInformation?: CurrentQuotaLimitBase;

  /**
   * Additional properties for the quota status for the resource.
   */
  properties?: QuotaRequestStatusDetails;
}

/**
 * Quotas (service limits) in the request response.
 */
model QuotaLimitsResponse {
  /**
   * List of quotas with the quota request status.
   */
  value?: CurrentQuotaLimit[];

  /**
   * The URI for fetching the next page of quota limits. When no more pages exist, the value is null.
   */
  nextLink?: string;
}

/**
 * Quota change requests information.
 */
model CreateGenericQuotaRequestParameters {
  /**
   * Quota change requests.
   */
  value?: CurrentQuotaLimitBase[];
}

/**
 * Response for the quota submission request.
 */
model QuotaRequestOneResourceSubmitResponse {
  /**
   * The quota request ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the quota request.
   */
  @visibility("read")
  name?: string;

  /**
   * Type of resource. "Microsoft.Capacity/ServiceLimits"
   */
  @visibility("read")
  type?: string;

  /**
   * The details for quota request.
   */
  properties?: QuotaRequestOneResourceProperties;
}

/**
 * The details of quota request.
 */
model QuotaRequestOneResourceProperties {
  /**
   * The quota request status.
   */
  @visibility("read")
  provisioningState?: QuotaRequestState;

  /**
   * User friendly status message.
   */
  @visibility("read")
  message?: string;

  /**
   * The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  /**
   * The quota request addition properties.
   */
  properties?: CurrentQuotaLimitBase;
}

/**
 * Response for the quota submission request.
 */
model QuotaRequestSubmitResponse {
  /**
   * The quota request ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the quota request.
   */
  @visibility("read")
  name?: string;

  /**
   * The quota request details.
   */
  properties?: QuotaRequestProperties;

  /**
   * Type of resource. "Microsoft.Capacity/serviceLimits"
   */
  @visibility("read")
  type?: string;
}
