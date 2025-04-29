import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_GetDryrun")
  getDryrun is DryrunResourceOps.Read<DryrunResource>;

  /**
   * create a dryrun job to do necessary check before actual creation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_CreateDryrun")
  createDryrun is DryrunResourceOps.CreateOrUpdateAsync<DryrunResource>;

  /**
   * update a dryrun job to do necessary check before actual creation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Connector_UpdateDryrun")
  updateDryrun is DryrunResourceOps.CustomPatchAsync<
    DryrunResource,
    PatchModel = DryrunPatch,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * delete a dryrun job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_DeleteDryrun")
  deleteDryrun is DryrunResourceOps.DeleteSync<DryrunResource>;

  /**
   * list dryrun jobs
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Connector_ListDryrun")
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

        /** {resourceUri} */
        @path @segment("{resourceUri}") providers: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = DryrunResource,
        KeyName = "dryruns",
        SegmentName = "Microsoft.ServiceLinker",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Linkers {
  /**
   * get a dryrun job
   */
  getDryrun is LinkersOps.Read<
    DryrunResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name of dryrun.
       */
      @path
      dryrunName: string;
    }
  >;

  /**
   * create a dryrun job to do necessary check before actual creation
   */
  createDryrun is LinkersOps.CreateOrUpdateAsync<
    DryrunResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name of dryrun.
       */
      @path
      dryrunName: string;
    }
  >;

  /**
   * add a dryrun job to do necessary check before actual creation
   */
  @patch(#{ implicitOptionality: false })
  updateDryrun is LinkersOps.CustomPatchAsync<
    DryrunResource,
    PatchModel = DryrunPatch,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name of dryrun.
       */
      @path
      dryrunName: string;
    },
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * delete a dryrun job
   */
  deleteDryrun is LinkersOps.DeleteSync<
    DryrunResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;

      /**
       * The name of dryrun.
       */
      @path
      dryrunName: string;
    }
  >;

  /**
   * list dryrun jobs
   */
  listDryrun is LinkersOps.List<
    DryrunResource,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource to be connected.
       */
      @path
      resourceUri: string;
    },
    Response = ArmResponse<DryrunList>
  >;
}

@@doc(DryrunResource.name, "The name of dryrun.");
@@doc(DryrunResource.properties, "The properties of the dryrun job.");
@@doc(DryrunResources.createDryrun::parameters.resource, "dryrun resource.");
@@doc(DryrunResources.updateDryrun::parameters.properties, "dryrun resource.");
@@doc(Linkers.createDryrun::parameters.resource, "dryrun resource.");
@@doc(Linkers.updateDryrun::parameters.properties, "dryrun resource.");
