import "@typespec/versioning";
using TypeSpec.Versioning;

/** Describes the schema of the Azure HealthcareApis events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  // model HealthcareFhirResourceType is string {}
  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceCreated event. */
  model HealthcareFhirResourceCreatedEventData {
    /** Type of HL7 FHIR resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceVersionId: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceUpdated event. */
  model HealthcareFhirResourceUpdatedEventData {
    /** Type of HL7 FHIR resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceVersionId: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceDeleted event. */
  model HealthcareFhirResourceDeletedEventData {
    /** Type of HL7 FHIR resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceVersionId: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageCreated event. */
  model HealthcareDicomImageCreatedEventData {
    /** Data partition name */
    partitionName: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid: string;

    /** Domain name of the DICOM account for this image. */
    serviceHostName: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation and deletion within the service. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    sequenceNumber: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageDeleted event. */
  model HealthcareDicomImageDeletedEventData {
    /** Data partition name */
    partitionName: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid: string;

    /** Host name of the DICOM account for this image. */
    serviceHostName: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation and deletion within the service. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    sequenceNumber: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageUpdated event. */
  model HealthcareDicomImageUpdatedEventData {
    /** Data partition name */
    partitionName: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid: string;

    /** Domain name of the DICOM account for this image. */
    serviceHostName: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation, updation and deletion within the service. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    sequenceNumber: int64;
  }

  /** Schema of FHIR resource type enumeration. */
  union HealthcareFhirResourceType {
    /** The FHIR resource type defined in STU3 and R4. */
    Account: "Account",

    /** The FHIR resource type defined in STU3 and R4. */
    ActivityDefinition: "ActivityDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    AdverseEvent: "AdverseEvent",

    /** The FHIR resource type defined in STU3 and R4. */
    AllergyIntolerance: "AllergyIntolerance",

    /** The FHIR resource type defined in STU3 and R4. */
    Appointment: "Appointment",

    /** The FHIR resource type defined in STU3 and R4. */
    AppointmentResponse: "AppointmentResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    AuditEvent: "AuditEvent",

    /** The FHIR resource type defined in STU3 and R4. */
    Basic: "Basic",

    /** The FHIR resource type defined in STU3 and R4. */
    Binary: "Binary",

    /** The FHIR resource type defined in R4. */
    BiologicallyDerivedProduct: "BiologicallyDerivedProduct",

    /** The FHIR resource type defined in STU3. */
    BodySite: "BodySite",

    /** The FHIR resource type defined in R4. */
    BodyStructure: "BodyStructure",

    /** The FHIR resource type defined in STU3 and R4. */
    Bundle: "Bundle",

    /** The FHIR resource type defined in STU3 and R4. */
    CapabilityStatement: "CapabilityStatement",

    /** The FHIR resource type defined in STU3 and R4. */
    CarePlan: "CarePlan",

    /** The FHIR resource type defined in STU3 and R4. */
    CareTeam: "CareTeam",

    /** The FHIR resource type defined in R4. */
    CatalogEntry: "CatalogEntry",

    /** The FHIR resource type defined in STU3 and R4. */
    ChargeItem: "ChargeItem",

    /** The FHIR resource type defined in R4. */
    ChargeItemDefinition: "ChargeItemDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    Claim: "Claim",

    /** The FHIR resource type defined in STU3 and R4. */
    ClaimResponse: "ClaimResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    ClinicalImpression: "ClinicalImpression",

    /** The FHIR resource type defined in STU3 and R4. */
    CodeSystem: "CodeSystem",

    /** The FHIR resource type defined in STU3 and R4. */
    Communication: "Communication",

    /** The FHIR resource type defined in STU3 and R4. */
    CommunicationRequest: "CommunicationRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    CompartmentDefinition: "CompartmentDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    Composition: "Composition",

    /** The FHIR resource type defined in STU3 and R4. */
    ConceptMap: "ConceptMap",

    /** The FHIR resource type defined in STU3 and R4. */
    Condition: "Condition",

    /** The FHIR resource type defined in STU3 and R4. */
    Consent: "Consent",

    /** The FHIR resource type defined in STU3 and R4. */
    Contract: "Contract",

    /** The FHIR resource type defined in STU3 and R4. */
    Coverage: "Coverage",

    /** The FHIR resource type defined in R4. */
    CoverageEligibilityRequest: "CoverageEligibilityRequest",

    /** The FHIR resource type defined in R4. */
    CoverageEligibilityResponse: "CoverageEligibilityResponse",

    /** The FHIR resource type defined in STU3. */
    DataElement: "DataElement",

    /** The FHIR resource type defined in STU3 and R4. */
    DetectedIssue: "DetectedIssue",

    /** The FHIR resource type defined in STU3 and R4. */
    Device: "Device",

    /** The FHIR resource type defined in STU3. */
    DeviceComponent: "DeviceComponent",

    /** The FHIR resource type defined in R4. */
    DeviceDefinition: "DeviceDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    DeviceMetric: "DeviceMetric",

    /** The FHIR resource type defined in STU3 and R4. */
    DeviceRequest: "DeviceRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    DeviceUseStatement: "DeviceUseStatement",

    /** The FHIR resource type defined in STU3 and R4. */
    DiagnosticReport: "DiagnosticReport",

    /** The FHIR resource type defined in STU3 and R4. */
    DocumentManifest: "DocumentManifest",

    /** The FHIR resource type defined in STU3 and R4. */
    DocumentReference: "DocumentReference",

    /** The FHIR resource type defined in STU3 and R4. */
    DomainResource: "DomainResource",

    /** The FHIR resource type defined in R4. */
    EffectEvidenceSynthesis: "EffectEvidenceSynthesis",

    /** The FHIR resource type defined in STU3. */
    EligibilityRequest: "EligibilityRequest",

    /** The FHIR resource type defined in STU3. */
    EligibilityResponse: "EligibilityResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    Encounter: "Encounter",

    /** The FHIR resource type defined in STU3 and R4. */
    Endpoint: "Endpoint",

    /** The FHIR resource type defined in STU3 and R4. */
    EnrollmentRequest: "EnrollmentRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    EnrollmentResponse: "EnrollmentResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    EpisodeOfCare: "EpisodeOfCare",

    /** The FHIR resource type defined in R4. */
    EventDefinition: "EventDefinition",

    /** The FHIR resource type defined in R4. */
    Evidence: "Evidence",

    /** The FHIR resource type defined in R4. */
    EvidenceVariable: "EvidenceVariable",

    /** The FHIR resource type defined in R4. */
    ExampleScenario: "ExampleScenario",

    /** The FHIR resource type defined in STU3. */
    ExpansionProfile: "ExpansionProfile",

    /** The FHIR resource type defined in STU3 and R4. */
    ExplanationOfBenefit: "ExplanationOfBenefit",

    /** The FHIR resource type defined in STU3 and R4. */
    FamilyMemberHistory: "FamilyMemberHistory",

    /** The FHIR resource type defined in STU3 and R4. */
    Flag: "Flag",

    /** The FHIR resource type defined in STU3 and R4. */
    Goal: "Goal",

    /** The FHIR resource type defined in STU3 and R4. */
    GraphDefinition: "GraphDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    Group: "Group",

    /** The FHIR resource type defined in STU3 and R4. */
    GuidanceResponse: "GuidanceResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    HealthcareService: "HealthcareService",

    /** The FHIR resource type defined in STU3. */
    ImagingManifest: "ImagingManifest",

    /** The FHIR resource type defined in STU3 and R4. */
    ImagingStudy: "ImagingStudy",

    /** The FHIR resource type defined in STU3 and R4. */
    Immunization: "Immunization",

    /** The FHIR resource type defined in R4. */
    ImmunizationEvaluation: "ImmunizationEvaluation",

    /** The FHIR resource type defined in STU3 and R4. */
    ImmunizationRecommendation: "ImmunizationRecommendation",

    /** The FHIR resource type defined in STU3 and R4. */
    ImplementationGuide: "ImplementationGuide",

    /** The FHIR resource type defined in R4. */
    InsurancePlan: "InsurancePlan",

    /** The FHIR resource type defined in R4. */
    Invoice: "Invoice",

    /** The FHIR resource type defined in STU3 and R4. */
    Library: "Library",

    /** The FHIR resource type defined in STU3 and R4. */
    Linkage: "Linkage",

    /** The FHIR resource type defined in STU3 and R4. */
    List: "List",

    /** The FHIR resource type defined in STU3 and R4. */
    Location: "Location",

    /** The FHIR resource type defined in STU3 and R4. */
    Measure: "Measure",

    /** The FHIR resource type defined in STU3 and R4. */
    MeasureReport: "MeasureReport",

    /** The FHIR resource type defined in STU3 and R4. */
    Media: "Media",

    /** The FHIR resource type defined in STU3 and R4. */
    Medication: "Medication",

    /** The FHIR resource type defined in STU3 and R4. */
    MedicationAdministration: "MedicationAdministration",

    /** The FHIR resource type defined in STU3 and R4. */
    MedicationDispense: "MedicationDispense",

    /** The FHIR resource type defined in R4. */
    MedicationKnowledge: "MedicationKnowledge",

    /** The FHIR resource type defined in STU3 and R4. */
    MedicationRequest: "MedicationRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    MedicationStatement: "MedicationStatement",

    /** The FHIR resource type defined in R4. */
    MedicinalProduct: "MedicinalProduct",

    /** The FHIR resource type defined in R4. */
    MedicinalProductAuthorization: "MedicinalProductAuthorization",

    /** The FHIR resource type defined in R4. */
    MedicinalProductContraindication: "MedicinalProductContraindication",

    /** The FHIR resource type defined in R4. */
    MedicinalProductIndication: "MedicinalProductIndication",

    /** The FHIR resource type defined in R4. */
    MedicinalProductIngredient: "MedicinalProductIngredient",

    /** The FHIR resource type defined in R4. */
    MedicinalProductInteraction: "MedicinalProductInteraction",

    /** The FHIR resource type defined in R4. */
    MedicinalProductManufactured: "MedicinalProductManufactured",

    /** The FHIR resource type defined in R4. */
    MedicinalProductPackaged: "MedicinalProductPackaged",

    /** The FHIR resource type defined in R4. */
    MedicinalProductPharmaceutical: "MedicinalProductPharmaceutical",

    /** The FHIR resource type defined in R4. */
    MedicinalProductUndesirableEffect: "MedicinalProductUndesirableEffect",

    /** The FHIR resource type defined in STU3 and R4. */
    MessageDefinition: "MessageDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    MessageHeader: "MessageHeader",

    /** The FHIR resource type defined in R4. */
    MolecularSequence: "MolecularSequence",

    /** The FHIR resource type defined in STU3 and R4. */
    NamingSystem: "NamingSystem",

    /** The FHIR resource type defined in STU3 and R4. */
    NutritionOrder: "NutritionOrder",

    /** The FHIR resource type defined in STU3 and R4. */
    Observation: "Observation",

    /** The FHIR resource type defined in R4. */
    ObservationDefinition: "ObservationDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    OperationDefinition: "OperationDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    OperationOutcome: "OperationOutcome",

    /** The FHIR resource type defined in STU3 and R4. */
    Organization: "Organization",

    /** The FHIR resource type defined in R4. */
    OrganizationAffiliation: "OrganizationAffiliation",

    /** The FHIR resource type defined in STU3 and R4. */
    Parameters: "Parameters",

    /** The FHIR resource type defined in STU3 and R4. */
    Patient: "Patient",

    /** The FHIR resource type defined in STU3 and R4. */
    PaymentNotice: "PaymentNotice",

    /** The FHIR resource type defined in STU3 and R4. */
    PaymentReconciliation: "PaymentReconciliation",

    /** The FHIR resource type defined in STU3 and R4. */
    Person: "Person",

    /** The FHIR resource type defined in STU3 and R4. */
    PlanDefinition: "PlanDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    Practitioner: "Practitioner",

    /** The FHIR resource type defined in STU3 and R4. */
    PractitionerRole: "PractitionerRole",

    /** The FHIR resource type defined in STU3 and R4. */
    Procedure: "Procedure",

    /** The FHIR resource type defined in STU3. */
    ProcedureRequest: "ProcedureRequest",

    /** The FHIR resource type defined in STU3. */
    ProcessRequest: "ProcessRequest",

    /** The FHIR resource type defined in STU3. */
    ProcessResponse: "ProcessResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    Provenance: "Provenance",

    /** The FHIR resource type defined in STU3 and R4. */
    Questionnaire: "Questionnaire",

    /** The FHIR resource type defined in STU3 and R4. */
    QuestionnaireResponse: "QuestionnaireResponse",

    /** The FHIR resource type defined in STU3. */
    ReferralRequest: "ReferralRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    RelatedPerson: "RelatedPerson",

    /** The FHIR resource type defined in STU3 and R4. */
    RequestGroup: "RequestGroup",

    /** The FHIR resource type defined in R4. */
    ResearchDefinition: "ResearchDefinition",

    /** The FHIR resource type defined in R4. */
    ResearchElementDefinition: "ResearchElementDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    ResearchStudy: "ResearchStudy",

    /** The FHIR resource type defined in STU3 and R4. */
    ResearchSubject: "ResearchSubject",

    /** The FHIR resource type defined in STU3 and R4. */
    Resource: "Resource",

    /** The FHIR resource type defined in STU3 and R4. */
    RiskAssessment: "RiskAssessment",

    /** The FHIR resource type defined in R4. */
    RiskEvidenceSynthesis: "RiskEvidenceSynthesis",

    /** The FHIR resource type defined in STU3 and R4. */
    Schedule: "Schedule",

    /** The FHIR resource type defined in STU3 and R4. */
    SearchParameter: "SearchParameter",

    /** The FHIR resource type defined in STU3. */
    Sequence: "Sequence",

    /** The FHIR resource type defined in STU3. */
    ServiceDefinition: "ServiceDefinition",

    /** The FHIR resource type defined in R4. */
    ServiceRequest: "ServiceRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    Slot: "Slot",

    /** The FHIR resource type defined in STU3 and R4. */
    Specimen: "Specimen",

    /** The FHIR resource type defined in R4. */
    SpecimenDefinition: "SpecimenDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    StructureDefinition: "StructureDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    StructureMap: "StructureMap",

    /** The FHIR resource type defined in STU3 and R4. */
    Subscription: "Subscription",

    /** The FHIR resource type defined in STU3 and R4. */
    Substance: "Substance",

    /** The FHIR resource type defined in R4. */
    SubstanceNucleicAcid: "SubstanceNucleicAcid",

    /** The FHIR resource type defined in R4. */
    SubstancePolymer: "SubstancePolymer",

    /** The FHIR resource type defined in R4. */
    SubstanceProtein: "SubstanceProtein",

    /** The FHIR resource type defined in R4. */
    SubstanceReferenceInformation: "SubstanceReferenceInformation",

    /** The FHIR resource type defined in R4. */
    SubstanceSourceMaterial: "SubstanceSourceMaterial",

    /** The FHIR resource type defined in R4. */
    SubstanceSpecification: "SubstanceSpecification",

    /** The FHIR resource type defined in STU3 and R4. */
    SupplyDelivery: "SupplyDelivery",

    /** The FHIR resource type defined in STU3 and R4. */
    SupplyRequest: "SupplyRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    Task: "Task",

    /** The FHIR resource type defined in R4. */
    TerminologyCapabilities: "TerminologyCapabilities",

    /** The FHIR resource type defined in STU3 and R4. */
    TestReport: "TestReport",

    /** The FHIR resource type defined in STU3 and R4. */
    TestScript: "TestScript",

    /** The FHIR resource type defined in STU3 and R4. */
    ValueSet: "ValueSet",

    /** The FHIR resource type defined in R4. */
    VerificationResult: "VerificationResult",

    /** The FHIR resource type defined in STU3 and R4. */
    VisionPrescription: "VisionPrescription",

    string,
  }
}
