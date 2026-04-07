import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;

/** The type of the software subscription resource. */
union SoftwareSubscriptionType {
  string,

  /** SoftwareSubscription resource type */
  SoftwareSubscription: "SoftwareSubscription",

  /** LicenseSoftwareAssurance resource type */
  LicenseSoftwareAssurance: "LicenseSoftwareAssurance",
}

/** Billing account parameter */
model BillingAccountNameParameter {
  /** The ID that uniquely identifies a billing account. */
  @path
  @pattern("^([0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
  billingAccountName: string;
}

/** Query parameters for pagination */
model PaginationParameters {
  /** Maximum number of items to return per page */
  @query("top")
  top?: int32;

  /** Continuation token for retrieving the next page of results. Returned in the response nextLink uri when more items are available. */
  @query("skipToken")
  skipToken?: string;
}

/** Validation result */
model ValidationResponse {
  /** Validation result */
  validationResult: ValidationResult;

  /** List of validation failures */
  @identifiers(#[])
  validationFailures?: ValidationFailure[];
}

/** Validation result */
union ValidationResult {
  string,

  /** Validation passed */
  Passed: "Passed",

  /** Validation failed */
  Failed: "Failed",
}

/** Validation failure */
model ValidationFailure {
  /** Reason code for the validation failure */
  reasonCode: string;

  /** Detailed reason for the validation failure */
  reason: string;
}
