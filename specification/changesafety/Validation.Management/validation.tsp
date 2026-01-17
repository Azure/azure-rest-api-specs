import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

model Validation is ProxyResource<ValidationPropertiesExtended> {
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("validationName")
  @path
  @segment("validations")
  @visibility(Lifecycle.Read)
  @doc("The name of the validation.")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Location is needed for MSI"
  @doc("The location of the validation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_01_01_preview)
  location?: Azure.Core.azureLocation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "MSI support for proxy resource"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The managed identity for the validation to use.")
  @added(Versions.v2026_01_01_preview)
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface Validations {
  @doc("Get the validation.")
  get is ArmResourceRead<Validation>;

  @added(Versions.v2025_01_15_preview)
  getAtSubscriptionLevel is ArmResourceRead<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Creates a validation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Validation>;

  @added(Versions.v2025_01_15_preview)
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Validation can be re-run by doing a PUT operation with the same parameters. The output of the validation will be updated based on the new validation run.")
  update is ArmResourcePatchSync<Validation, ValidationProperties>;

  @added(Versions.v2025_01_15_preview)
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    Validation,
    ValidationPropertiesExtended,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Deletes the validation.")
  delete is ArmResourceDeleteWithoutOkAsync<Validation>;

  @added(Versions.v2025_01_15_preview)
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("List the validations.")
  listByResourceGroup is ArmResourceListByParent<Validation>;

  @doc("List the validations.")
  listBySubscription is ArmListBySubscription<Validation>;
}
