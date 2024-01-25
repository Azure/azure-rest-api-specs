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
/**
 * The registration assignment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  RegistrationAssignmentProperties
)
model RegistrationAssignment extends ExtensionResourceBase {
  /**
   * The GUID of the registration assignment.
   */
  @path
  @key("registrationAssignmentId")
  @segment("registrationAssignments")
  @visibility("read")
  name: string;

  /**
   * The properties of a registration assignment.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RegistrationAssignmentProperties;
}

@armResourceOperations
interface RegistrationAssignments {
  /**
   * Gets the details of the specified registration assignment.
   */
  get is ArmResourceRead<
    RegistrationAssignment,
    {
      ...BaseParameters<RegistrationAssignment>;

      /**
       * The flag indicating whether to return the registration definition details along with the registration assignment details.
       */
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;
    }
  >;

  /**
   * Creates or updates a registration assignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RegistrationAssignment>;

  /**
   * Deletes the specified registration assignment.
   */
  delete is ArmResourceDeleteAsync<RegistrationAssignment>;

  /**
   * Gets a list of the registration assignments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegistrationAssignments_List")
  list is ArmResourceListByParent<
    RegistrationAssignment,
    {
      ...BaseParameters<RegistrationAssignment>;

      /**
       * The flag indicating whether to return the registration definition details along with the registration assignment details.
       */
      @query("$expandRegistrationDefinition")
      $expandRegistrationDefinition?: boolean;

      /**
       * The filter query parameter to filter managed services resources by.
       */
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
