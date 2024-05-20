import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace HealthDataAIServices.Deidentification;

@doc("A job containing a batch of documents to deidentify.")
@resource("jobs")
model DeidentifyJob {
  @key("jobName")
  @doc("The name of a job.")
  @visibility("read")
  @maxLength(36)
  @minLength(3) // Must be 3 to match regex
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]+[a-zA-Z0-9]$")
  @path
  name: string;

  @doc("Storage location to perform the operation on.")
  sourceLocation: SourceStorageLocation;

  @doc("Target location to store output of operation.")
  targetLocation: TargetStorageLocation;

  @doc("Data type of the input documents.")
  dataType: DocumentDataType = DocumentDataType.PlainText;

  @doc("Operation to perform on the input documents.")
  operation: OperationType = OperationType.Surrogate;

  @maxLength(16)
  @minLength(1)
  @doc("Format of the redacted output. Only valid when Operation is Redact.")
  redactionFormat?: string;

  // Readonly Properties

  @doc("Current status of a job.")
  @visibility("read")
  @lroResult
  @pollingOperationParameter
  status: JobStatus;

  @doc("Error when job fails in it's entirety.")
  @visibility("read")
  @lroErrorResult
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
@parentResource(DeidentifyJob)
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
enum JobStatus {
  ...Azure.Core.Foundations.OperationState,

  // NotStarted
  // Running
  // Succeeded
  @lroFailed
  @doc("Job has completed with at least 1 file failing.")
  PartialFailed,
  // Failed
  // Canceled
}

@doc("Storage location.")
model SourceStorageLocation {
  @doc("URL to storage location. Must be a valid Azure Storage SAS URI.")
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
  location: url;

  @doc("Prefix to filter blobs by.")
  @minLength(1)
  @maxLength(1024)
  prefix: string;
}

@doc("Enum of supported Data Types.")
enum DocumentDataType {
  @doc("Plain text data type.")
  PlainText,
}

@doc("Enum of supported Operation Types.")
enum OperationType {
  @doc("Redact Operation will remove all entities of PHI and replace them with a placeholder value.")
  Redact,

  @doc("Surrogation Operation will replace all entities of PHI with a surrogate value.")
  Surrogate,

  @doc("Tag Operation will detect all entities of PHI, their type, and return their locations in the document.")
  Tag,
}

// Source: Text Analytics
@doc("List of supported index encodings.")
enum StringIndexType {
  @doc("Iterates over graphemes as defined by the Unicode 8.0.0 standard.")
  TextElement_v8,

  @doc("Iterates over Unicode Code Points, the default scheme for Python 3.")
  UnicodeCodePoint,

  @doc("Iterates over UTF-16 Code Units, the default scheme for JavaScript, Java, and .NET.")
  Utf16CodeUnit,
}

@doc("Request for synchronous De-Identify operation.")
@projectedName("csharp", "DeidentifyConfig")
model DeidentifyOptions {
  @doc("Input text to deidentify.")
  @maxLength(100000) // 100KB
  inputText: string;

  @doc("Data type of the input.")
  dataType: DocumentDataType = DocumentDataType.PlainText;

  @doc("Operation to perform on the input.")
  operation: OperationType = OperationType.Surrogate;

  @doc("Requested Encoding of the tag response indices.")
  stringIndexType: StringIndexType = StringIndexType.TextElement_v8;

  @maxLength(16)
  @doc("Format of the redacted output. Only valid when OperationType is Redact.")
  redactionFormat?: string;
}

@doc("Response for synchronous De-Identify operation.")
model DeidentifyResult {
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
enum PhiCategory {
  @doc("Unknown PHI Type.")
  Unknown,

  @doc("Account Number.")
  Account,

  @doc("Age.")
  Age,

  @doc("Biological Identifier, such as a fingerprint or retinal scan")
  @projectedName("python", "BIO_ID")
  BioID,

  @doc("City.")
  City,

  @doc("Country or Region.")
  CountryOrRegion,

  @doc("Date.")
  Date,

  @doc("Device ID or serial numbers.")
  Device,

  @doc("Doctor's Name.")
  Doctor,

  @doc("Email Addresses.")
  Email,

  @doc("Fax Number.")
  Fax,

  @doc("Health Plan ID Numbers.")
  HealthPlan,

  @doc("Hospital Name.")
  Hospital,

  @doc("Id Numbers. Such as a passport number.")
  @projectedName("python", "ID_NUM")
  IDNum,

  @doc("IP Address.")
  @projectedName("python", "IP_ADDRESS")
  IPAddress,

  @doc("License. Such as a driver's license or medical license")
  License,

  @doc("Location Other. Such as Golden Gate Park.")
  LocationOther,

  @doc("Medical Record Number.")
  MedicalRecord,

  @doc("Organization. Such as a company name")
  Organization,

  @doc("Patient Name.")
  Patient,

  @doc("Phone Number.")
  Phone,

  @doc("Profession.")
  Profession,

  @doc("Social Security Numbers in the US.")
  SocialSecurity,

  @doc("State")
  State,

  @doc("Street.")
  Street,

  @doc("Web URL.")
  Url,

  @doc("Usernames, such as a social media handle")
  Username,

  @doc("Vehicle IDs, such as license plates or VIN numbers")
  Vehicle,

  @doc("Zip Code.")
  Zip,
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
