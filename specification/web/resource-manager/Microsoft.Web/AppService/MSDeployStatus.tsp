import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * MSDeploy ARM response
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("MSDeploy")
@parentResource(Site)
model MSDeployStatus
  is Azure.ResourceManager.ProxyResource<MSDeployStatusProperties> {
  ...ResourceNameParameter<
    Resource = MSDeployStatus,
    KeyName = "extension",
    SegmentName = "extensions",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("extensions")
        @key
        mSDeploy: "mSDeploy",
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatuses {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the status of the last MSDeploy operation.")
  getMSDeployStatus is MSDeployStatusOps.Read<
    MSDeployStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Invoke the MSDeploy web app extension.")
  createMSDeployOperation is MSDeployStatusOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader<FinalResult = MSDeployStatus> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmConflictResponse,
    Request = MSDeploy,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @get
  @action("log")
  getMSDeployLog is MSDeployStatusOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatusOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** ID of web app instance. */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** undefined */
        @path
        @segment("extensions")
        @key
        mSDeploy: "mSDeploy",
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatusOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  getInstanceMsDeployStatus is MSDeployStatusOperationGroupOps.Read<
    MSDeployStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Invoke the MSDeploy web app extension.")
  createInstanceMSDeployOperation is MSDeployStatusOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader<FinalResult = MSDeployStatus> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmConflictResponse,
    Request = MSDeploy,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @get
  @action("log")
  getInstanceMSDeployLog is MSDeployStatusOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatusSlotOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of web app slot. If not specified then will default to production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("extensions")
        @key
        mSDeploy: "mSDeploy",
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MSDeployStatusSlotOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  getMSDeployStatusSlot is MSDeployStatusSlotOperationGroupOps.Read<
    MSDeployStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Invoke the MSDeploy web app extension.")
  createMSDeployOperationSlot is MSDeployStatusSlotOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader<FinalResult = MSDeployStatus> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmConflictResponse,
    Request = MSDeploy,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @get
  @action("log")
  getMSDeployLogSlot is MSDeployStatusSlotOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface InstanceMSDeployStatusOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of web app slot. If not specified then will default to production slot. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** ID of web app instance. */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** undefined */
        @path
        @segment("extensions")
        @key
        mSDeploy: "mSDeploy",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface InstanceMSDeployStatusOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  @summary("Get the status of the last MSDeploy operation.")
  getInstanceMsDeployStatusSlot is InstanceMSDeployStatusOperationGroupOps.Read<
    MSDeployStatus,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Invoke the MSDeploy web app extension.")
  createInstanceMSDeployOperationSlot is InstanceMSDeployStatusOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader<FinalResult = MSDeployStatus> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmConflictResponse,
    Request = MSDeploy,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @get
  @action("log")
  getInstanceMSDeployLogSlot is InstanceMSDeployStatusOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(MSDeployStatus.name, "");
@@doc(MSDeployStatus.properties, "MSDeployStatus resource specific properties");
@@doc(MSDeployStatuses.createMSDeployOperation::parameters.resource,
  "Details of MSDeploy operation"
);
@@doc(MSDeployStatusOperationGroup.createInstanceMSDeployOperation::parameters.resource,
  "Details of MSDeploy operation"
);
@@doc(MSDeployStatusSlotOperationGroup.createMSDeployOperationSlot::parameters.resource,
  "Details of MSDeploy operation"
);
@@doc(InstanceMSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot::parameters.resource,
  "Details of MSDeploy operation"
);
