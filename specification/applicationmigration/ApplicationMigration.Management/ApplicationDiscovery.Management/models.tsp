import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./discoveryHub.tsp";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApplicationMigration;

/**
 * Model representing the properties of an application.
 */
model ApplicationProperties {
  @doc("The display name of the application.")
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "We are using the record datatype to represent the tags as it is not supported for proxy resources in ARM yet"
  @doc("The tags of the application.")
  tags?: Record<string>;

  @doc("The description of the application.")
  description?: string;

  @doc("The publisher of the application.")
  publisher?: string;

  @doc("The type of the application.")
  applicationType?: ApplicationType;

  @doc("The technology stack of the application.")
  technologyStack?: string[];

  @doc("The business criticality of the application.")
  businessCriticality?: BusinessCriticality;

  @doc("The complexity of the application.")
  complexity?: Complexity;

  @doc("The entity that manages the application.")
  @added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
  managedBy?: ManagedBy;

  @doc("The confidence score for the application (used in autoAppDiscovery).")
  @added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  confidenceScore?: float32;

  @doc("The provisioning status of Application.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model representing the properties of a member.
 */
model MemberProperties {
  @doc("The Azure resource id of the member.")
  memberResourceId: armResourceIdentifier;

  @doc("The provisioning status of Application.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The enum defining type of application.")
union ApplicationType {
  @doc("The application is a Commercial Off the Shelf application.")
  COTS: "COTS",

  @doc("The application is a custom developed application.")
  Custom: "Custom",

  string,
}

@doc("The enum defining the business criticality of the application.")
union BusinessCriticality {
  @doc("The application has low criticality for the business.")
  Low: "Low",

  @doc("The application has medium criticality for the business.")
  Medium: "Medium",

  @doc("The application is highly critical for the business.")
  High: "High",

  string,
}

@doc("The enum defining the complexity of the application.")
union Complexity {
  @doc("The application is simple, with minimal dependencies and straightforward functionality.")
  Low: "Low",

  @doc("The application has moderate interdependencies and requires some coordination between components.")
  Medium: "Medium",

  @doc("The application is intricate, with multiple interdependent components and complex interactions.")
  High: "High",

  string,
}

@doc("The enum defining the entity that manages the application.")
@added(Microsoft.ApplicationMigration.Versions.v2026_01_01_preview)
union ManagedBy {
  @doc("The application is managed by the system.")
  System: "System",

  @doc("The application is managed by a user.")
  User: "User",

  string,
}

@doc("Model representing the result of the fetch SAS URI operation.")
model FetchSasUriResult {
  @doc("The SAS URI to upload the import applications csv.")
  importApplicationsSasUri: string;

  @doc("The expiration time of the SAS uri.")
  expirationTime: utcDateTime;
}

@doc("Model representing the request to import applications.")
model ImportApplicationsRequest {
  @doc("The SAS URI of the CSV file to be imported.")
  importApplicationsSasUri: string;
}

@doc("Model representing the status of the import applications operation.")
model ImportApplicationsOperationStatusResult {
  @doc("The status url of the import applications operation.")
  id?: armResourceIdentifier;

  @doc("The resource name of the operation status")
  name?: string;

  @doc("The overall arm status of the operation. Has to have one of the following terminal states - Succeeded/Failed/Canceled.")
  status: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("Contains error details if status is Failed/Canceled.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;

  @doc("Additional properties applicable for import applications operation status result")
  properties?: ImportOperationStatusProperties;
}

@doc("Model representing the properties of the import operation status.")
model ImportOperationStatusProperties {
  @doc("Status of the import application request.")
  status?: ImportApplicationOperationStatus;

  @doc("The operation type of the import applications operation.")
  operationType: AppOperationType;

  @doc("The SAS URI of the Excel file containing the error data.")
  errorExcelSasUri?: url;

  @doc("The number of rows processed successfully.")
  @minValue(0)
  noOfRowsProcessed?: int32;

  @doc("The number of applications created successfully.")
  @minValue(0)
  noOfApplicationsCreated?: int32;
}

@doc("The operation type for import applications.")
union AppOperationType {
  string,

  @doc("The import applications operation type.")
  ImportApplications: "ImportApplications",
}

@doc("The status of the import operation.")
union ImportApplicationOperationStatus {
  string,

  @doc("The import operation status - Accepted.")
  Accepted: "Accepted",

  @doc("The import operation status - InProgress.")
  InProgress: "InProgress",

  @doc("The import operation status - Succeeded.")
  Succeeded: "Succeeded",

  @doc("The import operation status - PartiallySucceeded.")
  PartiallySucceeded: "PartiallySucceeded",

  @doc("The import operation status - Failed.")
  Failed: "Failed",

  @doc("The import operation status - Canceled.")
  Canceled: "Canceled",
}
