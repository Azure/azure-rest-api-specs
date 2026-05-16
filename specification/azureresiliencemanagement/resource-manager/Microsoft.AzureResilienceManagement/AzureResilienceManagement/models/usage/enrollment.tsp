import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../common/common.tsp";
import "./usagePlan.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_03_01_preview)
@doc("Definition of enrollment properties.")
model EnrollmentProperties {
  @added(Versions.v2026_03_01_preview)
  @doc("ARM resource identifier of the service group associated with this usage plan.")
  serviceGroupId: armResourceIdentifier<[
    {
      type: "Microsoft.Management/serviceGroups";
    }
  ]>;

  @added(Versions.v2026_03_01_preview)
  @doc("Provisioning state of the enrollment.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Details of any errors encountered during Enrollment create or update.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@added(Versions.v2026_03_01_preview)
@parentResource(UsagePlan)
@doc("An enrollment that links a usage plan to a service group.")
model Enrollment is Azure.ResourceManager.ProxyResource<EnrollmentProperties> {
  @doc("The name of the enrollment.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("enrollmentName")
  @segment("enrollments")
  @path
  name: string;
}
