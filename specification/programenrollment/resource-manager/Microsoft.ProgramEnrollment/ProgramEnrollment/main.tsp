import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ProgramEnrollment")
@service(#{ title: "Microsoft.ProgramEnrollment" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ProgramEnrollment;

enum Versions {
  /** The 2026-08-10-preview API version. */
  @Azure.Core.previewVersion
  v2026_08_10_preview: "2026-08-10-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("An education program enrollment that groups Entra domains under a single sovereign/edu program scope.")
model EduEnrollment is ExtensionResource<EduEnrollmentProperties> {
  @doc("The name of the edu enrollment")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("enrollmentName")
  @segment("eduEnrollments")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",
}

@doc("The assessment state of a domain group.")
union DomainGroupState {
  string,

  @doc("Assessment is pending.")
  Pending: "Pending",

  @doc("Action is required to complete assessment.")
  ActionRequired: "ActionRequired",

  @doc("Assessment failed.")
  Failed: "Failed",

  @doc("Assessment succeeded.")
  Succeeded: "Succeeded",
}

@doc("A group of edu domains scoped to an Entra tenant.")
model DomainGroup {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The edu domain names in this group.")
  @minItems(1)
  domainNames: string[];

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The Entra tenant ID that owns these domains. Defaults to the caller's tenant if omitted.")
  tenantId?: Azure.Core.uuid;

  @visibility(Lifecycle.Read)
  @doc("The assessment state of this domain group.")
  state?: DomainGroupState;

  @visibility(Lifecycle.Read)
  @doc("Failure detail when state is Failed or ActionRequired. Omitted otherwise.")
  failureReason?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@doc("Details of the Program EduEnrollment.")
model EduEnrollmentProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The domain groups associated with this enrollment.")
  @minItems(1)
  @identifiers(#["tenantId"])
  domains: DomainGroup[];

  @visibility(Lifecycle.Read)
  @doc("Failure detail when provisioningState is Failed. Omitted otherwise.")
  failureReason?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

// EduEnrollment is modeled as a generic ARM extension resource. The public
// contract uses the `{resourceUri}` extension scope
// (`/{resourceUri}/providers/Microsoft.ProgramEnrollment/eduEnrollments/{enrollmentName}`),
// matching the ARM-approved Microsoft.BillingTrust precedent. At runtime the
// service constrains the scope to `Microsoft.Billing/billingAccounts/{name}`.
@armResourceOperations(EduEnrollment)
interface EduEnrollments {
  /** Gets the specified edu enrollment. */
  get is ArmResourceRead<EduEnrollment>;

  /** Creates or updates the specified edu enrollment. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EduEnrollment>;

  /** Deletes the specified edu enrollment. */
  delete is ArmResourceDeleteWithoutOkAsync<EduEnrollment>;

  /** Lists the edu enrollments for the specified scope. */
  list is ArmResourceListByParent<EduEnrollment>;
}
