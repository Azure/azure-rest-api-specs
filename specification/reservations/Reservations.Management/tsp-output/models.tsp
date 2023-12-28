import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Reservations;

interface Operations extends Azure.ResourceManager.Operations {}

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

enum ReservationBillingPlan {
  Upfront,
  Monthly,
}

enum ReservationTerm {
  P1Y,
  P3Y,
  P5Y,
}

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

enum AppliedScopeType {
  Single,
  Shared,
  ManagementGroup,
}

enum InstanceFlexibility {
  On,
  Off,
}

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

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SavingsPlanTerm {
  P1Y,
  P3Y,
}

enum BillingPlan {
  P1M,
}

enum CommitmentGrain {
  Hourly,
}

enum CalculateExchangeOperationResultStatus {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
}

enum ExchangeOperationResultStatus {
  Succeeded,
  Failed,
  Cancelled,
  PendingRefunds,
  PendingPurchases,
}

enum OperationStatus {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
}

enum ResourceType {
  standard,
  dedicated,
  lowPriority,
  shared,
  serviceSpecific,
}

enum QuotaRequestState {
  Accepted,
  Invalid,
  Succeeded,
  Failed,
  InProgress,
}

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

enum UserFriendlyAppliedScopeType {
  None,
  Shared,
  Single,
  ResourceGroup,
  ManagementGroup,
}

enum UserFriendlyRenewState {
  On,
  Off,
  Renewed,
  NotRenewed,
  NotApplicable,
}

@doc("Available scope")
model AvailableScopeRequest {
  @doc("Available scope request properties")
  properties?: AvailableScopeRequestProperties;
}

@doc("Available scope request properties")
model AvailableScopeRequestProperties {
  scopes?: string[];
}

@doc("The response of available scope api containing scopes and their eligibilities.")
model AvailableScopeProperties {
  @doc("The scopes checked by the available scope api.")
  properties?: SubscriptionScopeProperties;
}

@doc("The scopes checked by the available scope api.")
model SubscriptionScopeProperties {
  scopes?: ScopeProperties[];
}

@doc("The scope and whether it is valid.")
model ScopeProperties {
  scope?: string;
  valid?: boolean;
}

@doc("Error information")
@error
model Error {
  @doc("Extended error information including error code and error message")
  error?: ExtendedErrorInfo;
}

@doc("Extended error information including error code and error message")
model ExtendedErrorInfo {
  @doc("Error code describing the reason that service is not able to process the incoming request")
  code?: ErrorResponseCode;

  message?: string;
}

@doc("The list of catalogs and pagination information.")
model CatalogsResult is Azure.Core.Page<Catalog> {
  @doc("The total amount of catalog items.")
  totalItems?: int32;
}

@doc("Product details of a type of resource.")
model Catalog {
  @doc("The type of resource the sku applies to.")
  @visibility("read")
  resourceType?: string;

  @doc("The name of sku")
  @visibility("read")
  name?: string;

  @doc("The billing plan options available for this sku.")
  billingPlans?: Record<ReservationBillingPlan[]>;

  @doc("Available reservation terms for this resource")
  @visibility("read")
  terms?: ReservationTerm[];

  @visibility("read")
  locations?: string[];

  @visibility("read")
  skuProperties?: SkuProperty[];

  @doc("Pricing information about the sku")
  @visibility("read")
  msrp?: CatalogMsrp;

  @visibility("read")
  restrictions?: SkuRestriction[];

  @doc("The tier of this sku")
  @visibility("read")
  tier?: string;

  @doc("The size of this sku")
  @visibility("read")
  size?: string;

  @visibility("read")
  capabilities?: SkuCapability[];
}

@doc("Property of a sku.")
model SkuProperty {
  @doc("An invariant to describe the feature.")
  name?: string;

  @doc("An invariant if the feature is measured by quantity.")
  value?: string;
}

@doc("Pricing information about the sku")
model CatalogMsrp {
  @doc("Amount in pricing currency. Tax not included.")
  p1Y?: Price;

  @doc("Amount in pricing currency. Tax not included.")
  p3Y?: Price;

  @doc("Amount in pricing currency. Tax not included.")
  p5Y?: Price;
}

@doc("Pricing information containing the amount and the currency code")
model Price {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  amount?: float32;
}

@doc("Restriction of a sku.")
model SkuRestriction {
  @doc("The type of restrictions.")
  type?: string;

  @doc("The value of restrictions. If the restriction type is set to location. This would be different locations where the sku is restricted.")
  values?: string[];

  @doc("The reason for restriction.")
  reasonCode?: string;
}

@doc("Capability of a sku.")
model SkuCapability {
  @doc("An invariant to describe the feature.")
  name?: string;

  @doc("An invariant if the feature is measured by quantity.")
  value?: string;
}

@doc("The response for applied reservations api")
model AppliedReservations {
  @doc("Identifier of the applied reservations")
  @visibility("read")
  id?: string;

  @doc("Name of resource")
  @visibility("read")
  name?: string;

  @doc("Type of resource. \"Microsoft.Capacity/AppliedReservations\"")
  @visibility("read")
  type?: string;

  @doc("Properties for applied reservations returned")
  properties?: AppliedReservationsProperties;
}

@doc("Properties for applied reservations returned")
model AppliedReservationsProperties {
  @doc("Paginated list of applied reservations")
  reservationOrderIds?: AppliedReservationList;
}

@doc("Paginated list of applied reservations")
model AppliedReservationList {
  value?: string[];

  @doc("Url to get the next page of reservations")
  nextLink?: string;
}

@doc("The request for reservation purchase")
model PurchaseRequest {
  @doc("The name of sku")
  sku?: SkuName;

  @doc("The Azure region where the reserved resource lives.")
  @visibility("read", "create")
  location?: string;

  @doc("Properties of reservation purchase request")
  properties?: PurchaseRequestProperties;
}

@doc("The name of sku")
model SkuName {
  name?: string;
}

@doc("Properties of reservation purchase request")
model PurchaseRequestProperties {
  @doc("The type of the resource that is being reserved.")
  reservedResourceType?: ReservedResourceType;

  @doc("Subscription that will be charged for purchasing reservation or savings plan")
  billingScopeId?: string;

  @doc("Represent the term of reservation.")
  term?: ReservationTerm;

  @doc("Represent the billing plans.")
  billingPlan?: ReservationBillingPlan;

  @doc("Quantity of the skus that are part of the reservation.")
  quantity?: int32;

  @doc("Friendly name of the reservation")
  displayName?: string;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("List of the subscriptions that the benefit will be applied. Do not specify if AppliedScopeType is Shared. This property will be deprecated and replaced by appliedScopeProperties instead for Single AppliedScopeType.")
  appliedScopes?: string[];

  @doc("Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Setting this to true will automatically purchase a new reservation on the expiration date time.")
  renew?: boolean;

  @doc("Properties specific to each reserved resource type. Not required if not applicable.")
  reservedResourceProperties?: PurchaseRequestPropertiesReservedResourceProperties;

  @doc("This is the date-time when the Azure hybrid benefit needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

@doc("Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup")
model AppliedScopeProperties {
  @doc("Tenant ID where the savings plan should apply benefit.")
  tenantId?: string;

  @doc("Fully-qualified identifier of the management group where the benefit must be applied.")
  managementGroupId?: string;

  @doc("Fully-qualified identifier of the subscription.")
  subscriptionId?: string;

  @doc("Fully-qualified identifier of the resource group.")
  resourceGroupId?: string;

  @doc("Display name")
  displayName?: string;
}

@doc("Properties specific to each reserved resource type. Not required if not applicable.")
model PurchaseRequestPropertiesReservedResourceProperties {
  @doc("Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.")
  instanceFlexibility?: InstanceFlexibility;
}

@doc("The response of calculate price for reservation.")
model CalculatePriceResponse {
  @doc("Properties for calculate price response")
  properties?: CalculatePriceResponseProperties;
}

@doc("Properties for calculate price response")
model CalculatePriceResponseProperties {
  @doc("Currency and amount that customer will be charged in customer's local currency. Tax is not included.")
  billingCurrencyTotal?: CalculatePriceResponsePropertiesBillingCurrencyTotal;

  @doc("Net total amount in pricing currency.")
  netTotal?: float32;

  @doc("Tax amount in pricing currency.")
  taxTotal?: float32;

  @doc("Total amount in pricing currency.")
  grandTotal?: float32;

  @doc("Whether or not tax is included in grand total")
  isTaxIncluded?: boolean;

  @doc("True if billing is managed by Microsoft Partner. Used only for CSP accounts.")
  isBillingPartnerManaged?: boolean;

  @doc("GUID that represents reservation order that can be placed after calculating price.")
  reservationOrderId?: string;

  @doc("Title of sku that is being purchased.")
  skuTitle?: string;

  @doc("Description of sku that is being purchased.")
  skuDescription?: string;

  @doc("Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included.")
  pricingCurrencyTotal?: CalculatePriceResponsePropertiesPricingCurrencyTotal;

  paymentSchedule?: PaymentDetail[];
}

@doc("Currency and amount that customer will be charged in customer's local currency. Tax is not included.")
model CalculatePriceResponsePropertiesBillingCurrencyTotal {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  @doc("Amount in pricing currency. Tax is not included.")
  amount?: float32;
}

@doc("Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included.")
model CalculatePriceResponsePropertiesPricingCurrencyTotal {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  amount?: float32;
}

@doc("Information about payment related to a reservation order.")
model PaymentDetail {
  @doc("Date when the payment needs to be done.")
  dueDate?: plainDate;

  @doc("Date when the transaction is completed. Is null when it is scheduled.")
  paymentDate?: plainDate;

  @doc("Amount in pricing currency. Tax not included.")
  pricingCurrencyTotal?: Price;

  @doc("Amount charged in Billing currency. Tax not included. Is null for future payments")
  billingCurrencyTotal?: Price;

  @doc("Shows the Account that is charged for this payment.")
  billingAccount?: string;

  @doc("Describes whether the payment is completed, failed, cancelled or scheduled in the future.")
  status?: PaymentStatus;

  extendedStatusInfo?: ExtendedStatusInfo;
}

model ExtendedStatusInfo {
  statusCode?: ReservationStatusCode;

  @doc("The message giving detailed information about the status code.")
  message?: string;
}

@doc("Properties of a reservation order.")
model ReservationOrderProperties {
  @doc("Friendly name for user to easily identified the reservation.")
  displayName?: string;

  @doc("This is the DateTime when the reservation was initially requested for purchase.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestDateTime?: utcDateTime;

  @doc("This is the DateTime when the reservation was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  @doc("This is the date when the reservation will expire.")
  @projectedName("json", "expiryDate")
  expireOn?: plainDate;

  @doc("This is the date-time when the reservation will expire.")
  @projectedName("json", "expiryDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationExpireOn?: utcDateTime;

  @doc("This is the DateTime when the reservation benefit started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  @doc("Total Quantity of the skus purchased in the reservation.")
  originalQuantity?: int32;

  @doc("Represent the term of reservation.")
  term?: ReservationTerm;

  @doc("Current state of the reservation.")
  provisioningState?: ProvisioningState;

  @doc("Represent the billing plans.")
  billingPlan?: ReservationBillingPlan;

  @doc("Information describing the type of billing plan for this reservation.")
  planInformation?: ReservationOrderBillingPlanInformation;

  reservations?: ReservationResponse[];

  @doc("This is the date-time when the Azure Hybrid Benefit needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

@doc("Information describing the type of billing plan for this reservation.")
model ReservationOrderBillingPlanInformation {
  @doc("Amount of money to be paid for the Order. Tax is not included.")
  pricingCurrencyTotal?: Price;

  @doc("Date when the billing plan has started.")
  startDate?: plainDate;

  @doc("For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.")
  nextPaymentDueDate?: plainDate;

  transactions?: PaymentDetail[];
}

@doc("The properties of the reservations")
model ReservationsProperties {
  @doc("The type of the resource that is being reserved.")
  reservedResourceType?: ReservedResourceType;

  @doc("Allows reservation discount to be applied across skus within the same auto fit group. Not all skus support instance size flexibility.")
  instanceFlexibility?: InstanceFlexibility;

  @doc("Friendly name for user to easily identify the reservation")
  displayName?: string;

  @doc("The list of applied scopes")
  appliedScopes?: string[];

  @doc("The applied scope type")
  appliedScopeType?: AppliedScopeType;

  @doc("Indicates if the reservation is archived")
  archived?: boolean;

  @doc("Capabilities of the reservation")
  capabilities?: string;

  @doc("Quantity of the skus that are part of the reservation.")
  quantity?: int32;

  @doc("Current state of the reservation.")
  provisioningState?: ProvisioningState;

  @doc("DateTime of the reservation starting when this version is effective from.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  @doc("This is the DateTime when the reservation benefit started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  @doc("DateTime of the last time the reservation was updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateTime?: utcDateTime;

  @doc("This is the date when the reservation will expire.")
  @projectedName("json", "expiryDate")
  expireOn?: plainDate;

  @doc("This is the date-time when the reservation will expire.")
  @projectedName("json", "expiryDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationExpireOn?: utcDateTime;

  @doc("This is the date-time when the Azure Hybrid Benefit needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  @doc("Description of the sku in english.")
  skuDescription?: string;

  @doc("The message giving detailed information about the status code.")
  extendedStatusInfo?: ExtendedStatusInfo;

  @doc("The billing plan options available for this sku.")
  billingPlan?: ReservationBillingPlan;

  @doc("The provisioning state of the reservation for display, e.g. Succeeded")
  @visibility("read")
  displayProvisioningState?: string;

  @doc("The provisioning sub-state of the reservation, e.g. Succeeded")
  @visibility("read")
  provisioningSubState?: string;

  @doc("This is the date when the reservation was purchased.")
  @projectedName("json", "purchaseDate")
  purchaseOn?: plainDate;

  @doc("This is the date-time when the reservation was purchased.")
  @projectedName("json", "purchaseDateTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationPurchaseOn?: utcDateTime;

  @doc("Properties of reservation split")
  splitProperties?: ReservationSplitProperties;

  @doc("Properties of reservation merge")
  mergeProperties?: ReservationMergeProperties;

  @doc("Properties of reservation swap")
  swapProperties?: ReservationSwapProperties;

  @doc("Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Subscription that will be charged for purchasing reservation or savings plan")
  billingScopeId?: string;

  @doc("Setting this to true will automatically purchase a new reservation on the expiration date time.")
  renew?: boolean;

  @doc("Reservation Id of the reservation from which this reservation is renewed. Format of the resource Id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}.")
  renewSource?: string;

  @doc("Reservation Id of the reservation which is purchased because of renew. Format of the resource Id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}.")
  renewDestination?: string;

  @doc("The renew properties for a reservation.")
  renewProperties?: RenewPropertiesResponse;

  @doc("Represent the term of reservation.")
  term?: ReservationTerm;

  @doc("The applied scope type of the reservation for display, e.g. Shared")
  @visibility("read")
  userFriendlyAppliedScopeType?: string;

  @doc("The renew state of the reservation for display, e.g. On")
  @visibility("read")
  userFriendlyRenewState?: string;

  @doc("Reservation utilization")
  @visibility("read")
  utilization?: ReservationsPropertiesUtilization;
}

@doc("Properties of reservation split")
model ReservationSplitProperties {
  @doc("List of destination resource id that are created due to split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  splitDestinations?: string[];

  @doc("Resource id of the reservation from which this is split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  splitSource?: string;
}

@doc("Properties of reservation merge")
model ReservationMergeProperties {
  @doc("Reservation resource id Created due to the merge. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  mergeDestination?: string;

  @doc("Resource ids of the source reservation's merged to form this reservation. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  mergeSources?: string[];
}

@doc("Properties of reservation swap")
model ReservationSwapProperties {
  @doc("Resource id of the source reservation that gets swapped. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  swapSource?: string;

  @doc("Reservation resource id that the original resource gets swapped to. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  swapDestination?: string;
}

@doc("The renew properties for a reservation.")
model RenewPropertiesResponse {
  @doc("The request for reservation purchase")
  purchaseProperties?: PurchaseRequest;

  @doc("Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included. This is locked price 30 days before expiry.")
  pricingCurrencyTotal?: RenewPropertiesResponsePricingCurrencyTotal;

  @doc("Currency and amount that customer will be charged in customer's local currency for renewal purchase. Tax is not included.")
  billingCurrencyTotal?: RenewPropertiesResponseBillingCurrencyTotal;
}

@doc("Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included. This is locked price 30 days before expiry.")
model RenewPropertiesResponsePricingCurrencyTotal {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  amount?: float32;
}

@doc("Currency and amount that customer will be charged in customer's local currency for renewal purchase. Tax is not included.")
model RenewPropertiesResponseBillingCurrencyTotal {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  amount?: float32;
}

@doc("Reservation utilization")
model ReservationsPropertiesUtilization {
  @doc("last 7 day utilization trend for a reservation")
  @visibility("read")
  trend?: string;

  @doc("The array of aggregates of a reservation's utilization")
  aggregates?: ReservationUtilizationAggregates[];
}

@doc("The aggregate values of reservation utilization")
model ReservationUtilizationAggregates {
  @doc("The grain of the aggregate")
  @visibility("read")
  grain?: float32;

  @doc("The grain unit of the aggregate")
  @visibility("read")
  grainUnit?: string;

  @doc("The aggregate value")
  @visibility("read")
  value?: float32;

  @doc("The aggregate value unit")
  @visibility("read")
  valueUnit?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The request for reservation split")
model SplitRequest {
  @doc("Properties for reservation split")
  properties?: SplitProperties;
}

@doc("Properties for reservation split")
model SplitProperties {
  @doc("List of the quantities in the new reservations to create.")
  quantities?: int32[];

  @doc("Resource id of the reservation to be split. Format of the resource id should be /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  reservationId?: string;
}

@doc("The request for reservation merge")
model MergeRequest {
  @doc("Properties for reservation merge")
  properties?: MergeProperties;
}

@doc("Properties for reservation merge")
model MergeProperties {
  @doc("Format of the resource id should be /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}")
  sources?: string[];
}

@doc("The request for reservation patch")
model Patch {
  @doc("Properties for reservation patch")
  properties?: PatchProperties;
}

@doc("Properties for reservation patch")
model PatchProperties {
  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("List of the subscriptions that the benefit will be applied. Do not specify if AppliedScopeType is Shared. This property will be deprecated and replaced by appliedScopeProperties instead for Single AppliedScopeType.")
  appliedScopes?: string[];

  @doc("Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.")
  instanceFlexibility?: InstanceFlexibility;

  @doc("Display name of the reservation")
  name?: string;

  @doc("Setting this to true will automatically purchase a new reservation on the expiration date time.")
  renew?: boolean;

  renewProperties?: PatchPropertiesRenewProperties;

  @doc("This is the date-time when the Azure hybrid benefit needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

model PatchPropertiesRenewProperties {
  @doc("The request for reservation purchase")
  purchaseProperties?: PurchaseRequest;
}

@doc("Request containing information needed for calculating refund.")
model CalculateRefundRequest {
  @doc("Fully qualified identifier of the reservation order being returned")
  id?: string;

  @doc("Properties needed for calculate refund including the scope and the reservation to be returned.")
  properties?: CalculateRefundRequestProperties;
}

@doc("Properties needed for calculate refund including the scope and the reservation to be returned.")
model CalculateRefundRequestProperties {
  @doc("The scope of the refund, e.g. Reservation")
  scope?: string;

  @doc("Reservation to return")
  reservationToReturn?: ReservationToReturn;
}

@doc("Reservation to return")
model ReservationToReturn {
  @doc("Fully qualified identifier of the reservation being returned")
  reservationId?: string;

  @doc("Quantity to be returned. Must be greater than zero.")
  quantity?: int32;
}

@doc("The response of calculate refund containing refund information of reservation")
model CalculateRefundResponse {
  @doc("Fully qualified identifier of the reservation being returned")
  id?: string;

  @doc("The refund properties of reservation")
  properties?: RefundResponseProperties;
}

@doc("The refund properties of reservation")
model RefundResponseProperties {
  @doc("Refund session identifier")
  sessionId?: string;

  @doc("Quantity to be returned")
  quantity?: int32;

  @doc("Pricing information containing the amount and the currency code")
  billingRefundAmount?: Price;

  @doc("Pricing information containing the amount and the currency code")
  pricingRefundAmount?: Price;

  @doc("Refund policy result")
  policyResult?: RefundPolicyResult;

  @doc("billing information")
  billingInformation?: RefundBillingInformation;
}

@doc("Refund policy result")
model RefundPolicyResult {
  @doc("Refund policy result property")
  properties?: RefundPolicyResultProperty;
}

@doc("Refund policy result property")
model RefundPolicyResultProperty {
  @doc("Pricing information containing the amount and the currency code")
  consumedRefundsTotal?: Price;

  @doc("Pricing information containing the amount and the currency code")
  maxRefundLimit?: Price;

  @doc("Refund Policy errors")
  policyErrors?: RefundPolicyError[];
}

@doc("error details")
model RefundPolicyError {
  @doc("Error code describing the reason that service is not able to process the incoming request")
  code?: ErrorResponseCode;

  message?: string;
}

@doc("billing information")
model RefundBillingInformation {
  @doc("Represent the billing plans.")
  billingPlan?: ReservationBillingPlan;

  @doc("The number of completed transactions in this reservation's payment")
  completedTransactions?: int32;

  @doc("The number of total transactions in this reservation's payment")
  totalTransactions?: int32;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotalPaidAmount?: Price;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyProratedAmount?: Price;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyRemainingCommitmentAmount?: Price;
}

@doc("Request containing information needed for returning reservation.")
model RefundRequest {
  @doc("Properties needed for refund request including the session id from calculate refund, the scope, the reservation to be returned and the return reason.")
  properties?: RefundRequestProperties;
}

@doc("Properties needed for refund request including the session id from calculate refund, the scope, the reservation to be returned and the return reason.")
model RefundRequestProperties {
  @doc("SessionId that was returned by CalculateRefund API.")
  sessionId?: string;

  @doc("The scope of the refund, e.g. Reservation")
  scope?: string;

  @doc("Reservation to return")
  reservationToReturn?: ReservationToReturn;

  @doc("The reason of returning the reservation")
  returnReason?: string;
}

@doc("The response of refund request containing refund information of reservation")
model RefundResponse {
  @doc("Fully qualified identifier of the reservation being returned")
  id?: string;

  @doc("The refund properties of reservation")
  properties?: RefundResponseProperties;
}

@doc("Calculate exchange request")
model CalculateExchangeRequest {
  @doc("Calculate exchange request properties")
  properties?: CalculateExchangeRequestProperties;
}

@doc("Calculate exchange request properties")
model CalculateExchangeRequestProperties {
  @doc("List of reservations that are being purchased in this exchange.")
  reservationsToPurchase?: PurchaseRequest[];

  @doc("List of savings plans that are being purchased in this exchange.")
  savingsPlansToPurchase?: SavingsPlanPurchaseRequest[];

  @doc("List of reservations that are being returned in this exchange.")
  reservationsToExchange?: ReservationToReturn[];
}

@doc("Request body for savings plan purchase")
model SavingsPlanPurchaseRequest {
  @doc("The name of sku")
  sku?: SkuName;

  @doc("Properties of a savings plan purchase")
  properties?: SavingsPlanPurchaseRequestProperties;
}

@doc("Properties of a savings plan purchase")
model SavingsPlanPurchaseRequestProperties {
  @doc("Friendly name of the savings plan")
  displayName?: string;

  @doc("Subscription that will be charged for purchasing reservation or savings plan")
  billingScopeId?: string;

  @doc("Represent savings plan term in ISO 8601 format.")
  term?: SavingsPlanTerm;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Commitment towards the benefit.")
  commitment?: Commitment;
}

@doc("Commitment towards the benefit.")
model Commitment extends Price {
  @doc("Commitment grain.")
  grain?: CommitmentGrain;
}

@doc("CalculateExchange operation result")
model CalculateExchangeOperationResultResponse {
  @doc("It should match what is used to GET the operation result.")
  id?: string;

  @doc("It must match the last segment of the id field, and will typically be a GUID / system generated value.")
  name?: string;

  @doc("Status of the operation.")
  status?: CalculateExchangeOperationResultStatus;

  @doc("CalculateExchange response properties")
  properties?: CalculateExchangeResponseProperties;

  @doc("Required if status == failed or status == canceled.")
  error?: OperationResultError;
}

@doc("CalculateExchange response properties")
model CalculateExchangeResponseProperties {
  @doc("Exchange session identifier")
  sessionId?: string;

  @doc("Pricing information containing the amount and the currency code")
  netPayable?: Price;

  @doc("Pricing information containing the amount and the currency code")
  refundsTotal?: Price;

  @doc("Pricing information containing the amount and the currency code")
  purchasesTotal?: Price;

  @doc("Details of the reservations being purchased")
  reservationsToPurchase?: ReservationToPurchaseCalculateExchange[];

  @doc("Details of the savings plans being purchased")
  savingsPlansToPurchase?: SavingsPlanToPurchaseCalculateExchange[];

  @doc("Details of the reservations being returned")
  reservationsToExchange?: ReservationToExchange[];

  @doc("Exchange policy errors")
  policyResult?: ExchangePolicyErrors;
}

@doc("Reservation purchase details")
model ReservationToPurchaseCalculateExchange {
  @doc("The request for reservation purchase")
  properties?: PurchaseRequest;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotal?: Price;
}

@doc("Savings plan purchase details")
model SavingsPlanToPurchaseCalculateExchange {
  @doc("Request body for savings plan purchase")
  properties?: SavingsPlanPurchaseRequest;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotal?: Price;
}

@doc("Reservation refund details")
model ReservationToExchange {
  @doc("Fully qualified id of the reservation being returned.")
  reservationId?: string;

  @doc("Quantity to be returned")
  quantity?: int32;

  @doc("Pricing information containing the amount and the currency code")
  billingRefundAmount?: Price;

  @doc("billing information")
  billingInformation?: BillingInformation;
}

@doc("billing information")
model BillingInformation {
  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotalPaidAmount?: Price;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyProratedAmount?: Price;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyRemainingCommitmentAmount?: Price;
}

@doc("Exchange policy errors")
model ExchangePolicyErrors {
  @doc("Exchange Policy errors")
  policyErrors?: ExchangePolicyError[];
}

@doc("error details")
model ExchangePolicyError {
  code?: string;
  message?: string;
}

@doc("Required if status == failed or status == canceled.")
model OperationResultError {
  @doc("Required if status == failed or status == cancelled. If status == failed, provide an invariant error code used for error troubleshooting, aggregation, and analysis.")
  code?: string;

  @doc("Required if status == failed. Localized. If status == failed, provide an actionable error message indicating what error occurred, and what the user can do to address the issue.")
  message?: string;
}

@doc("Exchange request")
model ExchangeRequest {
  @doc("Exchange request properties")
  properties?: ExchangeRequestProperties;
}

@doc("Exchange request properties")
model ExchangeRequestProperties {
  @doc("SessionId that was returned by CalculateExchange API.")
  sessionId?: string;
}

@doc("Exchange operation result")
model ExchangeOperationResultResponse {
  @doc("It should match what is used to GET the operation result.")
  id?: string;

  @doc("It must match the last segment of the id field, and will typically be a GUID / system generated value.")
  name?: string;

  @doc("Status of the operation.")
  status?: ExchangeOperationResultStatus;

  @doc("Exchange response properties")
  properties?: ExchangeResponseProperties;

  @doc("Required if status == failed or status == canceled.")
  error?: OperationResultError;
}

@doc("Exchange response properties")
model ExchangeResponseProperties {
  @doc("Exchange session identifier")
  sessionId?: string;

  @doc("Pricing information containing the amount and the currency code")
  netPayable?: Price;

  @doc("Pricing information containing the amount and the currency code")
  refundsTotal?: Price;

  @doc("Pricing information containing the amount and the currency code")
  purchasesTotal?: Price;

  @doc("Details of the reservations being purchased")
  reservationsToPurchase?: ReservationToPurchaseExchange[];

  @doc("Details of the savings plans being purchased")
  savingsPlansToPurchase?: SavingsPlanToPurchaseExchange[];

  @doc("Details of the reservations being returned")
  reservationsToExchange?: ReservationToReturnForExchange[];

  @doc("Exchange policy errors")
  policyResult?: ExchangePolicyErrors;
}

@doc("Reservation purchase details")
model ReservationToPurchaseExchange {
  @doc("Fully qualified id of the reservationOrder being purchased")
  reservationOrderId?: string;

  @doc("Fully qualified id of the reservation being purchased. This value is only guaranteed to be non-null if the purchase is successful.")
  reservationId?: string;

  @doc("The request for reservation purchase")
  properties?: PurchaseRequest;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotal?: Price;

  @doc("Status of the individual operation.")
  status?: OperationStatus;
}

@doc("Savings plan purchase details")
model SavingsPlanToPurchaseExchange {
  @doc("Fully qualified id of the savings plan order being purchased")
  savingsPlanOrderId?: string;

  @doc("Fully qualified id of the savings plan being purchased. This value is only guaranteed to be non-null if the purchase is successful.")
  savingsPlanId?: string;

  @doc("Request body for savings plan purchase")
  properties?: SavingsPlanPurchaseRequest;

  @doc("Pricing information containing the amount and the currency code")
  billingCurrencyTotal?: Price;

  @doc("Status of the individual operation.")
  status?: OperationStatus;
}

@doc("Reservation refund details")
model ReservationToReturnForExchange {
  @doc("Fully qualified id of the reservation being returned.")
  reservationId?: string;

  @doc("Quantity to be returned")
  quantity?: int32;

  @doc("Pricing information containing the amount and the currency code")
  billingRefundAmount?: Price;

  @doc("billing information")
  billingInformation?: BillingInformation;

  @doc("Status of the individual operation.")
  status?: OperationStatus;
}

@doc("The roll up count summary of reservations in each state")
model ReservationSummary {
  @doc("The number of reservation in Succeeded state")
  @visibility("read")
  succeededCount?: float32;

  @doc("The number of reservation in Failed state")
  @visibility("read")
  failedCount?: float32;

  @doc("The number of reservation in Expiring state")
  @visibility("read")
  expiringCount?: float32;

  @doc("The number of reservation in Expired state")
  @visibility("read")
  expiredCount?: float32;

  @doc("The number of reservation in Pending state")
  @visibility("read")
  pendingCount?: float32;

  @doc("The number of reservation in Cancelled state")
  @visibility("read")
  cancelledCount?: float32;

  @doc("The number of reservation in Processing state")
  @visibility("read")
  processingCount?: float32;

  @doc("The number of reservation in Warning state")
  @visibility("read")
  warningCount?: float32;

  @doc("The number of reservation in NoBenefit state")
  @visibility("read")
  noBenefitCount?: float32;
}

@doc("The details of the error.")
model ErrorDetails {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error.")
  @visibility("read")
  target?: string;
}

@doc("Request body for change directory of a reservation.")
model ChangeDirectoryRequest {
  @doc("Tenant id GUID that reservation order is to be transferred to")
  destinationTenantId?: string;
}

@doc("Change directory response")
model ChangeDirectoryResponse {
  @doc("Change directory result for reservation order or reservation")
  reservationOrder?: ChangeDirectoryResult;

  reservations?: ChangeDirectoryResult[];
}

@doc("Change directory result for reservation order or reservation")
model ChangeDirectoryResult {
  @doc("Identifier of the reservation order or reservation")
  id?: string;

  @doc("Name of the reservation order or reservation")
  name?: string;

  @doc("True if change directory operation succeeded on this reservation order or reservation")
  isSucceeded?: boolean;

  @doc("Error reason if operation failed. Null otherwise")
  error?: string;
}

@doc("Quota properties for the resource.")
model QuotaProperties {
  @doc("Quota properties.")
  limit?: int32;

  @doc("Current usage value for the resource.")
  @visibility("read")
  currentValue?: int32;

  @doc(" The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.")
  unit?: string;

  @doc("Name of the resource provide by the resource provider. Use this property for quotaRequests resource operations.")
  name?: ResourceName;

  @doc("The name of the resource type.")
  resourceType?: ResourceType;

  @doc("The time period over which the quota usage values are summarized. For example, P1D (per one day), PT1M (per one minute), and PT1S (per one second). This parameter is optional because, for some resources such as compute, the time period is irrelevant.")
  @visibility("read")
  quotaPeriod?: string;

  @doc("Additional properties for the specified resource provider.")
  properties?: Record<unknown>;
}

@doc("Resource name provided by the resource provider. Use this property for quotaRequest parameter.")
model ResourceName {
  @doc("Resource name.")
  value?: string;

  @doc("Resource display localized name.")
  @visibility("read")
  localizedValue?: string;
}

@doc("The API error.")
@error
model ExceptionResponse {
  @doc("The API error details.")
  error?: ServiceError;
}

@doc("The API error details.")
model ServiceError {
  @doc("The error code.")
  code?: string;

  @doc("The error message text.")
  message?: string;

  @doc("The list of error details.")
  @visibility("read")
  details?: ServiceErrorDetail[];
}

@doc("The error details.")
model ServiceErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;
}

@doc("Response with request ID that the quota request was accepted.")
model QuotaRequestSubmitResponse201 {
  @doc("The quota request ID. Use the requestId parameter to check the request status.")
  @visibility("read")
  id?: string;

  @doc("Operation ID")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Quota request status.")
  properties?: QuotaRequestStatusDetails;
}

@doc("Quota request status details.")
model QuotaRequestStatusDetails {
  @doc("The details of the quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("A user friendly message.")
  @visibility("read")
  message?: string;
}

@doc("The details of quota request.")
model QuotaRequestProperties {
  @doc("The quota request status.")
  provisioningState?: QuotaRequestState;

  @doc("User friendly status message.")
  @visibility("read")
  message?: string;

  @doc("The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  @doc("The quotaRequests.")
  value?: SubRequest[];
}

@doc("The sub-request submitted with the quota request.")
model SubRequest {
  @doc("Quota (resource limit).")
  @visibility("read")
  limit?: int32;

  @doc("The resource name.")
  name?: ResourceName;

  @doc("Resource type for which the quota check was made.")
  @visibility("read")
  resourceType?: string;

  @doc(" The limit units, such as **count** and **bytes**. Use the unit field provided in the response of the GET quota operation.")
  unit?: string;

  @doc("The quota request status.")
  provisioningState?: QuotaRequestState;

  @doc("User-friendly status message.")
  @visibility("read")
  message?: string;

  @doc("Sub request ID for individual request.")
  @visibility("read")
  subRequestId?: string;
}

@doc("Paginated list of operations")
model OperationList {
  value?: OperationResponse[];

  @doc("Url to get the next page of items.")
  nextLink?: string;
}

@doc("The response containing operation information")
model OperationResponse {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: Record<unknown>;
}

@doc("Current quota limits.")
model CurrentQuotaLimit {
  @doc("Quota details.")
  quotaInformation?: CurrentQuotaLimitBase;

  @doc("Additional properties for the quota status for the resource.")
  properties?: QuotaRequestStatusDetails;
}

@doc("Quotas (service limits) in the request response.")
model QuotaLimitsResponse {
  @doc("List of quotas with the quota request status.")
  value?: CurrentQuotaLimit[];

  @doc("The URI for fetching the next page of quota limits. When no more pages exist, the value is null.")
  nextLink?: string;
}

@doc("Quota change requests information.")
model CreateGenericQuotaRequestParameters {
  @doc("Quota change requests.")
  value?: CurrentQuotaLimitBase[];
}

@doc("Response for the quota submission request.")
model QuotaRequestOneResourceSubmitResponse {
  @doc("The quota request ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the quota request.")
  @visibility("read")
  name?: string;

  @doc("Type of resource. \"Microsoft.Capacity/ServiceLimits\"")
  @visibility("read")
  type?: string;

  @doc("The details for quota request.")
  properties?: QuotaRequestOneResourceProperties;
}

@doc("The details of quota request.")
model QuotaRequestOneResourceProperties {
  @doc("The quota request status.")
  @visibility("read")
  provisioningState?: QuotaRequestState;

  @doc("User friendly status message.")
  @visibility("read")
  message?: string;

  @doc("The time when the quota request was submitted using format: yyyy-MM-ddTHH:mm:ssZ as specified by the ISO 8601 standard.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestSubmitTime?: utcDateTime;

  @doc("The quota request addition properties.")
  properties?: CurrentQuotaLimitBase;
}

@doc("Response for the quota submission request.")
model QuotaRequestSubmitResponse {
  @doc("The quota request ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the quota request.")
  @visibility("read")
  name?: string;

  @doc("The quota request details.")
  properties?: QuotaRequestProperties;

  @doc("Type of resource. \"Microsoft.Capacity/serviceLimits\"")
  @visibility("read")
  type?: string;
}
