import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the datastore.
 */
model Datastore
  is Azure.ResourceManager.TrackedResource<DatastoreProperties, false> {
  ...ResourceNameParameter<
    Resource = Datastore,
    KeyName = "datastoreName",
    SegmentName = "datastores",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface DatastoresOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = Datastore,
        KeyName = "datastoreName",
        SegmentName = "datastores",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Datastores {
  /**
   * Implements datastore GET method.
   */
  get is ArmResourceRead<Datastore>;

  /**
   * Create Or Update datastore.
   */
  create is DatastoresOps.CreateOrUpdateAsync<
    Datastore,
    OptionalRequestBody = true
  >;

  /**
   * API to update certain properties of the datastore resource.
   */
  @patch(#{ implicitOptionality: false })
  update is DatastoresOps.CustomPatchSync<
    Datastore,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements datastore DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Datastore,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of datastores in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Datastore,
    Response = ArmResponse<DatastoresList>
  >;

  /**
   * List of datastores in a subscription.
   */
  list is ArmListBySubscription<
    Datastore,
    Response = ArmResponse<DatastoresList>
  >;
}

@@doc(Datastore.name, "Name of the datastore.");
@@doc(Datastore.properties, "Resource properties.");
@@doc(Datastores.create::parameters.resource, "Request payload.");
@@doc(Datastores.update::parameters.properties,
  "Resource properties to update."
);
