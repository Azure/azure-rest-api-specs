import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SCVMM;

interface VmmServersOperations {
  @summary("Gets a VMMServer.")
  @doc("Implements VMMServer GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;
    },
    VMMServer
  >;

  @summary("Implements VmmServers PUT method.")
  @doc("Onboards the SCVMM fabric as an Azure VmmServer resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("Request payload.")
      @body
      body: VMMServer;
    },
    VMMServer
  >;

  @summary("Implements VmmServers DELETE method.")
  @doc("Deboards the SCVMM fabric from Azure.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements VmmServers PATCH method.")
  @doc("Updates the VmmServers resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("VmmServers patch payload.")
      @body
      body: ResourcePatch;
    },
    VMMServer | void
  >;

  @summary("Implements GET VmmServers in a resource group.")
  @doc("List of VmmServers in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    VMMServerListResult
  >;

  @summary("Implements GET VmmServers in a subscription.")
  @doc("List of VmmServers in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/vmmServers")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    VMMServerListResult
  >;
}

interface OperationsOperations {
  @doc("Returns list of all operations.")
  @route("/providers/Microsoft.ScVmm/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ResourceProviderOperationList>;
}

interface CloudsOperations {
  @summary("Gets a Cloud.")
  @doc("Implements Cloud GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/clouds/{cloudName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the Cloud.")
      @path
      cloudName: string;
    },
    Cloud
  >;

  @summary("Implements Clouds PUT method.")
  @doc("Onboards the ScVmm fabric cloud as an Azure cloud resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/clouds/{cloudName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the Cloud.")
      @path
      cloudName: string;

      @doc("Request payload.")
      @body
      body: Cloud;
    },
    Cloud
  >;

  @summary("Implements Cloud resource DELETE method.")
  @doc("Deregisters the ScVmm fabric cloud from Azure.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/clouds/{cloudName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the Cloud.")
      @path
      cloudName: string;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements the Clouds PATCH method.")
  @doc("Updates the Clouds resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/clouds/{cloudName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the Cloud.")
      @path
      cloudName: string;

      @doc("Clouds patch payload.")
      @body
      body: ResourcePatch;
    },
    Cloud | void
  >;

  @summary("Implements GET Clouds in a resource group.")
  @doc("List of Clouds in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/clouds")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    CloudListResult
  >;

  @summary("Implements GET Clouds in a subscription.")
  @doc("List of Clouds in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/clouds")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    CloudListResult
  >;
}

interface VirtualNetworksOperations {
  @summary("Gets a VirtualNetwork.")
  @doc("Implements VirtualNetwork GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualNetworks/{virtualNetworkName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualNetwork.")
      @path
      virtualNetworkName: string;
    },
    VirtualNetwork
  >;

  @summary("Implements VirtualNetworks PUT method.")
  @doc("Onboards the ScVmm virtual network as an Azure virtual network resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualNetworks/{virtualNetworkName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualNetwork.")
      @path
      virtualNetworkName: string;

      @doc("Request payload.")
      @body
      body: VirtualNetwork;
    },
    VirtualNetwork
  >;

  @summary("Implements VirtualNetwork DELETE method.")
  @doc("Deregisters the ScVmm virtual network from Azure.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualNetworks/{virtualNetworkName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualNetwork.")
      @path
      virtualNetworkName: string;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements the VirtualNetworks PATCH method.")
  @doc("Updates the VirtualNetworks resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualNetworks/{virtualNetworkName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualNetwork.")
      @path
      virtualNetworkName: string;

      @doc("VirtualNetworks patch payload.")
      @body
      body: ResourcePatch;
    },
    VirtualNetwork | void
  >;

  @summary("Implements GET VirtualNetworks in a resource group.")
  @doc("List of VirtualNetworks in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualNetworks")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    VirtualNetworkListResult
  >;

  @summary("Implements GET VirtualNetworks in a subscription.")
  @doc("List of VirtualNetworks in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/virtualNetworks")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    VirtualNetworkListResult
  >;
}

interface VirtualMachinesOperations {
  @summary("Gets a VirtualMachine.")
  @doc("Implements VirtualMachine GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;
    },
    VirtualMachine
  >;

  @summary("Implements VirtualMachines PUT method.")
  @doc("Creates Or Updates virtual machines deployed on scvmm fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Request payload.")
      @body
      body: VirtualMachine;
    },
    VirtualMachine
  >;

  @summary("Implements VirtualMachine DELETE method.")
  @doc("Deletes a VirtualMachine deployed on ScVmm fabric.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Whether to just disable the VM from azure and retain the VM in the VMM.")
      @query
      retain: boolean;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements the VirtualMachines PATCH method.")
  @doc("Updates the VirtualMachines resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("VirtualMachines patch payload.")
      @body
      body: VirtualMachineUpdate;
    },
    VirtualMachine | void
  >;

  @summary("Implements the operation to stop a virtual machine.")
  @doc("Stop virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/stop")
  @post
  Stop is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Virtualmachine stop action payload.")
      @body
      body: StopVirtualMachineOptions;
    },
    void
  >;

  @summary("Implements the operation to start a virtual machine.")
  @doc("Start virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("Implements the operation to restart a virtual machine.")
  @doc("Restart virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/restart")
  @post
  Restart is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("Implements the operation to creates a checkpoint in a virtual machine.")
  @doc("Creates a checkpoint in virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/createCheckpoint")
  @post
  CreateCheckpoint is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Virtualmachine create checkpoint action payload.")
      @body
      body: VirtualMachineCreateCheckpoint;
    },
    void
  >;

  @summary("Implements the operation to delete a checkpoint in a virtual machine.")
  @doc("Deletes a checkpoint in virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/deleteCheckpoint")
  @post
  DeleteCheckpoint is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Virtualmachine delete checkpoint action payload.")
      @body
      body: VirtualMachineDeleteCheckpoint;
    },
    void
  >;

  @summary("Implements the operation to restores to a checkpoint in a virtual machine.")
  @doc("Restores to a checkpoint in virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines/{virtualMachineName}/restoreCheckpoint")
  @post
  RestoreCheckpoint is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachine.")
      @path
      virtualMachineName: string;

      @doc("Virtualmachine restore checkpoint action payload.")
      @body
      body: VirtualMachineRestoreCheckpoint;
    },
    void
  >;

  @summary("Implements GET VirtualMachines in a resource group.")
  @doc("List of VirtualMachines in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachines")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    VirtualMachineListResult
  >;

  @summary("Implements GET VirtualMachines in a subscription.")
  @doc("List of VirtualMachines in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/virtualMachines")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    VirtualMachineListResult
  >;
}

interface VirtualMachineTemplatesOperations {
  @summary("Gets a VirtualMachineTemplate.")
  @doc("Implements VirtualMachineTemplate GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachineTemplates/{virtualMachineTemplateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachineTemplate.")
      @path
      virtualMachineTemplateName: string;
    },
    VirtualMachineTemplate
  >;

  @summary("Implements VirtualMachineTemplates PUT method.")
  @doc("Onboards the ScVmm VM Template as an Azure VM Template resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachineTemplates/{virtualMachineTemplateName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachineTemplate.")
      @path
      virtualMachineTemplateName: string;

      @doc("Request payload.")
      @body
      body: VirtualMachineTemplate;
    },
    VirtualMachineTemplate
  >;

  @summary("Implements VirtualMachineTemplate DELETE method.")
  @doc("Deregisters the ScVmm VM Template from Azure.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachineTemplates/{virtualMachineTemplateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VirtualMachineTemplate.")
      @path
      virtualMachineTemplateName: string;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements the VirtualMachineTemplate PATCH method.")
  @doc("Updates the VirtualMachineTemplate resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachineTemplates/{virtualMachineTemplateName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the VirtualMachineTemplate.")
      @path
      virtualMachineTemplateName: string;

      @doc("VirtualMachineTemplates patch details.")
      @body
      body: ResourcePatch;
    },
    VirtualMachineTemplate | void
  >;

  @summary("Implements GET VirtualMachineTemplates in a resource group.")
  @doc("List of VirtualMachineTemplates in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/virtualMachineTemplates")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    VirtualMachineTemplateListResult
  >;

  @summary("Implements GET VirtualMachineTemplates in a subscription.")
  @doc("List of VirtualMachineTemplates in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/virtualMachineTemplates")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    VirtualMachineTemplateListResult
  >;
}

interface AvailabilitySetsOperations {
  @summary("Gets an AvailabilitySet.")
  @doc("Implements AvailabilitySet GET method.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/availabilitySets/{availabilitySetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the AvailabilitySet.")
      @path
      availabilitySetName: string;
    },
    AvailabilitySet
  >;

  @summary("Implements AvailabilitySets PUT method.")
  @doc("Onboards the ScVmm availability set as an Azure resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/availabilitySets/{availabilitySetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the AvailabilitySet.")
      @path
      availabilitySetName: string;

      @doc("Request payload.")
      @body
      body: AvailabilitySet;
    },
    AvailabilitySet
  >;

  @summary("Implements AvailabilitySet DELETE method.")
  @doc("Deregisters the ScVmm availability set from Azure.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/availabilitySets/{availabilitySetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the AvailabilitySet.")
      @path
      availabilitySetName: string;

      @doc("""
Forces the resource to be deleted from azure. The corresponding CR would be
attempted to be deleted too.
""")
      @query
      force: boolean;
    },
    void
  >;

  @summary("Implements the AvailabilitySets PATCH method.")
  @doc("Updates the AvailabilitySets resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/availabilitySets/{availabilitySetName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("Name of the AvailabilitySet.")
      @path
      availabilitySetName: string;

      @doc("AvailabilitySets patch payload.")
      @body
      body: ResourcePatch;
    },
    AvailabilitySet | void
  >;

  @summary("Implements GET AvailabilitySets in a resource group.")
  @doc("List of AvailabilitySets in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/availabilitySets")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;
    },
    AvailabilitySetListResult
  >;

  @summary("Implements GET AvailabilitySets in a subscription.")
  @doc("List of AvailabilitySets in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ScVmm/availabilitySets")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;
    },
    AvailabilitySetListResult
  >;
}

interface InventoryItemsOperations {
  @summary("Implements InventoryItem PUT method.")
  @doc("Create Or Update InventoryItem.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}/inventoryItems/{inventoryItemName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("Name of the inventoryItem.")
      @path
      inventoryItemName: string;

      @doc("Request payload.")
      @body
      body: InventoryItem;
    },
    InventoryItem
  >;

  @summary("Implements GET InventoryItem method.")
  @doc("Shows an inventory item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}/inventoryItems/{inventoryItemName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("Name of the inventoryItem.")
      @path
      inventoryItemName: string;
    },
    InventoryItem
  >;

  @summary("Implements inventoryItem DELETE method.")
  @doc("Deletes an inventoryItem.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}/inventoryItems/{inventoryItemName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;

      @doc("Name of the inventoryItem.")
      @path
      inventoryItemName: string;
    },
    void
  >;

  @summary("Implements GET for the list of Inventory Items in the VMMServer.")
  @doc("Returns the list of inventoryItems in the given VMMServer.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ScVmm/vmmServers/{vmmServerName}/inventoryItems")
  @get
  ListByVMMServer is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of the VMMServer.")
      @path
      vmmServerName: string;
    },
    InventoryItemsList
  >;
}
