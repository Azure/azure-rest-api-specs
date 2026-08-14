using Http;

namespace AzureDevCompute;

/** User-owned sandbox group route scope. */
model SandboxGroupScope {
  /** Sandbox group identifier. */
  @path sandboxGroupId: SandboxGroupId;
}

/** Default user-scoped Sandbox CRUD operations. */
@tag("Sandboxes")
@route("/sandboxes")
@useAuth(UserScopedAuth)
interface Sandboxes {
  @get
  list is SandboxOperations.List<{}>;

  @put
  create is SandboxOperations.Create<{}>;

  @route("/{id}")
  @get
  get is SandboxOperations.Get<{}>;

  @route("/{id}")
  @patch
  update is SandboxOperations.Update<{}>;

  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<{}, SandboxOperations.UserDeleteErrors>;
}

/** Explicit user sandbox-group CRUD operations. */
@tag("Sandboxes")
@route("/sandboxGroups/{sandboxGroupId}/sandboxes")
@useAuth(UserScopedAuth)
interface SandboxGroupSandboxes {
  @get
  list is SandboxOperations.List<SandboxGroupScope>;

  @route("/{id}")
  @get
  get is SandboxOperations.Get<SandboxGroupScope>;

  @route("/{id}")
  @patch
  update is SandboxOperations.Update<SandboxGroupScope>;

  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<
    SandboxGroupScope,
    SandboxOperations.UserDeleteErrors
  >;
}
