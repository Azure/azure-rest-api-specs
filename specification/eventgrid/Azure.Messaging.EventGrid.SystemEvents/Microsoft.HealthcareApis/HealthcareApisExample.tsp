import "./HealthcareApis.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftHealthcareApisFhirResourceCreatedExample: HealthcareFhirResourceCreatedEventData = #{
  resourceType: "Patient",
  resourceFhirAccount: "{fhir-account}.fhir.azurehealthcareapis.com",
  resourceFhirId: "e0a1f743-1a70-451f-830e-e96477163902",
  resourceVersionId: 1,
};

const MicrosoftHealthcareApisFhirResourceUpdatedExample: HealthcareFhirResourceUpdatedEventData = #{
  resourceType: "Patient",
  resourceFhirAccount: "{fhir-account}.fhir.azurehealthcareapis.com",
  resourceFhirId: "e0a1f743-1a70-451f-830e-e96477163902",
  resourceVersionId: 2,
};

const MicrosoftHealthcareApisFhirResourceDeletedExample: HealthcareFhirResourceDeletedEventData = #{
  resourceType: "Patient",
  resourceFhirAccount: "{fhir-account}.fhir.azurehealthcareapis.com",
  resourceFhirId: "e0a1f743-1a70-451f-830e-e96477163902",
  resourceVersionId: 3,
};

const MicrosoftHealthcareApisDicomImageCreatedExample: HealthcareDicomImageCreatedEventData = #{
  partitionName: "Microsoft.Default",
  imageStudyInstanceUid: "1.2.3.4.3",
  imageSeriesInstanceUid: "1.2.3.4.3.9423673",
  imageSopInstanceUid: "1.3.6.1.4.1.45096.2.296485376.2210.1633373143.864442",
  serviceHostName: "{dicom-account}.dicom.azurehealthcareapis.com",
  sequenceNumber: 1,
};

const MicrosoftHealthcareApisDicomImageDeletedExample: HealthcareDicomImageDeletedEventData = #{
  partitionName: "Microsoft.Default",
  imageStudyInstanceUid: "1.2.3.4.3",
  imageSeriesInstanceUid: "1.2.3.4.3.9423673",
  imageSopInstanceUid: "1.3.6.1.4.1.45096.2.296485376.2210.1633373143.864442",
  serviceHostName: "{dicom-account}.dicom.azurehealthcareapis.com",
  sequenceNumber: 2,
};

const MicrosoftHealthcareApisDicomImageUpdatedExample: HealthcareDicomImageUpdatedEventData = #{
  partitionName: "Microsoft.Default",
  imageStudyInstanceUid: "1.2.3.4.3",
  imageSeriesInstanceUid: "1.2.3.4.3.9423673",
  imageSopInstanceUid: "1.3.6.1.4.1.45096.2.296485376.2210.1633373143.864442",
  serviceHostName: "{dicom-account}.dicom.azurehealthcareapis.com",
  sequenceNumber: 1,
};
