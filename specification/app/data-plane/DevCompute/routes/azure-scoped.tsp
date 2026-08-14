using Http;

namespace AzureDevCompute;

/** Azure-scoped Sandbox CRUD operations. */
@tag("Sandboxes")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
@useAuth(AzureDataPlaneS2SAuth)
interface AzureSandboxes {
  @get
  list is SandboxOperations.List<AzureResourceScope>;

  @put
  create is SandboxOperations.Create<AzureResourceScope>;

  @route("/{id}")
  @get
  get is SandboxOperations.Get<AzureResourceScope>;

  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<
    AzureResourceScope,
    SandboxOperations.AzureDeleteErrors
  >;
}
