import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Logic;

@doc("The workflow provisioning state.")
union WorkflowProvisioningState {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a state where the workflow is accepted.")
  Accepted: "Accepted",
  @doc("Represents a state where the workflow is running.")
  Running: "Running",
  @doc("Represents a state where the workflow is ready.")
  Ready: "Ready",
  @doc("Represents a state where the workflow is creating.")
  Creating: "Creating",
  @doc("Represents a state where the workflow is created.")
  Created: "Created",
  @doc("Represents a state where the workflow is deleting.")
  Deleting: "Deleting",
  @doc("Represents a state where the workflow is deleted.")
  Deleted: "Deleted",
  @doc("Represents a state where the workflow is canceled.")
  Canceled: "Canceled",
  @doc("Represents a state where the workflow is failed.")
  Failed: "Failed",
  @doc("Represents a state where the workflow is succeeded.")
  Succeeded: "Succeeded",
  @doc("Represents a state where the workflow is moving.")
  Moving: "Moving",
  @doc("Represents a state where the workflow is updating.")
  Updating: "Updating",
  @doc("Represents a state where the workflow is registering.")
  Registering: "Registering",
  @doc("Represents a state where the workflow is registered.")
  Registered: "Registered",
  @doc("Represents a state where the workflow is unregistering.")
  Unregistering: "Unregistering",
  @doc("Represents a state where the workflow is unregistered.")
  Unregistered: "Unregistered",
  @doc("Represents a state where the workflow is completed.")
  Completed: "Completed",
  @doc("Represents a state where the workflow is renewing.")
  Renewing: "Renewing",
  @doc("Represents a state where the workflow is pending.")
  Pending: "Pending",
  @doc("Represents a state where the workflow is waiting.")
  Waiting: "Waiting",
  @doc("Represents a state where the workflow is in progress.")
  InProgress: "InProgress",
}

@doc("The workflow state.")
union WorkflowState {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a state where the workflow is completed.")
  Completed: "Completed",
  @doc("Represents a state where the workflow is enabled.")
  Enabled: "Enabled",
  @doc("Represents a state where the workflow is disabled.")
  Disabled: "Disabled",
  @doc("Represents a state where the workflow is deleted.")
  Deleted: "Deleted",
  @doc("Represents a state where the workflow is suspended.")
  Suspended: "Suspended",
}

@doc("Open authentication policy provider type.")
union OpenAuthenticationProviderType {
  string,
  @doc("Represents Azure Active Directory (AAD) provider type.")
  AAD: "AAD",
}

@doc("The sku name.")
union SkuName {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a free SKU.")
  Free: "Free",
  @doc("Represents a shared SKU.")
  Shared: "Shared",
  @doc("Represents a basic SKU.")
  Basic: "Basic",
  @doc("Represents a standard SKU.")
  Standard: "Standard",
  @doc("Represents a premium SKU.")
  Premium: "Premium",
}

@doc("The parameter type.")
union ParameterType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a string parameter type.")
  String: "String",
  @doc("Represents a secure string parameter type.")
  SecureString: "SecureString",
  @doc("Represents an integer parameter type.")
  Int: "Int",
  @doc("Represents a float parameter type.")
  Float: "Float",
  @doc("Represents a boolean parameter type.")
  Bool: "Bool",
  @doc("Represents an array parameter type.")
  Array: "Array",
  @doc("Represents an object parameter type.")
  Object: "Object",
  @doc("Represents a secure object parameter type.")
  SecureObject: "SecureObject",
}

@doc("The key type.")
union KeyType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a primary key type.")
  Primary: "Primary",
  @doc("Represents a secondary key type.")
  Secondary: "Secondary",
}

@doc("The workflow trigger provisioning state.")
union WorkflowTriggerProvisioningState {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a state where the workflow trigger is accepted.")
  Accepted: "Accepted",
  @doc("Represents a state where the workflow trigger is running.")
  Running: "Running",
  @doc("Represents a state where the workflow trigger is ready.")
  Ready: "Ready",
  @doc("Represents a state where the workflow trigger is creating.")
  Creating: "Creating",
  @doc("Represents a state where the workflow trigger is created.")
  Created: "Created",
  @doc("Represents a state where the workflow trigger is deleting.")
  Deleting: "Deleting",
  @doc("Represents a state where the workflow trigger is deleted.")
  Deleted: "Deleted",
  @doc("Represents a state where the workflow trigger is canceled.")
  Canceled: "Canceled",
  @doc("Represents a state where the workflow trigger is failed.")
  Failed: "Failed",
  @doc("Represents a state where the workflow trigger is succeeded.")
  Succeeded: "Succeeded",
  @doc("Represents a state where the workflow trigger is moving.")
  Moving: "Moving",
  @doc("Represents a state where the workflow trigger is updating.")
  Updating: "Updating",
  @doc("Represents a state where the workflow trigger is registering.")
  Registering: "Registering",
  @doc("Represents a state where the workflow trigger is registered.")
  Registered: "Registered",
  @doc("Represents a state where the workflow trigger is unregistering.")
  Unregistering: "Unregistering",
  @doc("Represents a state where the workflow trigger is unregistered.")
  Unregistered: "Unregistered",
  @doc("Represents a state where the workflow trigger is completed.")
  Completed: "Completed",
}

@doc("The workflow status.")
union WorkflowStatus {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a paused workflow status.")
  Paused: "Paused",
  @doc("Represents a running workflow status.")
  Running: "Running",
  @doc("Represents a waiting workflow status.")
  Waiting: "Waiting",
  @doc("Represents a succeeded workflow status.")
  Succeeded: "Succeeded",
  @doc("Represents a skipped workflow status.")
  Skipped: "Skipped",
  @doc("Represents a suspended workflow status.")
  Suspended: "Suspended",
  @doc("Represents a cancelled workflow status.")
  Cancelled: "Cancelled",
  @doc("Represents a failed workflow status.")
  Failed: "Failed",
  @doc("Represents a faulted workflow status.")
  Faulted: "Faulted",
  @doc("Represents a timed out workflow status.")
  TimedOut: "TimedOut",
  @doc("Represents an aborted workflow status.")
  Aborted: "Aborted",
  @doc("Represents an ignored workflow status.")
  Ignored: "Ignored",
}

@doc("The recurrence frequency.")
union RecurrenceFrequency {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a recurrence frequency of seconds.")
  Second: "Second",
  @doc("Represents a recurrence frequency of minutes.")
  Minute: "Minute",
  @doc("Represents a recurrence frequency of hours.")
  Hour: "Hour",
  @doc("Represents a recurrence frequency of days.")
  Day: "Day",
  @doc("Represents a recurrence frequency of weeks.")
  Week: "Week",
  @doc("Represents a recurrence frequency of months.")
  Month: "Month",
  @doc("Represents a recurrence frequency of years.")
  Year: "Year",
}

@doc("The integration account sku name.")
union IntegrationAccountSkuName {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a free integration account SKU.")
  Free: "Free",
  @doc("Represents a basic integration account SKU.")
  Basic: "Basic",
  @doc("Represents a standard integration account SKU.")
  Standard: "Standard",
}

@doc("The track events operation options.")
union TrackEventsOperationOptions {
  string,
  @doc("Represents no track events operation options.")
  None: "None",
  @doc("Represents disabling source info enrichment for track events operation.")
  DisableSourceInfoEnrich: "DisableSourceInfoEnrich",
}

@doc("The tracking record type.")
union TrackingRecordType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a custom tracking record type.")
  Custom: "Custom",
  @doc("Represents an AS2 message tracking record type.")
  AS2Message: "AS2Message",
  @doc("Represents an AS2 MDN tracking record type.")
  AS2MDN: "AS2MDN",
  @doc("Represents an X12 interchange tracking record type.")
  X12Interchange: "X12Interchange",
  @doc("Represents an X12 functional group tracking record type.")
  X12FunctionalGroup: "X12FunctionalGroup",
  @doc("Represents an X12 transaction set tracking record type.")
  X12TransactionSet: "X12TransactionSet",
  @doc("Represents an X12 interchange acknowledgment tracking record type.")
  X12InterchangeAcknowledgment: "X12InterchangeAcknowledgment",
  @doc("Represents an X12 functional group acknowledgment tracking record type.")
  X12FunctionalGroupAcknowledgment: "X12FunctionalGroupAcknowledgment",
  @doc("Represents an X12 transaction set acknowledgment tracking record type.")
  X12TransactionSetAcknowledgment: "X12TransactionSetAcknowledgment",
  @doc("Represents an Edifact interchange tracking record type.")
  EdifactInterchange: "EdifactInterchange",
  @doc("Represents an Edifact functional group tracking record type.")
  EdifactFunctionalGroup: "EdifactFunctionalGroup",
  @doc("Represents an Edifact transaction set tracking record type.")
  EdifactTransactionSet: "EdifactTransactionSet",
  @doc("Represents an Edifact interchange acknowledgment tracking record type.")
  EdifactInterchangeAcknowledgment: "EdifactInterchangeAcknowledgment",
  @doc("Represents an Edifact functional group acknowledgment tracking record type.")
  EdifactFunctionalGroupAcknowledgment: "EdifactFunctionalGroupAcknowledgment",
  @doc("Represents an Edifact transaction set acknowledgment tracking record type.")
  EdifactTransactionSetAcknowledgment: "EdifactTransactionSetAcknowledgment",
}

@doc("The schema type.")
union SchemaType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an XML schema type.")
  Xml: "Xml",
}

@doc("The map type.")
union MapType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an XSLT map type.")
  Xslt: "Xslt",
  @doc("Represents an XSLT 2.0 map type.")
  Xslt20: "Xslt20",
  @doc("Represents an XSLT 3.0 map type.")
  Xslt30: "Xslt30",
  @doc("Represents a Liquid map type.")
  Liquid: "Liquid",
}

@doc("The partner type.")
union PartnerType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a B2B partner type.")
  B2B: "B2B",
}

@doc("The signing or hashing algorithm.")
union HashingAlgorithm {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents no hashing algorithm.")
  None: "None",
  @doc("Represents the MD5 hashing algorithm.")
  MD5: "MD5",
  @doc("Represents the SHA1 hashing algorithm.")
  SHA1: "SHA1",
  @doc("Represents the SHA2-256 hashing algorithm.")
  SHA2256: "SHA2256",
  @doc("Represents the SHA2-384 hashing algorithm.")
  SHA2384: "SHA2384",
  @doc("Represents the SHA2-512 hashing algorithm.")
  SHA2512: "SHA2512",
}

@doc("The encryption algorithm.")
union EncryptionAlgorithm {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents no encryption algorithm.")
  None: "None",
  @doc("Represents the DES3 encryption algorithm.")
  DES3: "DES3",
  @doc("Represents the RC2 encryption algorithm.")
  RC2: "RC2",
  @doc("Represents the AES-128 encryption algorithm.")
  AES128: "AES128",
  @doc("Represents the AES-192 encryption algorithm.")
  AES192: "AES192",
  @doc("Represents the AES-256 encryption algorithm.")
  AES256: "AES256",
}

@doc("The signing or hashing algorithm.")
union SigningAlgorithm {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents the default signing algorithm.")
  Default: "Default",
  @doc("Represents the SHA1 signing algorithm.")
  SHA1: "SHA1",
  @doc("Represents the SHA2-256 signing algorithm.")
  SHA2256: "SHA2256",
  @doc("Represents the SHA2-384 signing algorithm.")
  SHA2384: "SHA2384",
  @doc("Represents the SHA2-512 signing algorithm.")
  SHA2512: "SHA2512",
}

@doc("The trailing separator policy.")
union TrailingSeparatorPolicy {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a policy where trailing separators are not allowed.")
  NotAllowed: "NotAllowed",
  @doc("Represents a policy where trailing separators are optional.")
  Optional: "Optional",
  @doc("Represents a policy where trailing separators are mandatory.")
  Mandatory: "Mandatory",
}

@doc("The X12 character set.")
union X12CharacterSet {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents the basic X12 character set.")
  Basic: "Basic",
  @doc("Represents the extended X12 character set.")
  Extended: "Extended",
  @doc("Represents the UTF-8 X12 character set.")
  UTF8: "UTF8",
}

@doc("The x12 date format.")
union X12DateFormat {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents the CCYYMMDD date format.")
  CCYYMMDD: "CCYYMMDD",
  @doc("Represents the YYMMDD date format.")
  YYMMDD: "YYMMDD",
}

@doc("The x12 time format.")
union X12TimeFormat {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents the HHMM time format.")
  HHMM: "HHMM",
  @doc("Represents the HHMMSS time format.")
  HHMMSS: "HHMMSS",
  @doc("Represents the HHMMSSdd time format.")
  HHMMSSdd: "HHMMSSdd",
  @doc("Represents the HHMMSSd time format.")
  HHMMSSd: "HHMMSSd",
}

@doc("The usage indicator.")
union UsageIndicator {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a test usage indicator.")
  Test: "Test",
  @doc("Represents an information usage indicator.")
  Information: "Information",
  @doc("Represents a production usage indicator.")
  Production: "Production",
}

@doc("The message filter type.")
union MessageFilterType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an include message filter type.")
  Include: "Include",
  @doc("Represents an exclude message filter type.")
  Exclude: "Exclude",
}

@doc("The edifact character set.")
union EdifactCharacterSet {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents the UNOB Edifact character set.")
  UNOB: "UNOB",
  @doc("Represents the UNOA Edifact character set.")
  UNOA: "UNOA",
  @doc("Represents the UNOC Edifact character set.")
  UNOC: "UNOC",
  @doc("Represents the UNOD Edifact character set.")
  UNOD: "UNOD",
  @doc("Represents the UNOE Edifact character set.")
  UNOE: "UNOE",
  @doc("Represents the UNOF Edifact character set.")
  UNOF: "UNOF",
  @doc("Represents the UNOG Edifact character set.")
  UNOG: "UNOG",
  @doc("Represents the UNOH Edifact character set.")
  UNOH: "UNOH",
  @doc("Represents the UNOI Edifact character set.")
  UNOI: "UNOI",
  @doc("Represents the UNOJ Edifact character set.")
  UNOJ: "UNOJ",
  @doc("Represents the UNOK Edifact character set.")
  UNOK: "UNOK",
  @doc("Represents the UNOX Edifact character set.")
  UNOX: "UNOX",
  @doc("Represents the UNOY Edifact character set.")
  UNOY: "UNOY",
  @doc("Represents the KECA Edifact character set.")
  KECA: "KECA",
}

@doc("The integration service environment access endpoint type.")
union IntegrationServiceEnvironmentAccessEndpointType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an external access endpoint type.")
  External: "External",
  @doc("Represents an internal access endpoint type.")
  Internal: "Internal",
}

@doc("The integration service environment sku name.")
union IntegrationServiceEnvironmentSkuName {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a premium integration service environment SKU.")
  Premium: "Premium",
  @doc("Represents a developer integration service environment SKU.")
  Developer: "Developer",
}

@doc("The integration service environment sku scale type.")
union IntegrationServiceEnvironmentSkuScaleType {
  string,
  @doc("Represents a manual scale type.")
  Manual: "Manual",
  @doc("Represents an automatic scale type.")
  Automatic: "Automatic",
  @doc("Represents no scale type.")
  None: "None",
}

@doc("The integration service environment network dependency category type.")
union IntegrationServiceEnvironmentNetworkDependencyCategoryType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an Azure Storage network dependency category type.")
  AzureStorage: "AzureStorage",
  @doc("Represents an Azure Management network dependency category type.")
  AzureManagement: "AzureManagement",
  @doc("Represents an Azure Active Directory network dependency category type.")
  AzureActiveDirectory: "AzureActiveDirectory",
  @doc("Represents an SSL Certificate Verification network dependency category type.")
  SSLCertificateVerification: "SSLCertificateVerification",
  @doc("Represents a Diagnostic Logs and Metrics network dependency category type.")
  DiagnosticLogsAndMetrics: "DiagnosticLogsAndMetrics",
  @doc("Represents an Integration Service Environment Connectors network dependency category type.")
  IntegrationServiceEnvironmentConnectors: "IntegrationServiceEnvironmentConnectors",
  @doc("Represents a Redis Cache network dependency category type.")
  RedisCache: "RedisCache",
  @doc("Represents an Access Endpoints network dependency category type.")
  AccessEndpoints: "AccessEndpoints",
  @doc("Represents a Recovery Service network dependency category type.")
  RecoveryService: "RecoveryService",
  @doc("Represents a SQL network dependency category type.")
  SQL: "SQL",
  @doc("Represents a Regional Service network dependency category type.")
  RegionalService: "RegionalService",
}

@doc("The integration service environment network endpoint accessibility state.")
union IntegrationServiceEnvironmentNetworkEndPointAccessibilityState {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an unknown network endpoint accessibility state.")
  Unknown: "Unknown",
  @doc("Represents an available network endpoint accessibility state.")
  Available: "Available",
  @doc("Represents a not available network endpoint accessibility state.")
  NotAvailable: "NotAvailable",
}

@doc("The error response code.")
union ErrorResponseCode {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an Integration Service Environment Not Found error response code.")
  IntegrationServiceEnvironmentNotFound: "IntegrationServiceEnvironmentNotFound",
  @doc("Represents an Internal Server Error response code.")
  InternalServerError: "InternalServerError",
  @doc("Represents an Invalid Operation Id error response code.")
  InvalidOperationId: "InvalidOperationId",
}

@doc("The integration service environment network dependency health state.")
union IntegrationServiceEnvironmentNetworkDependencyHealthState {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a healthy network dependency health state.")
  Healthy: "Healthy",
  @doc("Represents an unhealthy network dependency health state.")
  Unhealthy: "Unhealthy",
  @doc("Represents an unknown network dependency health state.")
  Unknown: "Unknown",
}

@doc("The API type.")
union ApiType {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a REST API type.")
  Rest: "Rest",
  @doc("Represents a SOAP API type.")
  Soap: "Soap",
}

@doc("The WSDL import method.")
union WsdlImportMethod {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a SOAP to REST WSDL import method.")
  SoapToRest: "SoapToRest",
  @doc("Represents a SOAP Pass Through WSDL import method.")
  SoapPassThrough: "SoapPassThrough",
}

@doc("The Api deployment parameter visibility.")
union ApiDeploymentParameterVisibility {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a default API deployment parameter visibility.")
  Default: "Default",
  @doc("Represents an internal API deployment parameter visibility.")
  Internal: "Internal",
}

@doc("The Api tier.")
union ApiTier {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents an enterprise API tier.")
  Enterprise: "Enterprise",
  @doc("Represents a standard API tier.")
  Standard: "Standard",
  @doc("Represents a premium API tier.")
  Premium: "Premium",
}

@doc("The status annotation.")
union StatusAnnotation {
  string,
  @doc("Represents a state where the value is not specified.")
  NotSpecified: "NotSpecified",
  @doc("Represents a preview status annotation.")
  Preview: "Preview",
  @doc("Represents a production status annotation.")
  Production: "Production",
}

@doc("The swagger schema type.")
union SwaggerSchemaType {
  string,
  @doc("Represents a string schema type.")
  String: "String",
  @doc("Represents a number schema type.")
  Number: "Number",
  @doc("Represents an integer schema type.")
  Integer: "Integer",
  @doc("Represents a boolean schema type.")
  Boolean: "Boolean",
  @doc("Represents an array schema type.")
  Array: "Array",
  @doc("Represents a file schema type.")
  File: "File",
  @doc("Represents an object schema type.")
  Object: "Object",
  @doc("Represents a null schema type.")
  Null: "Null",
}

@doc("The Azure async operation state.")
union AzureAsyncOperationState {
  string,
  @doc("Represents a failed async operation state.")
  Failed: "Failed",
  @doc("Represents a succeeded async operation state.")
  Succeeded: "Succeeded",
  @doc("Represents a pending async operation state.")
  Pending: "Pending",
  @doc("Represents a canceled async operation state.")
  Canceled: "Canceled",
}

@doc("The days of a week.")
union DaysOfWeek {
  string,
  @doc("Represents day of a week Sunday.")
  Sunday: "Sunday",
  @doc("Represents day of a week Monday.")
  Monday: "Monday",
  @doc("Represents day of a week Tuesday.")
  Tuesday: "Tuesday",
  @doc("Represents day of a week Wednesday.")
  Wednesday: "Wednesday",
  @doc("Represents day of a week Thursday.")
  Thursday: "Thursday",
  @doc("Represents day of a week Friday.")
  Friday: "Friday",
  @doc("Represents day of a week Saturday.")
  Saturday: "Saturday",
}

@doc("The day of the week.")
union DayOfWeek {
  string,
  @doc("Represents day of a week Sunday.")
  Sunday: "Sunday",
  @doc("Represents day of a week Monday.")
  Monday: "Monday",
  @doc("Represents day of a week Tuesday.")
  Tuesday: "Tuesday",
  @doc("Represents day of a week Wednesday.")
  Wednesday: "Wednesday",
  @doc("Represents day of a week Thursday.")
  Thursday: "Thursday",
  @doc("Represents day of a week Friday.")
  Friday: "Friday",
  @doc("Represents day of a week Saturday.")
  Saturday: "Saturday",
}

@doc("The event level.")
union EventLevel {
  string,
  @doc("Represents a log always event level.")
  LogAlways: "LogAlways",
  @doc("Represents a critical event level.")
  Critical: "Critical",
  @doc("Represents an error event level.")
  Error: "Error",
  @doc("Represents a warning event level.")
  Warning: "Warning",
  @doc("Represents an information event level.")
  Informational: "Informational",
  @doc("Represents a verbose event level.")
  Verbose: "Verbose",
}

@doc("The agreement type.")
union AgreementType {
  string,
  @doc("Represents a not specified agreement type.")
  NotSpecified: "NotSpecified",
  @doc("Represents an AS2 agreement type.")
  AS2: "AS2",
  @doc("Represents an X12 agreement type.")
  X12: "X12",
  @doc("Represents an Edifact agreement type.")
  Edifact: "Edifact",
}

@doc("The segment terminator suffix.")
union SegmentTerminatorSuffix {
  string,
  @doc("Represents a not specified segment terminator suffix.")
  NotSpecified: "NotSpecified",
  @doc("Represents a none segment terminator suffix.")
  None: "None",
  @doc("Represents a CR segment terminator suffix.")
  CR: "CR",
  @doc("Represents a LF segment terminator suffix.")
  LF: "LF",
  @doc("Represents a CRLF segment terminator suffix.")
  CRLF: "CRLF",
}

@doc("The edifact decimal indicator.")
union EdifactDecimalIndicator {
  string,
  @doc("Represents a not specified edifact decimal indicator.")
  NotSpecified: "NotSpecified",
  @doc("Represents a comma edifact decimal indicator.")
  Comma: "Comma",
  @doc("Represents a decimal edifact decimal indicator.")
  Decimal: "Decimal",
}

@doc("The workflow properties.")
model WorkflowProperties {
  @doc("Gets the provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("Gets the created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Gets the changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The state.")
  state?: WorkflowState;

  @doc("Gets the version.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Gets the access endpoint.")
  @visibility(Lifecycle.Read)
  accessEndpoint?: string;

  @doc("The endpoints configuration.")
  endpointsConfiguration?: FlowEndpointsConfiguration;

  @doc("The access control configuration.")
  accessControl?: FlowAccessControlConfiguration;

  @doc("The sku.")
  @visibility(Lifecycle.Read)
  sku?: Sku;

  @doc("The integration account.")
  integrationAccount?: ResourceReference;

  @doc("The integration service environment.")
  integrationServiceEnvironment?: ResourceReference;

  @doc("The definition.")
  definition?: Record<unknown>;

  @doc("The parameters.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<WorkflowParameter>;
}

@doc("The endpoints configuration.")
model FlowEndpointsConfiguration {
  @doc("The workflow endpoints.")
  workflow?: FlowEndpoints;

  @doc("The connector endpoints.")
  connector?: FlowEndpoints;
}

@doc("The flow endpoints configuration.")
model FlowEndpoints {
  @doc("The outgoing ip address.")
  @OpenAPI.extension("x-ms-identifiers", #["address"])
  outgoingIpAddresses?: IpAddress[];

  @doc("The access endpoint ip address.")
  @OpenAPI.extension("x-ms-identifiers", #["address"])
  accessEndpointIpAddresses?: IpAddress[];
}

@doc("The ip address.")
model IpAddress {
  @doc("The address.")
  address?: string;
}

@doc("The access control configuration.")
model FlowAccessControlConfiguration {
  @doc("The access control configuration for invoking workflow triggers.")
  triggers?: FlowAccessControlConfigurationPolicy;

  @doc("The access control configuration for accessing workflow run contents.")
  contents?: FlowAccessControlConfigurationPolicy;

  @doc("The access control configuration for workflow actions.")
  actions?: FlowAccessControlConfigurationPolicy;

  @doc("The access control configuration for workflow management.")
  workflowManagement?: FlowAccessControlConfigurationPolicy;
}

@doc("The access control configuration policy.")
model FlowAccessControlConfigurationPolicy {
  @doc("The allowed caller IP address ranges.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  allowedCallerIpAddresses?: IpAddressRange[];

  @doc("The authentication policies for workflow.")
  openAuthenticationPolicies?: OpenAuthenticationAccessPolicies;
}

@doc("The ip address range.")
model IpAddressRange {
  @doc("The IP address range.")
  addressRange?: string;
}

@doc("AuthenticationPolicy of type Open.")
model OpenAuthenticationAccessPolicies {
  @doc("Open authentication policies.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  policies?: Record<OpenAuthenticationAccessPolicy>;
}

@doc("Open authentication access policy defined by user.")
model OpenAuthenticationAccessPolicy {
  @doc("Type of provider for OAuth.")
  type?: OpenAuthenticationProviderType;

  @doc("The access policy claims.")
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  claims?: OpenAuthenticationPolicyClaim[];
}

@doc("Open authentication policy claim.")
model OpenAuthenticationPolicyClaim {
  @doc("The name of the claim.")
  name?: string;

  @doc("The value of the claim.")
  value?: string;
}

@doc("The sku type.")
model Sku {
  @doc("The name.")
  name: SkuName;

  @doc("The reference to plan.")
  plan?: ResourceReference;
}

@doc("The resource reference.")
model ResourceReference {
  @doc("The resource id.")
  id?: string;

  @doc("Gets the resource name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Gets the resource type.")
  @visibility(Lifecycle.Read)
  type?: string;
}

@doc("The workflow parameters.")
model WorkflowParameter {
  @doc("The type.")
  type?: ParameterType;

  @doc("The value.")
  value?: Record<unknown>;

  @doc("The metadata.")
  metadata?: Record<unknown>;

  @doc("The description.")
  description?: string;
}

@doc("Error properties indicate why the Logic service was not able to process the incoming request. The reason is provided in the error message.")
model ErrorProperties {
  @doc("Error code.")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  message?: string;
}

@doc("The parameters to generate upgraded definition.")
model GenerateUpgradedDefinitionParameters {
  @doc("The target schema version.")
  targetSchemaVersion?: string;
}

@doc("The callback url parameters.")
model GetCallbackUrlParameters {
  @doc("The expiry time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  @doc("The key type.")
  keyType?: KeyType;
}

@doc("The workflow trigger callback URL.")
model WorkflowTriggerCallbackUrl {
  @doc("Gets the workflow trigger callback URL.")
  @visibility(Lifecycle.Read)
  value?: string;

  @doc("Gets the workflow trigger callback URL HTTP method.")
  @visibility(Lifecycle.Read)
  method?: string;

  @doc("Gets the workflow trigger callback URL base path.")
  @visibility(Lifecycle.Read)
  basePath?: string;

  @doc("Gets the workflow trigger callback URL relative path.")
  @visibility(Lifecycle.Read)
  relativePath?: string;

  @doc("Gets the workflow trigger callback URL relative path parameters.")
  relativePathParameters?: string[];

  @doc("Gets the workflow trigger callback URL query parameters.")
  queries?: WorkflowTriggerListCallbackUrlQueries;
}

@doc("Gets the workflow trigger callback URL query parameters.")
model WorkflowTriggerListCallbackUrlQueries {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  @doc("The api version.")
  `api-version`?: string;

  @doc("The SAS permissions.")
  sp?: string;

  @doc("The SAS version.")
  sv?: string;

  @doc("The SAS signature.")
  sig?: string;

  @doc("The SAS timestamp.")
  se?: string;
}

@doc("The workflow reference.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model WorkflowReference extends ResourceReference {}

@doc("The access key regenerate action content.")
model RegenerateActionParameter {
  @doc("The key type.")
  keyType?: KeyType;
}

@doc("The workflow version properties.")
model WorkflowVersionProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("Gets the created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Gets the changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The state.")
  state?: WorkflowState;

  @doc("Gets the version.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Gets the access endpoint.")
  @visibility(Lifecycle.Read)
  accessEndpoint?: string;

  @doc("The endpoints configuration.")
  endpointsConfiguration?: FlowEndpointsConfiguration;

  @doc("The access control configuration.")
  accessControl?: FlowAccessControlConfiguration;

  @doc("The sku.")
  @visibility(Lifecycle.Read)
  sku?: Sku;

  @doc("The integration account.")
  integrationAccount?: ResourceReference;

  @doc("The definition.")
  definition?: Record<unknown>;

  @doc("The parameters.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<WorkflowParameter>;
}

@doc("The workflow trigger properties.")
model WorkflowTriggerProperties {
  @doc("Gets the provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowTriggerProvisioningState;

  @doc("Gets the created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Gets the changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("Gets the state.")
  @visibility(Lifecycle.Read)
  state?: WorkflowState;

  @doc("Gets the status.")
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  @doc("Gets the last execution time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;

  @doc("Gets the next execution time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExecutionTime?: utcDateTime;

  @doc("Gets the workflow trigger recurrence.")
  @visibility(Lifecycle.Read)
  recurrence?: WorkflowTriggerRecurrence;

  @doc("Gets the reference to workflow.")
  @visibility(Lifecycle.Read)
  workflow?: ResourceReference;
}

@doc("The workflow trigger recurrence.")
model WorkflowTriggerRecurrence {
  @doc("The frequency.")
  frequency?: RecurrenceFrequency;

  @doc("The interval.")
  interval?: int32;

  @doc("The start time.")
  startTime?: string;

  @doc("The end time.")
  endTime?: string;

  @doc("The time zone.")
  timeZone?: string;

  @doc("The recurrence schedule.")
  schedule?: RecurrenceSchedule;
}

@doc("The recurrence schedule.")
model RecurrenceSchedule {
  @doc("The minutes.")
  minutes?: int32[];

  @doc("The hours.")
  hours?: int32[];

  @doc("The days of the week.")
  weekDays?: DaysOfWeek[];

  @doc("The month days.")
  monthDays?: int32[];

  @doc("The monthly occurrences.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

@doc("The recurrence schedule occurrence.")
model RecurrenceScheduleOccurrence {
  @doc("The day of the week.")
  day?: DayOfWeek;

  @doc("The occurrence.")
  occurrence?: int32;
}

@doc("The sub resource type.")
model SubResource {
  @doc("The resource id.")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The JSON schema.")
model JsonSchema {
  @doc("The JSON title.")
  title?: string;

  @doc("The JSON content.")
  content?: string;
}

@doc("The set trigger state action definition.")
model SetTriggerStateActionDefinition {
  @doc("The source.")
  source: WorkflowTriggerReference;
}

@doc("The workflow trigger reference.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model WorkflowTriggerReference extends ResourceReference {
  @doc("The workflow name.")
  flowName?: string;

  @doc("The workflow trigger name.")
  triggerName?: string;
}

@doc("The workflow trigger history properties.")
model WorkflowTriggerHistoryProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;
  
  @doc("Gets the start time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The scheduled time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  @doc("Gets the status.")
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  @doc("Gets the code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the error.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;

  @doc("Gets the tracking id.")
  @visibility(Lifecycle.Read)
  trackingId?: string;

  @doc("The run correlation.")
  correlation?: Correlation;

  @doc("Gets the link to input parameters.")
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  @doc("Gets the link to output parameters.")
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  @doc("The value indicating whether trigger was fired.")
  @visibility(Lifecycle.Read)
  fired?: boolean;

  @doc("Gets the reference to workflow run.")
  @visibility(Lifecycle.Read)
  run?: ResourceReference;
}

@doc("The correlation property.")
model Correlation {
  @doc("The client tracking id.")
  clientTrackingId?: string;
}

@doc("The content link.")
model ContentLink {
  @doc("The content link URI.")
  uri?: string;

  @doc("The content version.")
  @visibility(Lifecycle.Read)
  contentVersion?: string;

  @doc("The content size.")
  @visibility(Lifecycle.Read)
  contentSize?: int64;

  @doc("The content hash.")
  @visibility(Lifecycle.Read)
  contentHash?: ContentHash;

  @doc("The metadata.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;
}

@doc("The content hash.")
model ContentHash {
  @doc("The algorithm of the content hash.")
  algorithm?: string;

  @doc("The value of the content hash.")
  value?: string;
}

@doc("The workflow run properties.")
model WorkflowRunProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("Gets the wait end time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  waitEndTime?: utcDateTime;

  @doc("Gets the start time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the status.")
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  @doc("Gets the code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the error.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;

  @doc("Gets the correlation id.")
  @visibility(Lifecycle.Read)
  correlationId?: string;

  @doc("The run correlation.")
  correlation?: Correlation;

  @doc("Gets the reference to workflow version.")
  @visibility(Lifecycle.Read)
  workflow?: ResourceReference;

  @doc("Gets the fired trigger.")
  @visibility(Lifecycle.Read)
  trigger?: WorkflowRunTrigger;

  @doc("Gets the outputs.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  outputs?: Record<WorkflowOutputParameter>;

  @doc("Gets the response of the flow run.")
  @visibility(Lifecycle.Read)
  response?: WorkflowRunTrigger;
}

@doc("The workflow run trigger.")
model WorkflowRunTrigger {
  @doc("Gets the name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Gets the inputs.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  inputs?: Record<unknown>;

  @doc("Gets the link to inputs.")
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  @doc("Gets the outputs.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  outputs?: Record<unknown>;

  @doc("Gets the link to outputs.")
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  @doc("Gets the scheduled time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  @doc("Gets the start time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the tracking id.")
  @visibility(Lifecycle.Read)
  trackingId?: string;

  @doc("The run correlation.")
  correlation?: Correlation;

  @doc("Gets the code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the status.")
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  @doc("Gets the error.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;

  @doc("Gets the tracked properties.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackedProperties?: Record<unknown>;
}

@doc("The workflow output parameter.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model WorkflowOutputParameter extends WorkflowParameter {
  @doc("Gets the error.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;
}

@doc("The workflow run action properties.")
model WorkflowRunActionProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("Gets the start time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the status.")
  @visibility(Lifecycle.Read)
  status?: WorkflowStatus;

  @doc("Gets the code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the error.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;

  @doc("Gets the tracking id.")
  @visibility(Lifecycle.Read)
  trackingId?: string;

  @doc("The correlation properties.")
  correlation?: RunActionCorrelation;

  @doc("Gets the link to inputs.")
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  @doc("Gets the link to outputs.")
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  @doc("Gets the tracked properties.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackedProperties?: Record<unknown>;

  @doc("Gets the retry histories.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  retryHistory?: RetryHistory[];
}

@doc("The workflow run action correlation properties.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RunActionCorrelation extends RunCorrelation {
  @doc("The action tracking identifier.")
  actionTrackingId?: string;
}

@doc("The correlation properties.")
model RunCorrelation {
  @doc("The client tracking identifier.")
  clientTrackingId?: string;

  @doc("The client keywords.")
  clientKeywords?: string[];
}

@doc("The retry history.")
model RetryHistory {
  @doc("Gets the start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the status code.")
  code?: string;

  @doc("Gets the client request Id.")
  clientRequestId?: string;

  @doc("Gets the service request Id.")
  serviceRequestId?: string;

  @doc("Gets the error response.")
  error?: ErrorResponse;
}

@doc("The expression traces.")
@pagedResult
model ExpressionTraces {
  @items
  @OpenAPI.extension("x-ms-identifiers", #["path"])
  @doc("The expression trace.")
  inputs?: ExpressionRoot[];
}

@doc("The expression root.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ExpressionRoot extends Expression {
  @doc("The path.")
  path?: string;
}

@doc("The expression.")
model Expression {
  @doc("The text.")
  text?: string;

  @doc("Anything")
  value?: unknown;

  @doc("The sub expressions.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  subexpressions?: Expression[];
  
  @doc("The azure resource error info.")
  error?: AzureResourceErrorInfo;
}

@doc("The error info.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AzureResourceErrorInfo extends ErrorInfo {
  @doc("The error message.")
  message: string;

  @doc("The error details.")
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: AzureResourceErrorInfo[];
}

@doc("The error info.")
model ErrorInfo {
  @doc("The error code.")
  code: string;
}

@doc("A collection of workflow run action repetitions.")
model WorkflowRunActionRepetitionDefinitionCollection
  is Azure.Core.Page<WorkflowRunActionRepetitionDefinition>;

@doc("The workflow run action repetition properties definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model WorkflowRunActionRepetitionProperties extends OperationResult {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The repetition indexes.")
  @OpenAPI.extension("x-ms-identifiers", #["itemIndex"])
  repetitionIndexes?: RepetitionIndex[];
}

@doc("The workflow run action repetition index.")
model RepetitionIndex {
  @doc("The scope.")
  scopeName?: string;

  @doc("The index.")
  itemIndex: int32;
}

@doc("The operation result definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OperationResult extends OperationResultProperties {
  @doc("Gets the tracking id.")
  @visibility(Lifecycle.Read)
  trackingId?: string;

  @doc("Gets the inputs.")
  @visibility(Lifecycle.Read)
  inputs?: Record<unknown>;

  @doc("Gets the link to inputs.")
  @visibility(Lifecycle.Read)
  inputsLink?: ContentLink;

  @doc("Gets the outputs.")
  @visibility(Lifecycle.Read)
  outputs?: Record<unknown>;

  @doc("Gets the link to outputs.")
  @visibility(Lifecycle.Read)
  outputsLink?: ContentLink;

  @doc("Gets the tracked properties.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  trackedProperties?: Record<unknown>;

  @doc("Gets the retry histories.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  retryHistory?: RetryHistory[];

  @doc("Gets the iteration count.")
  iterationCount?: int32;
}

@doc("The run operation result properties.")
model OperationResultProperties {
  @doc("The start time of the workflow scope repetition.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the workflow scope repetition.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The correlation properties.")
  correlation?: RunActionCorrelation;

  @doc("The status of the workflow scope repetition.")
  status?: WorkflowStatus;

  @doc("The workflow scope repetition code.")
  code?: string;

  @doc("Anything")
  error?: unknown;
}

@doc("The request history.")
model RequestHistoryProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The time the request started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time the request ended.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The request.")
  request?: Request;

  @doc("The response.")
  response?: Response;
}

@doc("A request.")
model Request {
  @doc("A list of all the headers attached to the request.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  headers?: Record<unknown>;

  @doc("The destination for the request.")
  uri?: string;

  @doc("The HTTP method used for the request.")
  method?: string;
}

@doc("A response.")
model Response {
  @doc("A list of all the headers attached to the response.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  headers?: Record<unknown>;

  @doc("The status code of the response.")
  statusCode?: int32;

  @doc("Details on the location of the body content.")
  bodyLink?: ContentLink;
}

@doc("The integration account properties.")
model IntegrationAccountProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The integration service environment.")
  integrationServiceEnvironment?: ResourceReference;

  @doc("The workflow state.")
  state?: WorkflowState;
}

@doc("The integration account sku.")
model IntegrationAccountSku {
  @doc("The sku name.")
  name: IntegrationAccountSkuName;
}

@doc("A collection of assembly definitions.")
@pagedResult
model AssemblyCollection {
  @items
  @doc("The assembly definitions.")
  value?: AssemblyDefinition[];
}

@doc("The assembly properties definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AssemblyProperties extends ArtifactContentPropertiesDefinition {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The assembly name.")
  assemblyName: string;

  @doc("The assembly version.")
  assemblyVersion?: string;

  @doc("The assembly culture.")
  assemblyCulture?: string;

  @doc("The assembly public key token.")
  assemblyPublicKeyToken?: string;
}

@doc("The artifact content properties definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ArtifactContentPropertiesDefinition extends ArtifactProperties {
  @doc("Anything")
  content?: unknown;

  @doc("The content type.")
  contentType?: string;

  @doc("The content link.")
  contentLink?: ContentLink;
}

@doc("The artifact properties definition.")
model ArtifactProperties {
  @doc("The artifact creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The artifact changed time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("Anything")
  metadata?: unknown;
}

@doc("A collection of batch configurations.")
@pagedResult
model BatchConfigurationCollection {
  @items
  @doc("The batch configurations.")
  value?: BatchConfiguration[];
}

@doc("The batch configuration properties definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BatchConfigurationProperties extends ArtifactProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The name of the batch group.")
  batchGroupName: string;

  @doc("The batch release criteria.")
  releaseCriteria: BatchReleaseCriteria;
}

@doc("The batch release criteria.")
model BatchReleaseCriteria {
  @doc("The message count.")
  messageCount?: int32;

  @doc("The batch size in bytes.")
  batchSize?: int32;

  @doc("The recurrence.")
  recurrence?: WorkflowTriggerRecurrence;
}

@doc("The callback url.")
model CallbackUrl {
  @doc("The URL value.")
  value?: string;
}

@doc("The list key vault keys definition.")
model ListKeyVaultKeysDefinition {
  @doc("The key vault reference.")
  keyVault: KeyVaultReference;

  @doc("The skip token.")
  skipToken?: string;
}

@doc("The key vault reference.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model KeyVaultReference extends ResourceReference {}

@doc("Collection of key vault keys.")
@pagedResult
model KeyVaultKeyCollection {
  @doc("The key vault keys.")
  @items
  @OpenAPI.extension("x-ms-identifiers", #["kid"])
  value?: KeyVaultKey[];

  @doc("The skip token.")
  skipToken?: string;
}

@doc("The key vault key.")
model KeyVaultKey {
  @doc("The key id.")
  kid?: string;

  @doc("The key attributes.")
  attributes?: KeyVaultKeyAttributes;
}

@doc("The key attributes.")
model KeyVaultKeyAttributes {
  @doc("Whether the key is enabled or not.")
  enabled?: boolean;

  @doc("When the key was created.")
  created?: int64;

  @doc("When the key was updated.")
  updated?: int64;
}

@doc("The tracking events definition.")
model TrackingEventsDefinition {
  @doc("The source type.")
  sourceType: string;

  @doc("The track events options.")
  trackEventsOptions?: TrackEventsOperationOptions;

  @doc("The events.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  events: TrackingEvent[];
}

@doc("The tracking event.")
model TrackingEvent {
  @doc("The event level.")
  eventLevel: EventLevel;

  @doc("The event time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime: utcDateTime;

  @doc("The record type.")
  recordType: TrackingRecordType;

  @doc("The record.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  record?: Record<unknown>;

  @doc("The error.")
  error?: TrackingEventErrorInfo;
}

@doc("The tracking event error info.")
model TrackingEventErrorInfo {
  @doc("The message.")
  message?: string;

  @doc("The code.")
  code?: string;
}

@doc("The integration account schema properties.")
model IntegrationAccountSchemaProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The schema type.")
  schemaType: SchemaType;

  @doc("The target namespace of the schema.")
  targetNamespace?: string;

  @doc("The document name.")
  documentName?: string;

  @doc("The file name.")
  fileName?: string;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The metadata.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;

  @doc("The content.")
  content?: string;

  @doc("The content type.")
  contentType?: string;

  @doc("The content link.")
  @visibility(Lifecycle.Read)
  contentLink?: ContentLink;
}

@doc("The integration account map.")
model IntegrationAccountMapProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The map type.")
  mapType: MapType;

  @doc("The parameters schema of integration account map.")
  parametersSchema?: IntegrationAccountMapPropertiesParametersSchema;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The content.")
  content?: string;

  @doc("The content type.")
  contentType?: string;

  @doc("The content link.")
  @visibility(Lifecycle.Read)
  contentLink?: ContentLink;

  @doc("The metadata.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;
}

@doc("The parameters schema of integration account map.")
model IntegrationAccountMapPropertiesParametersSchema {
  @doc("The reference name.")
  ref?: string;
}

@doc("The integration account partner properties.")
model IntegrationAccountPartnerProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The partner type.")
  partnerType: PartnerType;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The metadata.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;

  @doc("The partner content.")
  content: PartnerContent;
}

@doc("The integration account partner content.")
model PartnerContent {
  @doc("The B2B partner content.")
  b2b?: B2bPartnerContent;
}

@doc("The B2B partner content.")
model B2bPartnerContent {
  @doc("The list of partner business identities.")
  @OpenAPI.extension("x-ms-identifiers", #["qualifier"])
  businessIdentities?: BusinessIdentity[];
}

@doc("The integration account partner's business identity.")
model BusinessIdentity {
  @doc("The business identity qualifier e.g. as2identity, ZZ, ZZZ, 31, 32")
  qualifier: string;

  @doc("The user defined business identity value.")
  value: string;
}

@doc("The integration account agreement properties.")
model IntegrationAccountAgreementProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The metadata.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;

  @doc("The agreement type.")
  agreementType: AgreementType;

  @doc("The integration account partner that is set as host partner for this agreement.")
  hostPartner: string;

  @doc("The integration account partner that is set as guest partner for this agreement.")
  guestPartner: string;

  @doc("The business identity of the host partner.")
  hostIdentity: BusinessIdentity;

  @doc("The business identity of the guest partner.")
  guestIdentity: BusinessIdentity;

  @doc("The agreement content.")
  content: AgreementContent;
}

@doc("The integration account agreement content.")
model AgreementContent {
  @doc("The AS2 agreement content.")
  aS2?: As2AgreementContent;

  @doc("The X12 agreement content.")
  x12?: X12AgreementContent;

  @doc("The EDIFACT agreement content.")
  edifact?: EdifactAgreementContent;
}

@doc("The integration account AS2 agreement content.")
model As2AgreementContent {
  @doc("The AS2 one-way receive agreement.")
  receiveAgreement: As2OneWayAgreement;

  @doc("The AS2 one-way send agreement.")
  sendAgreement: As2OneWayAgreement;
}

@doc("The integration account AS2 one-way agreement.")
model As2OneWayAgreement {
  @doc("The sender business identity")
  senderBusinessIdentity: BusinessIdentity;

  @doc("The receiver business identity")
  receiverBusinessIdentity: BusinessIdentity;

  @doc("The AS2 protocol settings.")
  protocolSettings: As2ProtocolSettings;
}

@doc("The AS2 agreement protocol settings.")
model As2ProtocolSettings {
  @doc("The message connection settings.")
  messageConnectionSettings: As2MessageConnectionSettings;

  @doc("The acknowledgement connection settings.")
  acknowledgementConnectionSettings: As2AcknowledgementConnectionSettings;

  @doc("The MDN settings.")
  mdnSettings: As2MdnSettings;

  @doc("The security settings.")
  securitySettings: As2SecuritySettings;

  @doc("The validation settings.")
  validationSettings: As2ValidationSettings;

  @doc("The envelope settings.")
  envelopeSettings: As2EnvelopeSettings;

  @doc("The error settings.")
  errorSettings: As2ErrorSettings;
}

@doc("The AS2 agreement message connection settings.")
model As2MessageConnectionSettings {
  @doc("The value indicating whether to ignore mismatch in certificate name.")
  ignoreCertificateNameMismatch: boolean;

  @doc("The value indicating whether to support HTTP status code 'CONTINUE'.")
  supportHttpStatusCodeContinue: boolean;

  @doc("The value indicating whether to keep the connection alive.")
  keepHttpConnectionAlive: boolean;

  @doc("The value indicating whether to unfold the HTTP headers.")
  unfoldHttpHeaders: boolean;
}

@doc("The AS2 agreement acknowledgement connection settings.")
model As2AcknowledgementConnectionSettings {
  @doc("Indicates whether to ignore mismatch in certificate name.")
  ignoreCertificateNameMismatch: boolean;

  @doc("Indicates whether to support HTTP status code 'CONTINUE'.")
  supportHttpStatusCodeContinue: boolean;

  @doc("Indicates whether to keep the connection alive.")
  keepHttpConnectionAlive: boolean;

  @doc("Indicates whether to unfold the HTTP headers.")
  unfoldHttpHeaders: boolean;
}

@doc("The AS2 agreement mdn settings.")
model As2MdnSettings {
  @doc("The value indicating whether to send or request a MDN.")
  needMdn: boolean;

  @doc("The value indicating whether the MDN needs to be signed or not.")
  signMdn: boolean;

  @doc("The value indicating whether to send the asynchronous MDN.")
  sendMdnAsynchronously: boolean;

  @doc("The receipt delivery URL.")
  receiptDeliveryUrl?: string;

  @doc("The disposition notification to header value.")
  dispositionNotificationTo?: string;

  @doc("The value indicating whether to sign the outbound MDN if optional.")
  signOutboundMdnIfOptional: boolean;

  @doc("The MDN text.")
  mdnText?: string;

  @doc("The value indicating whether to send inbound MDN to message box.")
  sendInboundMdnToMessageBox: boolean;

  @doc("The signing or hashing algorithm.")
  micHashingAlgorithm: HashingAlgorithm;
}

@doc("The AS2 agreement security settings.")
model As2SecuritySettings {
  @doc("The value indicating whether to send or request a MDN.")
  overrideGroupSigningCertificate: boolean;

  @doc("The name of the signing certificate.")
  signingCertificateName?: string;

  @doc("The name of the encryption certificate.")
  encryptionCertificateName?: string;

  @doc("The value indicating whether to enable NRR for inbound encoded messages.")
  enableNrrForInboundEncodedMessages: boolean;

  @doc("The value indicating whether to enable NRR for inbound decoded messages.")
  enableNrrForInboundDecodedMessages: boolean;

  @doc("The value indicating whether to enable NRR for outbound MDN.")
  enableNrrForOutboundMdn: boolean;

  @doc("The value indicating whether to enable NRR for outbound encoded messages.")
  enableNrrForOutboundEncodedMessages: boolean;

  @doc("The value indicating whether to enable NRR for outbound decoded messages.")
  enableNrrForOutboundDecodedMessages: boolean;

  @doc("The value indicating whether to enable NRR for inbound MDN.")
  enableNrrForInboundMdn: boolean;

  @doc("The Sha2 algorithm format. Valid values are Sha2, ShaHashSize, ShaHyphenHashSize, Sha2UnderscoreHashSize.")
  sha2AlgorithmFormat?: string;
}

@doc("The AS2 agreement validation settings.")
model As2ValidationSettings {
  @doc("The value indicating whether to override incoming message properties with those in agreement.")
  overrideMessageProperties: boolean;

  @doc("The value indicating whether the message has to be encrypted.")
  encryptMessage: boolean;

  @doc("The value indicating whether the message has to be signed.")
  signMessage: boolean;

  @doc("The value indicating whether the message has to be compressed.")
  compressMessage: boolean;

  @doc("The value indicating whether to check for duplicate message.")
  checkDuplicateMessage: boolean;

  @doc("The number of days to look back for duplicate interchange.")
  interchangeDuplicatesValidityDays: int32;

  @doc("The value indicating whether to check for certificate revocation list on send.")
  checkCertificateRevocationListOnSend: boolean;

  @doc("The value indicating whether to check for certificate revocation list on receive.")
  checkCertificateRevocationListOnReceive: boolean;

  @doc("The encryption algorithm.")
  encryptionAlgorithm: EncryptionAlgorithm;

  @doc("The signing algorithm.")
  signingAlgorithm?: SigningAlgorithm;
}

@doc("The AS2 agreement envelope settings.")
model As2EnvelopeSettings {
  @doc("The message content type.")
  messageContentType: string;

  @doc("The value indicating whether to transmit file name in mime header.")
  transmitFileNameInMimeHeader: boolean;

  @doc("The template for file name.")
  fileNameTemplate: string;

  @doc("The value indicating whether to suspend message on file name generation error.")
  suspendMessageOnFileNameGenerationError: boolean;

  @doc("The value indicating whether to auto generate file name.")
  autogenerateFileName: boolean;
}

@doc("The AS2 agreement error settings.")
model As2ErrorSettings {
  @doc("The value indicating whether to suspend duplicate message.")
  suspendDuplicateMessage: boolean;

  @doc("The value indicating whether to resend message If MDN is not received.")
  resendIfMdnNotReceived: boolean;
}

@doc("The X12 agreement content.")
model X12AgreementContent {
  @doc("The X12 one-way receive agreement.")
  receiveAgreement: X12OneWayAgreement;

  @doc("The X12 one-way send agreement.")
  sendAgreement: X12OneWayAgreement;
}

@doc("The X12 one-way agreement.")
model X12OneWayAgreement {
  @doc("The sender business identity")
  senderBusinessIdentity: BusinessIdentity;

  @doc("The receiver business identity")
  receiverBusinessIdentity: BusinessIdentity;

  @doc("The X12 protocol settings.")
  protocolSettings: X12ProtocolSettings;
}

@doc("The X12 agreement protocol settings.")
model X12ProtocolSettings {
  @doc("The X12 validation settings.")
  validationSettings: X12ValidationSettings;

  @doc("The X12 framing settings.")
  framingSettings: X12FramingSettings;

  @doc("The X12 envelope settings.")
  envelopeSettings: X12EnvelopeSettings;

  @doc("The X12 acknowledgment settings.")
  acknowledgementSettings: X12AcknowledgementSettings;

  @doc("The X12 message filter.")
  messageFilter: X12MessageFilter;

  @doc("The X12 security settings.")
  securitySettings: X12SecuritySettings;

  @doc("The X12 processing settings.")
  processingSettings: X12ProcessingSettings;

  @doc("The X12 envelope override settings.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  envelopeOverrides?: X12EnvelopeOverride[];

  @doc("The X12 validation override settings.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  validationOverrides?: X12ValidationOverride[];

  @doc("The X12 message filter list.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  messageFilterList?: X12MessageIdentifier[];

  @doc("The X12 schema references.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  schemaReferences: X12SchemaReference[];

  @doc("The X12 delimiter override settings.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  x12DelimiterOverrides?: X12DelimiterOverrides[];
}

@doc("The X12 agreement validation settings.")
model X12ValidationSettings {
  @doc("The value indicating whether to validate character set in the message.")
  validateCharacterSet: boolean;

  @doc("The value indicating whether to check for duplicate interchange control number.")
  checkDuplicateInterchangeControlNumber: boolean;

  @doc("The validity period of interchange control number.")
  interchangeControlNumberValidityDays: int32;

  @doc("The value indicating whether to check for duplicate group control number.")
  checkDuplicateGroupControlNumber: boolean;

  @doc("The value indicating whether to check for duplicate transaction set control number.")
  checkDuplicateTransactionSetControlNumber: boolean;

  @doc("The value indicating whether to Whether to validate EDI types.")
  validateEdiTypes: boolean;

  @doc("The value indicating whether to Whether to validate XSD types.")
  validateXsdTypes: boolean;

  @doc("The value indicating whether to allow leading and trailing spaces and zeroes.")
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The value indicating whether to trim leading and trailing spaces and zeroes.")
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The trailing separator policy.")
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

@doc("The X12 agreement framing settings.")
model X12FramingSettings {
  @doc("The data element separator.")
  dataElementSeparator: int32;

  @doc("The component separator.")
  componentSeparator: int32;

  @doc("The value indicating whether to replace separators in payload.")
  replaceSeparatorsInPayload: boolean;

  @doc("The replacement character.")
  replaceCharacter: int32;

  @doc("The segment terminator.")
  segmentTerminator: int32;

  @doc("The X12 character set.")
  characterSet: X12CharacterSet;

  @doc("The segment terminator suffix.")
  segmentTerminatorSuffix: SegmentTerminatorSuffix;
}

@doc("The X12 agreement envelope settings.")
model X12EnvelopeSettings {
  @doc("The controls standards id.")
  controlStandardsId: int32;

  @doc("The value indicating whether to use control standards id as repetition character.")
  useControlStandardsIdAsRepetitionCharacter: boolean;

  @doc("The sender application id.")
  senderApplicationId: string;

  @doc("The receiver application id.")
  receiverApplicationId: string;

  @doc("The control version number.")
  controlVersionNumber: string;

  @doc("The interchange  control number lower bound.")
  interchangeControlNumberLowerBound: int32;

  @doc("The interchange  control number upper bound.")
  interchangeControlNumberUpperBound: int32;

  @doc("The value indicating whether to rollover interchange control number.")
  rolloverInterchangeControlNumber: boolean;

  @doc("The value indicating whether to enable default group headers.")
  enableDefaultGroupHeaders: boolean;

  @doc("The functional group id.")
  functionalGroupId?: string;

  @doc("The group control number lower bound.")
  groupControlNumberLowerBound: int32;

  @doc("The group control number upper bound.")
  groupControlNumberUpperBound: int32;

  @doc("The value indicating whether to rollover group control number.")
  rolloverGroupControlNumber: boolean;

  @doc("The group header agency code.")
  groupHeaderAgencyCode: string;

  @doc("The group header version.")
  groupHeaderVersion: string;

  @doc("The transaction set control number lower bound.")
  transactionSetControlNumberLowerBound: int32;

  @doc("The transaction set control number upper bound.")
  transactionSetControlNumberUpperBound: int32;

  @doc("The value indicating whether to rollover transaction set control number.")
  rolloverTransactionSetControlNumber: boolean;

  @doc("The transaction set control number prefix.")
  transactionSetControlNumberPrefix?: string;

  @doc("The transaction set control number suffix.")
  transactionSetControlNumberSuffix?: string;

  @doc("The value indicating whether to overwrite existing transaction set control number.")
  overwriteExistingTransactionSetControlNumber: boolean;

  @doc("The group header date format.")
  groupHeaderDateFormat: X12DateFormat;

  @doc("The group header time format.")
  groupHeaderTimeFormat: X12TimeFormat;

  @doc("The usage indicator.")
  usageIndicator: UsageIndicator;
}

@doc("The X12 agreement acknowledgement settings.")
model X12AcknowledgementSettings {
  @doc("The value indicating whether technical acknowledgement is needed.")
  needTechnicalAcknowledgement: boolean;

  @doc("The value indicating whether to batch the technical acknowledgements.")
  batchTechnicalAcknowledgements: boolean;

  @doc("The value indicating whether functional acknowledgement is needed.")
  needFunctionalAcknowledgement: boolean;

  @doc("The functional acknowledgement version.")
  functionalAcknowledgementVersion?: string;

  @doc("The value indicating whether to batch functional acknowledgements.")
  batchFunctionalAcknowledgements: boolean;

  @doc("The value indicating whether implementation acknowledgement is needed.")
  needImplementationAcknowledgement: boolean;

  @doc("The implementation acknowledgement version.")
  implementationAcknowledgementVersion?: string;

  @doc("The value indicating whether to batch implementation acknowledgements.")
  batchImplementationAcknowledgements: boolean;

  @doc("The value indicating whether a loop is needed for valid messages.")
  needLoopForValidMessages: boolean;

  @doc("The value indicating whether to send synchronous acknowledgement.")
  sendSynchronousAcknowledgement: boolean;

  @doc("The acknowledgement control number prefix.")
  acknowledgementControlNumberPrefix?: string;

  @doc("The acknowledgement control number suffix.")
  acknowledgementControlNumberSuffix?: string;

  @doc("The acknowledgement control number lower bound.")
  acknowledgementControlNumberLowerBound: int32;

  @doc("The acknowledgement control number upper bound.")
  acknowledgementControlNumberUpperBound: int32;

  @doc("The value indicating whether to rollover acknowledgement control number.")
  rolloverAcknowledgementControlNumber: boolean;
}

@doc("The X12 message filter for odata query.")
model X12MessageFilter {
  @doc("The message filter type.")
  messageFilterType: MessageFilterType;
}

@doc("The X12 agreement security settings.")
model X12SecuritySettings {
  @doc("The authorization qualifier.")
  authorizationQualifier: string;

  @doc("The authorization value.")
  authorizationValue?: string;

  @doc("The security qualifier.")
  securityQualifier: string;

  @doc("The password value.")
  passwordValue?: string;
}

@doc("The X12 processing settings.")
model X12ProcessingSettings {
  @doc("The value indicating whether to mask security information.")
  maskSecurityInfo: boolean;

  @doc("The value indicating whether to convert numerical type to implied decimal.")
  convertImpliedDecimal: boolean;

  @doc("The value indicating whether to preserve interchange.")
  preserveInterchange: boolean;

  @doc("The value indicating whether to suspend interchange on error.")
  suspendInterchangeOnError: boolean;

  @doc("The value indicating whether to create empty xml tags for trailing separators.")
  createEmptyXmlTagsForTrailingSeparators: boolean;

  @doc("The value indicating whether to use dot as decimal separator.")
  useDotAsDecimalSeparator: boolean;
}

@doc("The X12 envelope override settings.")
model X12EnvelopeOverride {
  @doc("The target namespace on which this envelope settings has to be applied.")
  targetNamespace: string;

  @doc("The protocol version on which this envelope settings has to be applied.")
  protocolVersion: string;

  @doc("The message id on which this envelope settings has to be applied.")
  messageId: string;

  @doc("The responsible agency code.")
  responsibleAgencyCode: string;

  @doc("The header version.")
  headerVersion: string;

  @doc("The sender application id.")
  senderApplicationId: string;

  @doc("The receiver application id.")
  receiverApplicationId: string;

  @doc("The functional identifier code.")
  functionalIdentifierCode?: string;

  @doc("The date format.")
  dateFormat: X12DateFormat;

  @doc("The time format.")
  timeFormat: X12TimeFormat;
}

@doc("The X12 validation override settings.")
model X12ValidationOverride {
  @doc("The message id on which the validation settings has to be applied.")
  messageId: string;

  @doc("The value indicating whether to validate EDI types.")
  validateEdiTypes: boolean;

  @doc("The value indicating whether to validate XSD types.")
  validateXsdTypes: boolean;

  @doc("The value indicating whether to allow leading and trailing spaces and zeroes.")
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The value indicating whether to validate character Set.")
  validateCharacterSet: boolean;

  @doc("The value indicating whether to trim leading and trailing spaces and zeroes.")
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The trailing separator policy.")
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

@doc("The X12 message identifier.")
model X12MessageIdentifier {
  @doc("The message id.")
  messageId: string;
}

@doc("The X12 schema reference.")
model X12SchemaReference {
  @doc("The message id.")
  messageId: string;

  @doc("The sender application id.")
  senderApplicationId?: string;

  @doc("The schema version.")
  schemaVersion: string;

  @doc("The schema name.")
  schemaName: string;
}

@doc("The X12 delimiter override settings.")
model X12DelimiterOverrides {
  @doc("The protocol version.")
  protocolVersion?: string;

  @doc("The message id.")
  messageId?: string;

  @doc("The data element separator.")
  dataElementSeparator: int32;

  @doc("The component separator.")
  componentSeparator: int32;

  @doc("The segment terminator.")
  segmentTerminator: int32;

  @doc("The segment terminator suffix.")
  segmentTerminatorSuffix: SegmentTerminatorSuffix;

  @doc("The replacement character.")
  replaceCharacter: int32;

  @doc("The value indicating whether to replace separators in payload.")
  replaceSeparatorsInPayload: boolean;

  @doc("The target namespace on which this delimiter settings has to be applied.")
  targetNamespace?: string;
}

@doc("The Edifact agreement content.")
model EdifactAgreementContent {
  @doc("The EDIFACT one-way receive agreement.")
  receiveAgreement: EdifactOneWayAgreement;

  @doc("The EDIFACT one-way send agreement.")
  sendAgreement: EdifactOneWayAgreement;
}

@doc("The Edifact one way agreement.")
model EdifactOneWayAgreement {
  @doc("The sender business identity")
  senderBusinessIdentity: BusinessIdentity;

  @doc("The receiver business identity")
  receiverBusinessIdentity: BusinessIdentity;

  @doc("The EDIFACT protocol settings.")
  protocolSettings: EdifactProtocolSettings;
}

@doc("The Edifact agreement protocol settings.")
model EdifactProtocolSettings {
  @doc("The EDIFACT validation settings.")
  validationSettings: EdifactValidationSettings;

  @doc("The EDIFACT framing settings.")
  framingSettings: EdifactFramingSettings;

  @doc("The EDIFACT envelope settings.")
  envelopeSettings: EdifactEnvelopeSettings;

  @doc("The EDIFACT acknowledgement settings.")
  acknowledgementSettings: EdifactAcknowledgementSettings;

  @doc("The EDIFACT message filter.")
  messageFilter: EdifactMessageFilter;

  @doc("The EDIFACT processing Settings.")
  processingSettings: EdifactProcessingSettings;

  @doc("The EDIFACT envelope override settings.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  envelopeOverrides?: EdifactEnvelopeOverride[];

  @doc("The EDIFACT message filter list.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  messageFilterList?: EdifactMessageIdentifier[];

  @doc("The EDIFACT schema references.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  schemaReferences: EdifactSchemaReference[];

  @doc("The EDIFACT validation override settings.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  validationOverrides?: EdifactValidationOverride[];

  @doc("The EDIFACT delimiter override settings.")
  @OpenAPI.extension("x-ms-identifiers", #["messageId"])
  edifactDelimiterOverrides?: EdifactDelimiterOverride[];
}

@doc("The Edifact agreement validation settings.")
model EdifactValidationSettings {
  @doc("The value indicating whether to validate character set in the message.")
  validateCharacterSet: boolean;

  @doc("The value indicating whether to check for duplicate interchange control number.")
  checkDuplicateInterchangeControlNumber: boolean;

  @doc("The validity period of interchange control number.")
  interchangeControlNumberValidityDays: int32;

  @doc("The value indicating whether to check for duplicate group control number.")
  checkDuplicateGroupControlNumber: boolean;

  @doc("The value indicating whether to check for duplicate transaction set control number.")
  checkDuplicateTransactionSetControlNumber: boolean;

  @doc("The value indicating whether to Whether to validate EDI types.")
  validateEdiTypes: boolean;

  @doc("The value indicating whether to Whether to validate XSD types.")
  validateXsdTypes: boolean;

  @doc("The value indicating whether to allow leading and trailing spaces and zeroes.")
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The value indicating whether to trim leading and trailing spaces and zeroes.")
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The trailing separator policy.")
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

@doc("The Edifact agreement framing settings.")
model EdifactFramingSettings {
  @doc("The service code list directory version.")
  serviceCodeListDirectoryVersion?: string;

  @doc("The character encoding.")
  characterEncoding?: string;

  @doc("The protocol version.")
  protocolVersion: int32;

  @doc("The data element separator.")
  dataElementSeparator: int32;

  @doc("The component separator.")
  componentSeparator: int32;

  @doc("The segment terminator.")
  segmentTerminator: int32;

  @doc("The release indicator.")
  releaseIndicator: int32;

  @doc("The repetition separator.")
  repetitionSeparator: int32;

  @doc("The EDIFACT frame setting characterSet.")
  characterSet: EdifactCharacterSet;

  @doc("The EDIFACT frame setting decimal indicator.")
  decimalPointIndicator: EdifactDecimalIndicator;

  @doc("The EDIFACT frame setting segment terminator suffix.")
  segmentTerminatorSuffix: SegmentTerminatorSuffix;
}

@doc("The Edifact agreement envelope settings.")
model EdifactEnvelopeSettings {
  @doc("The group association assigned code.")
  groupAssociationAssignedCode?: string;

  @doc("The communication agreement id.")
  communicationAgreementId?: string;

  @doc("The value indicating whether to apply delimiter string advice.")
  applyDelimiterStringAdvice: boolean;

  @doc("The value indicating whether to create grouping segments.")
  createGroupingSegments: boolean;

  @doc("The value indicating whether to enable default group headers.")
  enableDefaultGroupHeaders: boolean;

  @doc("The recipient reference password value.")
  recipientReferencePasswordValue?: string;

  @doc("The recipient reference password qualifier.")
  recipientReferencePasswordQualifier?: string;

  @doc("The application reference id.")
  applicationReferenceId?: string;

  @doc("The processing priority code.")
  processingPriorityCode?: string;

  @doc("The interchange control number lower bound.")
  interchangeControlNumberLowerBound: int64;

  @doc("The interchange control number upper bound.")
  interchangeControlNumberUpperBound: int64;

  @doc("The value indicating whether to rollover interchange control number.")
  rolloverInterchangeControlNumber: boolean;

  @doc("The interchange control number prefix.")
  interchangeControlNumberPrefix?: string;

  @doc("The interchange control number suffix.")
  interchangeControlNumberSuffix?: string;

  @doc("The sender reverse routing address.")
  senderReverseRoutingAddress?: string;

  @doc("The receiver reverse routing address.")
  receiverReverseRoutingAddress?: string;

  @doc("The functional group id.")
  functionalGroupId?: string;

  @doc("The group controlling agency code.")
  groupControllingAgencyCode?: string;

  @doc("The group message version.")
  groupMessageVersion?: string;

  @doc("The group message release.")
  groupMessageRelease?: string;

  @doc("The group control number lower bound.")
  groupControlNumberLowerBound: int64;

  @doc("The group control number upper bound.")
  groupControlNumberUpperBound: int64;

  @doc("The value indicating whether to rollover group control number.")
  rolloverGroupControlNumber: boolean;

  @doc("The group control number prefix.")
  groupControlNumberPrefix?: string;

  @doc("The group control number suffix.")
  groupControlNumberSuffix?: string;

  @doc("The group application receiver qualifier.")
  groupApplicationReceiverQualifier?: string;

  @doc("The group application receiver id.")
  groupApplicationReceiverId?: string;

  @doc("The group application sender qualifier.")
  groupApplicationSenderQualifier?: string;

  @doc("The group application sender id.")
  groupApplicationSenderId?: string;

  @doc("The group application password.")
  groupApplicationPassword?: string;

  @doc("The value indicating whether to overwrite existing transaction set control number.")
  overwriteExistingTransactionSetControlNumber: boolean;

  @doc("The transaction set control number prefix.")
  transactionSetControlNumberPrefix?: string;

  @doc("The transaction set control number suffix.")
  transactionSetControlNumberSuffix?: string;

  @doc("The transaction set control number lower bound.")
  transactionSetControlNumberLowerBound: int64;

  @doc("The transaction set control number upper bound.")
  transactionSetControlNumberUpperBound: int64;

  @doc("The value indicating whether to rollover transaction set control number.")
  rolloverTransactionSetControlNumber: boolean;

  @doc("The value indicating whether the message is a test interchange.")
  isTestInterchange: boolean;

  @doc("The sender internal identification.")
  senderInternalIdentification?: string;

  @doc("The sender internal sub identification.")
  senderInternalSubIdentification?: string;

  @doc("The receiver internal identification.")
  receiverInternalIdentification?: string;

  @doc("The receiver internal sub identification.")
  receiverInternalSubIdentification?: string;
}

@doc("The Edifact agreement acknowledgement settings.")
model EdifactAcknowledgementSettings {
  @doc("The value indicating whether technical acknowledgement is needed.")
  needTechnicalAcknowledgement: boolean;

  @doc("The value indicating whether to batch the technical acknowledgements.")
  batchTechnicalAcknowledgements: boolean;

  @doc("The value indicating whether functional acknowledgement is needed.")
  needFunctionalAcknowledgement: boolean;

  @doc("The value indicating whether to batch functional acknowledgements.")
  batchFunctionalAcknowledgements: boolean;

  @doc("The value indicating whether a loop is needed for valid messages.")
  needLoopForValidMessages: boolean;

  @doc("The value indicating whether to send synchronous acknowledgement.")
  sendSynchronousAcknowledgement: boolean;

  @doc("The acknowledgement control number prefix.")
  acknowledgementControlNumberPrefix?: string;

  @doc("The acknowledgement control number suffix.")
  acknowledgementControlNumberSuffix?: string;

  @doc("The acknowledgement control number lower bound.")
  acknowledgementControlNumberLowerBound: int32;

  @doc("The acknowledgement control number upper bound.")
  acknowledgementControlNumberUpperBound: int32;

  @doc("The value indicating whether to rollover acknowledgement control number.")
  rolloverAcknowledgementControlNumber: boolean;
}

@doc("The Edifact message filter for odata query.")
model EdifactMessageFilter {
  @doc("The message filter type.")
  messageFilterType: MessageFilterType;
}

@doc("The Edifact agreement protocol settings.")
model EdifactProcessingSettings {
  @doc("The value indicating whether to mask security information.")
  maskSecurityInfo: boolean;

  @doc("The value indicating whether to preserve interchange.")
  preserveInterchange: boolean;

  @doc("The value indicating whether to suspend interchange on error.")
  suspendInterchangeOnError: boolean;

  @doc("The value indicating whether to create empty xml tags for trailing separators.")
  createEmptyXmlTagsForTrailingSeparators: boolean;

  @doc("The value indicating whether to use dot as decimal separator.")
  useDotAsDecimalSeparator: boolean;
}

@doc("The Edifact envelope override settings.")
model EdifactEnvelopeOverride {
  @doc("The message id on which this envelope settings has to be applied.")
  messageId?: string;

  @doc("The message version on which this envelope settings has to be applied.")
  messageVersion?: string;

  @doc("The message release version on which this envelope settings has to be applied.")
  messageRelease?: string;

  @doc("The message association assigned code.")
  messageAssociationAssignedCode?: string;

  @doc("The target namespace on which this envelope settings has to be applied.")
  targetNamespace?: string;

  @doc("The functional group id.")
  functionalGroupId?: string;

  @doc("The sender application qualifier.")
  senderApplicationQualifier?: string;

  @doc("The sender application id.")
  senderApplicationId?: string;

  @doc("The receiver application qualifier.")
  receiverApplicationQualifier?: string;

  @doc("The receiver application id.")
  receiverApplicationId?: string;

  @doc("The controlling agency code.")
  controllingAgencyCode?: string;

  @doc("The group header message version.")
  groupHeaderMessageVersion?: string;

  @doc("The group header message release.")
  groupHeaderMessageRelease?: string;

  @doc("The association assigned code.")
  associationAssignedCode?: string;

  @doc("The application password.")
  applicationPassword?: string;
}

@doc("The Edifact message identifier.")
model EdifactMessageIdentifier {
  @doc("The message id on which this envelope settings has to be applied.")
  messageId: string;
}

@doc("The Edifact schema reference.")
model EdifactSchemaReference {
  @doc("The message id.")
  messageId: string;

  @doc("The message version.")
  messageVersion: string;

  @doc("The message release version.")
  messageRelease: string;

  @doc("The sender application id.")
  senderApplicationId?: string;

  @doc("The sender application qualifier.")
  senderApplicationQualifier?: string;

  @doc("The association assigned code.")
  associationAssignedCode?: string;

  @doc("The schema name.")
  schemaName: string;
}

@doc("The Edifact validation override settings.")
model EdifactValidationOverride {
  @doc("The message id on which the validation settings has to be applied.")
  messageId: string;

  @doc("The value indicating whether to validate character Set.")
  enforceCharacterSet: boolean;

  @doc("The value indicating whether to validate EDI types.")
  validateEdiTypes: boolean;

  @doc("The value indicating whether to validate XSD types.")
  validateXsdTypes: boolean;

  @doc("The value indicating whether to allow leading and trailing spaces and zeroes.")
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  @doc("The trailing separator policy.")
  trailingSeparatorPolicy: TrailingSeparatorPolicy;

  @doc("The value indicating whether to trim leading and trailing spaces and zeroes.")
  trimLeadingAndTrailingSpacesAndZeroes: boolean;
}

@doc("The Edifact delimiter override settings.")
model EdifactDelimiterOverride {
  @doc("The message id.")
  messageId?: string;

  @doc("The message version.")
  messageVersion?: string;

  @doc("The message release.")
  messageRelease?: string;

  @doc("The data element separator.")
  dataElementSeparator: int32;

  @doc("The component separator.")
  componentSeparator: int32;

  @doc("The segment terminator.")
  segmentTerminator: int32;

  @doc("The repetition separator.")
  repetitionSeparator: int32;

  @doc("The segment terminator suffix.")
  segmentTerminatorSuffix: SegmentTerminatorSuffix;

  @doc("The decimal point indicator.")
  decimalPointIndicator: EdifactDecimalIndicator;

  @doc("The release indicator.")
  releaseIndicator: int32;

  @doc("The message association assigned code.")
  messageAssociationAssignedCode?: string;

  @doc("The target namespace on which this delimiter settings has to be applied.")
  targetNamespace?: string;
}

@doc("The integration account certificate properties.")
model IntegrationAccountCertificateProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The metadata.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<unknown>;

  @doc("The key details in the key vault.")
  key?: KeyVaultKeyReference;

  @doc("The public certificate.")
  publicCertificate?: string;
}

@doc("The reference to the key vault key.")
model KeyVaultKeyReference {
  @doc("The key vault reference.")
  keyVault: KeyVaultKeyReferenceKeyVault;

  @doc("The private key name in key vault.")
  keyName: string;

  @doc("The private key version in key vault.")
  keyVersion?: string;
}

@doc("The key vault reference.")
model KeyVaultKeyReferenceKeyVault {
  @doc("The resource id.")
  id?: string;

  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The resource type.")
  @visibility(Lifecycle.Read)
  type?: string;
}

@doc("The integration account session properties.")
model IntegrationAccountSessionProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The created time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("The changed time.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  @doc("The session content.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  content?: Record<unknown>;
}

@doc("The integration service environment properties.")
model IntegrationServiceEnvironmentProperties {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The integration service environment state.")
  state?: WorkflowState;

  @doc("Gets the tracking id.")
  integrationServiceEnvironmentId?: string;

  @doc("The endpoints configuration.")
  endpointsConfiguration?: FlowEndpointsConfiguration;

  @doc("The network configuration.")
  networkConfiguration?: NetworkConfiguration;

  @doc("The encryption configuration.")
  encryptionConfiguration?: IntegrationServiceEnvironmenEncryptionConfiguration;
}

@doc("The network configuration.")
model NetworkConfiguration {
  @doc("Gets the virtual network address space.")
  virtualNetworkAddressSpace?: string;

  @doc("The access endpoint.")
  accessEndpoint?: IntegrationServiceEnvironmentAccessEndpoint;

  @doc("The subnets.")
  subnets?: ResourceReference[];
}

@doc("The integration service environment access endpoint.")
model IntegrationServiceEnvironmentAccessEndpoint {
  @doc("The access endpoint type.")
  type?: IntegrationServiceEnvironmentAccessEndpointType;
}

@doc("The encryption configuration for the integration service environment.")
model IntegrationServiceEnvironmenEncryptionConfiguration {
  @doc("The encryption key reference.")
  encryptionKeyReference?: IntegrationServiceEnvironmenEncryptionKeyReference;
}

@doc("The encryption key details for the integration service environment.")
model IntegrationServiceEnvironmenEncryptionKeyReference {
  @doc("The key vault reference.")
  keyVault?: ResourceReference;

  @doc("Gets the key name in the Key Vault.")
  keyName?: string;

  @doc("Gets the version of the key specified in the keyName property.")
  keyVersion?: string;
}

@doc("The integration service environment sku.")
model IntegrationServiceEnvironmentSku {
  @doc("The sku name.")
  name?: IntegrationServiceEnvironmentSkuName;

  @doc("The sku capacity.")
  capacity?: int32;
}

@doc("The list of integration service environment skus.")
model IntegrationServiceEnvironmentSkuList
  is Azure.Core.Page<IntegrationServiceEnvironmentSkuDefinition>;

@doc("The integration service environment sku definition.")
model IntegrationServiceEnvironmentSkuDefinition {
  @doc("The resource type.")
  resourceType?: string;

  @doc("The sku.")
  sku?: IntegrationServiceEnvironmentSkuDefinitionSku;

  @doc("The sku capacity.")
  capacity?: IntegrationServiceEnvironmentSkuCapacity;
}

@doc("The sku.")
model IntegrationServiceEnvironmentSkuDefinitionSku {
  @doc("The sku name.")
  name?: IntegrationServiceEnvironmentSkuName;

  @doc("The sku tier.")
  tier?: string;
}

@doc("The integration service environment sku capacity.")
model IntegrationServiceEnvironmentSkuCapacity {
  @doc("The minimum capacity.")
  minimum?: int32;

  @doc("The maximum capacity.")
  maximum?: int32;

  @doc("The default capacity.")
  default?: int32;

  @doc("The sku scale type.")
  scaleType?: IntegrationServiceEnvironmentSkuScaleType;
}

@doc("The integration service environment network health.")
model IntegrationServiceEnvironmentNetworkHealth {
  @doc("The outbound network dependencies.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  outboundNetworkDependencies?: IntegrationServiceEnvironmentNetworkDependency[];
}

@doc("The integration service environment subnet network health.")
model IntegrationServiceEnvironmentSubnetNetworkHealth {
  @doc("The outbound network dependencies.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  outboundNetworkDependencies?: IntegrationServiceEnvironmentNetworkDependency[];

  @doc("The integration service environment network health.")
  outboundNetworkHealth?: IntegrationServiceEnvironmentNetworkDependencyHealth;

  @doc("The integration service environment network health state.")
  networkDependencyHealthState: IntegrationServiceEnvironmentNetworkEndPointAccessibilityState;
}

@doc("The azure async operation resource.")
model IntegrationServiceEnvironmentNetworkDependency {
  @doc("The network dependency category type.")
  category?: IntegrationServiceEnvironmentNetworkDependencyCategoryType;

  @doc("The display name.")
  displayName?: string;

  @doc("The endpoints.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: IntegrationServiceEnvironmentNetworkEndpoint[];
}

@doc("The network endpoint.")
model IntegrationServiceEnvironmentNetworkEndpoint {
  @doc("The accessibility state.")
  accessibility?: IntegrationServiceEnvironmentNetworkEndPointAccessibilityState;

  @doc("The domain name.")
  domainName?: string;

  @doc("The ports.")
  ports?: string[];
}

@doc("The integration service environment subnet network health.")
model IntegrationServiceEnvironmentNetworkDependencyHealth {
  @doc("The error if any occurred during the operation.")
  error?: ExtendedErrorInfo;

  @doc("The network dependency health state.")
  state?: IntegrationServiceEnvironmentNetworkDependencyHealthState;
}

@doc("The extended error info.")
model ExtendedErrorInfo {
  @doc("The error code.")
  code: ErrorResponseCode;

  @doc("The error message.")
  message: string;

  @doc("The error message details.")
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: ExtendedErrorInfo[];

  @doc("The inner error.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  // FIXME: use built in arm error
  innerError?: Record<unknown>;
}

@doc("The integration service environment managed api properties.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IntegrationServiceEnvironmentManagedApiProperties
  extends ApiResourceProperties {
  @doc("The integration service environment managed api deployment parameters.")
  deploymentParameters?: IntegrationServiceEnvironmentManagedApiDeploymentParameters;
}

@doc("The integration service environment managed api deployment parameters.")
model IntegrationServiceEnvironmentManagedApiDeploymentParameters {
  @doc("The integration service environment managed api content link for deployment.")
  contentLinkDefinition?: ContentLink;
}

@doc("The API resource properties.")
model ApiResourceProperties {
  @doc("The connection parameters.")
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  connectionParameters?: Record<Record<unknown>>;

  @doc("The metadata.")
  @visibility(Lifecycle.Read)
  metadata?: ApiResourceMetadata;

  @doc("The runtime urls.")
  @visibility(Lifecycle.Read)
  runtimeUrls?: string[];

  @doc("The api general information.")
  @visibility(Lifecycle.Read)
  generalInformation?: ApiResourceGeneralInformation;

  @doc("The capabilities.")
  @visibility(Lifecycle.Read)
  capabilities?: string[];

  @doc("The backend service.")
  @visibility(Lifecycle.Read)
  backendService?: ApiResourceBackendService;

  @doc("The policies for the API.")
  @visibility(Lifecycle.Read)
  policies?: ApiResourcePolicies;

  @doc("The API definition.")
  @visibility(Lifecycle.Read)
  apiDefinitionUrl?: string;

  @doc("The api definitions.")
  @visibility(Lifecycle.Read)
  apiDefinitions?: ApiResourceDefinitions;

  @doc("The integration service environment reference.")
  integrationServiceEnvironment?: ResourceReference;

  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The category.")
  @visibility(Lifecycle.Read)
  category?: ApiTier;
}

@doc("The api resource metadata.")
model ApiResourceMetadata {
  @doc("The source.")
  source?: string;

  @doc("The brand color.")
  brandColor?: string;

  @doc("The hide key.")
  hideKey?: string;

  @doc("The tags.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  @doc("The api type.")
  apiType?: ApiType;

  @doc("The WSDL service.")
  wsdlService?: WsdlService;

  @doc("The WSDL import method.")
  wsdlImportMethod?: WsdlImportMethod;

  @doc("The connection type.")
  connectionType?: string;

  @doc("The provisioning state.")
  provisioningState?: WorkflowProvisioningState;

  @doc("The connector deployment parameters metadata.")
  deploymentParameters?: ApiDeploymentParameterMetadataSet;
}

@doc("The WSDL service.")
model WsdlService {
  @doc("The qualified name.")
  qualifiedName?: string;

  @doc("The list of endpoints' qualified names.")
  endpointQualifiedNames?: string[];
}

@doc("The API deployment parameters metadata.")
model ApiDeploymentParameterMetadataSet {
  @doc("The package content link parameter.")
  packageContentLink?: ApiDeploymentParameterMetadata;

  @doc("The package content link parameter.")
  redisCacheConnectionString?: ApiDeploymentParameterMetadata;
}

@doc("The API deployment parameter metadata.")
model ApiDeploymentParameterMetadata {
  @doc("The type.")
  type?: string;

  @doc("Indicates whether its required.")
  isRequired?: boolean;

  @doc("The display name.")
  displayName?: string;

  @doc("The description.")
  description?: string;

  @doc("The visibility.")
  visibility?: ApiDeploymentParameterVisibility;
}

@doc("The API general information.")
model ApiResourceGeneralInformation {
  @doc("The icon url.")
  iconUrl?: string;

  @doc("The display name.")
  displayName?: string;

  @doc("The description.")
  description?: string;

  @doc("The terms of use url.")
  termsOfUseUrl?: string;

  @doc("The release tag.")
  releaseTag?: string;

  @doc("The tier.")
  tier?: ApiTier;
}

@doc("The API backend service.")
model ApiResourceBackendService {
  @doc("The service URL.")
  serviceUrl?: string;
}

@doc("The API resource policies.")
model ApiResourcePolicies {
  @doc("The API level only policies XML as embedded content.")
  content?: string;

  @doc("The content link to the policies.")
  contentLink?: string;
}

@doc("The Api resource definition.")
model ApiResourceDefinitions {
  @doc("The original swagger url.")
  originalSwaggerUrl?: string;

  @doc("The modified swagger url.")
  modifiedSwaggerUrl?: string;
}

// /**
//  * The api operation.
//  */
// #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
// model ApiOperation2 extends Azure.ResourceManager.ProxyResource<ApiOperationPropertiesDefinition> {
//   /**
//    * The api operations properties
//    */
//   properties?: ApiOperationPropertiesDefinition;
// }

@doc("The api operations properties")
model ApiOperationPropertiesDefinition {
  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;
  
  @doc("The summary of the api operation.")
  summary?: string;

  @doc("The description of the api operation.")
  description?: string;

  @doc("The visibility of the api operation.")
  visibility?: string;

  @doc("The trigger type of api operation.")
  trigger?: string;

  @doc("The trigger hint for the api operation.")
  triggerHint?: string;

  @doc("Indicates whether the api operation is pageable.")
  pageable?: boolean;

  @doc("The annotation of api operation.")
  annotation?: ApiOperationAnnotation;

  @doc("The api reference.")
  api?: ApiReference;

  @doc("The operation inputs definition schema.")
  inputsDefinition?: SwaggerSchema;

  @doc("The operation responses definition schemas.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  responsesDefinition?: Record<SwaggerSchema>;

  @doc("Indicates whether the API operation is webhook or not.")
  isWebhook?: boolean;

  @doc("Indicates whether the API operation is notification or not.")
  isNotification?: boolean;
}

@doc("The Api Operation Annotation.")
model ApiOperationAnnotation {
  @doc("The status annotation.")
  status?: StatusAnnotation;

  @doc("The family.")
  family?: string;

  @doc("The revision.")
  revision?: int32;
}

@doc("The Api reference.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApiReference extends ResourceReference {
  @doc("The display name of the api.")
  displayName?: string;

  @doc("The description of the api.")
  description?: string;

  @doc("The icon uri of the api.")
  iconUri?: string;

  @doc("The swagger of the api.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  swagger?: Record<unknown>;

  @doc("The brand color of the api.")
  brandColor?: string;

  @doc("The tier.")
  category?: ApiTier;

  @doc("The integration service environment reference.")
  integrationServiceEnvironment?: ResourceReference;
}

@doc("The swagger schema.")
model SwaggerSchema {
  @doc("The reference.")
  ref?: string;

  @doc("The type")
  type?: SwaggerSchemaType;

  @doc("The title.")
  title?: string;

  @doc("The items schema.")
  items?: SwaggerSchema;

  @doc("The object properties")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<SwaggerSchema>;

  @doc("The additional properties.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  additionalProperties?: Record<unknown>;

  @doc("The object required properties.")
  required?: string[];

  @doc("The maximum number of allowed properties.")
  maxProperties?: int32;

  @doc("The minimum number of allowed properties.")
  minProperties?: int32;

  @doc("The schemas which must pass validation when this schema is used.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  allOf?: SwaggerSchema[];

  @doc("The discriminator.")
  discriminator?: string;

  @doc("Indicates whether this property must be present in the a request.")
  readOnly?: boolean;

  @doc("The xml representation format for a property.")
  xml?: SwaggerXml;

  @doc("The external documentation.")
  externalDocs?: SwaggerExternalDocumentation;

  @doc("The example value.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  example?: Record<unknown>;

  @doc("Indicates the notification url extension. If this is set, the property's value should be a callback url for a webhook.")
  notificationUrlExtension?: boolean;

  @doc("The dynamic schema configuration.")
  dynamicSchemaOld?: SwaggerCustomDynamicSchema;

  @doc("The dynamic schema configuration.")
  dynamicSchemaNew?: SwaggerCustomDynamicProperties;

  @doc("The dynamic list.")
  dynamicListNew?: SwaggerCustomDynamicList;

  @doc("The dynamic values tree configuration.")
  dynamicTree?: SwaggerCustomDynamicTree;
}

@doc("The Swagger XML.")
model SwaggerXml {
  @doc("The xml element or attribute name.")
  name?: string;

  @doc("The xml namespace.")
  `namespace`?: string;

  @doc("The name prefix.")
  prefix?: string;

  @doc("Indicates whether the property should be an attribute instead of an element.")
  attribute?: boolean;

  @doc("Indicates whether the array elements are wrapped in a container element.")
  wrapped?: boolean;

  @doc("The vendor extensions.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extensions?: Record<Record<unknown>>;
}

@doc("The swagger external documentation")
model SwaggerExternalDocumentation {
  @doc("The document description.")
  description?: string;

  @doc("The documentation Uri.")
  uri?: string;

  @doc("The vendor extensions.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extensions?: Record<Record<unknown>>;
}

@doc("The swagger custom dynamic schema.")
model SwaggerCustomDynamicSchema {
  @doc("The operation id to fetch dynamic schema.")
  operationId?: string;

  @doc("Json pointer to the dynamic schema on the response body.")
  valuePath?: string;

  @doc("The operation parameters.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<Record<unknown>>;
}

@doc("The swagger custom dynamic properties.")
model SwaggerCustomDynamicProperties {
  @doc("The operation id to fetch dynamic schema.")
  operationId?: string;

  @doc("Json pointer to the dynamic schema on the response body.")
  valuePath?: string;

  @doc("The operation parameters.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<SwaggerCustomDynamicProperties>;
}

@doc("The swagger custom dynamic list.")
model SwaggerCustomDynamicList {
  @doc("The operation id to fetch dynamic schema.")
  operationId?: string;

  @doc("The built in operation.")
  builtInOperation?: string;

  @doc("The path to a response property (relative to the response object, not the response body) which contains an array of dynamic value items.")
  itemsPath?: string;

  @doc("The path to a property which defines the value which should be used.")
  itemValuePath?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemTitlePath?: string;

  @doc("The parameters.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<SwaggerCustomDynamicProperties>;
}

@doc("The swagger custom dynamic tree.")
model SwaggerCustomDynamicTree {
  @doc("The tree settings")
  settings?: SwaggerCustomDynamicTreeSettings;

  @doc("The tree on-open configuration")
  open?: SwaggerCustomDynamicTreeCommand;

  @doc("The tree on-browse configuration")
  browse?: SwaggerCustomDynamicTreeCommand;
}

@doc("The swagger custom dynamic tree settings.")
model SwaggerCustomDynamicTreeSettings {
  @doc("Indicates whether parent nodes can be selected.")
  canSelectParentNodes?: boolean;

  @doc("Indicates whether leaf nodes can be selected.")
  canSelectLeafNodes?: boolean;
}

@doc("The swagger tree command.")
model SwaggerCustomDynamicTreeCommand {
  @doc("The path to an item property which defines the display name of the item.")
  operationId?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemsPath?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemValuePath?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemTitlePath?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemFullTitlePath?: string;

  @doc("The path to an item property which defines the display name of the item.")
  itemIsParent?: string;

  @doc("The path to an item property which defines the display name of the item.")
  selectableFilter?: string;

  @doc("Dictionary of <SwaggerCustomDynamicTreeParameter>")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<SwaggerCustomDynamicTreeParameter>;
}

@doc("The swagger custom dynamic tree parameter.")
model SwaggerCustomDynamicTreeParameter {
  @doc("Gets or sets a path to a property in the currently selected item to pass as a value to a parameter for the given operation.")
  selectedItemValuePath?: string;

  @doc("The parameter value.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  value?: Record<unknown>;

  @doc("The parameter reference.")
  parameterReference?: string;

  @doc("Indicates whether the parameter is required.")
  required?: boolean;
}

@doc("The workflow filter.")
model WorkflowFilter {
  @doc("The state of workflows.")
  state?: WorkflowState;
}

@doc("The workflow trigger filter.")
model WorkflowTriggerFilter {
  @doc("The state of workflow trigger.")
  state?: WorkflowState;
}

@doc("The workflow trigger history filter.")
model WorkflowTriggerHistoryFilter {
  @doc("The status of workflow trigger history.")
  status?: WorkflowStatus;
}

@doc("The workflow run filter.")
model WorkflowRunFilter {
  @doc("The status of workflow run.")
  status?: WorkflowStatus;
}

@doc("The workflow run action filter.")
model WorkflowRunActionFilter {
  @doc("The status of workflow run action.")
  status?: WorkflowStatus;
}

@doc("The list of managed APIs.")
model ManagedApiListResult {
  @doc("The managed APIs.")
  value?: ManagedApi[];

  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

@doc("The managed api definition.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedApi extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("The api resource properties.")
  properties?: ApiResourceProperties;
}

@doc("The integration account schema filter for odata query.")
model IntegrationAccountSchemaFilter {
  @doc("The schema type of integration account schema.")
  schemaType: SchemaType;
}

@doc("The integration account map filter for odata query.")
model IntegrationAccountMapFilter {
  @doc("The map type of integration account map.")
  mapType: MapType;
}

@doc("The integration account partner filter for odata query.")
model IntegrationAccountPartnerFilter {
  @doc("The partner type of integration account partner.")
  partnerType: PartnerType;
}

@doc("The integration account agreement filter for odata query.")
model IntegrationAccountAgreementFilter {
  @doc("The agreement type of integration account agreement.")
  agreementType: AgreementType;
}

@doc("The integration account session filter.")
model IntegrationAccountSessionFilter {
  @doc("The changed time of integration account sessions.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime: utcDateTime;
}
