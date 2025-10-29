import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * A Service Fabric.
 */
model ServiceFabric
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<
    ServiceFabricProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ServiceFabric,
    KeyName = "name",
    SegmentName = "servicefabrics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceFabricOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,

        /** The name of the user profile. */
        @path @segment("users") userName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ServiceFabric,
        KeyName = "name",
        SegmentName = "servicefabrics",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ServiceFabrics {
  /**
   * Get service fabric.
   */
  get is ServiceFabricOps.Read<
    ServiceFabric,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing service fabric. This operation can take a while to complete.
   */
  createOrUpdate is ServiceFabricOps.CreateOrUpdateAsync<
    ServiceFabric,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServiceFabric> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of service fabrics. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ServiceFabricOps.CustomPatchSync<
    ServiceFabric,
    PatchModel = ServiceFabricFragment
  >;

  /**
   * Delete service fabric. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ServiceFabricOps.DeleteWithoutOkAsync<
    ServiceFabric,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List service fabrics in a given user profile.
   */
  list is ServiceFabricOps.List<
    ServiceFabric,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<ServiceFabricList>
  >;

  /**
   * Lists the applicable start/stop schedules, if any.
   */
  listApplicableSchedules is ServiceFabricOps.ActionSync<
    ServiceFabric,
    void,
    ArmResponse<ApplicableSchedule>
  >;

  /**
   * Start a service fabric. This operation can take a while to complete.
   */
  start is ServiceFabricOps.ActionAsync<
    ServiceFabric,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Stop a service fabric This operation can take a while to complete.
   */
  stop is ServiceFabricOps.ActionAsync<
    ServiceFabric,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(ServiceFabric.name, "The name of the service fabric.");
@@doc(ServiceFabric.properties, "The properties of the resource.");
@@doc(ServiceFabrics.createOrUpdate::parameters.resource, "A Service Fabric.");
@@doc(ServiceFabrics.update::parameters.properties, "A Service Fabric.");
