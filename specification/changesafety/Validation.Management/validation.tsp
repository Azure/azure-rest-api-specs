import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

model Validation is ProxyResource<ValidationProperties> {
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("validationName")
  @path
  @segment("validations")
  @visibility("read")
  @doc("The name of the validation.")
  name: string;
}

@armResourceOperations
interface Validations {
    @doc("Get the validation.")
    getValidations is ArmResourceRead<Validation>;

    @doc("Creates a validation.")
    createValidations is ArmResourceCreateOrReplaceAsync<Validation>;

    @doc("Validation can be re-run by doing a PUT operation with the same parameters. The output of the validation will be updated based on the new validation run.")
    updateValidations is ArmResourcePatchSync<Validation, ValidationProperties>;

    @doc("Deletes the validation.")
    deleteValidations is ArmResourceDeleteSync<Validation>;

    @doc("List the validations.")
    listValidationsByResourceGroup is ArmResourceListByParent<Validation>;

    @doc("List the validations.")
    listValidationsBySubscription is ArmListBySubscription<Validation>;
}