import "./model.common.fhir.elements.tsp";

using TypeSpec.Rest;

namespace Fhir.R4;

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("""
Resource is the ancestor of DomainResource from which most resources are derived. Bundle, Parameters, and Binary extend Resource directly.
Based on [FHIR Resource](https://www.hl7.org/fhir/r4/resource.html
""")
model Resource is Record<unknown> {
  @doc("The type of resource")
  resourceType: string;

  @doc("Resource Id")
  id?: string;

  @doc("Metadata about the resource")
  meta?: Meta;

  @doc("A set of rules under which this content was created")
  implicitRules?: fhirUri;

  @doc("Language of the resource content")
  language?: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "must extends Resource to be able use clientName in both Resource and DomainResource"
@doc("""
A resource with narrative, extensions, and contained resources
Based on [FHIR DomainResource](https://www.hl7.org/fhir/domainresource.html)
""")
@discriminator("resourceType")
model DomainResource extends Resource {
  @doc("Text summary of the resource, for human interpretation")
  text?: Narrative;

  @doc("Contained, inline Resources")
  contained?: Array<Resource>;

  @doc("Additional Content defined by implementations")
  extension?: Array<Extension>;

  @doc("Extensions that cannot be ignored")
  modifierExtension?: Array<Extension>;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("""
Detailed information about conditions, problems or diagnoses
Based on [FHIR Condition](https://www.hl7.org/fhir/R4/condition.html)
""")
model Condition extends DomainResource {
  @doc("resourceType")
  resourceType: "Condition";

  @doc("External Ids for this condition")
  identifier?: Array<Identifier>;

  @doc("active | recurrence | relapse | inactive | remission | resolved")
  clinicalStatus?: CodeableConcept;

  @doc("unconfirmed | provisional | differential | confirmed | refuted | entered-in-error")
  verificationStatus?: CodeableConcept;

  @doc("problem-list-item | encounter-diagnosis")
  category?: Array<CodeableConcept>;

  @doc("Subjective severity of condition")
  severity?: CodeableConcept;

  @doc("Identification of the condition, problem or diagnosis")
  code?: CodeableConcept;

  @doc("Anatomical location, if relevant")
  bodySite?: Array<CodeableConcept>;

  @doc("Encounter created as part of")
  encounter?: Reference;

  @doc("Estimated or actual date,  date-time, or age")
  onsetDateTime?: fhirDateTime;

  @doc("Estimated or actual date,  date-time, or age")
  onsetAge?: Quantity;

  @doc("Estimated or actual date,  date-time, or age")
  onsetPeriod?: Period;

  @doc("Estimated or actual date,  date-time, or age")
  onsetRange?: Range;

  @doc("Estimated or actual date,  date-time, or age")
  onsetString?: string;

  @doc("When in resolution/remission")
  abatementDateTime?: fhirDateTime;

  @doc("When in resolution/remission")
  abatementAge?: Quantity;

  @doc("When in resolution/remission")
  abatementPeriod?: Period;

  @doc("When in resolution/remission")
  abatementRange?: Range;

  @doc("When in resolution/remission")
  abatementString?: string;

  @doc("Date record was first recorded")
  recordedDate?: fhirDateTime;

  @doc("stge/grade, usually assessed formally")
  stage?: Array<ConditionStage>;

  @doc("Additional information about the Condition")
  note?: Array<Annotation>;
}

@doc("""
Stage/grade, usually assessed formally
Based on [FHIR Condition.Stage](https://www.hl7.org/fhir/R4/condition.html)
""")
model ConditionStage {
  @doc("Simple summary (disease specific)")
  summary?: CodeableConcept;

  @doc("Kind of staging")
  type?: CodeableConcept;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("""
Detailed information about observations
Based on [FHIR Observation](https://www.hl7.org/fhir/R4/observation.html)
""")
model Observation extends DomainResource {
  @doc("resourceType")
  resourceType: "Observation";

  @doc("Business Identifier for observation")
  identifier?: Array<Identifier>;

  @doc("registered | preliminary | final | amended +")
  status: ObservationStatusCodeType;

  @doc("Classification of  type of observation")
  category?: Array<CodeableConcept>;

  @doc("Type of observation (code / type)")
  code: CodeableConcept;

  @doc("Who and/or what the observation is about")
  subject?: Reference;

  @doc("Healthcare event during which this observation is made")
  encounter?: Reference;

  @doc("Clinically relevant time/time-period for observation")
  effectiveDateTime?: fhirDateTime;

  @doc("Clinically relevant time/time-period for observation")
  effectivePeriod?: Period;

  @doc("Clinically relevant time/time-period for observation")
  effectiveInstant?: fhirInstant;

  @doc("Date/Time this version was made available")
  issued?: fhirInstant;

  @doc("Actual result")
  valueQuantity?: Quantity;

  @doc("Actual result")
  valueCodeableConcept?: CodeableConcept;

  @doc("Actual result")
  valueString?: string;

  @doc("Actual result")
  valueBoolean?: boolean;

  @doc("Actual result")
  valueInteger?: int32;

  @doc("Actual result")
  valueRange?: Range;

  @doc("Actual result")
  valueRatio?: Ratio;

  @doc("Actual result")
  valueSampledData?: SampledData;

  @doc("Actual result")
  valueTime?: plainTime;

  @doc("Actual result")
  valueDateTime?: fhirDateTime;

  @doc("Actual result")
  valuePeriod?: Period;

  @doc("Why the result is missing")
  dataAbsentReason?: CodeableConcept;

  @doc("High, low, normal, etc.")
  interpretation?: Array<CodeableConcept>;

  @doc("Comments about the observation")
  note?: Array<Annotation>;

  @doc("Observed body part")
  bodySite?: CodeableConcept;

  @doc("How it was done")
  method?: CodeableConcept;

  @doc("Provides guide for interpretation")
  referenceRange?: Array<ObservationReferenceRange>;

  @doc("Related resource that belongs to the Observation group")
  hasMember?: Array<Reference>;

  @doc("Related measurements the observation is made from")
  derivedFrom?: Array<Reference>;

  @doc("Component results")
  component?: Array<ObservationComponent>;
}

@doc("""
Provides guide for interpretation of component result
Based on [FHIR Observation.referenceRange](https://www.hl7.org/fhir/R4/observation.html)
""")
model ObservationReferenceRange {
  @doc("Low Range, if relevant")
  low?: Quantity;

  @doc("High Range, if relevant")
  high?: Quantity;

  @doc("Reference range qualifier")
  type?: CodeableConcept;

  @doc("Reference range population")
  appliesTo?: Array<CodeableConcept>;

  @doc("Applicable age range, if relevant")
  age?: Range;

  @doc("Text based reference range in an observation")
  text?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Keep is much as close to FHIR Spec"
@doc("""
Component results
Based on [FHIR Observation.component](https://www.hl7.org/fhir/R4/observation.html)
""")
model ObservationComponent extends Element {
  @doc("Type of component observation (code / type)")
  code: CodeableConcept;

  ...value_x;

  @doc("Why the component result is missing")
  dataAbsentReason?: CodeableConcept;

  @doc("High, low, normal, etc.")
  interpretation?: Array<CodeableConcept>;

  @doc("Provides guide for interpretation of component result")
  referenceRange?: Array<ObservationReferenceRange>;
}

@doc("""
Observation Status
Based on [FHIR ObservationStatus](https://www.hl7.org/fhir/R4/valueset-observation-status.html)
""")
union ObservationStatusCodeType {
  string,

  @doc("The existence of the observation is registered, but there is no result yet available.")
  Registered: "registered",

  @doc("This is an initial or interim observation: data may be incomplete or unverified.")
  Preliminary: "preliminary",

  @doc("The observation is complete and verified by an authorized person.")
  Final: "final",

  @doc("Subsequent to being Final, the observation has been modified subsequent.  This includes updates/new information and corrections.")
  Amended: "amended",

  @doc("Subsequent to being Final, the observation has been modified to correct an error in the test result.")
  Corrected: "corrected",

  @doc("The observation is unavailable because the measurement was not started or not completed (also sometimes called \"aborted\").")
  Cancelled: "cancelled",

  @doc("The observation has been withdrawn following previous final release.")
  EnteredInError: "entered-in-error",

  @doc("The observation status is unknown.  Note that \"unknown\" is a value of last resort and every attempt should be made to provide a meaningful value other than \"unknown\".")
  Unknown: "unknown",
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
@doc("""
Detailed information about Research Study
Based on [FHIR ResearchStudy](https://www.hl7.org/fhir/R4/researchstudy.html)
""")
model ResearchStudy extends DomainResource {
  @doc("resourceType")
  resourceType: "ResearchStudy";

  @doc("Business Identifier for study")
  identifier?: Array<Identifier>;

  @doc("Name for this study")
  title?: string;

  @doc("Steps followed in executing study")
  protocol?: Array<Reference>;

  @doc("Part of larger study")
  partOf?: Array<Reference>;

  @doc("active | administratively-completed | approved | closed-to-accrual | closed-to-accrual-and-intervention | completed | disapproved | in-review | temporarily-closed-to-accrual | temporarily-closed-to-accrual-and-intervention | withdrawn")
  status: ResearchStudyStatusCodeType;

  @doc("treatment | prevention | diagnostic | supportive-care | screening | health-services-research | basic-science | device-feasibility")
  primaryPurposeType?: CodeableConcept;

  @doc("n-a | early-phase-1 | phase-1 | phase-1-phase-2 | phase-2 | phase-2-phase-3 | phase-3 | phase-4")
  phase?: CodeableConcept;

  @doc("Classifications for the study")
  category?: Array<CodeableConcept>;

  @doc("Drugs, devices, etc. under study")
  focus?: Array<CodeableConcept>;

  @doc("Condition being studied")
  condition?: Array<CodeableConcept>;

  @doc("Contact details for the study")
  contact?: Array<ContactDetail>;

  @doc("Used to search for the study")
  keyword?: Array<CodeableConcept>;

  @doc("Geographic region(s) for study")
  location?: Array<CodeableConcept>;

  @doc("What this is study doing")
  description?: markdown;

  @doc("Inclusion & exclusion criteria")
  enrollment?: Array<Reference>;

  @doc("When the study began and ended")
  period?: Period;

  @doc("Organization that initiates and is legally responsible for the study")
  sponsor?: Reference;

  @doc("Researcher who oversees multiple aspects of the study")
  principalInvestigator?: Reference;

  @doc("Facility where study activities are conducted")
  site?: Array<Reference>;

  @doc("accrual-goal-met | closed-due-to-toxicity | closed-due-to-lack-of-study-progress | temporarily-closed-per-study-design")
  reasonStopped?: CodeableConcept;

  @doc("Comments made about the study")
  note?: Array<Annotation>;

  @doc("Defined path through the study for a subject")
  arm?: Array<ResearchStudyArm>;

  @doc("A goal for the study")
  objective?: Array<ResearchStudyObjective>;
}

alias ResearchStudyArm = {
  @doc("Label for study arm")
  name: string;

  @doc("Categorization of study arm")
  type?: CodeableConcept;

  @doc("Short explanation of study path")
  description?: string;
};

alias ResearchStudyObjective = {
  @doc("Label for the objective")
  name: string;

  @doc("primary | secondary | exploratory")
  type?: CodeableConcept;
};

@doc("""
https://www.hl7.org/fhir/R4/codesystem-research-study-status.html
""")
union ResearchStudyStatusCodeType {
  string,

  @doc("The study is open for accrual.")
  Active: "active",

  @doc("Study is completed prematurely and will not resume; patients are no longer examined nor treated.")
  AdministrativelyCompleted: "administratively-completed",

  @doc("Protocol is approved by the review board.")
  Approved: "approved",

  @doc("Study is closed for accrual; patients can be examined and treated.")
  ClosedToAccrual: "closed-to-accrual",

  @doc("The study is closed to accrual and intervention, i.e. the study is closed to enrollment, all study subjects have completed treatment or intervention but are still being followed according to the primary objective of the study.")
  ClosedToAccrualAndIntervention: "closed-to-accrual-and-intervention",

  @doc("Study is closed to accrual and intervention, i.e. the study is closed to enrollment, all study subjects have completed treatment or intervention but are still being followed according to the primary objective of the study.")
  Completed: "completed",

  @doc("Protocol was disapproved by the review board.")
  Disapproved: "disapproved",

  @doc("Protocol is submitted to the review board for approval.")
  InReview: "in-review",

  @doc("The study is temporarily closed to accrual; a pause in accrual while study is reviewed, but is expected to resume.")
  TemporarilyClosedToAccrual: "temporarily-closed-to-accrual",

  @doc("Study is temporarily closed for accrual; can be potentially resumed in the future")
  TemporarilyClosedToAccrualAndIntervention: "temporarily-closed-to-accrual-and-intervention",

  @doc("Protocol was withdrawn by the lead organization.")
  Withdrawn: "withdrawn",
}
