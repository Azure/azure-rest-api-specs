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
@doc("The registration assignment.")
model RegistrationAssignment
  is ExtensionResource<RegistrationAssignmentProperties> {
  @doc("The GUID of the registration assignment.")
  @path
  @key("registrationAssignmentId")
  @segment("registrationAssignments")
  name: string;
}

@armResourceOperations
interface RegistrationAssignments {
  @doc("Gets the details of the specified registration assignment.")
  get is ArmResourceRead<
    RegistrationAssignment,
    {
      ...BaseParameters<RegistrationAssignment>;

      @doc("The flag indicating whether to return the registration definition details along with the registration assignment details.")
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;
    }
  >;

  @doc("Creates or updates a registration assignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RegistrationAssignment>;

  @doc("Deletes the specified registration assignment.")
  delete is ArmResourceDeleteAsync<RegistrationAssignment>;

  @doc("Gets a list of the registration assignments.")
  list is ArmResourceListByParent<
    RegistrationAssignment,
    {
      ...BaseParameters<RegistrationAssignment>;

      @doc("The flag indicating whether to return the registration definition details along with the registration assignment details.")
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;

      @doc("The filter query parameter to filter managed services resources by.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(RegistrationAssignments.createOrUpdate::parameters.resource,
  "json",
  "requestBody"
);
@@extension(RegistrationAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "requestBody"
);
@@doc(RegistrationAssignments.createOrUpdate::parameters.resource,
  "The parameters required to create new registration assignment."
);
