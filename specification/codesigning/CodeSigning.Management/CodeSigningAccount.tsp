import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CodeSigning;
@doc("Artifact signing account resource.")
model CodeSigningAccount is TrackedResource<CodeSigningAccountProperties> {
  @doc("Artifact Signing account name.")
  @pattern("^(?=.{3,24}$)[^0-9][A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("accountName")
  @segment("codeSigningAccounts")
  name: string;
}

@armResourceOperations
interface CodeSigningAccounts {
  @doc("Get an artifact Signing Account.")
  get is ArmResourceRead<CodeSigningAccount>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Create an artifact Signing Account.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    CodeSigningAccount,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Update an artifact signing account.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<CodeSigningAccount, CodeSigningAccountPatch>;

  @doc("Delete an artifact signing account.")
  delete is ArmResourceDeleteWithoutOkAsync<CodeSigningAccount>;

  @doc("Lists artifact signing accounts within a resource group.")
  listByResourceGroup is ArmResourceListByParent<CodeSigningAccount>;

  @doc("Lists artifact signing accounts within a subscription.")
  listBySubscription is ArmListBySubscription<CodeSigningAccount>;

  @doc("Checks if the artifact signing account name is valid and is not already in use.")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailability,
    CheckNameAvailabilityResult
  >;
}

@@doc(CodeSigningAccounts.create::parameters.resource,
  "Parameters to create the artifact signing account"
);
@@doc(CodeSigningAccounts.update::parameters.properties,
  "Parameters supplied to update the artifact signing account"
);
