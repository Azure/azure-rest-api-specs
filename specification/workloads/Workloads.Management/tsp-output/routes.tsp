import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace WorkloadsClient;

@doc("""
Get SAP sizing recommendations by providing input SAPS for application tier and
memory required for database tier
""")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSizingRecommendations")
@post
op SAPSizingRecommendations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @path
    location: string;

    @doc("SAP Sizing Recommendation Request body")
    @body
    SAPSizingRecommendation: SAPSizingRecommendationRequest;
  },
  SAPSizingRecommendationResult
>;

@doc("Get a list of SAP supported SKUs for ASCS, Application and Database tier.")
// FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
// Problematic names: [SAPSupportedSku]
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSapSupportedSku")
@post
op SAPSupportedSku is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @path
    location: string;

    @doc("SAP Supported SKU Request body")
    @body
    SAPSupportedSku: SAPSupportedSkusRequest;
  },
  SAPSupportedResourceSkusResult
>;

@doc("Get the SAP Disk Configuration Layout prod/non-prod SAP System.")
// FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
// Problematic names: [SAPDiskConfigurations]
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getDiskConfigurations")
@post
op SAPDiskConfigurations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @path
    location: string;

    @doc("SAP Disk Configurations Request body")
    @body
    SAPDiskConfigurations: SAPDiskConfigurationsRequest;
  },
  SAPDiskConfigurationsResult
>;

@doc("Get the recommended SAP Availability Zone Pair Details for your region.")
// FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
// Problematic names: [SAPAvailabilityZoneDetails]
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getAvailabilityZoneDetails")
@post
op SAPAvailabilityZoneDetails is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @path
    location: string;

    @doc("SAP Availability Zone Details Request body")
    @body
    SAPAvailabilityZoneDetails: SAPAvailabilityZoneDetailsRequest;
  },
  SAPAvailabilityZoneDetailsResult
>;

interface SAPVirtualInstancesOperations {
  @doc("Creates a Virtual Instance for SAP solutions (VIS) resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("Virtual Instance for SAP solutions resource request body.")
      @body
      body: SAPVirtualInstance;
    },
    SAPVirtualInstance
  >;

  @doc("Gets a Virtual Instance for SAP solutions resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    SAPVirtualInstance
  >;

  @doc("Updates a Virtual Instance for SAP solutions resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("Request body to update a Virtual Instance for SAP solutions resource.")
      @body
      body: UpdateSAPVirtualInstanceRequest;
    },
    SAPVirtualInstance
  >;

  @doc("""
Deletes a Virtual Instance for SAP solutions resource and its child resources,
that is the associated Central Services Instance, Application Server Instances
and Database Instance.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("Gets all Virtual Instances for SAP solutions resources in a Resource Group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    SAPVirtualInstanceList
  >;

  @doc("Gets all Virtual Instances for SAP solutions resources in a Subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/sapVirtualInstances")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    SAPVirtualInstanceList
  >;

  @doc("""
Starts the SAP application, that is the Central Services instance and
Application server instances.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("""
Stops the SAP Application, that is the Application server instances and Central
Services instance.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/stop")
  @post
  Stop is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The Virtual Instance for SAP solutions resource stop request body.")
      @body
      body: StopRequest;
    },
    OperationStatusResult | void
  >;
}

interface SAPCentralInstancesOperations {
  @doc("Gets the SAP Central Services Instance resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;
    },
    SAPCentralServerInstance
  >;

  @doc("""
Creates the SAP Central Services Instance resource. <br><br>This will be used
by service only. PUT operation on this resource by end user will return a Bad
Request error.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;

      @doc("The SAP Central Services Instance request body.")
      @body
      body: SAPCentralServerInstance;
    },
    SAPCentralServerInstance
  >;

  @doc("""
Updates the SAP Central Services Instance resource. <br><br>This can be used to
update tags on the resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;

      @doc("The SAP Central Services Instance resource request body.")
      @body
      body: UpdateSAPCentralInstanceRequest;
    },
    SAPCentralServerInstance
  >;

  @doc("""
Deletes the SAP Central Services Instance resource. <br><br>This will be used
by service only. Delete operation on this resource by end user will return a
Bad Request error. You can delete the parent resource, which is the Virtual
Instance for SAP solutions resource, using the delete operation on it.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("""
Lists the SAP Central Services Instance resource for the given Virtual Instance
for SAP solutions resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    SAPCentralInstanceList
  >;

  @doc("Starts the SAP Central Services Instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}/start")
  @post
  StartInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("Stops the SAP Central Services Instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/centralInstances/{centralInstanceName}/stop")
  @post
  StopInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Central Services Instance resource name string modeled as parameter for auto
generation to work correctly.
""")
      @path
      centralInstanceName: string;

      @doc("SAP Central Services instance stop request body.")
      @body
      body: StopRequest;
    },
    OperationStatusResult | void
  >;
}

interface SAPDatabaseInstancesOperations {
  @doc("Gets the SAP Database Instance resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;
    },
    SAPDatabaseInstance
  >;

  @doc("""
Creates the Database resource corresponding to the Virtual Instance for SAP
solutions resource. <br><br>This will be used by service only. PUT by end user
will return a Bad Request error.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;

      @doc("Request body of Database resource of a SAP system.")
      @body
      body: SAPDatabaseInstance;
    },
    SAPDatabaseInstance
  >;

  @doc("Updates the Database resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;

      @doc("Database resource update request body.")
      @body
      body: UpdateSAPDatabaseInstanceRequest;
    },
    SAPDatabaseInstance
  >;

  @doc("""
Deletes the Database resource corresponding to a Virtual Instance for SAP
solutions resource. <br><br>This will be used by service only. Delete by end
user will return a Bad Request error.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("""
Lists the Database resources associated with a Virtual Instance for SAP
solutions resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    SAPDatabaseInstanceList
  >;

  @doc("Starts the database instance of the SAP system.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}/start")
  @post
  StartInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("Stops the database instance of the SAP system.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/databaseInstances/{databaseInstanceName}/stop")
  @post
  StopInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("""
Database resource name string modeled as parameter for auto generation to work
correctly.
""")
      @path
      databaseInstanceName: string;

      @doc("Stop request for the database instance of the SAP system.")
      @body
      body: StopRequest;
    },
    OperationStatusResult | void
  >;
}

interface SAPApplicationServerInstancesOperations {
  @doc("""
Gets the SAP Application Server Instance corresponding to the Virtual Instance
for SAP solutions resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;
    },
    SAPApplicationServerInstance
  >;

  @doc("""
Puts the SAP Application Server Instance resource. <br><br>This will be used by
service only. PUT by end user will return a Bad Request error.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;

      @doc("The SAP Application Server Instance resource request body.")
      @body
      body: SAPApplicationServerInstance;
    },
    SAPApplicationServerInstance
  >;

  @doc("Puts the SAP Application Server Instance resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;

      @doc("The SAP Application Server Instance resource request body.")
      @body
      body: UpdateSAPApplicationInstanceRequest;
    },
    SAPApplicationServerInstance
  >;

  @doc("""
Deletes the SAP Application Server Instance resource. <br><br>This operation
will be used by service only. Delete by end user will return a Bad Request
error.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("""
Lists the SAP Application Server Instance resources for a given Virtual
Instance for SAP solutions resource.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;
    },
    SAPApplicationServerInstanceList
  >;

  @doc("Starts the SAP Application Server Instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}/start")
  @post
  StartInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;
    },
    OperationStatusResult | void
  >;

  @doc("Stops the SAP Application Server Instance.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/sapVirtualInstances/{sapVirtualInstanceName}/applicationInstances/{applicationInstanceName}/stop")
  @post
  StopInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Virtual Instances for SAP solutions resource")
      @path
      sapVirtualInstanceName: string;

      @doc("The name of SAP Application Server instance resource.")
      @path
      applicationInstanceName: string;

      @doc("SAP Application server instance stop request body.")
      @body
      body: StopRequest;
    },
    OperationStatusResult | void
  >;
}

interface monitorsOperations {
  @summary("Gets a list of SAP monitors in the specified subscription.")
  @doc("""
Gets a list of SAP monitors in the specified subscription. The operations
returns various properties of each SAP monitor.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/monitors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    MonitorListResult
  >;

  @summary("Gets a list of SAP monitors")
  @doc("Gets a list of SAP monitors in the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    MonitorListResult
  >;

  @summary("Gets properties of a SAP monitor.")
  @doc("""
Gets properties of a SAP monitor for the specified subscription, resource
group, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    Monitor
  >;

  @summary("Creates a SAP monitor.")
  @doc("""
Creates a SAP monitor for the specified subscription, resource group, and
resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Request body representing a SAP monitor")
      @body
      MonitorParameter: Monitor;
    },
    Monitor
  >;

  @summary("Deletes a SAP monitor.")
  @doc("""
Deletes a SAP monitor with the specified subscription, resource group, and SAP
monitor name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    OperationStatusResult | void
  >;

  @summary("Patches the Tags field of a SAP monitor.")
  @doc("""
Patches the Tags field of a SAP monitor for the specified subscription,
resource group, and SAP monitor name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("The Update SAP workload monitor request body.")
      @body
      body: UpdateMonitorRequest;
    },
    Monitor
  >;
}

interface ProviderInstancesOperations {
  @summary("Gets a list of provider instances in the specified SAP monitor.")
  @doc("""
Gets a list of provider instances in the specified SAP monitor. The operations
returns various properties of each provider instances.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/providerInstances")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    ProviderInstanceListResult
  >;

  @summary("Gets properties of a provider instance.")
  @doc("""
Gets properties of a provider instance for the specified subscription, resource
group, SAP monitor name, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/providerInstances/{providerInstanceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Name of the provider instance.")
      @path
      providerInstanceName: string;
    },
    ProviderInstance
  >;

  @summary("Creates a provider instance.")
  @doc("""
Creates a provider instance for the specified subscription, resource group, SAP
monitor name, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/providerInstances/{providerInstanceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Name of the provider instance.")
      @path
      providerInstanceName: string;

      @doc("Request body representing a provider instance")
      @body
      providerInstanceParameter: ProviderInstance;
    },
    ProviderInstance
  >;

  @summary("Deletes a provider instance.")
  @doc("""
Deletes a provider instance for the specified subscription, resource group, SAP
monitor name, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/providerInstances/{providerInstanceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Name of the provider instance.")
      @path
      providerInstanceName: string;
    },
    OperationStatusResult | void
  >;
}

interface SapLandscapeMonitorOperations {
  @summary("Gets configuration values for Single Pane Of Glass for SAP monitor.")
  @doc("""
Gets configuration values for Single Pane Of Glass for SAP monitor for the
specified subscription, resource group, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/sapLandscapeMonitor/default")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    SapLandscapeMonitor
  >;

  @summary("Creates a SAP Landscape Monitor Dashboard.")
  @doc("""
Creates a SAP Landscape Monitor Dashboard for the specified subscription,
resource group, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/sapLandscapeMonitor/default")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Request body representing a configuration for Sap Landscape Monitor Dashboard")
      @body
      sapLandscapeMonitorParameter: SapLandscapeMonitor;
    },
    SapLandscapeMonitor
  >;

  @summary("Deletes a SAP Landscape Monitor Dashboard.")
  @doc("""
Deletes a SAP Landscape Monitor Dashboard with the specified subscription,
resource group, and SAP monitor name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/sapLandscapeMonitor/default")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    void
  >;

  @summary("Patches the SAP Landscape Monitor Dashboard.")
  @doc("""
Patches the SAP Landscape Monitor Dashboard for the specified subscription,
resource group, and SAP monitor name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/sapLandscapeMonitor/default")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;

      @doc("Request body representing a configuration for Sap Landscape Monitor Dashboard")
      @body
      sapLandscapeMonitorParameter: SapLandscapeMonitor;
    },
    SapLandscapeMonitor
  >;

  @summary("Gets configuration values for Single Pane Of Glass for SAP monitor.")
  @doc("""
Gets configuration values for Single Pane Of Glass for SAP monitor for the
specified subscription, resource group, and resource name.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Workloads/monitors/{monitorName}/sapLandscapeMonitor")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of the SAP monitor resource.")
      @path
      monitorName: string;
    },
    SapLandscapeMonitorListResult
  >;
}

interface OperationsOperations {
  @doc("Lists all the available API operations under this PR")
  @route("/providers/Microsoft.Workloads/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
