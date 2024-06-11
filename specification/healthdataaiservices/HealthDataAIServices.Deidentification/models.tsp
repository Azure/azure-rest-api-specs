import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace HealthDataAIServices.Deidentification;

@doc("A job containing a batch of documents to deidentify.")
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
  operation: OperationType = OperationType.Surrogate;

  @doc("Data type of the input documents.")
  dataType: DocumentDataType = DocumentDataType.PlainText;

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

  @doc("Date and time when the job was created.")
  @visibility("read")
  createdAt: utcDateTime;

  @doc("Date and time when the job was started.")
  @visibility("read")
  startedAt?: utcDateTime;

  @doc("""
  Date and time when the job was completed.
  
  If the job is canceled, this is the time when the job was canceled.
  
  If the job failed, this is the time when the job failed.
  """)
  @visibility("read")
  lastUpdatedAt?: utcDateTime;

  @doc("Summary of a job. Exists only when the job is completed.")
  @visibility("read")
  summary?: JobSummary;
}

@doc("File report once job has completed.")
@resource("files")
@parentResource(DeidentificationJob)
model HealthFileDetails {
  @key
  @doc("Id of the file report.")
  @visibility("read")
  id: string;

  @doc("File Location for the input.")
  input: FileLocation;

  @doc("File Location for the output.")
  output?: FileLocation;

  @doc("Status of the file.")
  status: Azure.Core.Foundations.OperationState;

  @doc("Error when file fails.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Location of a file.")
model FileLocation {
  @doc("Absolute path to the file in storage.")
  @maxLength(1024)
  path: string;

  ...EtagProperty;
}

@doc("Summary metrics the documents pertaining to a job.")
model JobSummary {
  @doc("Number of blobs that have completed.")
  successful: int32;

  @doc("Number of blobs that have failed.")
  failed: int32;

  @doc("Number of blobs that have been canceled.")
  canceled: int32;

  @doc("Number of blobs total.")
  total: int32;

  @doc("Number of bytes processed.")
  bytesProcessed: int64;
}

@doc("List of statuses a job can have.")
@lroStatus
union JobStatus {
  // Cannot use Azure.Core.Foundations.OperationState. because it is not a union type.

  NotStarted: "NotStarted",

  Running: "Running",

  @lroSucceeded
  Succeeded: "Succeeded",

  @lroFailed
  @doc("Job has completed with at least 1 file failing.")
  PartialFailed: "PartialFailed",

  @lroFailed
  Failed: "Failed",

  @lroCanceled
  Canceled: "Canceled",

  string,
}

@doc("Storage location.")
model SourceStorageLocation {
  @doc("URL to storage location. Must be a valid Azure Storage SAS URI.")
  @secret
  location: url;

  @doc("Prefix to filter blobs by.")
  @minLength(1)
  @maxLength(1024)
  prefix: string;

  @doc("List of extensions to filter blobs by.")
  @minItems(1)
  extensions: Array<string> = ["*"];
}

@doc("Storage location.")
model TargetStorageLocation {
  @doc("URL to storage location. Must be a valid Azure Storage SAS URI.")
  @secret
  location: url;

  @doc("Prefix to filter blobs by.")
  @minLength(1)
  @maxLength(1024)
  prefix: string;
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

// Source: Text Analytics
@doc("List of supported index encodings.")
union StringIndexType {
  @doc("Iterates over graphemes as defined by the Unicode 8.0.0 standard.")
  TextElement_v8: "TextElement_v8",

  @doc("Iterates over Unicode Code Points, the default scheme for Python 3.")
  UnicodeCodePoint: "UnicodeCodePoint",

  @doc("Iterates over UTF-16 Code Units, the default scheme for JavaScript, Java, and .NET.")
  Utf16CodeUnit: "Utf16CodeUnit",

  string,
}

@doc("Request for synchronous De-Identify operation.")
model DeidentificationContent {
  @doc("Input text to deidentify.")
  @maxLength(100000) // 100KB
  inputText: string;

  @doc("Operation to perform on the input.")
  operation: OperationType = OperationType.Surrogate;

  @doc("Data type of the input.")
  dataType: DocumentDataType = DocumentDataType.PlainText;

  // This must be set as optional so it isn't included in sdk constructors.
  // SDKs then overwrite it as internal with appropriate default value for that SDK.
  @doc("Requested Encoding of the tag response indices.")
  stringIndexType?: StringIndexType;

  @maxLength(16)
  @doc("Format of the redacted output. Only valid when OperationType is Redact.")
  redactionFormat?: string;
}

@doc("Response for synchronous De-Identify operation.")
model DeidentificationResult {
  @doc("Output text after de-identifying. Not available for Tag Operation.")
  outputText?: string;

  @doc("Result of the tag operation. Only available for Tag Operation.")
  taggerResult?: PhiTaggerResult;
}

@doc("Result of the tag operation.")
model PhiTaggerResult {
  @doc("List of entities detected in the input.")
  entities: Array<PhiEntity>;

  @doc("Requested Encoding of the tag response indices.")
  stringIndexType: StringIndexType = StringIndexType.TextElement_v8;

  @doc("Path to the file in the storage container.")
  @maxLength(1024) // Max length for Blob Name
  path?: string;

  ...EtagProperty;
}

@doc("List of PHI Entities.")
union PhiCategory {
  @doc("Unknown PHI Type.")
  Unknown: "Unknown",

  @doc("Account Number.")
  Account: "Account",

  @doc("Age.")
  Age: "Age",

  @doc("Biological Identifier, such as a fingerprint or retinal scan")
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

  @doc("Id Numbers. Such as a passport number.")
  IDNum: "IDNum",

  @doc("IP Address.")
  IPAddress: "IPAddress",

  @doc("License. Such as a driver's license or medical license")
  License: "License",

  @doc("Location Other. Such as Golden Gate Park.")
  LocationOther: "LocationOther",

  @doc("Medical Record Number.")
  MedicalRecord: "MedicalRecord",

  @doc("Organization. Such as a company name")
  Organization: "Organization",

  @doc("Patient Name.")
  Patient: "Patient",

  @doc("Phone Number.")
  Phone: "Phone",

  @doc("Profession.")
  Profession: "Profession",

  @doc("Social Security Numbers in the US.")
  SocialSecurity: "SocialSecurity",

  @doc("State")
  State: "State",

  @doc("Street.")
  Street: "Street",

  @doc("Web URL.")
  Url: "Url",

  @doc("Usernames, such as a social media handle")
  Username: "Username",

  @doc("Vehicle IDs, such as license plates or VIN numbers")
  Vehicle: "Vehicle",

  @doc("Zip Code.")
  Zip: "Zip",

  string,
}

@doc("Phi Entity tag in the input.")
model PhiEntity {
  @doc("Phi Category of the entity.")
  category: PhiCategory;

  @doc("Starting index of the location from within the input text.")
  offset: int32;

  @doc("Length of the input text.")
  length: int32;

  @doc("Text of the entity.")
  text?: string;

  @doc("Confidence score of the text/type pairing.")
  confidenceScore?: float64;
}

@doc("Query parameters for listing jobs.")
model PaginationByTokenQueryParameters {
  ...MaxPageSizeQueryParameter;

  @query
  @doc("Token to continue a previous query.")
  continuationToken?: string;
}
