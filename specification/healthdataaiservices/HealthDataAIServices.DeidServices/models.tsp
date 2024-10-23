import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
namespace HealthDataAIServices.DeidServices;

@doc("A job containing a batch of documents to de-identify.")
@resource("jobs")
model DeidentificationJob {
  @key
  @doc("The name of a job.")
  @visibility("read")
  @maxLength(36)
  @minLength(3) // Must be 3 to match regex
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
  name: string;

  @doc("Storage location to perform the operation on.")
  sourceLocation: SourceStorageLocation;

  @doc("Target location to store output of operation.")
  targetLocation: TargetStorageLocation;

  @doc("Operation to perform on the input documents.")
  operation?: OperationType = OperationType.Surrogate;

  @doc("Data type of the input documents.")
  dataType?: DocumentDataType = DocumentDataType.Plaintext;

  @maxLength(16)
  @minLength(1)
  @doc("Format of the redacted output. Only valid when Operation is Redact.")
  redactionFormat?: string;

  // Readonly Properties

  @doc("Current status of a job.")
  @visibility("read")
  @pollingOperationParameter
  status: JobStatus;

  @doc("Error when job fails in it's entirety.")
  @visibility("read")
  error?: Azure.Core.Foundations.Error;

  @doc("""
    Date and time when the job was completed.
    
    If the job is canceled, this is the time when the job was canceled.
    
    If the job failed, this is the time when the job failed.
    """)
  @visibility("read")
  lastUpdatedAt: utcDateTime;

  @doc("Date and time when the job was created.")
  @visibility("read")
  createdAt: utcDateTime;

  @doc("Date and time when the job was started.")
  @visibility("read")
  startedAt?: utcDateTime;

  @doc("Summary of a job. Exists only when the job is completed.")
  @visibility("read")
  summary?: JobSummary;
}

@doc("Summary metrics of a job.")
model JobSummary {
  @doc("Number of documents that have completed.")
  successful: int32;

  @doc("Number of documents that have failed.")
  failed: int32;

  @doc("Number of documents that have been canceled.")
  canceled: int32;

  @doc("Number of documents total.")
  total: int32;

  @doc("Number of bytes processed.")
  bytesProcessed: int64;
}

@doc("List of statuses a job can have.")
@lroStatus
union JobStatus {
  // Cannot use Azure.Core.Foundations.OperationState. because it is not a union type.
  @doc("Job has been submitted and is waiting to be processed.")
  NotStarted: "NotStarted",

  @doc("Job has been started.")
  Running: "Running",

  @lroSucceeded
  @doc("Job has completed successfully. All documents have succeeded.")
  Succeeded: "Succeeded",

  @lroFailed
  @doc("Job has completed with at least a single document failing.")
  PartialFailed: "PartialFailed",

  @lroFailed
  @doc("Job has completed with all documents failing, or a validation failure.")
  Failed: "Failed",

  @lroCanceled
  @doc("Job has been canceled after user request.")
  Canceled: "Canceled",

  string,
}

@doc("Storage location.")
model SourceStorageLocation {
  @doc("URL to storage location.")
  location: url;

  @doc("Prefix to filter path by.")
  @minLength(1)
  @maxLength(1024)
  prefix: string;

  @doc("List of extensions to filter path by.")
  @minItems(1)
  extensions?: Array<string> = #["*"];
}

@doc("Storage location.")
model TargetStorageLocation {
  @doc("URL to storage location.")
  location: url;

  @doc("Prefix to filter path by.")
  @minLength(1)
  @maxLength(1024)
  prefix: string;
}

@doc("Details of a single document in a job.")
@resource("documents")
@parentResource(DeidentificationJob)
model DocumentDetails {
  @key
  @doc("Id of the document details.")
  @visibility("read")
  id: string;

  @doc("Location for the input.")
  input: DocumentLocation;

  @doc("Location for the output.")
  output?: DocumentLocation;

  @doc("Status of the document.")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error when document fails.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Location of a document.")
model DocumentLocation {
  @doc("Path of document in storage.")
  @maxLength(1024)
  path: string;

  ...EtagProperty;
}

@doc("Enum of supported Data Types.")
union DocumentDataType {
  @doc("Plain text data type.")
  Plaintext: "Plaintext",

  string,
}

@doc("Enum of supported Operation Types.")
union OperationType {
  @doc("Redact Operation will remove all entities of PHI and replace them with a placeholder value.")
  Redact: "Redact",

  @doc("Surrogation Operation will replace all entities of PHI with a surrogate value.")
  Surrogate: "Surrogate",

  @doc("Tag Operation will detect all entities of PHI, their type, and return their locations in the document.")
  Tag: "Tag",

  string,
}

@doc("Request body for de-identification operation.")
model DeidentificationContent {
  @doc("Input text to de-identify.")
  @maxLength(100000) // 100KB
  inputText: string;

  @doc("Operation to perform on the input.")
  operation?: OperationType = OperationType.Surrogate;

  @doc("Data type of the input.")
  dataType?: DocumentDataType = DocumentDataType.Plaintext;

  @maxLength(16)
  @doc("Format of the redacted output. Only valid when OperationType is \"Redact\".")
  redactionFormat?: string;
}

@doc("Response body for de-identification operation.")
model DeidentificationResult {
  @doc("Output text after de-identification. Not available for \"Tag\" operation.")
  outputText?: string;

  @doc("Result of the \"Tag\" operation. Only available for \"Tag\" Operation.")
  taggerResult?: PhiTaggerResult;
}

@doc("Result of the \"Tag\" operation.")
model PhiTaggerResult {
  @doc("List of entities detected in the input.")
  entities: Array<PhiEntity>;

  @doc("Path to the document in storage.")
  @maxLength(1024) // Max length for path Name
  path?: string;

  // Source: ...EtagProperty;
  // Needs to be optional
  @doc("The entity tag for this resource.")
  etag?: eTag;
}

@doc("List of PHI Entities.")
union PhiCategory {
  @doc("Unknown PHI Type.")
  Unknown: "Unknown",

  @doc("Account Number.")
  Account: "Account",

  @doc("Age.")
  Age: "Age",

  @doc("Biological Identifier, such as a fingerprint or retinal scan.")
  BioID: "BioID",

  @doc("City.")
  City: "City",

  @doc("Country or Region.")
  CountryOrRegion: "CountryOrRegion",

  @doc("Date.")
  Date: "Date",

  @doc("Device ID or serial numbers.")
  Device: "Device",

  @doc("Doctor's Name.")
  Doctor: "Doctor",

  @doc("Email Addresses.")
  Email: "Email",

  @doc("Fax Number.")
  Fax: "Fax",

  @doc("Health Plan ID Numbers.")
  HealthPlan: "HealthPlan",

  @doc("Hospital Name.")
  Hospital: "Hospital",

  @doc("Id Number, eg. passport number.")
  IDNum: "IDNum",

  @doc("IP Address.")
  IPAddress: "IPAddress",

  @doc("License, eg. Driver's license or medical license.")
  License: "License",

  @doc("Location Other, eg. Golden Gate Park.")
  LocationOther: "LocationOther",

  @doc("Medical Record Number.")
  MedicalRecord: "MedicalRecord",

  @doc("Organization, eg. Microsoft.")
  Organization: "Organization",

  @doc("Patient Name.")
  Patient: "Patient",

  @doc("Phone Number.")
  Phone: "Phone",

  @doc("Profession.")
  Profession: "Profession",

  @doc("Social Security Number.")
  SocialSecurity: "SocialSecurity",

  @doc("State.")
  State: "State",

  @doc("Street.")
  Street: "Street",

  @doc("Web URL.")
  Url: "Url",

  @doc("Usernames, eg. a social media handle.")
  Username: "Username",

  @doc("Vehicle IDs, eg. license plate or VIN number.")
  Vehicle: "Vehicle",

  @doc("Zip Code.")
  Zip: "Zip",

  string,
}

@doc("PHI Entity tag in the input.")
model PhiEntity {
  @doc("PHI Category of the entity.")
  category: PhiCategory;

  @doc("Starting index of the location from within the input text.")
  offset: StringIndex;

  @doc("Length of the input text.")
  length: StringIndex;

  @doc("Text of the entity.")
  text?: string;

  @doc("Confidence score of the category match.")
  confidenceScore?: float64;
}

@doc("Query parameters for list operation.")
model PaginationByTokenQueryParameters {
  ...MaxPageSizeQueryParameter;

  @query
  @doc("Token to continue a previous query.")
  continuationToken?: string;
}

@doc("String index encoding model.")
model StringIndex {
  @doc("The offset or length of the substring in UTF-8 encoding")
  utf8: int32;

  @doc("""
    The offset or length of the substring in UTF-16 encoding.
    
    Primary encoding used by .NET, Java, and JavaScript.
    """)
  utf16: int32;

  @doc("""
    The offset or length of the substring in CodePoint encoding.
    
    Primary encoding used by Python.
    """)
  codePoint: int32;
}
