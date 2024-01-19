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

namespace Microsoft.ManagedServices;
@doc("The registration definition.")
model RegistrationDefinition
  is ExtensionResource<RegistrationDefinitionProperties> {
  @doc("The GUID of the registration definition.")
  @path
  @key("registrationDefinitionId")
  @segment("registrationDefinitions")
  name: string;

  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface RegistrationDefinitions {
  @doc("Gets the registration definition details.")
  get is ArmResourceRead<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      @doc("The GUID of the registration definition.")
      @path
      registrationId: string;
    }
  >;

  @doc("Creates or updates a registration definition.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      @doc("The GUID of the registration definition.")
      @path
      registrationId: string;
    }
  >;

  @doc("Deletes the registration definition.")
  delete is ArmResourceDeleteSync<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      @doc("The GUID of the registration definition.")
      @path
      registrationId: string;
    }
  >;

  @doc("Gets a list of the registration definitions.")
  list is ArmResourceListByParent<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      @doc("The filter query parameter to filter managed services resources by.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(RegistrationDefinitions.createOrUpdate::parameters.resource,
  "json",
  "requestBody"
);
@@extension(RegistrationDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "requestBody"
);
@@doc(RegistrationDefinitions.createOrUpdate::parameters.resource,
  "The parameters required to create a new registration definition."
);
