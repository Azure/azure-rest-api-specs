import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace OnboardingApi;

// ---------------------------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------------------------

/**
 * The provisioning state of an onboarding resource.
 */
@lroStatus
union OnboardingProvisioningState {
  ResourceProvisioningState,

  /**
   * The request has been accepted and is queued for processing.
   */
  Accepted: "Accepted",

  /**
   * The request is being processed.
   */
  Running: "Running",

  string,
}

/**
 * The onboarding review lifecycle. Advanced by Azure Resource Graph operators, never by the
 * partner. `Rejected` and `Executed` are terminal.
 */
union ReviewStatus {
  /**
   * The record has been submitted and is awaiting operator triage.
   */
  Submitted: "Submitted",

  /**
   * An operator is actively reviewing the record.
   */
  UnderReview: "UnderReview",

  /**
   * The approved record is being rolled out.
   */
  UnderExecution: "UnderExecution",

  /**
   * The record is approved to execute.
   */
  Approved: "Approved",

  /**
   * The record was rejected. Terminal.
   */
  Rejected: "Rejected",

  /**
   * Rollout finished and the operator closed the region out. Terminal. Distinct from `Approved`,
   * which means "approved to execute" rather than "execution finished".
   */
  Executed: "Executed",

  string,
}

/**
 * Aggregate control-plane rollout state of a data onboarding, computed from its regional
 * activation children and its declared `targetRegions`. This does not indicate whether an
 * operator has completed ingestion execution.
 *
 * This lives on supply only. An ontology is a blueprint with no physical footprint, so it carries
 * no activation state: its lifecycle is fully described by `provisioningState`, `reviewStatus` and
 * `validationStatus`. A query endpoint likewise reports where it is live through its own regional
 * activation children.
 */
union ActivationStatus {
  /**
   * No regional rollout has started.
   */
  Pending: "Pending",

  /**
   * At least one target region has completed control-plane activation, but not all of them.
   */
  RollingOut: "RollingOut",

  /**
   * Every target region has completed control-plane activation. Regional execution is tracked
   * separately through `UnderExecution` and `Executed`.
   */
  Active: "Active",

  string,
}

/**
 * Preferred query backend recorded on an onboarding query endpoint. This preference does not
 * provision a query backend.
 */
union QueryEnginePreference {
  /**
   * The Galaxy query backend.
   */
  Galaxy: "Galaxy",

  /**
   * The Kusto query backend.
   */
  Kusto: "Kusto",

  /**
   * The Pacific query backend.
   */
  Pacific: "Pacific",

  /**
   * No preferred query backend.
   */
  NoPreference: "NoPreference",

  string,
}

/**
 * Identifies whether an ontology entry describes a node type or an edge (relationship) type.
 */
union OntologyEntryKind {
  /**
   * The entry describes a node type.
   */
  Node: "Node",

  /**
   * The entry describes an edge (relationship) type.
   */
  Edge: "Edge",

  string,
}

/**
 * Per node/edge type visibility.
 */
union Visibility {
  /**
   * Visible only to Microsoft-internal consumers.
   */
  InternalOnly: "InternalOnly",

  /**
   * Available in public preview.
   */
  PublicPreview: "PublicPreview",

  /**
   * Generally available.
   */
  GA: "GA",

  string,
}

/**
 * Per-type availability produced by ontology gap analysis, also used as the ontology-wide roll-up
 * in `validationStatus`. Declaration order is severity order — `Available` is best, `Unknown`
 * worst — and the roll-up is the worst value across every declared node and edge reference.
 */
union ValidationAvailability {
  /**
   * Approved supply covers the type, or the platform catalog reports it as active.
   */
  Available: "Available",

  /**
   * A data onboarding declares the type but has not been approved yet. This is the normal state
   * between a partner creating an ontology and an operator approving the resulting supply.
   */
  OnboardingInProgress: "OnboardingInProgress",

  /**
   * Nothing supplies the type and the platform knows it is not onboarded: either the catalog
   * resolved it and reported no coverage, or, for relationships, no data onboarding declares it.
   */
  NotOnboarded: "NotOnboarded",

  /**
   * The platform cannot say. No data onboarding covers the type and the catalog has no entry for
   * it at all, so reporting `NotOnboarded` would assert more than is actually known.
   */
  Unknown: "Unknown",

  string,
}

/**
 * Commercial tier of an offering.
 */
union OfferingTier {
  /**
   * The offering runs on shared Azure Resource Graph capacity.
   */
  Shared: "Shared",

  /**
   * The offering runs on capacity dedicated to the partner.
   */
  Dedicated: "Dedicated",

  string,
}

/**
 * Public lifecycle of an offering.
 */
union LifecycleState {
  /**
   * The offering is in preview.
   */
  Preview: "Preview",

  /**
   * The offering is generally available.
   */
  GA: "GA",

  /**
   * The offering is deprecated and accepts no new consumers.
   */
  Deprecated: "Deprecated",

  string,
}

// ---------------------------------------------------------------------------------------------
// Shared models
// ---------------------------------------------------------------------------------------------

/**
 * A node-type reference declared on an ontology.
 */
model NodeTypeRef {
  /**
   * The fully qualified Azure resource type, for example `microsoft.compute/virtualmachines`.
   */
  @pattern("^[A-Za-z][A-Za-z0-9.]+/[A-Za-z0-9._/-]+$")
  resourceType: string;

  /**
   * An optional partner-facing alias for the node type.
   */
  `alias`?: string;
}

/**
 * An edge-type reference declared on an ontology.
 */
model EdgeTypeRef {
  /**
   * The fully qualified relationship type that connects the source and target node types.
   * Its own provider namespace identifies the publisher.
   */
  @pattern("^[A-Za-z][A-Za-z0-9.]+/[A-Za-z0-9._/-]+$")
  relationshipType: string;

  /**
   * The source node's Azure resource type or its ontology-local alias.
   */
  sourceNodeType: string;

  /**
   * The target node's Azure resource type or its ontology-local alias.
   */
  targetNodeType: string;
}

/**
 * A point-in-time snapshot of an ontology's semantic body that a regional activation was
 * generated from. Only semantic fields are captured; read-only and cosmetic fields are excluded.
 */
model OntologySnapshot {
  /**
   * The node types declared by the ontology at snapshot time.
   */
  @identifiers(#[])
  nodeTypeRefs?: NodeTypeRef[];

  /**
   * The edge types declared by the ontology at snapshot time.
   */
  @identifiers(#[])
  edgeTypeRefs?: EdgeTypeRef[];
}

/**
 * An operator-assigned physical storage placement for one ontology node or edge. Read-only on the
 * API surface: it is set when an operator approves the parent data onboarding and is copied onto
 * each regional activation so that a regional record is self-describing.
 */
model OntologyStorageAssignment {
  /**
   * Whether this assignment covers a node type or an edge type.
   */
  kind: OntologyEntryKind;

  /**
   * The Azure resource type. Node assignments only.
   */
  resourceType?: string;

  /**
   * The relationship type. Edge assignments only.
   */
  relationshipType?: string;

  /**
   * The Azure resource type at the source of the relationship. Edge assignments only.
   */
  sourceNodeType?: string;

  /**
   * The Azure resource type at the target of the relationship. Edge assignments only.
   */
  targetNodeType?: string;

  /**
   * The scale unit the type is placed on.
   */
  scaleUnit: string;

  /**
   * The dataset the type is placed in.
   */
  dataset: string;

  /**
   * The logical table name the type is written to.
   */
  logicalTableName: string;

  /**
   * The physical table name backing the logical table.
   */
  physicalTableName: string;

  /**
   * How far back, in hours, the type's data is retained for reconciliation.
   */
  @minValue(1)
  lookbackHours: int32;
}

/**
 * Per-type gap-analysis result. Carries the resolved data onboarding reference when the type is
 * (being) onboarded, which is how a partner discovers the supply record covering a type they
 * declared.
 */
model ValidationDetail {
  /**
   * Whether this detail describes a declared node type or edge type.
   */
  kind: OntologyEntryKind;

  /**
   * The Azure resource type. Node entries only.
   */
  resourceType?: string;

  /**
   * The relationship type. Edge entries only.
   */
  relationshipType?: string;

  /**
   * The Azure resource type at the source of the relationship. Edge entries only.
   */
  sourceNodeType?: string;

  /**
   * The Azure resource type at the target of the relationship. Edge entries only.
   */
  targetNodeType?: string;

  /**
   * The availability of the type.
   */
  availability: ValidationAvailability;

  /**
   * The ARM resource identifier of the data onboarding that covers this type.
   */
  dataOnboardingRef?: armResourceIdentifier<[
    {
      type: "Microsoft.ResourceGraph/offerings/dataOnboardings";
    }
  ]>;

  /**
   * The review status of the data onboarding named by `dataOnboardingRef`. The ontology's own
   * `reviewStatus` is a roll-up of these: it reads `Approved` only when every entry does, and
   * regional activation is rejected while any entry is still `Submitted`.
   */
  reviewStatus: ReviewStatus;

  /**
   * A human-readable explanation of the availability result. Emitted only when `availability` is
   * not `Available`, that is, only when there is something to explain.
   */
  message?: string;
}

/**
 * Peak per-minute notification rates for a node or edge type.
 */
model PeakNotificationRates {
  /**
   * Peak write notifications per minute.
   */
  write: int32;

  /**
   * Peak delete notifications per minute.
   */
  delete: int32;

  /**
   * Peak snapshot notifications per minute.
   */
  snapshot: int32;

  /**
   * Peak event notifications per minute.
   */
  event: int32;
}

/**
 * The ingestion endpoint resolved from the approved storage assignments during regional
 * control-plane activation. Its presence does not indicate completed ingestion execution.
 */
model IngestionEndpoint {
  /**
   * The URI the publisher sends notifications to.
   */
  uri: url;

  /**
   * The notification payload formats the endpoint accepts.
   */
  supportedFormats: string[];
}

/**
 * One type a data onboarding supplies, either a node type or an edge (relationship) type,
 * discriminated by `kind`. Nodes and edges share a single collection because a publisher onboards
 * both through the same pipeline and they are approved, provisioned and activated together.
 */
@discriminator("kind")
model OnboardingTypeSpec {
  /**
   * Whether this entry describes a node type or an edge type.
   */
  kind: OntologyEntryKind;

  /**
   * The average notification payload size, in kilobytes.
   */
  payloadSizeKb?: float32;

  /**
   * Peak per-minute notification rates for this type.
   */
  peakNotificationRates?: PeakNotificationRates;

  /**
   * The visibility of this type to consumers.
   */
  visibility: Visibility;

  /**
   * The review lifecycle state of this type.
   */
  @visibility(Lifecycle.Read)
  status: ReviewStatus;

  /**
   * The ingestion endpoint resolved for this type during regional activation.
   */
  @visibility(Lifecycle.Read)
  ingestionEndpoint?: IngestionEndpoint;
}

/**
 * A node type a data onboarding supplies.
 */
model NodeOnboardingTypeSpec extends OnboardingTypeSpec {
  /**
   * Identifies this entry as a node type.
   */
  kind: "Node";

  /**
   * The fully qualified Azure resource type, for example `microsoft.compute/virtualmachines`.
   */
  @pattern("^[A-Za-z][A-Za-z0-9.]+/[A-Za-z0-9._/-]+$")
  resourceType: string;

  /**
   * The total number of rows the publisher expects to supply.
   */
  totalRowCount?: int64;
}

/**
 * An edge (relationship) type a data onboarding supplies.
 */
model EdgeOnboardingTypeSpec extends OnboardingTypeSpec {
  /**
   * Identifies this entry as an edge type.
   */
  kind: "Edge";

  /**
   * The relationship type that connects the source and target node types.
   */
  relationshipType: string;

  /**
   * The Azure resource type at the source of the relationship.
   */
  sourceNodeType: string;

  /**
   * The Azure resource type at the target of the relationship.
   */
  targetNodeType: string;

  /**
   * The total number of edges the publisher expects to supply.
   */
  expectedEdgeCount?: int64;
}

// ---------------------------------------------------------------------------------------------
// Resource property bags
// ---------------------------------------------------------------------------------------------

/**
 * The properties of an offering, the global product boundary that owns both the demand
 * (ontologies, query endpoints) and the supply (data onboardings).
 */
model OfferingProperties {
  /**
   * The partner-facing display name of the offering.
   */
  displayName?: string;

  /**
   * The commercial tier of the offering.
   */
  tier?: OfferingTier = OfferingTier.Shared;

  /**
   * The public lifecycle state of the offering.
   */
  lifecycleState?: LifecycleState = LifecycleState.Preview;

  /**
   * The name of the organization that owns the offering.
   */
  organizationName: string;

  /**
   * Contact email addresses for the team that owns the offering.
   */
  @minItems(1)
  contactEmails: string[];

  /**
   * A description of the scenario the offering serves.
   */
  scenarioDescription: string;

  /**
   * A link to the offering's partner-facing documentation.
   */
  documentationLink?: url;

  /**
   * The Service Tree identifier of the owning service.
   */
  serviceTreeId?: string;

  /**
   * The provisioning state of the offering.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;
}

/**
 * The properties of an ontology, the data-model blueprint that declares the node and edge types a
 * partner needs.
 */
model OntologyProperties {
  /**
   * The partner-facing display name of the ontology.
   */
  displayName?: string;

  /**
   * When `true`, creating or updating the ontology immediately materializes global data
   * onboardings for every unmet type. When `false`, gap analysis still runs and
   * `validationDetails` reports the gaps, but no new supply is created. Existing approved supply
   * can still satisfy the ontology; unmet demand keeps its derived `reviewStatus` at `Submitted`.
   */
  autoOnboard?: boolean = false;

  /**
   * The node types the ontology declares.
   */
  @identifiers(#[])
  nodeTypeRefs?: NodeTypeRef[];

  /**
   * The edge types the ontology declares.
   */
  @identifiers(#[])
  edgeTypeRefs?: EdgeTypeRef[];

  /**
   * The provisioning state of the ontology.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;

  /**
   * The review lifecycle of the ontology. It is derived from the data onboardings referenced by
   * `validationDetails` and reaches `Approved` only once every one of them is approved. Regional
   * activation is blocked until then.
   */
  @visibility(Lifecycle.Read)
  reviewStatus?: ReviewStatus;

  /**
   * The rejection reason propagated from backing supply. Rejected supply leaves the ontology's
   * derived review status at `Submitted`.
   */
  @visibility(Lifecycle.Read)
  rejectionReason?: string;

  /**
   * The reviewer who last approved the ontology.
   */
  @visibility(Lifecycle.Read)
  approvedBy?: string;

  /**
   * When the ontology was last approved.
   */
  @visibility(Lifecycle.Read)
  approvedAt?: utcDateTime;

  /**
   * The reviewer who last rejected the ontology.
   */
  @visibility(Lifecycle.Read)
  rejectedBy?: string;

  /**
   * When the ontology was last rejected.
   */
  @visibility(Lifecycle.Read)
  rejectedAt?: utcDateTime;

  /**
   * The aggregate availability of every type the ontology declares. It is the worst per-type
   * availability across `validationDetails`.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: ValidationAvailability;

  /**
   * The per-type gap-analysis results for the ontology.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationDetails?: ValidationDetail[];
}

/**
 * The properties of a data onboarding, the publisher-side supply record that covers one or more
 * node and edge types for a single provider namespace.
 */
model DataOnboardingProperties {
  /**
   * The provider namespace that owns every entry in `types`, for example `microsoft.compute`.
   * Relationships use their own relationship type's namespace, not the source node's namespace.
   */
  @pattern("^[A-Za-z][A-Za-z0-9.]+$")
  publisherNamespace: string;

  /**
   * Every node and edge type this publisher supplies.
   */
  @identifiers(#[])
  types: OnboardingTypeSpec[];

  /**
   * The regions this supply is intended to reach. This is the denominator for `activationStatus`:
   * the roll-up reports `Active` only once every declared region has a succeeded regional
   * activation. An empty list means no target set was declared, in which case `activationStatus`
   * reports `Active` as soon as any region succeeds.
   */
  targetRegions: string[];

  /**
   * The ARM resource identifier of the ontology whose declared types caused this data onboarding
   * to be created. Reusing covered types within the same offering does not overwrite this
   * provenance. Newly unmet types are grouped by publisher within each generation batch, so a
   * publisher namespace can have multiple onboarding records.
   */
  @visibility(Lifecycle.Read)
  ontologyRef?: armResourceIdentifier<[
    {
      type: "Microsoft.ResourceGraph/offerings/ontologies";
    }
  ]>;

  /**
   * The regions that have completed control-plane activation, derived from the regional
   * activation children. This is the numerator to `targetRegions`, not an execution-readiness signal.
   */
  @visibility(Lifecycle.Read)
  activatedRegions?: string[];

  /**
   * The provisioning state of the data onboarding.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;

  /**
   * The review lifecycle of the data onboarding.
   */
  @visibility(Lifecycle.Read)
  reviewStatus?: ReviewStatus;

  /**
   * The aggregate regional rollout state of the data onboarding.
   */
  @visibility(Lifecycle.Read)
  activationStatus?: ActivationStatus;

  /**
   * The reason the data onboarding was rejected.
   */
  @visibility(Lifecycle.Read)
  rejectionReason?: string;
}

/**
 * The properties of a query endpoint, a consumer activation request that references an approved
 * ontology within the same offering.
 */
model QueryEndpointProperties {
  /**
   * The partner-facing display name of the query endpoint.
   */
  @minLength(1)
  displayName: string;

  /**
   * The full Azure resource identifier of an approved ontology in the same subscription and
   * offering. The reference cannot be changed after creation. Legacy bare ontology names are
   * accepted on input and normalized; responses always contain the full resource identifier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ontologyRef: armResourceIdentifier<[
    {
      type: "Microsoft.ResourceGraph/offerings/ontologies";
    }
  ]>;

  /**
   * The preferred query backend. Omission records no preference and does not provision a backend.
   */
  enginePreference?: QueryEnginePreference;

  /**
   * The expected daily query volume, used for capacity planning.
   */
  @minValue(1)
  estimatedQueriesPerDay: int32;

  /**
   * The expected peak query rate, in queries per minute.
   */
  @minValue(1)
  peakQueriesPerMinute?: int32;

  /**
   * The provisioning state of the query endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;
}

/**
 * The properties of a location grouping. The location resource carries no partner-settable state
 * of its own; it exists so that per-region activations are addressable and routable region by
 * region.
 */
model OnboardingLocationProperties {
  /**
   * The provisioning state of the location grouping.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;
}

/**
 * The properties of a per-region activation. The same body is returned whether the activation
 * hangs off an ontology or off a data onboarding; the fields that do not apply to a given parent
 * are simply empty. `assignments` is populated only for a data-onboarding activation, and
 * `materializedDataOnboardingRefs` only for an ontology activation.
 */
model RegionalActivationProperties {
  /**
   * The snapshot of the ontology body this activation was generated from. When supplied on create
   * or update, Azure Resource Graph compares it against the currently approved global ontology and
   * rejects the activation if they differ, enforcing the one-active-rollout invariant. When
   * omitted, the drift check is skipped. It is persisted and returned on read.
   */
  ontologySnapshot?: OntologySnapshot;

  /**
   * The Azure region this activation covers. It matches the `locations` segment of the resource
   * identifier.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The provisioning state of the activation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;

  /**
   * For data-onboarding activations, `UnderExecution` until the operator closes the region out
   * as `Executed`; approval happens globally on the supply record. The shared field is unused
   * for ontology activations and is returned with its default value, `Submitted`.
   */
  @visibility(Lifecycle.Read)
  reviewStatus?: ReviewStatus;

  /**
   * The per-type gap-analysis results for this region.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationDetails?: ValidationDetail[];

  /**
   * The approved storage assignments this region has to execute, copied from the parent data
   * onboarding's approved configuration so that a regional record is self-describing. It is also
   * what a re-activation compares against to decide whether a region that already reported
   * `Executed` still is. Empty for an ontology activation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  assignments?: OntologyStorageAssignment[];

  /**
   * The ingestion endpoint resolved for this region.
   */
  @visibility(Lifecycle.Read)
  ingestionEndpoint?: IngestionEndpoint;

  /**
   * ARM resource identifiers of the data onboardings materialized for this region as a side effect
   * of the activation. Empty when nothing was materialized.
   */
  @visibility(Lifecycle.Read)
  materializedDataOnboardingRefs?: armResourceIdentifier<[
    {
      type: "Microsoft.ResourceGraph/offerings/dataOnboardings";
    }
  ]>[];
}

/**
 * The properties of a per-region query endpoint activation.
 */
model QueryEndpointActivationProperties {
  /**
   * The full Azure resource identifier of the ontology this regional endpoint serves, copied
   * from the parent query endpoint rather than supplied by the caller.
   */
  @visibility(Lifecycle.Read)
  ontologyRef?: armResourceIdentifier<[
    {
      type: "Microsoft.ResourceGraph/offerings/ontologies";
    }
  ]>;

  /**
   * The preferred query backend copied from the parent query endpoint.
   */
  @visibility(Lifecycle.Read)
  enginePreference?: QueryEnginePreference;

  /**
   * The Azure region this activation covers. It matches the `locations` segment of the resource
   * identifier.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The provisioning state of the activation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: OnboardingProvisioningState;

  /**
   * The per-type gap-analysis results for this region.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationDetails?: ValidationDetail[];
}

// ---------------------------------------------------------------------------------------------
// Resources
// ---------------------------------------------------------------------------------------------

/**
 * An offering, the global product boundary a partner onboards under. It owns the demand side
 * (ontologies and query endpoints) and the supply side (data onboardings).
 */
@subscriptionResource
model Offering is Azure.ResourceManager.ProxyResource<OfferingProperties> {
  ...ResourceNameParameter<
    Resource = Offering,
    KeyName = "offeringName",
    SegmentName = "offerings",
    NamePattern = "^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$"
  >;
}

/**
 * An ontology, the data-model blueprint that declares the node and edge types a partner's scenario
 * needs. The definition is global; its per-region rollout lives on the activation children.
 */
@parentResource(Offering)
model Ontology is Azure.ResourceManager.ProxyResource<OntologyProperties> {
  ...ResourceNameParameter<
    Resource = Ontology,
    KeyName = "ontologyName",
    SegmentName = "ontologies",
    NamePattern = "^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$"
  >;
}

/**
 * A data onboarding, the publisher-side supply record for the types an ontology demands. Partners
 * read these to discover which publisher covers a type they declared. Global ontology writes
 * generate unmet supply when `autoOnboard` is enabled; operators approve the generated records.
 * There is no public data-onboarding write operation.
 */
@parentResource(Offering)
model DataOnboarding
  is Azure.ResourceManager.ProxyResource<DataOnboardingProperties> {
  ...ResourceNameParameter<
    Resource = DataOnboarding,
    KeyName = "dataOnboardingName",
    SegmentName = "dataOnboardings",
    NamePattern = "^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$"
  >;
}

/**
 * A query endpoint, the consumer-side activation request that binds an approved ontology to a
 * queryable surface.
 */
@parentResource(Offering)
model QueryEndpoint
  is Azure.ResourceManager.ProxyResource<QueryEndpointProperties> {
  ...ResourceNameParameter<
    Resource = QueryEndpoint,
    KeyName = "queryEndpointName",
    SegmentName = "queryEndpoints",
    NamePattern = "^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?$"
  >;
}

/**
 * An Azure region an ontology can be activated in. This resource exists to make per-region
 * activations addressable and to let Azure Resource Manager route each activation to the regional
 * Azure Resource Graph stamp that owns it.
 */
@parentResource(Ontology)
model OntologyLocation
  is Azure.ResourceManager.ProxyResource<OnboardingLocationProperties> {
  ...ResourceNameParameter<
    Resource = OntologyLocation,
    KeyName = "location",
    SegmentName = "locations",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

/**
 * An Azure region a data onboarding can be activated in. This resource exists to make per-region
 * activations addressable and to let Azure Resource Manager route each activation to the regional
 * Azure Resource Graph stamp that owns it.
 */
@parentResource(DataOnboarding)
model DataOnboardingLocation
  is Azure.ResourceManager.ProxyResource<OnboardingLocationProperties> {
  ...ResourceNameParameter<
    Resource = DataOnboardingLocation,
    KeyName = "location",
    SegmentName = "locations",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

/**
 * An Azure region a query endpoint can be activated in. This resource exists to make per-region
 * activations addressable and to let Azure Resource Manager route each activation to the regional
 * Azure Resource Graph stamp that owns it.
 */
@parentResource(QueryEndpoint)
model QueryEndpointLocation
  is Azure.ResourceManager.ProxyResource<OnboardingLocationProperties> {
  ...ResourceNameParameter<
    Resource = QueryEndpointLocation,
    KeyName = "location",
    SegmentName = "locations",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

/**
 * The activation of an ontology in a single Azure region. There is exactly one activation per
 * region, so the resource is a singleton addressed by the fixed name `default`.
 */
@singleton
@parentResource(OntologyLocation)
model OntologyActivation
  is Azure.ResourceManager.ProxyResource<RegionalActivationProperties> {
  ...ResourceNameParameter<
    Resource = OntologyActivation,
    KeyName = "activationName",
    SegmentName = "activation",
    NamePattern = "^default$"
  >;
}

/**
 * The activation of a data onboarding in a single Azure region. Azure Resource Graph materializes
 * one of these when an ontology is activated in the region, and operators advance it through the
 * review workflow as the supply is rolled out. There is exactly one activation per region, so the
 * resource is a singleton addressed by the fixed name `default`.
 */
@singleton
@parentResource(DataOnboardingLocation)
model DataOnboardingActivation
  is Azure.ResourceManager.ProxyResource<RegionalActivationProperties> {
  ...ResourceNameParameter<
    Resource = DataOnboardingActivation,
    KeyName = "activationName",
    SegmentName = "activation",
    NamePattern = "^default$"
  >;
}

/**
 * The activation of a query endpoint in a single Azure region. There is exactly one activation per
 * region, so the resource is a singleton addressed by the fixed name `default`.
 */
@singleton
@parentResource(QueryEndpointLocation)
model QueryEndpointActivation
  is Azure.ResourceManager.ProxyResource<QueryEndpointActivationProperties> {
  ...ResourceNameParameter<
    Resource = QueryEndpointActivation,
    KeyName = "activationName",
    SegmentName = "activation",
    NamePattern = "^default$"
  >;
}
