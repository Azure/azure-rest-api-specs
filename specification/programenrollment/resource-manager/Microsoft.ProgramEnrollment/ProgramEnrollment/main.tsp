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
  /** The 2026-03-01-preview API version. */
  @Azure.Core.previewVersion
  v2026_03_01_preview: "2026-03-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("An education program enrollment that groups Entra domains under a single sovereign/edu program scope.")
model EduEnrollment is TrackedResource<EduEnrollmentProperties> {
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

@doc("The type used for update operations of the EduEnrollment.")
model EduEnrollmentPatch {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "ARM tags are represented as a string map."
  @doc("Resource tags.")
  tags?: Record<string>;
}

@armResourceOperations(EduEnrollment)
interface EduEnrollments {
  /** Gets the specified edu enrollment. */
  get is ArmResourceRead<EduEnrollment>;

  /** Creates or updates the specified edu enrollment. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EduEnrollment>;

  /** Updates the specified edu enrollment. */
  update is ArmCustomPatchSync<EduEnrollment, EduEnrollmentPatch>;

  /** Deletes the specified edu enrollment. */
  delete is ArmResourceDeleteWithoutOkAsync<
    EduEnrollment,
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<EduEnrollment>,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = void> &
          ArmLroLocationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /** Lists the edu enrollments in a resource group. */
  listByResourceGroup is ArmResourceListByParent<EduEnrollment>;

  /** Lists the edu enrollments in a subscription. */
  listBySubscription is ArmListBySubscription<EduEnrollment>;
}
