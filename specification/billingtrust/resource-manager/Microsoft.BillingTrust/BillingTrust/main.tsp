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
  @doc("API Version 2026-03-17-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  `2026-03-17-preview`,
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

  @doc("Assessment succeeded but with a manual override applied by operations")
  SucceededWithOverride: "succeededWithOverride",

  @doc("Assessment failed but with a manual override applied by operations")
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

  @doc("Operations review is in progress")
  UnderReview: "underReview",

  @doc("Rule preconditions (runAfter) were not met; rule was skipped")
  Skipped: "skipped",

  @doc("Rule evaluation failed")
  Failed: "failed",

  @doc("Rule evaluation succeeded")
  Succeeded: "succeeded",

  @doc("Rule succeeded but with a manual override applied by operations")
  SucceededWithOverride: "succeededWithOverride",

  @doc("Rule failed but with a manual override applied by operations")
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
}

@doc("Assessment template name. Each template defines a fixed set of rules and their configuration. The list of templates may be extended in future API versions.")
union AssessmentType {
  string,

  @doc("Education qualification assessment. Verifies that the billing account qualifies for education programs based on customer-supplied domains.")
  Edu: "Edu",

  @doc("Business verification assessment. Verifies the billing account's business identity against the sold-to information on file.")
  BusinessVerification: "BusinessVerification",

  @doc("Payee enrollment assessment. Verifies a billing account is eligible to enroll as a payee. Rule names within this template may change between API versions — iterate `rules` via LIST rather than addressing rules by name.")
  PayeeEnrollment: "PayeeEnrollment",

  @doc("Payee profile assessment. Verifies the payee profile associated with a billing account. Rule names within this template may change between API versions — iterate `rules` via LIST rather than addressing rules by name.")
  PayeeProfile: "PayeeProfile",
}

// ============================================================================
// Assessment (Extension Resource, singleton named "default")
// ============================================================================

@doc("A billing trust assessment. An assessment runs a set of rules to evaluate trust attributes of a billing account. The assessment is a singleton per parent resource and is always named 'default'. Re-issuing PUT with the same `assessmentType` is idempotent; changing `assessmentType` after the assessment exists is not supported.")
@singleton
model Assessment is ExtensionResource<AssessmentProperties> {
  @doc("The name of the assessment. Must be 'default'.")
  @pattern("^default$")
  @key("assessmentName")
  @segment("assessments")
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

@doc("The properties of an Assessment resource")
model AssessmentProperties {
  @doc("The name of the assessment template whose rules will be evaluated (e.g. 'Edu'). Immutable after creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  assessmentType: AssessmentType;

  @doc("The aggregated evaluation state of all active rules within this assessment")
  @visibility(Lifecycle.Read)
  evaluationState?: AssessmentState;

  @doc("The next scheduled re-evaluation of this assessment. Only present when one or more rules in this assessment have a configured recurrence.")
  @visibility(Lifecycle.Read)
  nextEvaluation?: utcDateTime;

  @doc("Error information when evaluationState is failed")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "initialValues is a write-only seed parameter forwarded to per-kind rules; it is not persisted on the assessment and is intentionally not returned on Read."
  @doc("Optional initial values applied to the rules created with this assessment. Write-only — these values are routed to the per-kind rules and are not returned on read.")
  @visibility(Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  initialValues?: InitialRuleValueBase[];

  @doc("The provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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

@doc("Base properties of a Rule resource. Polymorphic by `kind` — kind-specific writable fields live on derived models.")
@discriminator("kind")
model RuleProperties {
  // Read-only contract for evaluator-owned fields (`evaluationState`, `error`):
  //   These are conceptually read-only from a customer's perspective — they
  //   are set by the BillingTrust evaluator and surfaced via the GET /LIST
  //   response. Customers cannot modify them via PUT/PATCH.
  //
  //   The RP back-PUT (issued by our worker with the BillingTrust 1P FPA
  //   identity) does carry these fields in the request body — and that is
  //   compatible with `Lifecycle.Read` on the spec, per ARM/RPaaS OAPI021
  //   (the server tolerates read-only fields in PUT bodies).
  //
  //   `kind` is the discriminator; SDK clients cannot change a rule's kind
  //   via any operation, so it's `Lifecycle.Read` only. Our back-PUT body
  //   still carries `kind` because TypeSpec's discriminator emits it
  //   regardless of mutability.
  //
  //   `provisioningState` stays `Lifecycle.Read` because RPaaS/MetaRP owns
  //   it end-to-end via operationStatus PATCH — the projector also strips
  //   it from the wire via `NullValueHandling.Ignore`.
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
  
  Sold-to fields (`soldTo`, `registrationNumber`, `taxIds`) reflect the billing
  account's information on file and cannot be supplied by end users.
  """)
model BusinessVerificationRuleProperties extends RuleProperties {
  kind: RuleKind.BusinessVerification;

  @doc("Sold-to identity used for business verification. Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  soldTo?: SoldTo;

  @doc("Registration number context (allowed types and registration id). Populated from the billing account at the time the rule is created. Server-managed.")
  @visibility(Lifecycle.Read)
  registrationNumber?: RegistrationNumber;

  @doc("Tax ids associated with the sold-to identity. Populated from the billing account at the time the rule is created. Server-managed.")
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

@doc("Patch body for updating a rule. Polymorphic by `kind` — kind-specific patchable fields live on per-kind subtypes. PATCH cannot change a rule's kind; the discriminator carries the rule's existing kind for routing only.")
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

// ============================================================================
// Review resource — DEFERRED to a future API version
// ============================================================================
//
// A tenant-level Review resource for operations follow-up is intentionally
// omitted from this preview. Tenant-level APIs require additional ARM API
// review sign-off (linter `TenantLevelAPIsNotAllowed`) and are out of scope
// for this revision. The `Review`, `ReviewProperties`, and `Reviews`
// interface — together with the appropriate `suppressions.yaml` entry and
// sign-off — will be added when the review feature is implemented.

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

// NOTE: No `BusinessVerificationInitialValue` model exists because BV-producing
// templates (`BusinessVerification`, `PayeeEnrollment`, `PayeeProfile`) reject
// any `initialValues` array at PUT time with `InitialValuesNotSupportedForAssessmentType`.
// Sold-to / registration-number / tax-ids are server-populated from BillingRP.
// If a future API version needs BV seed values, add the model then.

@doc("""
  Sold-to identity used for business verification.
  
  **Data classification — Personally Identifiable Information (PII):** This
  model carries customer/contact PII (names, email, phone, postal address).
  Producers (service code paths populating SoldTo) and consumers (anything
  emitting it to logs / telemetry) MUST treat individual field values as
  PII and avoid clear-text logging. BillingTrust's existing runtime
  discipline keeps SoldTo out of Geneva logs (see
  `Services/Rpaas/RpaasRuleProjector.cs` — raw bodies and parsed error
  messages are filtered before emission). Downstream consumers of the
  public OpenAPI surface should follow the same convention. Tracked for
  follow-up alignment with ARM ARG002 (control-plane PII guidance) — see
  PR description.
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

  @doc("Contact email address. PII — contact.")
  @maxLength(256)
  @pattern("^[^@]+@[^@]+\\.[^@]+$")
  email?: string;

  @doc("Contact first name. PII — contact.")
  @maxLength(100)
  firstName?: string;

  @doc("Contact last name. PII — contact.")
  @maxLength(100)
  lastName?: string;

  @doc("Contact middle name. PII — contact.")
  @maxLength(100)
  middleName?: string;

  @doc("Contact phone number (free-form string; format not validated server-side). PII — contact.")
  @maxLength(50)
  phoneNumber?: string;

  @doc("Postal or ZIP code. PII — postal address.")
  @maxLength(50)
  postalCode?: string;

  @doc("State, province, or region. PII — postal address.")
  @maxLength(100)
  region?: string;
}

@doc("Registration number context for business verification.")
model RegistrationNumber {
  @doc("Allowed registration-number types based on the billing-account country (e.g. `VAT`, `GST`, `EIN`).")
  type?: string[];

  @doc("Registration number value (e.g. the VAT / GST / EIN identifier string).")
  @maxLength(100)
  value?: string;

  @doc("Whether a registration number is required for the sold-to country.")
  registrationRequirement?: RegistrationRequirement;
}

@doc("Whether a registration number is required for the sold-to country. Extensible — additional states may be introduced as country-specific tax requirements evolve.")
union RegistrationRequirement {
  string,

  @doc("A registration number is required for the sold-to country.")
  Required: "required",

  @doc("A registration number is optional for the sold-to country.")
  Optional: "optional",

  @doc("A registration number is not applicable for the sold-to country.")
  NotApplicable: "notApplicable",
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
  @doc("Tax id value (e.g. the VAT / GST / EIN identifier string).")
  @maxLength(100)
  value?: string;

  @doc("ISO 3166-1 alpha-2 country code the tax id is registered in.")
  @maxLength(2)
  @pattern("^[A-Za-z]{2}$")
  country?: string;

  @doc("Scope of the tax id (e.g. `Federal`, `State`).")
  @maxLength(100)
  scope?: string;

  @doc("Status of the tax id.")
  status?: TaxIdStatus;

  @doc("Type of tax id (e.g. `VAT`, `GST`, `EIN`). Extensible — additional types may be returned as upstream registries evolve.")
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
  value: string;
}

@doc("A domain entry within an education qualification rule. `domainNames` and `tenantId` are supplied on creation; `state` and `error` are returned by the service.")
model DomainEntry {
  @doc("Domain names associated with a tenant.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  domainNames: string[];

  @doc("The Microsoft Entra tenant ID owning these domains. Defaults to the calling user's tenant when omitted.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tenantId?: Azure.Core.uuid;

  @doc("The verification state of this domain entry. Server-managed.")
  @visibility(Lifecycle.Read)
  state?: DomainEntryState;

  @doc("Error detail when state is `failed` or `actionRequired`. Omitted otherwise. Server-managed.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

// -- Action response models -------------------------------------------------

@doc("Response containing an upload token for supplemental document uploads")
model GenerateUploadTokenResponse {
  @doc("The time-bound, principal-bound upload token")
  @secret
  token: string;
}

// ============================================================================
// Resource operations
// ============================================================================

@armResourceOperations(Assessment)
interface Assessments {
  get is ArmResourceRead<Assessment>;

  @doc("Create or update an Assessment. Long-running operation — returns 200 (replace) or 201 (create) with the `Azure-AsyncOperation` polling header on both responses.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Assessment,
    LroHeaders = Azure.ResourceManager.ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | (ArmResourceUpdatedResponse<Assessment> &
          Azure.ResourceManager.ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader)
      | ArmResourceCreatedResponse<
          Assessment,
          Azure.ResourceManager.ArmCombinedLroHeaders &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  // NOTE: PATCH (`update`) intentionally NOT exposed for Assessment.
  // AssessmentProperties has zero updateable fields (assessmentType is immutable
  // Create+Read; evaluationState/error/provisioningState are read-only;
  // initialValues is create-only). Assessment is an ExtensionResource (proxy)
  // and therefore has no `tags` either. A PATCH endpoint with an empty body
  // schema is a no-op footgun for SDK consumers — drop it. Re-add when a real
  // mutable property exists.
  //
  // PUT idempotency contract: re-issuing PUT with the same assessmentType and
  // equivalent initialValues after the assessment exists is a no-op (rules
  // already exist; new identical seed is ignored). Re-issuing PUT with a
  // different assessmentType or with non-empty initialValues that would
  // re-seed existing rules is rejected by the service with 409 Conflict.

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "False positive: ArmResourceDeleteWithoutOkAsync correctly returns 202+204 for an async delete; linter mistakes it for a synchronous delete missing 200."
  @doc("Delete an assessment. Long-running operation — returns 202 + 204 + default with `Azure-AsyncOperation` (preferred) and `Location` polling headers.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Assessment,
    LroHeaders = Azure.ResourceManager.ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  list is ArmResourceListByParent<Assessment>;

  @doc("Request a time-bound, principal-bound upload token for supplemental document uploads.")
  listUploadToken is ArmResourceActionSync<
    Assessment,
    void,
    GenerateUploadTokenResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "By design: rule lifecycle is owned by the parent Assessment — rules are instantiated when the assessment is created and removed when it is deleted. Customers cannot independently delete rules. PUT-without-DELETE is an intentional asymmetry: PUT is the minimum the RPaaS tracked-resource cache needs to function; DELETE is correctly absent because rule removal does not round-trip through MetaRP. Peer precedents: Microsoft.HealthModel/HealthModelVersions ('cannot be deleted individually'), Microsoft.HealthModel/Snapshots ('cannot be deleted individually'), Microsoft.Monitor/AzureMonitorWorkspace metrics container ('always present with the workspace and cannot be deleted')."
@armResourceOperations(Rule)
interface Rules {
  get is ArmResourceRead<Rule>;
  list is ArmResourceListByParent<Rule>;

  // Design rationale: why Rules.createOrUpdate (PUT) is in the public spec
  //
  //   This PUT is required by RPaaS platform mechanics and MUST remain in
  //   the public spec. Removing it breaks the service — customer GETs on
  //   rules 404 permanently.
  //
  //   Mechanism: rules are server-instantiated during the parent assessment's
  //   ResourceCreationBegin. RPaaS's tracked-resources cache for
  //   ProxyOnly+Extension child types is populated ONLY by PUT-shaped
  //   operations going through the ARM/RPaaS swagger validator. Without a PUT
  //   declared here, our worker's back-PUT (RpaasRuleProjector.ProjectRuleAsync)
  //   fails RPaaS provider-api-validation with HTTP 412
  //   HttpResponsePayloadAPISpecValidationFailed, the cache never populates,
  //   and customer GET on /rules/{name} 404s at the ARM front door's
  //   tracked-cache short-circuit.
  //
  //   Customer protection: end-user PUT is rejected by
  //   RuleController.OnValidateCreate with the documented RPaaS soft-reject
  //   (200 OK + {status:failed, error:{Code:OperationNotAllowed}}) per the
  //   RPaaS Extension API Contract (Response Status Codes for
  //   ResourceCreationValidate). RPaaS surfaces this as 4xx to ARM; customer
  //   SDKs see a clean failure. Per the API Contracts for UserRP to
  //   communicate with MetaRP through ARM (PUT/PATCH section), UserRP
  //   extensions are not invoked when UserRP calls MetaRP with its own 1P
  //   identity, so the back-PUT bypasses OnValidateCreate.
  //
  //   Peer-RP precedent (same topology — extension singleton + proxy child,
  //   public PUT without restriction, no @disallowedEndUserOperations or
  //   @internal):
  //     - Microsoft.ScVmm: virtualMachineInstances/default/guestAgents
  //       (specification/scvmm/ScVmm.Management/GuestAgent.tsp:34)
  //     - Microsoft.ConnectedVMwarevSphere:
  //       virtualMachineInstances/default/guestAgents
  //       (specification/connectedvmware/.../connectedvmware.json ~line 3110)
  //
  //   The Internal ARM API Contracts process is not realized for
  //   RPaaS-extension RTs in practice — the cache layer reads the SAME spec
  //   registered through ProviderHub for customer reads.
  //
  // Design rationale: why DELETE is absent (PUT-without-DELETE asymmetry)
  //
  //   DELETE has no equivalent runtime requirement — rule lifecycle is driven
  //   entirely from the parent Assessment delete cascade. There is no per-rule
  //   delete that needs to round-trip through MetaRP. The
  //   no-resource-delete-operation suppression above captures this rationale.
  //   Peer precedents for PUT-without-DELETE on a parent-owned child proxy:
  //     - Microsoft.HealthModel/HealthModelVersions:
  //       "Health Model Versions cannot be deleted individually."
  //     - Microsoft.HealthModel/Snapshots:
  //       "Snapshots cannot be deleted individually."
  //     - Microsoft.Monitor/AzureMonitorWorkspace metrics container:
  //       "Metrics container is always present with the Azure Monitor
  //       Workspace and cannot be deleted."
  //
  // Sync (no LRO) because the back-PUT just refreshes the cache body;
  // the actual evaluation LRO is owned by the assessment-level Create
  // flow.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Rule names are deterministic server-instantiated names (Qualify_Edu, Verify_Business, …) per template; pattern is enforced at the model level."
  @doc("""
    Create or update a Rule. **This operation is required for RPaaS tracked-resource
    cache population and MUST remain in the public spec.** Rules are created by the
    service when the parent assessment is created; they are not directly creatable
    by end users. All customer PUT calls are rejected at runtime with
    `OperationNotAllowed` via the RPaaS ResourceCreationValidate extension.
    Use PATCH to modify rule fields that the customer is authorized to change.
    Peer RPs with the same topology (extension singleton parent + proxy child)
    declare an identical public PUT for the same RPaaS cache-population reason:
    Microsoft.ScVmm/virtualMachineInstances/guestAgents,
    Microsoft.ConnectedVMwarevSphere/virtualMachineInstances/guestAgents.
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
  @doc("Update a Rule. The PATCH body is discriminated by `kind` and must match the existing rule's kind. For `eduQualification` rules, only `supplementalDocuments` is patchable, and only when `evaluationState == actionRequired`. For `businessVerification` rules, the patchable fields are `supplementalDocuments` and `externalId`, and only when `evaluationState` is `pending` or `actionRequired`. All other field/state combinations are rejected with 400 InvalidParameterValue or 409 RuleNotActionable.")
  update is ArmCustomPatchSync<Rule, RulePatchProperties>;

  // NOTE: Rule deliberately does NOT support DELETE — rule lifecycle is
  // owned by the parent Assessment (instantiated on assessment Create
  // from the template; removed when the assessment is deleted).
  // Intentional deviation from the ARM convention that proxy resources
  // support DELETE.

  // NOTE: A `present` action applicable only to verifiedCredential rules
  // is deferred to a future API version — no template in scope uses
  // verifiedCredential. The action and its `PresentResponse` model will
  // be re-added when VerifiedCredential ships.
}

// NOTE: Reviews and provider-level actions `eventAssessment` and
// `hydrateReview` are intentionally not declared. Reviews require ARM
// API review sign-off as a tenant-level API; eventAssessment and
// hydrateReview are out of current scope and not registered in the
// ProviderHub manifest, so declaring them in TypeSpec would advertise
// endpoints the ARM front door would 404. They will be re-added (with
// manifest registrations and sign-off) when those features ship.
