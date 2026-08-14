using Http;

namespace AzureDevCompute;

/** Azure-scoped Sandbox CRUD operations. */
@tag("Sandboxes")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
@useAuth(AzureDataPlaneS2sAuth)
interface AzureSandboxes {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
  @get
  list is SandboxOperations.List<AzureResourceScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceCreateOrReplace cannot preserve the existing SandboxRequest body, 201 response, and custom error status shapes without changing the established wire contract."
  @put
  create is SandboxOperations.Create<AzureResourceScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing scoped id parameters and custom success/error response shapes without changing the established wire contract."
  @route("/{id}")
  @get
  get is SandboxOperations.Get<AzureResourceScope>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing empty 200 and 204 success responses or custom error status shapes without changing the established wire contract."
  @route("/{id}")
  @delete
  delete is SandboxOperations.Delete<
    AzureResourceScope,
    SandboxOperations.AzureDeleteErrors
  >;
}
