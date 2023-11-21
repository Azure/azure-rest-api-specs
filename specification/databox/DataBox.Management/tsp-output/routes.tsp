import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DataBoxManagementClient;

interface OperationsOperations {
  @doc("This method gets all the operations.")
  @route("/providers/Microsoft.DataBox/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationList>;
}

interface JobsOperations {
  @doc("Lists all the jobs available under the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/jobs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("""
$skipToken is supported on Get list of jobs, which provides the next page in
the list of jobs.
""")
      @query
      $skipToken: string;
    },
    JobResourceList
  >;

  @doc("Request to mark devices for a given job as shipped")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}/markDevicesShipped")
  @post
  MarkDevicesShipped is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("Mark Devices Shipped Request")
      @body
      markDevicesShippedRequest: MarkDevicesShippedRequest;
    },
    void
  >;

  @doc("Lists all the jobs available under the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
$skipToken is supported on Get list of jobs, which provides the next page in
the list of jobs.
""")
      @query
      $skipToken: string;
    },
    JobResourceList
  >;

  @doc("Gets information about the specified job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("""
$expand is supported on details parameter for job, which provides details on
the job stages.
""")
      @query
      $expand: string;
    },
    JobResource
  >;

  @doc("""
Creates a new job with the specified parameters. Existing job cannot be updated
with this API and should instead be updated with the Update job API.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("Job details from request body.")
      @body
      jobResource: JobResource;
    },
    JobResource | void
  >;

  @doc("Deletes a job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;
    },
    void
  >;

  @doc("Updates the properties of an existing job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("""
Defines the If-Match condition. The patch will be performed only if the ETag of
the job on the server matches this value.
""")
      @header
      `If-Match`: string;

      @doc("Job update parameters from request body.")
      @body
      jobResourceUpdateParameter: JobResourceUpdateParameter;
    },
    JobResource | void
  >;

  @doc("Book shipment pick up.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}/bookShipmentPickUp")
  @post
  BookShipmentPickUp is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("Details of shipment pick up request.")
      @body
      shipmentPickUpRequest: ShipmentPickUpRequest;
    },
    ShipmentPickUpResponse
  >;

  @doc("CancelJob.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}/cancel")
  @post
  Cancel is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;

      @doc("Reason for cancellation.")
      @body
      cancellationReason: CancellationReason;
    },
    void
  >;

  @doc("This method gets the unencrypted secrets related to the job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}/listCredentials")
  @post
  ListCredentials is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
      @path
      jobName: string;
    },
    UnencryptedCredentialsList
  >;
}

@doc("Request to mitigate for a given job")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/jobs/{jobName}/mitigate")
@post
op Mitigate is Azure.Core.Foundations.Operation<
  {
    @doc("""
The name of the job Resource within the specified resource group. job names
must be between 3 and 24 characters in length and use any alphanumeric and
underscore only
""")
    @path
    jobName: string;

    @doc("The Subscription Id")
    @path
    subscriptionId: string;

    @doc("The Resource Group Name")
    @path
    resourceGroupName: string;

    @doc("Mitigation Request")
    @body
    mitigateJobRequest: MitigateJobRequest;
  },
  void
>;

interface ServiceOperations {
  @doc("""
This method provides the list of available skus for the given subscription,
resource group and location.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/availableSkus")
  @post
  ListAvailableSkusByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Filters for showing the available skus.")
      @body
      availableSkuRequest: AvailableSkuRequest;
    },
    AvailableSkusResult
  >;

  @doc("""
[DEPRECATED NOTICE: This operation will soon be removed]. This method validates
the customer shipping address and provide alternate addresses if any.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/validateAddress")
  @post
  ValidateAddress is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Shipping address of the customer.")
      @body
      validateAddress: ValidateAddress;
    },
    AddressValidationOutput
  >;

  @doc("This method does all necessary pre-job creation validation under resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/validateInputs")
  @post
  ValidateInputsByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Inputs of the customer.")
      @body
      validationRequest: ValidationRequest;
    },
    ValidationResponse
  >;

  @doc("This method does all necessary pre-job creation validation under subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/validateInputs")
  @post
  ValidateInputs is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Inputs of the customer.")
      @body
      validationRequest: ValidationRequest;
    },
    ValidationResponse
  >;

  @doc("""
This API provides configuration details specific to given region/location at
Subscription level.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataBox/locations/{location}/regionConfiguration")
  @post
  RegionConfiguration is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Request body to get the configuration for the region.")
      @body
      regionConfigurationRequest: RegionConfigurationRequest;
    },
    RegionConfigurationResponse
  >;

  @doc("""
This API provides configuration details specific to given region/location at
Resource group level.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataBox/locations/{location}/regionConfiguration")
  @post
  RegionConfigurationByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription Id")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name")
      @path
      resourceGroupName: string;

      @doc("The location of the resource")
      @path
      location: string;

      @doc("Request body to get the configuration for the region at resource group level.")
      @body
      regionConfigurationRequest: RegionConfigurationRequest;
    },
    RegionConfigurationResponse
  >;
}
