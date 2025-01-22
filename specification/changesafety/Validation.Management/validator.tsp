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

model Validator is ProxyResource<ValidatorProperties> {
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("validatorName")
  @path
  @segment("validators")
  @visibility("read")
  @doc("The name of the resource validator.")
  name: string;
}

@parentResource(Validator)
model ValidatorVersion is ProxyResource<ValidatorVersionProperties> {
  // https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @key("validatorVersionName")
  @path
  @segment("versions")
  @visibility("read")
  @doc("The semantic version of the validator")
  name: string;
}

@doc("Azure resource Id of a Validator.")
scalar ValidatorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/validators",
    }
  ]>;

@doc("Azure resource Id of a Validator.")
scalar ValidatorVersionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/validators/versions",
    }
  ]>;

@armResourceOperations
interface Validators {
  @doc("Get the validator.")
  get is ArmResourceRead<Validator>;

  @added(Versions.v2025_01_15_preview)
  getAtSubscriptionLevel is ArmResourceRead<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Create the validator.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Validator>;

  @added(Versions.v2025_01_15_preview)
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Update the validator.")
  update is ArmResourcePatchSync<Validator, ValidatorProperties>;

  @added(Versions.v2025_01_15_preview)
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    Validator,
    ValidatorProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Deletes the validator.")
  delete is ArmResourceDeleteWithoutOkAsync<Validator>;

  @added(Versions.v2025_01_15_preview)
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("List the validators.")
  listByResourceGroup is ArmResourceListByParent<Validator>;

  @doc("List the validators.")
  listBySubscription is ArmListBySubscription<Validator>;

  @doc("Get the validator version.")
  getVersion is ArmResourceRead<ValidatorVersion>;

  @added(Versions.v2025_01_15_preview)
  getVersionAtSubscriptionLevel is ArmResourceRead<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Create the validator version.")
  createOrUpdateVersion is ArmResourceCreateOrReplaceAsync<ValidatorVersion>;

  @added(Versions.v2025_01_15_preview)
  createOrUpdateVersionAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Update the validator version.")
  updateVersion is ArmResourcePatchSync<
    ValidatorVersion,
    ValidatorVersionProperties
  >;

  @added(Versions.v2025_01_15_preview)
  updateVersionAtSubscriptionLevel is ArmResourcePatchSync<
    ValidatorVersion,
    ValidatorVersionProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Deletes the validator version.")
  deleteVersion is ArmResourceDeleteWithoutOkAsync<ValidatorVersion>;

  @added(Versions.v2025_01_15_preview)
  deleteVersionAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("List the validator versions.")
  listVersionByResourceGroup is ArmResourceListByParent<ValidatorVersion>;

  @doc("List the validator versions.")
  listVersionBySubscription is ArmListBySubscription<ValidatorVersion>;
}
