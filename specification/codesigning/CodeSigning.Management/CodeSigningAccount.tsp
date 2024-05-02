import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CodeSigning;
@doc("Trusted signing account resource.")
model CodeSigningAccount is TrackedResource<CodeSigningAccountProperties> {
  @doc("Trusted Signing account name.")
  @pattern("^(?=.{3,24}$)[^0-9][A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("accountName")
  @segment("codeSigningAccounts")
  name: string;
}

@armResourceOperations
interface CodeSigningAccounts {
  @doc("Get a trusted Signing Account.")
  get is ArmResourceRead<CodeSigningAccount>;

  @doc("Create a trusted Signing Account.")
  create is ArmResourceCreateOrReplaceAsync<CodeSigningAccount>;

  @doc("Update a trusted signing account.")
  @parameterVisibility
  update is ArmCustomPatchAsync<CodeSigningAccount, CodeSigningAccountPatch>;

  @doc("Delete a trusted signing account.")
  delete is ArmResourceDeleteWithoutOkAsync<CodeSigningAccount>;

  @doc("Lists trusted signing accounts within a resource group.")
  listByResourceGroup is ArmResourceListByParent<CodeSigningAccount>;

  @doc("Lists trusted signing accounts within a subscription.")
  listBySubscription is ArmListBySubscription<CodeSigningAccount>;

  @doc("Checks that the trusted signing account name is valid and is not already in use.")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailability,
    CheckNameAvailabilityResult
  >;
}

@@doc(CodeSigningAccounts.create::parameters.resource,
  "Parameters to create the trusted signing account"
);
@@doc(CodeSigningAccounts.update::parameters.properties,
  "Parameters supplied to update the trusted signing account"
);
