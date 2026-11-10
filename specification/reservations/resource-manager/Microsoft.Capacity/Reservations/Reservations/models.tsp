import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Reservations;

/**
 * Error code describing the reason that service is not able to process the incoming request
 */
union ErrorResponseCode {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InternalServerError
   */
  InternalServerError: "InternalServerError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ServerTimeout
   */
  ServerTimeout: "ServerTimeout",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AuthorizationFailed
   */
  AuthorizationFailed: "AuthorizationFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BadRequest
   */
  BadRequest: "BadRequest",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ClientCertificateThumbprintNotSet
   */
  ClientCertificateThumbprintNotSet: "ClientCertificateThumbprintNotSet",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidRequestContent
   */
  InvalidRequestContent: "InvalidRequestContent",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * OperationFailed
   */
  OperationFailed: "OperationFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * HttpMethodNotSupported
   */
  HttpMethodNotSupported: "HttpMethodNotSupported",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidRequestUri
   */
  InvalidRequestUri: "InvalidRequestUri",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MissingTenantId
   */
  MissingTenantId: "MissingTenantId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidTenantId
   */
  InvalidTenantId: "InvalidTenantId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidReservationOrderId
   */
  InvalidReservationOrderId: "InvalidReservationOrderId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidReservationId
   */
  InvalidReservationId: "InvalidReservationId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReservationIdNotInReservationOrder
   */
  ReservationIdNotInReservationOrder: "ReservationIdNotInReservationOrder",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReservationOrderNotFound
   */
  ReservationOrderNotFound: "ReservationOrderNotFound",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidSubscriptionId
   */
  InvalidSubscriptionId: "InvalidSubscriptionId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidAccessToken
   */
  InvalidAccessToken: "InvalidAccessToken",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidLocationId
   */
  InvalidLocationId: "InvalidLocationId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * UnauthenticatedRequestsThrottled
   */
  UnauthenticatedRequestsThrottled: "UnauthenticatedRequestsThrottled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidHealthCheckType
   */
  InvalidHealthCheckType: "InvalidHealthCheckType",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Forbidden
   */
  Forbidden: "Forbidden",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingScopeIdCannotBeChanged
   */
  BillingScopeIdCannotBeChanged: "BillingScopeIdCannotBeChanged",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AppliedScopesNotAssociatedWithCommerceAccount
   */
  AppliedScopesNotAssociatedWithCommerceAccount: "AppliedScopesNotAssociatedWithCommerceAccount",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PatchValuesSameAsExisting
   */
  PatchValuesSameAsExisting: "PatchValuesSameAsExisting",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleAssignmentCreationFailed
   */
  RoleAssignmentCreationFailed: "RoleAssignmentCreationFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReservationOrderCreationFailed
   */
  ReservationOrderCreationFailed: "ReservationOrderCreationFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReservationOrderNotEnabled
   */
  ReservationOrderNotEnabled: "ReservationOrderNotEnabled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CapacityUpdateScopesFailed
   */
  CapacityUpdateScopesFailed: "CapacityUpdateScopesFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * UnsupportedReservationTerm
   */
  UnsupportedReservationTerm: "UnsupportedReservationTerm",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReservationOrderIdAlreadyExists
   */
  ReservationOrderIdAlreadyExists: "ReservationOrderIdAlreadyExists",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RiskCheckFailed
   */
  RiskCheckFailed: "RiskCheckFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CreateQuoteFailed
   */
  CreateQuoteFailed: "CreateQuoteFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ActivateQuoteFailed
   */
  ActivateQuoteFailed: "ActivateQuoteFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NonsupportedAccountId
   */
  NonsupportedAccountId: "NonsupportedAccountId",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PaymentInstrumentNotFound
   */
  PaymentInstrumentNotFound: "PaymentInstrumentNotFound",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MissingAppliedScopesForSingle
   */
  MissingAppliedScopesForSingle: "MissingAppliedScopesForSingle",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NoValidReservationsToReRate
   */
  NoValidReservationsToReRate: "NoValidReservationsToReRate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReRateOnlyAllowedForEA
   */
  ReRateOnlyAllowedForEA: "ReRateOnlyAllowedForEA",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * OperationCannotBePerformedInCurrentState
   */
  OperationCannotBePerformedInCurrentState: "OperationCannotBePerformedInCurrentState",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidSingleAppliedScopesCount
   */
  InvalidSingleAppliedScopesCount: "InvalidSingleAppliedScopesCount",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidFulfillmentRequestParameters
   */
  InvalidFulfillmentRequestParameters: "InvalidFulfillmentRequestParameters",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotSupportedCountry
   */
  NotSupportedCountry: "NotSupportedCountry",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * InvalidRefundQuantity
   */
  InvalidRefundQuantity: "InvalidRefundQuantity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PurchaseError
   */
  PurchaseError: "PurchaseError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingCustomerInputError
   */
  BillingCustomerInputError: "BillingCustomerInputError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingPaymentInstrumentSoftError
   */
  BillingPaymentInstrumentSoftError: "BillingPaymentInstrumentSoftError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingPaymentInstrumentHardError
   */
  BillingPaymentInstrumentHardError: "BillingPaymentInstrumentHardError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingTransientError
   */
  BillingTransientError: "BillingTransientError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingError
   */
  BillingError: "BillingError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * FulfillmentConfigurationError
   */
  FulfillmentConfigurationError: "FulfillmentConfigurationError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * FulfillmentOutOfStockError
   */
  FulfillmentOutOfStockError: "FulfillmentOutOfStockError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * FulfillmentTransientError
   */
  FulfillmentTransientError: "FulfillmentTransientError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * FulfillmentError
   */
  FulfillmentError: "FulfillmentError",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CalculatePriceFailed
   */
  CalculatePriceFailed: "CalculatePriceFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AppliedScopesSameAsExisting
   */
  AppliedScopesSameAsExisting: "AppliedScopesSameAsExisting",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SelfServiceRefundNotSupported
   */
  SelfServiceRefundNotSupported: "SelfServiceRefundNotSupported",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RefundLimitExceeded
   */
  RefundLimitExceeded: "RefundLimitExceeded",
}

/**
 * Represent the billing plans.
 */
union ReservationBillingPlan {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Upfront
   */
  Upfront: "Upfront",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Monthly
   */
  Monthly: "Monthly",
}

/**
 * Represent the term of reservation.
 */
union ReservationTerm {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P1Y
   */
  P1Y: "P1Y",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P3Y
   */
  P3Y: "P3Y",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P5Y
   */
  P5Y: "P5Y",
}

/**
 * The type of the resource that is being reserved. In addition to below types we have also added the following: OpenAIPTU, MDC, Sentinel.
 */
union ReservedResourceType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * VirtualMachines
   */
  VirtualMachines: "VirtualMachines",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SqlDatabases
   */
  SqlDatabases: "SqlDatabases",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SuseLinux
   */
  SuseLinux: "SuseLinux",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * CosmosDb
   */
  CosmosDb: "CosmosDb",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RedHat
   */
  RedHat: "RedHat",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SqlDataWarehouse
   */
  SqlDataWarehouse: "SqlDataWarehouse",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * VMwareCloudSimple
   */
  VMwareCloudSimple: "VMwareCloudSimple",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RedHatOsa
   */
  RedHatOsa: "RedHatOsa",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Databricks
   */
  Databricks: "Databricks",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AppService
   */
  AppService: "AppService",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedDisk
   */
  ManagedDisk: "ManagedDisk",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BlockBlob
   */
  BlockBlob: "BlockBlob",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RedisCache
   */
  RedisCache: "RedisCache",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AzureDataExplorer
   */
  AzureDataExplorer: "AzureDataExplorer",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MySql
   */
  MySql: "MySql",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MariaDb
   */
  MariaDb: "MariaDb",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PostgreSql
   */
  PostgreSql: "PostgreSql",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * DedicatedHost
   */
  DedicatedHost: "DedicatedHost",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SapHana
   */
  SapHana: "SapHana",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SqlAzureHybridBenefit
   */
  SqlAzureHybridBenefit: "SqlAzureHybridBenefit",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AVS
   */
  AVS: "AVS",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * DataFactory
   */
  DataFactory: "DataFactory",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NetAppStorage
   */
  NetAppStorage: "NetAppStorage",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AzureFiles
   */
  AzureFiles: "AzureFiles",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SqlEdge
   */
  SqlEdge: "SqlEdge",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * VirtualMachineSoftware
   */
  VirtualMachineSoftware: "VirtualMachineSoftware",
}

/**
 * Type of the Applied Scope.
 */
union AppliedScopeType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Single
   */
  Single: "Single",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Shared
   */
  Shared: "Shared",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagementGroup
   */
  ManagementGroup: "ManagementGroup",
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
 */
union InstanceFlexibility {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * On
   */
  On: "On",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Off
   */
  Off: "Off",
}

/**
 * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
 */
union PaymentStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Scheduled
   */
  Scheduled: "Scheduled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ReservationStatusCode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Active
   */
  Active: "Active",

  /**
   * PurchaseError
   */
  PurchaseError: "PurchaseError",

  /**
   * PaymentInstrumentError
   */
  PaymentInstrumentError: "PaymentInstrumentError",

  /**
   * Split
   */
  Split: "Split",

  /**
   * Merged
   */
  Merged: "Merged",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * Represent the current state of the Reservation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Creating
   */
  Creating: "Creating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingResourceHold
   */
  PendingResourceHold: "PendingResourceHold",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ConfirmedResourceHold
   */
  ConfirmedResourceHold: "ConfirmedResourceHold",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingBilling
   */
  PendingBilling: "PendingBilling",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ConfirmedBilling
   */
  ConfirmedBilling: "ConfirmedBilling",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Created
   */
  Created: "Created",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Expired
   */
  Expired: "Expired",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * BillingFailed
   */
  BillingFailed: "BillingFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Split
   */
  Split: "Split",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Merged
   */
  Merged: "Merged",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application
   */
  Application: "Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Key
   */
  Key: "Key",
}

/**
 * Represent savings plan term in ISO 8601 format.
 */
union SavingsPlanTerm {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P1Y
   */
  P1Y: "P1Y",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P3Y
   */
  P3Y: "P3Y",
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
 */
union BillingPlan {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * P1M
   */
  P1M: "P1M",
}

/**
 * Commitment grain.
 */
union CommitmentGrain {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Hourly
   */
  Hourly: "Hourly",
}

/**
 * Status of the operation.
 */
union CalculateExchangeOperationResultStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Status of the operation.
 */
union ExchangeOperationResultStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingRefunds
   */
  PendingRefunds: "PendingRefunds",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingPurchases
   */
  PendingPurchases: "PendingPurchases",
}

/**
 * Status of the individual operation.
 */
union OperationStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Location in which the Resources needs to be reserved. It cannot be changed after the resource has been created.
 */
union Location {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * westus
   */
  westus: "westus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * eastus
   */
  eastus: "eastus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * eastus2
   */
  eastus2: "eastus2",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * northcentralus
   */
  northcentralus: "northcentralus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * westus2
   */
  westus2: "westus2",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * southcentralus
   */
  southcentralus: "southcentralus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * centralus
   */
  centralus: "centralus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * westeurope
   */
  westeurope: "westeurope",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * northeurope
   */
  northeurope: "northeurope",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * eastasia
   */
  eastasia: "eastasia",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * southeastasia
   */
  southeastasia: "southeastasia",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * japaneast
   */
  japaneast: "japaneast",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * japanwest
   */
  japanwest: "japanwest",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * brazilsouth
   */
  brazilsouth: "brazilsouth",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * australiaeast
   */
  australiaeast: "australiaeast",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * australiasoutheast
   */
  australiasoutheast: "australiasoutheast",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * southindia
   */
  southindia: "southindia",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * westindia
   */
  westindia: "westindia",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * centralindia
   */
  centralindia: "centralindia",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * canadacentral
   */
  canadacentral: "canadacentral",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * canadaeast
   */
  canadaeast: "canadaeast",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * uksouth
   */
  uksouth: "uksouth",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * westcentralus
   */
  westcentralus: "westcentralus",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ukwest
   */
  ukwest: "ukwest",
}

/**
 * Represent the current display state of the reservation.
 */
union DisplayProvisioningState {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Expiring
   */
  Expiring: "Expiring",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Expired
   */
  Expired: "Expired",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Processing
   */
  Processing: "Processing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Warning
   */
  Warning: "Warning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NoBenefit
   */
  NoBenefit: "NoBenefit",
}

/**
 * The applied scope type
 */
union UserFriendlyAppliedScopeType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * None
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Shared
   */
  Shared: "Shared",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Single
   */
  Single: "Single",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ResourceGroup
   */
  ResourceGroup: "ResourceGroup",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagementGroup
   */
  ManagementGroup: "ManagementGroup",
}

/**
 * The renew state of the reservation
 */
union UserFriendlyRenewState {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * On
   */
  On: "On",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Off
   */
  Off: "Off",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Renewed
   */
  Renewed: "Renewed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotRenewed
   */
  NotRenewed: "NotRenewed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
  scopes?: ScopeProperties[];
}

/**
 * The scope and whether it is valid.
 */
model ScopeProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  scope?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" ""
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of sku
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The billing plan options available for this sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  billingPlans?: Record<ReservationBillingPlan[]>;

  /**
   * Available reservation terms for this resource
   */
  @visibility(Lifecycle.Read)
  terms?: ReservationTerm[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  locations?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  skuProperties?: SkuProperty[];

  /**
   * Pricing information about the sku
   */
  @visibility(Lifecycle.Read)
  msrp?: CatalogMsrp;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  restrictions?: SkuRestriction[];

  /**
   * The tier of this sku
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The size of this sku
   */
  @visibility(Lifecycle.Read)
  size?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of resource. "Microsoft.Capacity/AppliedReservations"
   */
  @visibility(Lifecycle.Read)
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
  /**
   * Array of reservation resource ids
   */
  @pageItems
  value?: string[];

  /**
   * Url to get the next page of reservations
   */
  @nextLink
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
}

/**
 * Properties of reservation purchase request
 */
model PurchaseRequestProperties {
  /**
   * The type of the resource that is being reserved. In addition to below types we have also added the following: OpenAIPTU, MDC, Sentinel.
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
  renew?: boolean = false;

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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  extendedStatusInfo?: ExtendedStatusInfo;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExtendedStatusInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  statusCode?: ReservationStatusCode;

  /**
   * The message giving detailed information about the status code.
   */
  message?: string;
}

/**
 * List of `ReservationOrder`s
 */
model ReservationOrderList is Azure.Core.Page<ReservationOrderResponse>;

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
  expiryDate?: plainDate;

  /**
   * This is the date-time when the reservation will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  provisioningState?: ProvisioningState;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Information describing the type of billing plan for this reservation.
   */
  planInformation?: ReservationOrderBillingPlanInformation;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#[])
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
   * Quantity of the skus that are part of the reservation. Must be greater than zero.
   */
  quantity?: int32;

  /**
   * Current state of the reservation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateTime?: utcDateTime;

  /**
   * This is the date when the reservation will expire.
   */
  expiryDate?: plainDate;

  /**
   * This is the date-time when the reservation will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

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
  @visibility(Lifecycle.Read)
  displayProvisioningState?: string;

  /**
   * The provisioning sub-state of the reservation, e.g. Succeeded
   */
  @visibility(Lifecycle.Read)
  provisioningSubState?: string;

  /**
   * This is the date when the reservation was purchased.
   */
  purchaseDate?: plainDate;

  /**
   * This is the date-time when the reservation was purchased.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

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
  renew?: boolean = false;

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
  @visibility(Lifecycle.Read)
  userFriendlyAppliedScopeType?: string;

  /**
   * The renew state of the reservation for display, e.g. On
   */
  @visibility(Lifecycle.Read)
  userFriendlyRenewState?: string;

  /**
   * Reservation utilization
   */
  @visibility(Lifecycle.Read)
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  amount?: float32;
}

/**
 * Reservation utilization
 */
model ReservationsPropertiesUtilization {
  /**
   * last 7 day utilization trend for a reservation
   */
  @visibility(Lifecycle.Read)
  trend?: string;

  /**
   * The array of aggregates of a reservation's utilization
   */
  @identifiers(#[])
  aggregates?: ReservationUtilizationAggregates[];
}

/**
 * The aggregate values of reservation utilization
 */
model ReservationUtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility(Lifecycle.Read)
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility(Lifecycle.Read)
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility(Lifecycle.Read)
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility(Lifecycle.Read)
  valueUnit?: string;
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
 * List of `Reservation`s
 */
model ReservationList is Azure.Core.Page<ReservationResponse>;

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
  renew?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  renewProperties?: PatchPropertiesRenewProperties;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PatchPropertiesRenewProperties {
  /**
   * The request for reservation purchase
   */
  purchaseProperties?: PurchaseRequest;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
model OperationList {
  @pageItems
  value?: OperationResponse[];

  /** Url to get the next page of items. */
  @nextLink
  nextLink?: url;
}

/**
 * The response containing operation information
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  properties?: unknown;
}

/**
 * Information about an operation
 */
model OperationDisplay {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  provider?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resource?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  operation?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  description?: string;
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
  @identifiers(#[])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @identifiers(#[])
  reservationsToPurchase?: PurchaseRequest[];

  /**
   * List of savings plans that are being purchased in this exchange.
   */
  @identifiers(#[])
  savingsPlansToPurchase?: SavingsPlanPurchaseRequest[];

  /**
   * List of reservations that are being returned in this exchange.
   */
  @identifiers(#["reservationId"])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  @identifiers(#[])
  reservationsToPurchase?: ReservationToPurchaseCalculateExchange[];

  /**
   * Details of the savings plans being purchased
   */
  @identifiers(#[])
  savingsPlansToPurchase?: SavingsPlanToPurchaseCalculateExchange[];

  /**
   * Details of the reservations being returned
   */
  @identifiers(#["reservationId"])
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
  @identifiers(#[])
  policyErrors?: ExchangePolicyError[];
}

/**
 * error details
 */
model ExchangePolicyError {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @identifiers(#["reservationId"])
  reservationsToPurchase?: ReservationToPurchaseExchange[];

  /**
   * Details of the savings plans being purchased
   */
  @identifiers(#["savingsPlanId"])
  savingsPlansToPurchase?: SavingsPlanToPurchaseExchange[];

  /**
   * Details of the reservations being returned
   */
  @identifiers(#["reservationId"])
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
  @visibility(Lifecycle.Read)
  succeededCount?: float32;

  /**
   * The number of reservation in Failed state
   */
  @visibility(Lifecycle.Read)
  failedCount?: float32;

  /**
   * The number of reservation in Expiring state
   */
  @visibility(Lifecycle.Read)
  expiringCount?: float32;

  /**
   * The number of reservation in Expired state
   */
  @visibility(Lifecycle.Read)
  expiredCount?: float32;

  /**
   * The number of reservation in Pending state
   */
  @visibility(Lifecycle.Read)
  pendingCount?: float32;

  /**
   * The number of reservation in Cancelled state
   */
  @visibility(Lifecycle.Read)
  cancelledCount?: float32;

  /**
   * The number of reservation in Processing state
   */
  @visibility(Lifecycle.Read)
  processingCount?: float32;

  /**
   * The number of reservation in Warning state
   */
  @visibility(Lifecycle.Read)
  warningCount?: float32;

  /**
   * The number of reservation in NoBenefit state
   */
  @visibility(Lifecycle.Read)
  noBenefitCount?: float32;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@error
model ErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility(Lifecycle.Read)
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * The list of reservations and summary of roll out count of reservations in each state.
 */
model ReservationsListResult {
  /**
   * The list of reservations.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ReservationResponse[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;

  /**
   * The roll out count summary of the reservations
   */
  summary?: ReservationSummary;
}
