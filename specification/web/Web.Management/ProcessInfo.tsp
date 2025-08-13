import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebSiteInstanceStatus.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Process Information.
 */
@parentResource(WebSiteInstanceStatus)
model ProcessInfo
  is Azure.ResourceManager.ProxyResource<ProcessInfoProperties> {
  ...ResourceNameParameter<
    Resource = ProcessInfo,
    KeyName = "processId",
    SegmentName = "processes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProcessInfoOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances". */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfos {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceProcess")
  getInstanceProcess is ProcessInfoOps.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteInstanceProcess")
  deleteInstanceProcess is ProcessInfoOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceProcesses")
  listInstanceProcesses is ProcessInfoOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceProcessDump")
  @get
  @action("dump")
  getInstanceProcessDump is ProcessInfoOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceProcessThreads")
  @get
  @action("threads")
  listInstanceProcessThreads is ProcessInfoOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection>
  >;
}
@armResourceOperations
interface ProcessInfoOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProcess")
  getProcess is ProcessInfoOperationGroupOps.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteProcess")
  deleteProcess is ProcessInfoOperationGroupOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProcesses")
  listProcesses is ProcessInfoOperationGroupOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProcessDump")
  @get
  @action("dump")
  getProcessDump is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProcessThreads")
  @get
  @action("threads")
  listProcessThreads is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection>
  >;
}
@armResourceOperations
interface ProcessInfoOperationGroupOps_2
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances". */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup_2 {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceProcessSlot")
  getInstanceProcessSlot is ProcessInfoOperationGroupOps_2.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteInstanceProcessSlot")
  deleteInstanceProcessSlot is ProcessInfoOperationGroupOps_2.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceProcessesSlot")
  @segment("processes")
  listInstanceProcessesSlot is ProcessInfoOperationGroupOps_2.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceProcessDumpSlot")
  @get
  @action("dump")
  getInstanceProcessDumpSlot is ProcessInfoOperationGroupOps_2.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceProcessThreadsSlot")
  @get
  @action("threads")
  listInstanceProcessThreadsSlot is ProcessInfoOperationGroupOps_2.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection>
  >;
}
@armResourceOperations
interface ProcessInfoOperationGroupOps_3
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup_3 {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProcessSlot")
  getProcessSlot is ProcessInfoOperationGroupOps_3.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteProcessSlot")
  deleteProcessSlot is ProcessInfoOperationGroupOps_3.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProcessesSlot")
  @action("processes")
  listProcessesSlot is ProcessInfoOperationGroupOps_3.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProcessDumpSlot")
  @get
  @action("dump")
  getProcessDumpSlot is ProcessInfoOperationGroupOps_3.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProcessThreadsSlot")
  @get
  @action("threads")
  listProcessThreadsSlot is ProcessInfoOperationGroupOps_3.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection>
  >;
}

@@doc(ProcessInfo.name, "PID.");
@@doc(ProcessInfo.properties, "ProcessInfo resource specific properties");
