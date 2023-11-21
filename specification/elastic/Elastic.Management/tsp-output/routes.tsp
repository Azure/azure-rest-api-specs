import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Elastic;

interface OperationsOperations {
  @summary("List all operations provided by Microsoft.Elastic.")
  @doc("List all operations provided by Microsoft.Elastic.")
  @route("/providers/Microsoft.Elastic/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface MonitorsOperations {
  @summary("List all monitors under the specified subscription.")
  @doc("List all monitors under the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Elastic/monitors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;
    },
    ElasticMonitorResourceListResponse
  >;

  @summary("List all monitors under the specified resource group.")
  @doc("List all monitors under the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;
    },
    ElasticMonitorResourceListResponse
  >;

  @summary("Get the properties of a specific monitor resource.")
  @doc("Get the properties of a specific monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    ElasticMonitorResource
  >;

  @summary("Create a monitor resource.")
  @doc("Create a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Elastic monitor resource model")
      @body
      body: ElasticMonitorResource;
    },
    ElasticMonitorResource
  >;

  @summary("Update a monitor resource.")
  @doc("Update a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Elastic resource model update parameters.")
      @body
      body: ElasticMonitorResourceUpdateParameters;
    },
    ElasticMonitorResource
  >;

  @summary("Delete a monitor resource.")
  @doc("Delete a monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    void
  >;
}

interface MonitoredResourcesOperations {
  @summary("List the resources currently being monitored by the Elastic monitor resource.")
  @doc("List the resources currently being monitored by the Elastic monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/listMonitoredResources")
  @post
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    MonitoredResourceListResponse
  >;
}

interface DeploymentInfoOperations {
  @summary("""
Fetch information regarding Elastic cloud deployment corresponding to the
Elastic monitor resource.
""")
  @doc("""
Fetch information regarding Elastic cloud deployment corresponding to the
Elastic monitor resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/listDeploymentInfo")
  @post
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    DeploymentInfoResponse
  >;
}

interface TagRulesOperations {
  @summary("List the tag rules for a given monitor resource.")
  @doc("List the tag rules for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/tagRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    MonitoringTagRulesListResponse
  >;

  @summary("Create or update a tag rule set for a given monitor resource.")
  @doc("Create or update a tag rule set for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/tagRules/{ruleSetName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Tag Rule Set resource name")
      @path
      ruleSetName: string;

      @doc("request body of MonitoringTagRules")
      @body
      body: MonitoringTagRules;
    },
    MonitoringTagRules
  >;

  @summary("Get a tag rule set for a given monitor resource.")
  @doc("Get a tag rule set for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/tagRules/{ruleSetName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Tag Rule Set resource name")
      @path
      ruleSetName: string;
    },
    MonitoringTagRules
  >;

  @summary("Delete a tag rule set for a given monitor resource.")
  @doc("Delete a tag rule set for a given monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/tagRules/{ruleSetName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("Tag Rule Set resource name")
      @path
      ruleSetName: string;
    },
    void
  >;
}

interface VMHostOperations {
  @summary("List the vm resources currently being monitored by the Elastic monitor resource.")
  @doc("List the vm resources currently being monitored by the Elastic monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/listVMHost")
  @post
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    VMHostListResponse
  >;
}

interface VMIngestionOperations {
  @summary("""
List the vm ingestion details that will be monitored by the Elastic monitor
resource.
""")
  @doc("""
List the vm ingestion details that will be monitored by the Elastic monitor
resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/vmIngestionDetails")
  @post
  Details is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;
    },
    VMIngestionDetailsResponse
  >;
}

interface VMCollectionOperations {
  @summary("Update the vm details that will be monitored by the Elastic monitor resource.")
  @doc("Update the vm details that will be monitored by the Elastic monitor resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Elastic/monitors/{monitorName}/vmCollectionUpdate")
  @post
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The Azure subscription ID. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000)
""")
      @path
      subscriptionId: string;

      @doc("The name of the resource group to which the Elastic resource belongs.")
      @path
      resourceGroupName: string;

      @doc("Monitor resource name")
      @path
      monitorName: string;

      @doc("VM resource Id")
      @body
      body: VMCollectionUpdate;
    },
    void
  >;
}
