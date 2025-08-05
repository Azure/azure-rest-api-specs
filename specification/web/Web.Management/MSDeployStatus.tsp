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
}

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
        MSDeploy: string,
      }
    > {}

@armResourceOperations
interface MSDeployStatuses {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMSDeployStatus")
  getMSDeployStatus is MSDeployStatusOps.Read<MSDeployStatus>;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateMSDeployOperation")
  createMSDeployOperation is MSDeployStatusOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMSDeployLog")
  @get
  @action("log")
  getMSDeployLog is MSDeployStatusOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog>
  >;
}
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
        MSDeploy: string,
      }
    > {}

@armResourceOperations
interface MSDeployStatusOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceMsDeployStatus")
  getInstanceMsDeployStatus is MSDeployStatusOperationGroupOps.Read<MSDeployStatus>;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateInstanceMSDeployOperation")
  createInstanceMSDeployOperation is MSDeployStatusOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceMSDeployLog")
  @get
  @action("log")
  getInstanceMSDeployLog is MSDeployStatusOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog>
  >;
}
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
        MSDeploy: string,
      }
    > {}

@armResourceOperations
interface MSDeployStatusOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMSDeployStatusSlot")
  getMSDeployStatusSlot is MSDeployStatusOperationGroupOps.Read<MSDeployStatus>;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateMSDeployOperationSlot")
  createMSDeployOperationSlot is MSDeployStatusOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMSDeployLogSlot")
  @get
  @action("log")
  getMSDeployLogSlot is MSDeployStatusOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog>
  >;
}
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
        MSDeploy: string,
      }
    > {}

@armResourceOperations
interface MSDeployStatusOperationGroup {
  /**
   * Description for Get the status of the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceMsDeployStatusSlot")
  getInstanceMsDeployStatusSlot is MSDeployStatusOperationGroupOps.Read<MSDeployStatus>;

  /**
   * Description for Invoke the MSDeploy web app extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateInstanceMSDeployOperationSlot")
  createInstanceMSDeployOperationSlot is MSDeployStatusOperationGroupOps.CreateOrUpdateAsync<
    MSDeployStatus,
    Response = ArmResourceCreatedResponse<
      MSDeployStatus,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Description for Get the MSDeploy Log for the last MSDeploy operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceMSDeployLogSlot")
  @get
  @action("log")
  getInstanceMSDeployLogSlot is MSDeployStatusOperationGroupOps.ActionSync<
    MSDeployStatus,
    void,
    ArmResponse<MSDeployLog>
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
@@doc(MSDeployStatusOperationGroup.createMSDeployOperationSlot::parameters.resource,
  "Details of MSDeploy operation"
);
@@doc(MSDeployStatusOperationGroup.createInstanceMSDeployOperationSlot::parameters.resource,
  "Details of MSDeploy operation"
);
