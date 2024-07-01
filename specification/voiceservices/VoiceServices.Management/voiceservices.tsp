import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.VoiceServices")
@service({
  title: "Microsoft.VoiceServices",
})
@versioned(Versions)
namespace Microsoft.VoiceServices;

@doc("API Versions")
enum Versions {
  @doc("2023-01-31")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_01_31: "2023-01-31",

  @doc("2023-04-03")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_04_03: "2023-04-03",

  @doc("2023-07-13-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_07_13_preview: "2023-07-13-preview",

  @doc("2023-09-01")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_09_01: "2023-09-01",

  @doc("2023-09-21")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_09_21: "2023-09-21",

  @doc("2024-02-05-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_02_05_preview: "2024-02-05-preview",

  @doc("2024-02-16-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_02_16_preview: "2024-02-16-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

// Various tooling enforces (or at least suggests) that all models should have a provisioning State field, as this means something special to ARM.
// Needed to add this manually although it is available in azure tools node module
// because of bug https://github.com/Azure/typespec-azure-pr/issues/4152
@Azure.Core.lroStatus
@doc("The provisioning state of a resource type.")
union ResourceProvisioningState {
  string,

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",
}

//// Needed to remove this because of bug https://github.com/Azure/typespec-azure-pr/issues/4152
// @doc("Provisioning state of the resource.")
// union ProvisioningState {
//   string,
//   ResourceProvisioningState,
// }

@doc("General resource properties.")
model ResourceProperties {
  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

// A helper template for defining empty properties for resource PATCH operations
// In a future release this won't be necessary.
// See https://github.com/Azure/azure-rest-api-specs-pr/pull/8707#discussion_r971363996 for context
@doc("The type used for update operations of the {name}.", TResource)
@friendlyName("{name}Update", TResource)
model ResourceUpdateModelNoProperties<TResource extends {}>
  is OptionalProperties<UpdateableProperties<OmitProperties<
    TResource,
    "Name" | "name"
  >>>;

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-interface-requires-decorator" "Interface template does not require this."
#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-interface-uses-templates" "This is an official operations template."
@doc("Template for resources with no updateable properties")
@armResourceOperations
interface ResourceUpdateNoProperties<TResource extends Foundations.ArmResource> {
  @autoRoute
  @doc("Update a {name}", TResource)
  @armResourceUpdate(TResource)
  @patch
  update(
    ...ResourceInstanceParameters<TResource>,

    @doc("The resource properties to be updated.")
    @body
    properties: ResourceUpdateModelNoProperties<TResource>,
  ): ArmResponse<TResource> | ErrorResponse;
}

// These models and operation should be provided by the common TypeSpec infra, but the latest version of TypeSpec
// has a bug which gives Local Name Availability the wrong path.
// See https://github.com/Azure/typespec-azure/issues/3222

// For now, these definitions are reimplementations of the common types from:
// https://github.com/Azure/azure-rest-api-specs-pr/blob/66dc2c9a0243bc217a938583a53da052498ac39f/specification/common-types/resource-management/v3/types.json

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("Possible reasons for a name not being available.")
union CheckNameAvailabilityReason {
  string,

  @doc("Name not available if the name is invalid.")
  Invalid: "Invalid",

  @doc("Name not available if the name is already in use.")
  AlreadyExists: "AlreadyExists",
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is not available.")
  message?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "CheckNameAvailability is not supported by typespec-azure-resource-manager."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-uses-templates" "CheckNameAvailability is not supported by typespec-azure-resource-manager."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-missing-decorator" "CheckNameAvailability is not supported by typespec-azure-resource-manager."
interface NameAvailability {
  @doc("Check whether the resource name is available in the given region.")
  @armResourceAction(CheckNameAvailabilityRequest)
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.VoiceServices/locations/{location}/checkNameAvailability")
  checkLocal(
    @doc("The check availability request body.")
    @body
    body: CheckNameAvailabilityRequest,

    @doc("The location in which uniqueness will be verified.")
    @path
    location: string,

    ...SubscriptionIdParameter,
    ...ApiVersionParameter,
  ): CheckNameAvailabilityResponse | ErrorResponse;
}
