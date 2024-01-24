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
 * The registration definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  RegistrationDefinitionProperties
)
@includeInapplicableMetadataInPayload(false)
model RegistrationDefinition extends ExtensionResourceBase {
  /**
   * The GUID of the registration definition.
   */
  @path
  @key("registrationDefinitionId")
  @segment("registrationDefinitions")
  name: string;

  /**
   * The properties of a registration definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RegistrationDefinitionProperties;

  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface RegistrationDefinitions {
  /**
   * Gets the registration definition details.
   */
  get is ArmResourceRead<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      /**
       * The GUID of the registration definition.
       */
      @path
      registrationId: string;
    }
  >;

  /**
   * Creates or updates a registration definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      /**
       * The GUID of the registration definition.
       */
      @path
      registrationId: string;
    }
  >;

  /**
   * Deletes the registration definition.
   */
  delete is ArmResourceDeleteSync<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      /**
       * The GUID of the registration definition.
       */
      @path
      registrationId: string;
    }
  >;

  /**
   * Gets a list of the registration definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RegistrationDefinitions_List")
  list is ArmResourceListByParent<
    RegistrationDefinition,
    {
      ...BaseParameters<RegistrationDefinition>;

      /**
       * The filter query parameter to filter managed services resources by.
       */
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
