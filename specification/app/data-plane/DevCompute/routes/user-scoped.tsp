using Http;

namespace AzureDevCompute;

/** User-owned sandbox group route scope. */
model SandboxGroupScope {
  /** Sandbox group identifier. */
  @path sandboxGroupId: string;
}

/** Default user-scoped Sandbox CRUD operations. */
@tag("Sandboxes")
@route("/sandboxes")
@useAuth(UserScopedAuth)
interface Sandboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
  @get
  list is SandboxOperations.List<{}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceCreateOrReplace cannot preserve the existing SandboxRequest body, 201 response, and custom error status shapes without changing the established wire contract."
  @put
  create is SandboxOperations.Create<{}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing scoped id parameters and custom success/error response shapes without changing the established wire contract."
  @route("/{id}")
  @get
  get is SandboxOperations.Get<{}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceUpdate cannot preserve the existing PatchSandboxRequest body, custom scope parameters, and custom success/error response shapes without changing the established wire contract."
  @route("/{id}")
  @patch
  update is SandboxOperations.Update<{}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing empty 200 and 204 success responses or custom error status shapes without changing the established wire contract."
  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<{}, SandboxOperations.UserDeleteErrors>;
}

/** Explicit user sandbox-group CRUD operations. */
@tag("Sandboxes")
@route("/sandboxGroups/{sandboxGroupId}/sandboxes")
@useAuth(UserScopedAuth)
interface SandboxGroupSandboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
  @get
  list is SandboxOperations.List<SandboxGroupScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing scoped id parameters and custom success/error response shapes without changing the established wire contract."
  @route("/{id}")
  @get
  get is SandboxOperations.Get<SandboxGroupScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceUpdate cannot preserve the existing PatchSandboxRequest body, custom scope parameters, and custom success/error response shapes without changing the established wire contract."
  @route("/{id}")
  @patch
  update is SandboxOperations.Update<SandboxGroupScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing empty 200 and 204 success responses or custom error status shapes without changing the established wire contract."
  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<
    SandboxGroupScope,
    SandboxOperations.UserDeleteErrors
  >;
}
