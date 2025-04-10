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

namespace Microsoft.CertificateRegistration;
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WebSiteInstanceStatus,
          KeyName = "instanceId",
          SegmentName = "instances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProcessInfo,
        KeyName = "processId",
        SegmentName = "processes",
        NamePattern = ""
      >>
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
  @get
  @action("dump")
  @operationId("WebApps_GetInstanceProcessDump")
  getInstanceProcessDump is ProcessInfoOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("threads")
  @operationId("WebApps_ListInstanceProcessThreads")
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProcessInfo,
        KeyName = "processId",
        SegmentName = "processes",
        NamePattern = ""
      >>
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
  @get
  @action("dump")
  @operationId("WebApps_GetProcessDump")
  getProcessDump is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("threads")
  @operationId("WebApps_ListProcessThreads")
  listProcessThreads is ProcessInfoOperationGroupOps.ActionSync<
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WebSiteInstanceStatus,
          KeyName = "instanceId",
          SegmentName = "instances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProcessInfo,
        KeyName = "processId",
        SegmentName = "processes",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceProcessSlot")
  getInstanceProcessSlot is ProcessInfoOperationGroupOps.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteInstanceProcessSlot")
  deleteInstanceProcessSlot is ProcessInfoOperationGroupOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceProcessesSlot")
  listInstanceProcessesSlot is ProcessInfoOperationGroupOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("dump")
  @operationId("WebApps_GetInstanceProcessDumpSlot")
  getInstanceProcessDumpSlot is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("threads")
  @operationId("WebApps_ListInstanceProcessThreadsSlot")
  listInstanceProcessThreadsSlot is ProcessInfoOperationGroupOps.ActionSync<
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProcessInfo,
        KeyName = "processId",
        SegmentName = "processes",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetProcessSlot")
  getProcessSlot is ProcessInfoOperationGroupOps.Read<ProcessInfo>;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteProcessSlot")
  deleteProcessSlot is ProcessInfoOperationGroupOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListProcessesSlot")
  listProcessesSlot is ProcessInfoOperationGroupOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection>
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("dump")
  @operationId("WebApps_GetProcessDumpSlot")
  getProcessDumpSlot is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    OkResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("threads")
  @operationId("WebApps_ListProcessThreadsSlot")
  listProcessThreadsSlot is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection>
  >;
}

@@doc(ProcessInfo.name, "PID.");
@@doc(ProcessInfo.properties, "ProcessInfo resource specific properties");
