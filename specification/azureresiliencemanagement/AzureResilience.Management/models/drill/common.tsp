import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureResilienceManagement;

/**
 * Model that represents the Fault Properties.
 */
@doc("Fault Properties")
model FaultProperties {
  @identifiers(#[])
  @doc("Available faults for this resource.")
  @visibility(Lifecycle.Read)
  availableFaults?: FaultDetails[];

  @doc("Default fault provided by the system.")
  @visibility(Lifecycle.Read)
  defaultFault?: FaultDetails;

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

  @doc("ARMId of the target resource where fault will be applied. For non-NSG, same as ResourceId. For NSG, its the NSG resource and not the actual resource which is to be simulated for faulting.")
  targetResourceId: armResourceIdentifier;
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
