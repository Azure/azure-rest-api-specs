import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.BillingTrust")
@service(#{ title: "BillingTrust Management API" })
@doc("Microsoft.BillingTrust resource provider. Provides Assessment and Rule resources used to evaluate trust attributes (such as education-domain qualification and business verification) of a billing account.")
@versioned(Versions)
namespace Microsoft.BillingTrust;

@doc("Supported API Versions for Microsoft.BillingTrust")
enum Versions {
  @doc("API Version 2026-08-10-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  `2026-08-10-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

// ============================================================================
// Enums / Unions
// ============================================================================

@doc("The status of the current operation")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("The aggregated evaluation state of an assessment, derived from its rules")
union AssessmentState {
  string,

  @doc("One or more rules have not reached a steady state")
  Pending: "pending",

  @doc("One or more rules are currently being evaluated")
  Running: "running",

  @doc("One or more rules require user action")
  ActionRequired: "actionRequired",

  @doc("One or more rules require manual review")
  UnderReview: "underReview",

  @doc("All rules reached a steady state, and the last non-skipped rule failed")
  Failed: "failed",

  @doc("All rules reached a steady state, and the last non-skipped rule succeeded")
  Succeeded: "succeeded",

  @doc("Assessment succeeded but with a manual override applied by an authorized reviewer")
  SucceededWithOverride: "succeededWithOverride",

  @doc("Assessment failed but with a manual override applied by an authorized reviewer")
  FailedWithOverride: "failedWithOverride",

  @doc("Assessment expired and requires re-evaluation")
  Expired: "expired",
}

@doc("The evaluation state of a rule")
union RuleState {
  string,

  @doc("Rule is queued and not yet evaluated")
  Pending: "pending",

  @doc("Rule evaluation is in progress")
  Running: "running",

  @doc("Customer input is required to proceed")
  ActionRequired: "actionRequired",

  @doc("Manual review is in progress")
  UnderReview: "underReview",

  @doc("Rule preconditions were not met; rule was skipped")
  Skipped: "skipped",

  @doc("Rule evaluation failed")
  Failed: "failed",

  @doc("Rule evaluation succeeded")
  Succeeded: "succeeded",

  @doc("Rule succeeded but with a manual override applied by an authorized reviewer")
  SucceededWithOverride: "succeededWithOverride",

  @doc("Rule failed but with a manual override applied by an authorized reviewer")
  FailedWithOverride: "failedWithOverride",

  @doc("Rule expired and requires re-evaluation")
  Expired: "expired",
}

@doc("The verification state of a single domain entry within an eduQualification rule")
union DomainEntryState {
  string,

  @doc("Domain verification queued or in progress")
  Pending: "pending",

  @doc("Customer must supply additional evidence (e.g. supplemental documents)")
  ActionRequired: "actionRequired",

  @doc("Domain verification failed")
  Failed: "failed",

  @doc("Domain verification succeeded")
  Succeeded: "succeeded",
}

@doc("The kind of rule. Additional kinds may be added in future API versions.")
union RuleKind {
  string,

  @doc("Education qualification rule. Verifies education-domain ownership for the billing account.")
  EduQualification: "eduQualification",

  @doc("Business verification rule. Verifies the business identity of the billing account.")
  BusinessVerification: "businessVerification",

  @doc("Verified credential rule. Verifies a user's digital identity using a credential issued by a trusted identity verifier (IDV).")
  VerifiedCredential: "verifiedCredential",

  @doc("Domain verification rule. Verifies ownership of the DNS domain associated with the billing account.")
  DomainVerification: "domainVerification",

  @doc("Legal contact verification rule. Verifies the billing account's legal contact has been configured and its email verified.")
  LegalContactVerification: "legalContactVerification",

  @doc("Ultimate beneficial owner (UBO) verification rule. Tracks and verifies the billing account's ultimate beneficial owners.")
  UboVerification: "uboVerification",

  @doc("Payee verification rule. Verifies the billing account's ultimate beneficial owners satisfy the regulatory requirements to be a payee.")
  PayeeVerification: "payeeVerification",

  @doc("REM qualification rule. Determines the billing account's REM (Regulated Entity / EAA Model) qualification.")
  RemQualification: "remQualification",
}

@doc("The type of a next-step action surfaced for an assessment. Extensible — additional action types may be added in future API versions.")
union AssessmentActionType {
  string,

  @doc("Redirect the user to an external experience to complete the action (e.g. an interactive verification experience).")
  Redirect: "redirect",
}

// ============================================================================
// Assessment (Extension Resource, named by template)
// ============================================================================

@doc("A billing trust assessment. An assessment runs a set of rules to evaluate trust attributes of a billing account. The assessment name selects the template to run (for example `Edu` or `CommercialMarketplace`); a billing account may carry one assessment per template. The name is case-insensitive and must match a known template.")
model Assessment is ExtensionResource<AssessmentProperties> {
  @doc("The name of the assessment. Selects the assessment template to run (for example `Edu` or `CommercialMarketplace`). Case-insensitive; must match a known template or the request is rejected.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,63}$")
  @key("assessmentName")
  @segment("assessments")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("A single key/value entry in an assessment's `draft`.")
model DraftEntry {
  @doc("The metadata key.")
  @minLength(1)
  @maxLength(64)
  key: string;

  @doc("The metadata value.")
  @maxLength(1024)
  value: string;
}

@doc("The properties of an Assessment resource")
model AssessmentProperties {
  @doc("The aggregated evaluation state of all active rules within this assessment")
  @visibility(Lifecycle.Read)
  evaluationState?: AssessmentState;

  @doc("The next scheduled re-evaluation of this assessment. Only present when one or more rules in this assessment have a configured recurrence.")
  @visibility(Lifecycle.Read)
  nextEvaluation?: utcDateTime;

  @doc("Error information when evaluationState is failed")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  @doc("""
    Optional initial values applied to the rules created with this assessment.
    Set on PUT: the values seed the per-kind rules for the assessment's current
    evaluation. Re-PUT semantics depend on whether the values changed and on
    evaluation progress — see the assessment resource's PUT contract.
    
    Returned on read. Customer data within it is omitted from the default read
    response: for `eduQualification`, `domainNames` is returned empty, and the
    real names are returned only under `?$expandCustomerData=true`.
    """)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  initialValues?: InitialRuleValueBase[];

  @doc("The provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "actions is a server-computed, read-only projection surfaced on read responses; there is no request-body counterpart."
  @doc("Server-computed next-step actions for this assessment (for example, a redirect to an interactive verification experience). Populated only for assessment templates configured to surface actions; absent otherwise. Read-only.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  actions?: AssessmentAction[];

  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "draft is customer-supplied data omitted from the default read response and returned only under ?$expandCustomerData=true; it is set via PATCH (AssessmentUpdateProperties) and overlaid on read, and is kept out of the resource's Resource Graph projection."
  @doc("""
    Customer-supplied draft data about the operation, as a list of key/value pairs
    (for example, interactive-verification form fields). Set via PATCH, which replaces
    the whole list (send `[]` to clear). Returned on read only when
    `?$expandCustomerData=true`; omitted from the default read response.
    
    **Data classification — Personally Identifiable Information (PII):** may carry
    contact PII (for example, names). Returned only on `?$expandCustomerData=true`
    and omitted from the default read response.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Update)
  @Azure.ResourceManager.identifiers(#[])
  @maxItems(100)
  draft?: DraftEntry[];
}

@doc("The patchable properties of an Assessment resource. `draft` is the only field a customer can update.")
model AssessmentUpdateProperties {
  @doc("Customer-supplied draft data about the operation, as a list of key/value pairs (for example, interactive-verification form fields). Replaces the stored list wholesale; send `[]` to clear. Stored in service state and returned on read only under `?$expandCustomerData=true` — omitted from the default read response.")
  @Azure.ResourceManager.identifiers(#[])
  @maxItems(100)
  draft?: DraftEntry[];
}

// ============================================================================
// Rule (child resource of Assessment)
// ============================================================================

@doc("A rule within an assessment")
@parentResource(Assessment)
model Rule is ProxyResource<RuleProperties> {
  @doc("The name of the rule. Rules are created by the service when the parent assessment is created — the available rule names are determined by the assessment template. Names start with an alphanumeric character and may contain letters, digits, underscores, and hyphens.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,63}$")
  @key("ruleName")
  @segment("rules")
  @path
  name: string;
}

@doc("Appeal quota for a rule. Server-managed.")
model RuleAppealQuota {
  @doc("Number of appeals already used for this rule.")
  @visibility(Lifecycle.Read)
  used: int32;

  @doc("Maximum number of appeals permitted.")
  @visibility(Lifecycle.Read)
  limit: int32;
}

@doc("""
  Appeal state for a rule that has a failed, appeal-relevant outcome (currently
  `businessVerification`). Server-managed and read-only — set by the service from
  the verification outcome and surfaced on GET/LIST. **Absent when
  there is no appeal context** (the rule is pending/running/succeeded); **present**
  once the rule fails, so the presence of this object itself signals "an appeal may
  be relevant here."
  """)
model RuleAppeal {
  @doc("Whether the current failed outcome can be appealed right now (the outcome was marked appealable and appeal quota remains).")
  @visibility(Lifecycle.Read)
  appealable: boolean;

  @doc("Appeal quota (used vs. maximum permitted).")
  @visibility(Lifecycle.Read)
  quota: RuleAppealQuota;

  @doc("The reviewer's latest action-required message explaining what is needed for an appeal.")
  @visibility(Lifecycle.Read)
  comment?: string;

  @doc("The document type codes the reviewer requested for an appeal that the customer has not yet supplied.")
  @visibility(Lifecycle.Read)
  documentTypeCodes?: string[];
}

@doc("Base properties of a Rule resource. Polymorphic by `kind` — kind-specific writable fields live on derived models.")
@discriminator("kind")
model RuleProperties {
  // Read-only contract for service-owned fields (`evaluationState`, `error`):
  //   These are read-only from a customer's perspective — they are set by the
  //   service and surfaced via the GET/LIST response. Customers cannot modify
  //   them via PUT/PATCH.
  //
  //   `kind` is the discriminator; clients cannot change a rule's kind via any
  //   operation, so it is `Lifecycle.Read` only.
  //
  //   `provisioningState` is `Lifecycle.Read` because the platform owns it
  //   end-to-end via the operation-status lifecycle.
  //
  // Known emitter limitation — readOnly + $ref sibling pattern:
  //   Properties typed as `$ref` (e.g. `error` -> ErrorDetail, `kind` ->
  //   RuleKind, `soldTo` -> SoldTo) emit `{ "$ref": "...", "readOnly": true }`
  //   in the openapi.json. Per JSON Schema, siblings of `$ref` are ignored
  //   by strict validators, so `readOnly: true` is silently dropped. The
  //   correct output would be `{ "allOf": [{ "$ref": "..." }], "readOnly": true }`.
  //   This is a known limitation of @azure-tools/typespec-autorest (the
  //   emitter does not wrap read-only $ref properties in allOf). The
  //   TypeSpec source (@visibility(Lifecycle.Read)) is correct; the
  //   emitter output is the artifact that is wrong. Properties whose target
  //   type is a standalone enum with top-level readOnly (evaluationState,
  //   provisioningState) are unaffected. Tracked for resolution via
  //   the typespec-autorest emitter; no fix is available in TypeSpec source.

  @doc("The kind of rule. Acts as a discriminator for kind-specific properties.")
  @visibility(Lifecycle.Read)
  kind: RuleKind;

  @doc("The evaluation state of the rule. Server-managed.")
  @visibility(Lifecycle.Read)
  evaluationState?: RuleState;

  @doc("Error information when evaluationState is `failed` or `actionRequired`. Server-managed.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  @doc("The provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Appeal state — appealability, round usage, reviewer comment, and requested document types. Server-managed; absent when the rule has no appeal-relevant (failed) outcome.")
  @visibility(Lifecycle.Read)
  appeal?: RuleAppeal;
}

@doc("Properties of an eduQualification rule. Verifies education-domain ownership for a billing account.")
model EduQualificationRuleProperties extends RuleProperties {
  kind: RuleKind.EduQualification;

  @doc("Per-tenant domain entries to verify.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @Azure.ResourceManager.identifiers(#[])
  domains?: DomainEntry[];

  @doc("References to supplemental documents. Settable only when evaluationState is `actionRequired`.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  supplementalDocuments?: url[];
}

@doc("""
  Properties of a business verification rule. Verifies the billing account's
  business identity.
  
  Sold-to, legal contact, registration number, and tax ids reflect the billing
  account's information on file and cannot be supplied by end users.
  """)
model BusinessVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.BusinessVerification;

  @doc("Sold-to identity (company, postal address, and the account's own contact email/phone) used for business verification. Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  soldTo?: SoldTo;

  @doc("Legal contact person for the billing account. Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  legalContact?: LegalContact;

  @doc("Registration number context (allowed types, registration id, and whether one is required) on file for the billing account. Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  registrationNumber?: RegistrationNumber;

  @doc("Tax ids associated with the billing account. Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  taxIds?: TaxId[];

  @doc("Optional external-registry identifier (e.g. DUNS) used to disambiguate verification matches. Settable on PATCH while `evaluationState` is `pending` or `actionRequired`.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  externalId?: ExternalId;

  @doc("References to supplemental documents (businessVerification rules only; only settable while evaluationState is `pending` or `actionRequired`).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  supplementalDocuments?: url[];
}

@doc("Properties of a verified credential rule. Verifies a user's digital identity using a credential issued by a trusted identity verifier (IDV).")
model VerifiedCredentialRuleProperties extends RuleProperties {
  kind: RuleKind.VerifiedCredential;

  @doc("Link the end user follows to present their verifiable credential. Set by the verification provider after the request is created. Server-managed.")
  @visibility(Lifecycle.Read)
  verificationLink?: url;
}

@doc("Properties of a domain verification rule. Verifies ownership of the DNS domain associated with the billing account.")
model DomainVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.DomainVerification;

  @doc("The DNS domain being verified. Populated from the billing account when the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  domain?: string;
}

@doc("Properties of a legal contact verification rule. Verifies the billing account's legal contact is configured and its email verified.")
model LegalContactVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.LegalContactVerification;

  @doc("The billing account's legal contact. Populated from the billing account when the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  legalContact?: LegalContact;
}

@doc("Properties of an ultimate beneficial owner (UBO) verification rule. Shared rule — multiple instances over the same billing account operate on the same underlying data.")
model UboVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.UboVerification;

  @doc("The billing account's ultimate beneficial owners. Defaults to the owners retrieved from the configured provider. Server-managed.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  users?: UboUser[];

  @doc("Business ownership context (business name, country, registered address) resolved from the billing account sold-to. Server-managed.")
  @visibility(Lifecycle.Read)
  businessOwnership?: BusinessOwnership;

  @doc("The set of attestations allowed for this rule. Server-managed.")
  @visibility(Lifecycle.Read)
  allowedAttestations?: UboAttestation[];

  @doc("Whether the user has explicitly confirmed the UBO details. Server-managed.")
  @visibility(Lifecycle.Read)
  attestation?: UboAttestation;
}

@doc("Properties of a payee verification rule. Verifies the billing account's ultimate beneficial owners satisfy the regulatory requirements to be a payee. Requires a successful UBO verification rule as a prerequisite.")
model PayeeVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.PayeeVerification;
}

@doc("Properties of a REM qualification rule. Determines the billing account's REM (Regulated Entity / EAA Model) qualification.")
model RemQualificationRuleProperties extends RuleProperties {
  kind: RuleKind.RemQualification;
}

@doc("Patch body for updating a rule. Polymorphic by `kind` — kind-specific patchable fields live on per-kind subtypes. PATCH cannot change a rule's kind; the discriminator carries the rule's existing kind for routing only. `eduQualification`, `businessVerification`, and `uboVerification` define patchable fields today; PATCH on `payeeVerification`, `remQualification`, and `legalContactVerification` rules is rejected with 400 InvalidParameterValue (no patchable fields).")
@discriminator("kind")
model RulePatchProperties {
  @doc("The kind of rule. Acts as a discriminator for per-kind patchable fields. Must match the existing rule's kind; PATCH cannot mutate kind.")
  kind: RuleKind;
}

@doc("Patch body for an eduQualification rule. Only `supplementalDocuments` is settable, and only when evaluationState == actionRequired.")
model EduQualificationRulePatchProperties extends RulePatchProperties {
  kind: RuleKind.EduQualification;

  @doc("References to supplemental documents (eduQualification rules only; only settable when evaluationState == actionRequired).")
  supplementalDocuments?: url[];
}

@doc("Patch body for a businessVerification rule. Settable while evaluationState is `pending` or `actionRequired`. `externalId` lets the customer disambiguate an ambiguous verification match (e.g. via DUNS); `supplementalDocuments` carries references to documents uploaded via the assessment-scoped upload-token action.")
model BusinessVerificationRulePatchProperties extends RulePatchProperties {
  kind: RuleKind.BusinessVerification;

  @doc("Optional external-registry identifier (e.g. DUNS) used to disambiguate ambiguous verification matches.")
  externalId?: ExternalId;

  @doc("References to supplemental documents (businessVerification rules only; only settable while evaluationState is `pending` or `actionRequired`).")
  supplementalDocuments?: url[];
}

@doc("Patch body for a uboVerification rule. Settable while evaluationState is `actionRequired` or `failed`. The only patchable field is `attestation`; supplying it re-triggers provider evaluation of the UBO rule and resets downstream dependent rules (e.g. payeeVerification) to pending. The UBO `users` list and `businessOwnership` facts are NOT patchable — `users` is server-provided (fetched from the configured provider) and `businessOwnership` is resolved by the service from the billing account sold-to. Per-individual identity verification (IDV) is a separate operation — the `startIndividualVerification` action on the rule — and is not driven through PATCH.")
model UboVerificationRulePatchProperties extends RulePatchProperties {
  kind: RuleKind.UboVerification;

  @doc("Set the attestation state. Must be `attested` for downstream payeeVerification to proceed. When not `attested`, the downstream PayeeVerification rule fails with `NotAttested`.")
  attestation?: UboAttestation;
}

// ============================================================================
// Review resource — DEFERRED to a future API version
// ============================================================================
//
// A tenant-level Review resource for follow-up is intentionally omitted from
// this preview and is out of scope for this revision. The `Review`,
// `ReviewProperties`, and `Reviews` interface will be added when the review
// feature is implemented.

// ============================================================================
// Supporting models
// ============================================================================

@doc("Base type for write-only initial values supplied when creating an assessment. Polymorphic by `kind`; per-kind initial values forward into the corresponding rule.")
@discriminator("kind")
model InitialRuleValueBase {
  @doc("The kind of rule to initialize")
  kind: RuleKind;
}

@doc("Initial values for an education qualification rule. Per-domain entries (`domainNames` + `tenantId`) are used to populate the rule when the assessment is created.")
model EduInitialValue extends InitialRuleValueBase {
  kind: RuleKind.EduQualification;

  @doc("Per-domain entries to use when populating the education qualification rule. Only `domainNames` and `tenantId` are read from this payload; `state` and `error` on each entry are populated by the service.")
  @Azure.ResourceManager.identifiers(#[])
  domains: DomainEntry[];
}

@doc("Initial values for a uboVerification rule. The only customer input is `attestation`, which may be asserted on the customer's behalf at creation to confirm the UBO details have been reviewed. The UBO `users` list and business-ownership facts (business name, country, registered address) are NOT customer inputs: `users` is fetched from the configured provider and `businessOwnership` is resolved by the service from the billing account sold-to.")
model UboInitialValue extends InitialRuleValueBase {
  kind: RuleKind.UboVerification;

  @doc("Optional. Asserted on the customer's behalf at creation to confirm the UBO details have been reviewed. Defaults to `notAttested`. When not `attested`, the downstream PayeeVerification rule fails with `NotAttested`.")
  attestation?: UboAttestation;
}

// NOTE: No `PayeeInitialValue` model exists. The payee's payout destinations are
// not seeded through `initialValues`; the payee's related parties are inferred from
// the upstream UboVerification rule. The only accepted PayeeProfile seed is the
// optional `UboVerificationInitialValue.attestation`.

// NOTE: No `BusinessVerificationInitialValue` model exists because BV-producing
// templates (`CommercialMarketplace`, `OrganizationVerification`) reject
// any `initialValues` array at PUT time with `InitialValuesNotSupportedForAssessmentType`.
// Sold-to / registration-number / tax-ids are server-populated from the billing account.
// If a future API version needs BV seed values, add the model then.

@doc("""
  Sold-to identity used for business verification (company, postal address, and
  the billing account's own contact email / phone).
  
  **Data classification — Personally Identifiable Information (PII):** carries
  customer PII (email, phone, postal address). Individual field values MUST be
  treated as PII. Served only on
  `?$expandCustomerData=true` and omitted from the default read response.
  """)
model SoldTo {
  @doc("First address line. PII — postal address.")
  @maxLength(256)
  addressLine1?: string;

  @doc("Second address line. PII — postal address.")
  @maxLength(256)
  addressLine2?: string;

  @doc("Third address line. PII — postal address.")
  @maxLength(256)
  addressLine3?: string;

  @doc("City of the address. PII — postal address.")
  @maxLength(100)
  city?: string;

  @doc("ISO 3166-1 alpha-2 country code of the sold-to address (e.g. `US`, `IE`, `GB`). Populated from the billing account.")
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  country?: string;

  @doc("Company name.")
  @maxLength(256)
  companyName?: string;

  @doc("District or sub-region. PII — postal address.")
  @maxLength(100)
  district?: string;

  @doc("Sold-to contact email address. PII — contact.")
  @maxLength(256)
  @pattern("^[^@]+@[^@]+\\.[^@]+$")
  email?: string;

  @doc("Sold-to contact phone number (free-form string; format not validated server-side). PII — contact.")
  @maxLength(50)
  phoneNumber?: string;

  @doc("Postal or ZIP code. PII — postal address.")
  @maxLength(50)
  postalCode?: string;

  @doc("State, province, or region. PII — postal address.")
  @maxLength(100)
  region?: string;

  @doc("Whether the sold-to postal address passed billing-account address validation. Server-managed.")
  isValidAddress?: boolean;

  @doc("Verification status + timestamp of the sold-to email address. Server-managed.")
  @visibility(Lifecycle.Read)
  emailVerificationDetails?: EmailVerificationDetails;
}

@doc("Email verification status and timestamp for the sold-to email address, as reported by the billing account.")
model EmailVerificationDetails {
  @doc("Verification status of the sold-to email address. Server-managed.")
  @visibility(Lifecycle.Read)
  verificationStatus?: EmailVerificationStatus;

  @doc("UTC timestamp of the most recent sold-to email verification. Server-managed.")
  @visibility(Lifecycle.Read)
  verificationDate?: utcDateTime;
}

@doc("Registration number context for business verification.")
model RegistrationNumber {
  @doc("Allowed registration-number types based on the billing-account country (e.g. `VAT`, `GST`, `EIN`).")
  @visibility(Lifecycle.Read)
  type?: string[];

  @doc("Registration number identifier (e.g. the VAT / GST / EIN identifier string).")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  id?: string;

  @doc("Whether a registration number is required for the billing account's country.")
  @visibility(Lifecycle.Read)
  required?: boolean;
}

@doc("Status of a tax id record.")
union TaxIdStatus {
  string,

  @doc("The tax id has been verified and is currently valid.")
  Valid: "valid",

  @doc("The tax id is no longer valid (e.g. expired or revoked).")
  Invalid: "invalid",

  @doc("Status could not be determined from the upstream registry.")
  Other: "other",
}

@doc("Tax id entry associated with the sold-to identity.")
model TaxId {
  @doc("Tax id identifier (e.g. the VAT / GST / EIN identifier string).")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  id?: string;

  @doc("ISO 3166-1 alpha-2 country code the tax id is registered in.")
  @visibility(Lifecycle.Read)
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  country?: string;

  @doc("Scope of the tax id (e.g. `Federal`, `State`).")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  scope?: string;

  @doc("Status of the tax id.")
  @visibility(Lifecycle.Read)
  status?: TaxIdStatus;

  @doc("Type of tax id (e.g. `VAT`, `GST`, `EIN`). Extensible — additional types may be returned as upstream registries evolve.")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  type?: string;
}

@doc("External-registry identifier (e.g. DUNS) used to disambiguate ambiguous verification matches.")
model ExternalId {
  @doc("Identifier type. Currently `DUNS` is supported.")
  @maxLength(100)
  type: string;

  @doc("Identifier value (e.g. the DUNS number string).")
  @maxLength(100)
  id: string;
}

@doc("A domain entry within an education qualification rule. `domainNames` and `tenantId` are supplied on creation; `state` and `error` are returned by the service.")
model DomainEntry {
  @doc("Domain names associated with a tenant.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  domainNames: string[];

  @doc("The Microsoft Entra tenant ID owning these domains.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tenantId: Azure.Core.uuid;

  @doc("The verification state of this domain entry. Server-managed.")
  @visibility(Lifecycle.Read)
  state?: DomainEntryState;

  @doc("Error detail when state is `failed` or `actionRequired`. Omitted otherwise. Server-managed.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@doc("""
  Legal contact of a billing account. All fields are read-only and populated
  from the billing account.
  
  **Data classification — Personally Identifiable Information (PII):** carries
  contact PII (names, email, phone). Served only on `?$expandCustomerData=true`
  and omitted from the default read response.
  """)
model LegalContact {
  @doc("Contact first name. PII — contact.")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  firstName?: string;

  @doc("Contact middle name. PII — contact.")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  middleName?: string;

  @doc("Contact last name. PII — contact.")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  lastName?: string;

  @doc("Contact email address. PII — contact.")
  @visibility(Lifecycle.Read)
  @maxLength(256)
  email?: string;

  @doc("Contact phone number (free-form string; format not validated server-side). PII — contact.")
  @visibility(Lifecycle.Read)
  @maxLength(50)
  phoneNumber?: string;

  @doc("Verification status of the legal contact's email address. Server-managed.")
  @visibility(Lifecycle.Read)
  emailVerificationStatus?: EmailVerificationStatus;
}

@doc("Verification status of a legal contact's email address. Extensible — additional states may be introduced.")
union EmailVerificationStatus {
  string,

  @doc("The email verification status is not known.")
  Unknown: "unknown",

  @doc("The email address has been verified by the user.")
  Verified: "verified",

  @doc("The email address has not been verified by the user.")
  Unverified: "unverified",
}

@doc("""
  An ultimate beneficial owner (UBO) of the billing account.
  
  **Data classification — Personally Identifiable Information (PII):** carries
  owner PII (name, email, address, nationality). Served only on
  `?$expandCustomerData=true` and omitted from the default read response.
  """)
model UboUser {
  @doc("Stable, server-assigned identifier for this beneficial owner (an opaque GUID), unique within the rule's `users` list and stable for the lifetime of the assessment. Use it to target this individual in the `startIndividualVerification` action — it disambiguates owners that share a `fullName`. Server-managed.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Postal address of the owner. PII. Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(1024)
  address?: string;

  @doc("ISO 3166-1 alpha-2 country of residence. Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  country?: string;

  @doc("Contact email address. PII. Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(256)
  email?: string;

  @doc("Full legal name. PII. Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(256)
  fullName?: string;

  @doc("ISO 3166-1 alpha-2 nationality. Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  nationality?: string;

  @doc("Percentage of ownership held by this owner (0–100). Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(100)
  percentageOfOwnership?: int32;

  @doc("Role of this owner (e.g. `BeneficialOwner`). Server-provided (retrieved from the configured provider).")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  role?: string;

  @doc("Redirect URI to the provider's experience when `state` is `actionRequired` and the owner must resolve the action externally. For UBO individuals this carries the identity-verification link generated by the `startIndividualVerification` action. Server-managed.")
  @visibility(Lifecycle.Read)
  redirectUri?: url;

  @doc("Whether an identity-verification link has been generated for this individual via the `startIndividualVerification` action. False/absent until a directive targets this individual. Server-managed.")
  @visibility(Lifecycle.Read)
  linkGenerated?: boolean;

  @doc("Whether the identity-verification link was sent to this individual via SMS (a `sendSms` directive with a phone number on the `startIndividualVerification` action). False/absent when only a link was generated. Server-managed.")
  @visibility(Lifecycle.Read)
  smsSent?: boolean;

  @doc("Verification state of this owner. Server-managed.")
  @visibility(Lifecycle.Read)
  state?: UboUserState;

  @doc("Error detail when `state` is `failed` or `actionRequired`. Omitted otherwise. Server-managed.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@doc("Verification state of a UBO user. Extensible — additional states may be introduced.")
union UboUserState {
  string,

  @doc("Verification queued or in progress.")
  Pending: "pending",

  @doc("The owner must resolve an action externally (e.g. ID verification).")
  ActionRequired: "actionRequired",

  @doc("Verification failed.")
  Failed: "failed",

  @doc("Verification succeeded.")
  Succeeded: "succeeded",
}

@doc("Business ownership context for UBO verification (business name, country, registered address). Resolved by the service from the billing account sold-to at assessment creation — not a customer input and not patchable. The configured UBO provider uses these facts to start a KYB workflow.")
model BusinessOwnership {
  @doc("Legal entity / company name resolved from the billing account sold-to (`soldTo.companyName`). Used by the configured UBO provider to start a KYB workflow.")
  @maxLength(256)
  businessName?: string;

  @doc("ISO 3166-1 alpha-2 country code resolved from the billing account sold-to (`soldTo.country`); normalized to upper case before being sent to the UBO provider to start a KYB workflow.")
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  countryCode?: string;

  @doc("Registered postal address resolved from the billing account sold-to. Used by the UBO provider for best-effort KYB matching.")
  registeredAddress?: BusinessRegisteredAddress;
}

@doc("Structured registered postal address resolved from the billing account sold-to.")
model BusinessRegisteredAddress {
  @doc("State or province resolved from the billing account sold-to (`soldTo.region`).")
  @maxLength(100)
  state?: string;

  @doc("City / locality resolved from the billing account sold-to (`soldTo.city`).")
  @maxLength(100)
  city?: string;

  @doc("Street address line resolved from the billing account sold-to (`soldTo.addressLine1`).")
  @maxLength(256)
  streetName?: string;

  @doc("Postal / ZIP code resolved from the billing account sold-to (`soldTo.postalCode`).")
  @maxLength(100)
  postalCode?: string;
}

@doc("A UBO attestation state. Extensible — additional states may be introduced.")
union UboAttestation {
  string,

  @doc("The user has not attested the UBO details.")
  NotAttested: "notAttested",

  @doc("The user has attested the UBO details.")
  Attested: "attested",

  @doc("The user has opted out of attestation.")
  OptedOut: "optedOut",
}

// -- Action response models -------------------------------------------------

@doc("A server-computed next-step action surfaced for an assessment, such as a redirect to an interactive verification experience. Read-only.")
model AssessmentAction {
  @doc("Display name of the action (for example, 'Interactive Vetting Experience').")
  name: string;

  @doc("The type of action.")
  actionType: AssessmentActionType;

  @doc("The target the action points to (for example, an external redirect URL).")
  target: url;

  @doc("Whether the action is currently enabled.")
  enabled: boolean;

  @doc("A human-readable reason describing why the action is surfaced.")
  reason?: string;
}

@doc("A directive that drives a single UBO individual (targeted by `id`) through the provider's identity-verification flow. Extensible for future flows that direct an individual to complete an action.")
model UboIndividualDirective {
  @doc("Stable identifier of the UBO to target, taken from `users[].id`. Identity verification is targeted solely by `id`.")
  id: string;

  @doc("The action to perform for this individual.")
  action: UboIndividualAction;

  @doc("Phone number in international E.164 format (e.g. `+13055551234`) the identity-verification link is sent to via SMS. Required when `action` is `sendSms`; ignored otherwise.")
  phoneNumber?: string;
}

@doc("The action to perform for a UBO individual directive.")
union UboIndividualAction {
  string,

  @doc("Generate an identity-verification link for the individual and return it on the user's `redirectUri`. No SMS is sent.")
  GenerateLink: "generateLink",

  @doc("Generate an identity-verification link for the individual and send it to the individual via SMS. Requires `phoneNumber`.")
  SendSms: "sendSms",
}

@doc("Request body for the `startIndividualVerification` action: one or more per-individual identity-verification (IDV) directives to run against a uboVerification rule.")
model StartIndividualVerificationContent {
  @doc("Per-individual identity-verification directives. Each entry targets an already-resolved UBO by its `id` (from `users[].id`) and drives that individual through the provider's identity-verification flow. At least one directive is required.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  individuals: UboIndividualDirective[];
}

@doc("Result of the `startIndividualVerification` action: the per-individual outcome of each submitted directive.")
model StartIndividualVerificationResult {
  @doc("Per-individual outcomes, one per submitted directive (correlated back by `id`).")
  @Azure.ResourceManager.identifiers(#[])
  individuals: UboIndividualVerificationOutcome[];
}

@doc("Outcome of a single UBO individual identity-verification directive.")
model UboIndividualVerificationOutcome {
  @doc("Stable identifier of the targeted UBO (echoes the request `id`).")
  id: string;

  @doc("The generated identity-verification link, when the directive produced one (`generateLink` / `sendSms`). Absent when the directive was rejected.")
  redirectUri?: url;

  @doc("Whether an identity-verification link was generated for this individual.")
  linkGenerated?: boolean;

  @doc("Whether the identity-verification link was sent to this individual via SMS.")
  smsSent?: boolean;

  @doc("The individual's resulting verification state.")
  state?: UboUserState;

  @doc("Error detail when this individual's directive was rejected (e.g. the reused session was not approved, or did not match the individual's name and country).")
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@doc("Response containing an upload SAS URI for supplemental document uploads")
model GenerateUploadTokenResponse {
  @doc("The time-bound, principal-bound SAS URI to PUT the document bytes to")
  @secret
  sasUri: string;

  @doc("The BillingTrust-assigned document id reserved for this upload. It is server-assigned (never client-supplied); the appeal action references it.")
  documentId: string;
}

@doc("A document submitted as part of an appeal — a previously-uploaded document id paired with the document type it fulfils.")
model AppealDocumentRef {
  @doc("The document id returned by `listUploadToken` for the uploaded file.")
  documentId: string;

  @doc("The document type code this upload fulfils. Must match a reviewer-requested `documentTypeCodes` entry.")
  documentTypeCode: string;

  @doc("The file type of the uploaded document (for example `pdf` or `docx`), so it can be forwarded to the verification provider with the correct extension.")
  fileType: string;

  @doc("Optional customer-supplied comment for the reviewer about this document. Forwarded to the verification provider as the evidence description.")
  comment?: string;
}

@doc("Request to appeal a rule's failed outcome by submitting a set of previously-uploaded documents.")
model AppealRequest {
  @doc("The documents to submit as the appeal — one per requested document type. Each references a `documentId` from `listUploadToken` and the `documentTypeCode` it fulfils.")
  @identifiers(#["documentId"])
  documents: AppealDocumentRef[];
}

@doc("Acknowledgement of an accepted appeal submission. The rule transitions to `underReview` asynchronously once every document scans clean and forwarding begins; poll the rule for state.")
model AppealResponse {
  @doc("The document ids accepted for this appeal.")
  acceptedDocumentIds: string[];
}

// ============================================================================
// Resource operations
// ============================================================================

@armResourceOperations(Assessment)
interface Assessments {
  get is ArmResourceRead<Assessment, Parameters = ExpandCustomerDataParameter>;

  @doc("Create or update an Assessment. Long-running operation — returns 200 (replace) or 201 (create) with the `Azure-AsyncOperation` polling header on both responses.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Assessment,
    LroHeaders = Azure.ResourceManager.ArmCombinedLroHeaders<FinalResult = Assessment> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | (ArmResourceUpdatedResponse<Assessment> &
          Azure.ResourceManager.ArmCombinedLroHeaders<FinalResult = Assessment> &
          Azure.Core.Foundations.RetryAfterHeader)
      | ArmResourceCreatedResponse<
          Assessment,
          Azure.ResourceManager.ArmCombinedLroHeaders<FinalResult = Assessment> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  @doc("Update an assessment. The only patchable property is `draft`; evaluation/provisioning state and `error` are server-owned. Synchronous PATCH — the `draft` list is replaced wholesale (send `[]` to clear). The value is stored in service state and returned on read only under `?$expandCustomerData=true`; it is omitted from the default read response.")
  update is ArmCustomPatchSync<Assessment, AssessmentUpdateProperties>;

  @doc("Delete an assessment. Long-running operation — returns 202 with a polling header, then 204 once the assessment and its rules have been removed and any rule side-effects undone. Authorized to the parent resource provider; the billing-account lifecycle also removes assessments automatically when the account is gone.")
  delete is ArmResourceDeleteWithoutOkAsync<Assessment>;

  //
  // PUT contract (idempotent re-PUT):
  //   * First PUT creates the assessment and evaluates it (async 201).
  //   * Re-PUT with an equivalent initialValues desired state is an idempotent
  //     no-op that returns the current state (200); no re-evaluation.
  //   * Re-PUT with a changed initialValues desired state WHILE evaluation is
  //     still active (any rule pending/running/awaiting an external result) is
  //     rejected with 409 Conflict.
  //   * Re-PUT with a changed initialValues desired state once every rule is
  //     terminal re-evaluates the assessment from scratch (async 200).
  // Equivalence ignores whitespace, ordering, and server-managed fields; it is
  // the customer-writable desired state (initialValues) that decides.

  list is ArmResourceListByParent<
    Assessment,
    Parameters = ExpandCustomerDataParameter
  >;

  @doc("Request a time-bound, principal-bound upload token for a supplemental / appeal document. Returns the token and a pre-assigned document id; the document's type is bound later, when it is submitted via the rule `appeal` action.")
  listUploadToken is ArmResourceActionSync<
    Assessment,
    void,
    GenerateUploadTokenResponse
  >;
}

@doc("Optional query parameter that requests customer-supplied data on an assessment or rule read.")
model ExpandCustomerDataParameter {
  @query("$expandCustomerData")
  @doc("When `true`, read responses (GET and LIST) include the customer-supplied data that is omitted from the default response — for a rule, the `businessVerification` sold-to identity and tax ids or the `eduQualification` domains; for an assessment, the `eduQualification` domain names within its `initialValues` and its `draft`. Defaults to `false`.")
  expandCustomerData?: boolean;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "By design: rule lifecycle is owned by the parent Assessment — rules are instantiated when the assessment is created and removed when it is deleted. Customers cannot independently delete rules. PUT-without-DELETE is an intentional asymmetry: PUT is the minimum required for the rule resource to be created and served; DELETE is correctly absent because rule removal happens via the parent Assessment delete cascade. Peer precedents: Microsoft.HealthModel/HealthModelVersions ('cannot be deleted individually'), Microsoft.HealthModel/Snapshots ('cannot be deleted individually'), Microsoft.Monitor/AzureMonitorWorkspace metrics container ('always present with the workspace and cannot be deleted')."
@armResourceOperations(Rule)
interface Rules {
  get is ArmResourceRead<Rule, Parameters = ExpandCustomerDataParameter>;
  list is ArmResourceListByParent<
    Rule,
    Parameters = ExpandCustomerDataParameter
  >;

  // Rules are server-instantiated when the parent assessment is created; the
  // service maintains their state and makes it available to serve customer
  // GET/LIST. The PUT operation below exists for that service-managed flow —
  // end users cannot create rules directly (see the createOrUpdate doc).
  // DELETE is intentionally absent: rule lifecycle is driven entirely from the
  // parent Assessment delete cascade (see the no-resource-delete-operation
  // suppression above). The operation is synchronous; rule evaluation itself is
  // driven by the assessment-level Create flow.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Rule names are deterministic server-instantiated names (Qualify_Edu, Verify_Business, …) per template; pattern is enforced at the model level."
  @doc("""
    Create or update a Rule. Rules are created by the service when the parent
    assessment is created; they are not directly creatable by end users. Customer
    PUT calls are rejected at runtime with `OperationNotAllowed`. Use PATCH to
    modify rule fields that the customer is authorized to change.
    """)
  createOrUpdate is ArmResourceCreateOrReplaceSync<Rule>;

  // PATCH cannot change a rule's `kind`. The patch body is discriminated
  // by `kind`; each rule kind ships its own patchable field set on a
  // derived subtype (e.g. EduQualificationRulePatchProperties
  // .supplementalDocuments). The base RulePatchProperties carries only
  // the discriminator; the runtime PATCH controller rejects a kind that
  // does not match the existing rule.
  //
  // The arm-resource-patch linter expects every patchable field on the
  // base Properties model and cannot reason about discriminated
  // subtypes. This suppression documents the deliberate design choice.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "By design: the PATCH body is discriminated by `kind`. Per-kind patchable fields live on derived subtypes (e.g. EduQualificationRulePatchProperties.supplementalDocuments) because they are semantically meaningful only for that kind; service-side PATCH enforces both kind and state. Future kinds add their own RulePatchProperties subtype."
  @doc("Update a Rule. The PATCH body is discriminated by `kind` and must match the existing rule's kind. For `eduQualification` rules, only `supplementalDocuments` is patchable, and only when `evaluationState == actionRequired`. For `businessVerification` rules, the patchable fields are `supplementalDocuments` and `externalId`, and only when `evaluationState` is `pending` or `actionRequired`. For `uboVerification` rules, the only patchable field is `attestation`, and only when `evaluationState` is `actionRequired` or `failed`; submitting a PATCH re-triggers provider evaluation of the UBO rule and resets downstream dependent rules. The UBO `users` list and `businessOwnership` are both server-provided (`users` from the configured provider, `businessOwnership` from the billing account sold-to) — neither is patchable. `payeeVerification`, `remQualification`, and `legalContactVerification` have no patchable fields today; PATCH on those kinds is rejected with 400 InvalidParameterValue. All other field/state combinations are rejected with 400 InvalidParameterValue or 409 RuleNotActionable.")
  update is ArmCustomPatchSync<Rule, RulePatchProperties>;

  @doc("Start identity verification (IDV) for one or more of a `uboVerification` rule's individuals. Each directive targets an already-resolved UBO (by its `id` from `users[].id`) and drives that individual through the provider's identity-verification flow: `generateLink` returns a link; `sendSms` also sends the link to the individual via SMS. Returns the per-individual outcome (generated link, whether an SMS was sent, and the resulting state). Valid only for `uboVerification` rules while the rule is awaiting identity verification or has failed; it does NOT re-run business verification. Rejected with 400 InvalidParameterValue (wrong kind or invalid directive) or 409 RuleNotActionable (wrong state).")
  startIndividualVerification is ArmResourceActionSync<
    Rule,
    StartIndividualVerificationContent,
    StartIndividualVerificationResult
  >;

  // NOTE: Rule deliberately does NOT support DELETE — rule lifecycle is
  // owned by the parent Assessment (instantiated on assessment Create
  // from the template; removed when the assessment is deleted).
  // Intentional deviation from the ARM convention that proxy resources
  // support DELETE.

  // NOTE: A `present` action applicable only to verifiedCredential rules
  // is deferred to a future API version — no template in scope uses
  // verifiedCredential. The action and its `PresentResponse` model will
  // be re-added when the verifiedCredential present action is implemented.

  @doc("""
    Appeal a rule's failed outcome by submitting a set of previously-uploaded
    documents (typically one per reviewer-requested document type). Accepted
    synchronously when the rule is `appealable` and the documents are valid; the
    rule then scans the documents, forwards them to the verification provider, and
    transitions to `underReview` asynchronously. Rejected when the rule is not
    `appealable` or a document type is not among `documentTypeCodes`.
    """)
  appeal is ArmResourceActionSync<Rule, AppealRequest, AppealResponse>;
}

// NOTE: Additional provider-level actions are intentionally not declared in
// this preview; they are out of current scope and will be added in a future
// API version when those features ship.
