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

namespace Microsoft.Orbital;
/**
 * Customer creates a spacecraft resource to schedule a contact.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SpacecraftsProperties)
model Spacecraft extends TrackedResourceBase {
  /**
   * Spacecraft ID.
   */
  @path
  @key("spacecraftName")
  @segment("spacecrafts")
  @visibility("read")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Spacecraft Properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SpacecraftsProperties;
}

@armResourceOperations
interface Spacecrafts {
  /**
   * Gets the specified spacecraft in a specified resource group.
   */
  get is ArmResourceRead<Spacecraft>;

  /**
   * Creates or updates a spacecraft resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Spacecraft,
    BaseParameters<Spacecraft>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the specified spacecraft tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchAsync<
    Spacecraft,
    TagsObject,
    BaseParameters<Spacecraft>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes a specified spacecraft resource.
   */
  delete is ArmResourceDeleteAsync<
    Spacecraft,
    BaseParameters<Spacecraft>,
    ArmLroLocationHeader
  >;

  /**
   * Returns list of spacecrafts by resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Spacecrafts_List")
  list is ArmResourceListByParent<
    Spacecraft,
    {
      ...BaseParameters<Spacecraft>;

      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Returns list of spacecrafts by subscription.
   */
  listBySubscription is ArmListBySubscription<Spacecraft>;

  /**
   * Returns list of available contacts. A contact is available if the spacecraft is visible from the ground station for more than the minimum viable contact duration provided in the contact profile.
   */
  listAvailableContacts is ArmResourceActionAsync<
    Spacecraft,
    ContactParameters,
    AvailableContactsListResult,
    BaseParameters<Spacecraft>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Spacecrafts.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Spacecrafts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Spacecrafts.createOrUpdate::parameters.resource,
  "The parameters to provide for the created spacecraft."
);
@@projectedName(Spacecrafts.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(Spacecrafts.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Spacecrafts.updateTags::parameters.properties,
  "Parameters supplied to update spacecraft tags."
);
@@projectedName(Spacecrafts.listAvailableContacts::parameters.body,
  "json",
  "parameters"
);
@@extension(Spacecrafts.listAvailableContacts::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Spacecrafts.listAvailableContacts::parameters.body,
  "The parameters to provide for the contacts."
);
