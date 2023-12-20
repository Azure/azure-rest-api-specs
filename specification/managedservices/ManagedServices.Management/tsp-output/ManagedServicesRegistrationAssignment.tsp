import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedServices;
@doc("The registration assignment.")
model ManagedServicesRegistrationAssignment
  is ExtensionResource<RegistrationAssignmentProperties> {
  @doc("The GUID of the registration assignment.")
  @path
  @key("registrationAssignmentId")
  @segment("registrationAssignments")
  name: string;
}

@armResourceOperations
interface ManagedServicesRegistrationAssignments {
  @doc("Gets the details of the specified registration assignment.")
  get is ArmResourceRead<
    ManagedServicesRegistrationAssignment,
    {
      ...BaseParameters<ManagedServicesRegistrationAssignment>;

      @doc("The flag indicating whether to return the registration definition details along with the registration assignment details.")
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;
    }
  >;
  @doc("Creates or updates a registration assignment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedServicesRegistrationAssignment>;
  @doc("Deletes the specified registration assignment.")
  delete is ArmResourceDeleteAsync<ManagedServicesRegistrationAssignment>;
  @doc("Gets a list of the registration assignments.")
  list is ArmResourceListByParent<
    ManagedServicesRegistrationAssignment,
    {
      ...BaseParameters<ManagedServicesRegistrationAssignment>;

      @doc("The flag indicating whether to return the registration definition details along with the registration assignment details.")
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;

      @doc("The filter query parameter to filter managed services resources by.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
