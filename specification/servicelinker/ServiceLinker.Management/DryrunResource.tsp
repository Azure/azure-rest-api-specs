import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceLinker;
/**
 * a dryrun job resource
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DryrunResource is Azure.ResourceManager.ProxyResource<DryrunProperties> {
  ...ResourceNameParameter<
    Resource = DryrunResource,
    KeyName = "dryrunName",
    SegmentName = "dryruns",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DryrunResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = DryrunResource,
        KeyName = "dryrunName",
        SegmentName = "dryruns",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DryrunResources {
  /**
   * get a dryrun job
   */
  getDryrun is DryrunResourceOps.Read<DryrunResource>;

  /**
   * create a dryrun job to do necessary check before actual creation
   */
  createDryrun is DryrunResourceOps.CreateOrUpdateAsync<DryrunResource>;

  /**
   * update a dryrun job to do necessary check before actual creation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateDryrun is DryrunResourceOps.CustomPatchAsync<
    DryrunResource,
    PatchModel = DryrunPatch,
    Response = ArmResourceUpdatedResponse<DryrunResource> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = DryrunResource>>
  >;

  /**
   * delete a dryrun job
   */
  deleteDryrun is DryrunResourceOps.DeleteSync<DryrunResource>;

  /**
   * list dryrun jobs
   */
  listDryrun is DryrunResourceOps.List<
    DryrunResource,
    Response = ArmResponse<DryrunList>
  >;
}

@armResourceOperations
interface LinkersOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /** The fully qualified Azure Resource manager identifier of the resource to be connected. */
        @path(#{ allowReserved: true })
        resourceUri: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = DryrunResource,
        KeyName = "dryrunName",
        SegmentName = "dryruns",
        NamePattern = ""
      >>
    > {}
@armResourceOperations
interface Linkers {
  /**
   * get a dryrun job
   */
  getDryrun is LinkersOps.Read<DryrunResource>;

  /**
   * create a dryrun job to do necessary check before actual creation
   */
  createDryrun is LinkersOps.CreateOrUpdateAsync<DryrunResource>;

  /**
   * add a dryrun job to do necessary check before actual creation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateDryrun is LinkersOps.CustomPatchAsync<
    DryrunResource,
    PatchModel = DryrunPatch,
    Response = ArmResourceUpdatedResponse<DryrunResource> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = DryrunResource>>
  >;

  /**
   * delete a dryrun job
   */
  deleteDryrun is LinkersOps.DeleteSync<DryrunResource>;

  /**
   * list dryrun jobs
   */
  listDryrun is LinkersOps.List<
    DryrunResource,
    Response = ArmResponse<DryrunList>
  >;
}

@@doc(DryrunResource.name, "The name of dryrun.");
@@doc(DryrunResource.properties, "The properties of the dryrun job.");
@@doc(DryrunResources.createDryrun::parameters.resource, "dryrun resource.");
@@doc(DryrunResources.updateDryrun::parameters.properties, "dryrun resource.");
@@doc(Linkers.createDryrun::parameters.resource, "dryrun resource.");
@@doc(Linkers.updateDryrun::parameters.properties, "dryrun resource.");
