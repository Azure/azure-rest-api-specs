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
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "UsagePlans")
interface UsagePlansOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<UsagePlan>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<UsagePlan>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  update is ArmTagsPatchAsync<UsagePlan>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<UsagePlan>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  listByResourceGroup is ArmResourceListByParent<UsagePlan>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  listBySubscription is ArmListBySubscription<UsagePlan>;
}

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface UsagePlans {
  @sharedRoute
  get is ArmResourceRead<UsagePlan>;

  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<UsagePlan>;

  @sharedRoute
  update is ArmTagsPatchAsync<UsagePlan>;

  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<UsagePlan>;

  @sharedRoute
  listByResourceGroup is ArmResourceListByParent<UsagePlan>;

  @sharedRoute
  listBySubscription is ArmListBySubscription<UsagePlan>;
}

@added(Versions.v2026_03_01_preview)
@armResourceOperations
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "Enrollments")
interface EnrollmentsOld {
  @doc("Get an Enrollment.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<Enrollment>;

  @doc("Create or update an Enrollment.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Enrollment>;

  @doc("Delete an Enrollment.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Enrollment>;

  @doc("List Enrollments by Usage Plan.")
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<Enrollment>;
}

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface Enrollments {
  @doc("Get an Enrollment.")
  @sharedRoute
  get is ArmResourceRead<Enrollment>;

  @doc("Create or update an Enrollment.")
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Enrollment>;

  @doc("Delete an Enrollment.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Enrollment>;

  @doc("List Enrollments by Usage Plan.")
  @sharedRoute
  list is ArmResourceListByParent<Enrollment>;
}
