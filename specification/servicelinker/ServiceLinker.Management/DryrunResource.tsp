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
model DryrunResource
  is Azure.ResourceManager.ExtensionResource<DryrunProperties> {
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
interface Linkers {
  /**
   * get a dryrun job
   */
  getDryrun is Extension.Read<Extension.ScopeParameter, DryrunResource>;

  /**
   * create a dryrun job to do necessary check before actual creation
   */
  createDryrun is Extension.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    DryrunResource
  >;

  /**
   * add a dryrun job to do necessary check before actual creation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  updateDryrun is Extension.CustomPatchAsync<
    Extension.ScopeParameter,
    DryrunResource,
    PatchModel = DryrunPatch,
    Response = ArmResourceUpdatedResponse<DryrunResource> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = DryrunResource>>
  >;

  /**
   * delete a dryrun job
   */
  deleteDryrun is Extension.DeleteSync<
    Extension.ScopeParameter,
    DryrunResource
  >;

  /**
   * list dryrun jobs
   */
  listDryrun is Extension.ListByTarget<
    Extension.ScopeParameter,
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
