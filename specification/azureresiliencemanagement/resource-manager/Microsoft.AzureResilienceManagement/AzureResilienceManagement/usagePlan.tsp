import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/usage/usagePlan.tsp";
import "./models/usage/enrollment.tsp";
import "./models/common/common.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_03_01_preview)
@armResourceOperations
interface UsagePlans {
  get is ArmResourceRead<UsagePlan>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<UsagePlan>;

  update is ArmTagsPatchAsync<UsagePlan>;

  delete is ArmResourceDeleteWithoutOkAsync<UsagePlan>;

  listByResourceGroup is ArmResourceListByParent<UsagePlan>;

  listBySubscription is ArmListBySubscription<UsagePlan>;
}

@added(Versions.v2026_03_01_preview)
@armResourceOperations
interface Enrollments {
  @doc("Get an Enrollment.")
  get is ArmResourceRead<Enrollment>;

  @doc("Create or update an Enrollment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Enrollment>;

  @doc("Delete an Enrollment.")
  delete is ArmResourceDeleteWithoutOkAsync<Enrollment>;

  @doc("List Enrollments by Usage Plan.")
  list is ArmResourceListByParent<Enrollment>;
}
