import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.AzureResilienceManagement;

/**
 * Model that represents the Fault Properties.
 */
@doc("Fault Properties")
model FaultProperties {
  @doc("Available faults for this resource.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  availableFaults: FaultDetails;

  @doc("Default fault provided by the system.")
  @visibility(Lifecycle.Read)
  defaultFault: FaultDetails;

  @doc("Override fault provided by the user.")
  overriddenDefaultFault?: FaultDetails;

  @doc("Custom Fault Details selected by user")
  customFault?: CustomFaultDetails;
}

/**
 * Model that represents the Fault Details.
 */
@doc("Fault Details")
model FaultDetails {
  @doc("fault urn.")
  @minLength(1)
  faultUrn: string;

  @doc("fault name")
  @minLength(1)
  @maxLength(100)
  faultName: string;
}

/**
 * Model that represents the Custom fault Details.
 */
@doc("Custom fault details")
model CustomFaultDetails {
  @doc("fault name")
  @minLength(3)
  @maxLength(100)
  faultName: string;

  @doc("ID of ARM resource used for automation (e.g. Automation runbook URL).")
  scriptResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Automation/automationAccounts";
    }
  ]>;
}

/**
 * Model that represents the Error seen during T&C, RBAC setup.
 */
@doc("Errors in T&C / RBAC assignment.")
model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Error message.")
  message: string;
}
