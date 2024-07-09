/** Describes the schema of the Azure HealthcareApis events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  // model HealthcareFhirResourceType is string {}
  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceCreated event. */
  model HealthcareFhirResourceCreatedEventData {
    /** Type of HL7 FHIR resource. */
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount?: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId?: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    resourceVersionId?: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceUpdated event. */
  model HealthcareFhirResourceUpdatedEventData {
    /** Type of HL7 FHIR resource. */
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount?: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId?: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    resourceVersionId?: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.FhirResourceDeleted event. */
  model HealthcareFhirResourceDeletedEventData {
    /** Type of HL7 FHIR resource. */
    resourceType: HealthcareFhirResourceType;

    /** Domain name of FHIR account for this resource. */
    resourceFhirAccount?: string;

    /** Id of HL7 FHIR resource. */
    resourceFhirId?: string;

    /** VersionId of HL7 FHIR resource. It changes when the resource is created, updated, or deleted(soft-deletion). */
    resourceVersionId?: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageCreated event. */
  model HealthcareDicomImageCreatedEventData {
    /** Data partition name */
    partitionName?: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid?: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid?: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid?: string;

    /** Domain name of the DICOM account for this image. */
    serviceHostName?: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation and deletion within the service. */
    sequenceNumber?: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageDeleted event. */
  model HealthcareDicomImageDeletedEventData {
    /** Data partition name */
    partitionName?: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid?: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid?: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid?: string;

    /** Host name of the DICOM account for this image. */
    serviceHostName?: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation and deletion within the service. */
    sequenceNumber?: int64;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.HealthcareApis.DicomImageUpdated event. */
  model HealthcareDicomImageUpdatedEventData {
    /** Data partition name */
    partitionName?: string;

    /** Unique identifier for the Study */
    imageStudyInstanceUid?: string;

    /** Unique identifier for the Series */
    imageSeriesInstanceUid?: string;

    /** Unique identifier for the DICOM Image */
    imageSopInstanceUid?: string;

    /** Domain name of the DICOM account for this image. */
    serviceHostName?: string;

    /** Sequence number of the DICOM Service within Azure Health Data Services. It is unique for every image creation, updation and deletion within the service. */
    sequenceNumber?: int64;
  }

  /** Schema of FHIR resource type enumeration. */
  union HealthcareFhirResourceType {
    /** The FHIR resource type defined in STU3 and R4. */
    "Account",

    /** The FHIR resource type defined in STU3 and R4. */
    "ActivityDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "AdverseEvent",

    /** The FHIR resource type defined in STU3 and R4. */
    "AllergyIntolerance",

    /** The FHIR resource type defined in STU3 and R4. */
    "Appointment",

    /** The FHIR resource type defined in STU3 and R4. */
    "AppointmentResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "AuditEvent",

    /** The FHIR resource type defined in STU3 and R4. */
    "Basic",

    /** The FHIR resource type defined in STU3 and R4. */
    "Binary",

    /** The FHIR resource type defined in R4. */
    "BiologicallyDerivedProduct",

    /** The FHIR resource type defined in STU3. */
    "BodySite",

    /** The FHIR resource type defined in R4. */
    "BodyStructure",

    /** The FHIR resource type defined in STU3 and R4. */
    "Bundle",

    /** The FHIR resource type defined in STU3 and R4. */
    "CapabilityStatement",

    /** The FHIR resource type defined in STU3 and R4. */
    "CarePlan",

    /** The FHIR resource type defined in STU3 and R4. */
    "CareTeam",

    /** The FHIR resource type defined in R4. */
    "CatalogEntry",

    /** The FHIR resource type defined in STU3 and R4. */
    "ChargeItem",

    /** The FHIR resource type defined in R4. */
    "ChargeItemDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "Claim",

    /** The FHIR resource type defined in STU3 and R4. */
    "ClaimResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "ClinicalImpression",

    /** The FHIR resource type defined in STU3 and R4. */
    "CodeSystem",

    /** The FHIR resource type defined in STU3 and R4. */
    "Communication",

    /** The FHIR resource type defined in STU3 and R4. */
    "CommunicationRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "CompartmentDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "Composition",

    /** The FHIR resource type defined in STU3 and R4. */
    "ConceptMap",

    /** The FHIR resource type defined in STU3 and R4. */
    "Condition",

    /** The FHIR resource type defined in STU3 and R4. */
    "Consent",

    /** The FHIR resource type defined in STU3 and R4. */
    "Contract",

    /** The FHIR resource type defined in STU3 and R4. */
    "Coverage",

    /** The FHIR resource type defined in R4. */
    "CoverageEligibilityRequest",

    /** The FHIR resource type defined in R4. */
    "CoverageEligibilityResponse",

    /** The FHIR resource type defined in STU3. */
    "DataElement",

    /** The FHIR resource type defined in STU3 and R4. */
    "DetectedIssue",

    /** The FHIR resource type defined in STU3 and R4. */
    "Device",

    /** The FHIR resource type defined in STU3. */
    "DeviceComponent",

    /** The FHIR resource type defined in R4. */
    "DeviceDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "DeviceMetric",

    /** The FHIR resource type defined in STU3 and R4. */
    "DeviceRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "DeviceUseStatement",

    /** The FHIR resource type defined in STU3 and R4. */
    "DiagnosticReport",

    /** The FHIR resource type defined in STU3 and R4. */
    "DocumentManifest",

    /** The FHIR resource type defined in STU3 and R4. */
    "DocumentReference",

    /** The FHIR resource type defined in STU3 and R4. */
    "DomainResource",

    /** The FHIR resource type defined in R4. */
    "EffectEvidenceSynthesis",

    /** The FHIR resource type defined in STU3. */
    "EligibilityRequest",

    /** The FHIR resource type defined in STU3. */
    "EligibilityResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "Encounter",

    /** The FHIR resource type defined in STU3 and R4. */
    "Endpoint",

    /** The FHIR resource type defined in STU3 and R4. */
    "EnrollmentRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "EnrollmentResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "EpisodeOfCare",

    /** The FHIR resource type defined in R4. */
    "EventDefinition",

    /** The FHIR resource type defined in R4. */
    "Evidence",

    /** The FHIR resource type defined in R4. */
    "EvidenceVariable",

    /** The FHIR resource type defined in R4. */
    "ExampleScenario",

    /** The FHIR resource type defined in STU3. */
    "ExpansionProfile",

    /** The FHIR resource type defined in STU3 and R4. */
    "ExplanationOfBenefit",

    /** The FHIR resource type defined in STU3 and R4. */
    "FamilyMemberHistory",

    /** The FHIR resource type defined in STU3 and R4. */
    "Flag",

    /** The FHIR resource type defined in STU3 and R4. */
    "Goal",

    /** The FHIR resource type defined in STU3 and R4. */
    "GraphDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "Group",

    /** The FHIR resource type defined in STU3 and R4. */
    "GuidanceResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "HealthcareService",

    /** The FHIR resource type defined in STU3. */
    "ImagingManifest",

    /** The FHIR resource type defined in STU3 and R4. */
    "ImagingStudy",

    /** The FHIR resource type defined in STU3 and R4. */
    "Immunization",

    /** The FHIR resource type defined in R4. */
    "ImmunizationEvaluation",

    /** The FHIR resource type defined in STU3 and R4. */
    "ImmunizationRecommendation",

    /** The FHIR resource type defined in STU3 and R4. */
    "ImplementationGuide",

    /** The FHIR resource type defined in R4. */
    "InsurancePlan",

    /** The FHIR resource type defined in R4. */
    "Invoice",

    /** The FHIR resource type defined in STU3 and R4. */
    "Library",

    /** The FHIR resource type defined in STU3 and R4. */
    "Linkage",

    /** The FHIR resource type defined in STU3 and R4. */
    "List",

    /** The FHIR resource type defined in STU3 and R4. */
    "Location",

    /** The FHIR resource type defined in STU3 and R4. */
    "Measure",

    /** The FHIR resource type defined in STU3 and R4. */
    "MeasureReport",

    /** The FHIR resource type defined in STU3 and R4. */
    "Media",

    /** The FHIR resource type defined in STU3 and R4. */
    "Medication",

    /** The FHIR resource type defined in STU3 and R4. */
    "MedicationAdministration",

    /** The FHIR resource type defined in STU3 and R4. */
    "MedicationDispense",

    /** The FHIR resource type defined in R4. */
    "MedicationKnowledge",

    /** The FHIR resource type defined in STU3 and R4. */
    "MedicationRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "MedicationStatement",

    /** The FHIR resource type defined in R4. */
    "MedicinalProduct",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductAuthorization",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductContraindication",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductIndication",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductIngredient",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductInteraction",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductManufactured",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductPackaged",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductPharmaceutical",

    /** The FHIR resource type defined in R4. */
    "MedicinalProductUndesirableEffect",

    /** The FHIR resource type defined in STU3 and R4. */
    "MessageDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "MessageHeader",

    /** The FHIR resource type defined in R4. */
    "MolecularSequence",

    /** The FHIR resource type defined in STU3 and R4. */
    "NamingSystem",

    /** The FHIR resource type defined in STU3 and R4. */
    "NutritionOrder",

    /** The FHIR resource type defined in STU3 and R4. */
    "Observation",

    /** The FHIR resource type defined in R4. */
    "ObservationDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "OperationDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "OperationOutcome",

    /** The FHIR resource type defined in STU3 and R4. */
    "Organization",

    /** The FHIR resource type defined in R4. */
    "OrganizationAffiliation",

    /** The FHIR resource type defined in STU3 and R4. */
    "Parameters",

    /** The FHIR resource type defined in STU3 and R4. */
    "Patient",

    /** The FHIR resource type defined in STU3 and R4. */
    "PaymentNotice",

    /** The FHIR resource type defined in STU3 and R4. */
    "PaymentReconciliation",

    /** The FHIR resource type defined in STU3 and R4. */
    "Person",

    /** The FHIR resource type defined in STU3 and R4. */
    "PlanDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "Practitioner",

    /** The FHIR resource type defined in STU3 and R4. */
    "PractitionerRole",

    /** The FHIR resource type defined in STU3 and R4. */
    "Procedure",

    /** The FHIR resource type defined in STU3. */
    "ProcedureRequest",

    /** The FHIR resource type defined in STU3. */
    "ProcessRequest",

    /** The FHIR resource type defined in STU3. */
    "ProcessResponse",

    /** The FHIR resource type defined in STU3 and R4. */
    "Provenance",

    /** The FHIR resource type defined in STU3 and R4. */
    "Questionnaire",

    /** The FHIR resource type defined in STU3 and R4. */
    "QuestionnaireResponse",

    /** The FHIR resource type defined in STU3. */
    "ReferralRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "RelatedPerson",

    /** The FHIR resource type defined in STU3 and R4. */
    "RequestGroup",

    /** The FHIR resource type defined in R4. */
    "ResearchDefinition",

    /** The FHIR resource type defined in R4. */
    "ResearchElementDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "ResearchStudy",

    /** The FHIR resource type defined in STU3 and R4. */
    "ResearchSubject",

    /** The FHIR resource type defined in STU3 and R4. */
    "Resource",

    /** The FHIR resource type defined in STU3 and R4. */
    "RiskAssessment",

    /** The FHIR resource type defined in R4. */
    "RiskEvidenceSynthesis",

    /** The FHIR resource type defined in STU3 and R4. */
    "Schedule",

    /** The FHIR resource type defined in STU3 and R4. */
    "SearchParameter",

    /** The FHIR resource type defined in STU3. */
    "Sequence",

    /** The FHIR resource type defined in STU3. */
    "ServiceDefinition",

    /** The FHIR resource type defined in R4. */
    "ServiceRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "Slot",

    /** The FHIR resource type defined in STU3 and R4. */
    "Specimen",

    /** The FHIR resource type defined in R4. */
    "SpecimenDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "StructureDefinition",

    /** The FHIR resource type defined in STU3 and R4. */
    "StructureMap",

    /** The FHIR resource type defined in STU3 and R4. */
    "Subscription",

    /** The FHIR resource type defined in STU3 and R4. */
    "Substance",

    /** The FHIR resource type defined in R4. */
    "SubstanceNucleicAcid",

    /** The FHIR resource type defined in R4. */
    "SubstancePolymer",

    /** The FHIR resource type defined in R4. */
    "SubstanceProtein",

    /** The FHIR resource type defined in R4. */
    "SubstanceReferenceInformation",

    /** The FHIR resource type defined in R4. */
    "SubstanceSourceMaterial",

    /** The FHIR resource type defined in R4. */
    "SubstanceSpecification",

    /** The FHIR resource type defined in STU3 and R4. */
    "SupplyDelivery",

    /** The FHIR resource type defined in STU3 and R4. */
    "SupplyRequest",

    /** The FHIR resource type defined in STU3 and R4. */
    "Task",

    /** The FHIR resource type defined in R4. */
    "TerminologyCapabilities",

    /** The FHIR resource type defined in STU3 and R4. */
    "TestReport",

    /** The FHIR resource type defined in STU3 and R4. */
    "TestScript",

    /** The FHIR resource type defined in STU3 and R4. */
    "ValueSet",

    /** The FHIR resource type defined in R4. */
    "VerificationResult",

    /** The FHIR resource type defined in STU3 and R4. */
    "VisionPrescription",

    string,
  }
}
