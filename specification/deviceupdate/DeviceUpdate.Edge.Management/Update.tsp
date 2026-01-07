import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./UpdateAccount.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DeviceUpdate;

@parentResource(UpdateAccount)
model Update is Azure.ResourceManager.TrackedResource<UpdateProperties> {
  ...ResourceNameParameter<
    Resource = Update,
    KeyName = "updateResourceName",
    SegmentName = "updates",
    NamePattern = "^[a-zA-Z0-9-._]+$"
  >;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the Update.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_04_01_preview)
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface Updates {
  /**
   * Returns update details.
   */
  get is ArmResourceRead<Update>;

  /**
   * Create update resource.
   */
  create is ArmResourceCreateOrReplaceSync<Update>;

  /**
   * Update update tags.
   */
  @patch(#{ implicitOptionality: false })
  modify is ArmCustomPatchSync<Update, TagUpdate>;

  /**
   * Deletes update.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Update>;

  /**
   * Returns list of Updates.
   */
  list is ArmResourceListByParent<
    Update,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Update>;

      /**
       * May be used to filter the items in the result.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@maxLength(Update.name, 173);
@@minLength(Update.name, 7);
@@doc(Update.name,
  "Concatenated update provider, name and version separated by underscore."
);
@@doc(Updates.create::parameters.resource, "Update details.");
@@doc(Updates.modify::parameters.properties, "Updated tags.");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Updates.create::parameters.resource,
  "application/json",
  "update"
);
@@clientName(Updates.create::parameters.resource, "update");

#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(Updates.modify::parameters.properties,
  "application/json",
  "tagUpdatePayload"
);
@@clientName(Updates.modify::parameters.properties, "tagUpdatePayload");

/**
 * Java SDK does not like Update as model name.
 */
@@clientName(Update, "ResourceUpdate", "java");
