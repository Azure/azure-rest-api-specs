import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace LabServicesClient;

interface ImagesOperations {
  @summary("Gets all images.")
  @doc("Gets all images from galleries attached to a lab plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}/images")
  @get
  ListByLabPlan is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedImages
  >;

  @summary("Gets an image.")
  @doc("Gets an image resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}/images/{imageName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The image name.")
      @path
      imageName: string;
    },
    Image
  >;

  @summary("Updates an image via PUT.")
  @doc("""
Updates an image resource via PUT. Creating new resources via PUT will not
function.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}/images/{imageName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The image name.")
      @path
      imageName: string;

      @doc("The request body.")
      @body
      body: Image;
    },
    Image
  >;

  @summary("Updates an image.")
  @doc("Updates an image resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}/images/{imageName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The image name.")
      @path
      imageName: string;

      @doc("The request body.")
      @body
      body: ImageUpdate;
    },
    Image
  >;
}

interface LabPlansOperations {
  @summary("Get all lab plans for a subscription.")
  @doc("Returns a list of all lab plans within a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/labPlans")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedLabPlans
  >;

  @summary("Get all lab plans for a subscription and resource group.")
  @doc("Returns a list of all lab plans for a subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans")
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
    PagedLabPlans
  >;

  @summary("Retrieves a Lab Plan resource.")
  @doc("Retrieves the properties of a Lab Plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;
    },
    LabPlan
  >;

  @summary("Updates or creates a Lab Plan resource.")
  @doc("Operation to create or update a Lab Plan resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The request body.")
      @body
      body: LabPlan;
    },
    LabPlan
  >;

  @summary("Updates a Lab Plan resource.")
  @doc("Operation to update a Lab Plan resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The request body.")
      @body
      body: LabPlanUpdate;
    },
    LabPlan
  >;

  @summary("Deletes a Lab Plan resource.")
  @doc("""
Operation to delete a Lab Plan resource. Deleting a lab plan does not delete
labs associated with a lab plan, nor does it delete shared images added to a
gallery via the lab plan permission container.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;
    },
    void
  >;

  @summary("Save an image from a lab VM to the attached shared image gallery.")
  @doc("Saves an image from a lab VM to the attached shared image gallery.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labPlans/{labPlanName}/saveImage")
  @post
  SaveImage is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab plan that uniquely identifies it within containing resource
group. Used in resource URIs and in UI.
""")
      @path
      labPlanName: string;

      @doc("The request body.")
      @body
      body: SaveImageBody;
    },
    void
  >;
}

interface OperationsOperations {
  @summary("Get all operations")
  @doc("Returns a list of all operations.")
  @route("/providers/Microsoft.LabServices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface LabsOperations {
  @summary("Get all labs for a subscription.")
  @doc("Returns a list of all labs for a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/labs")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedLabs
  >;

  @summary("Get all labs for a subscription and resource group.")
  @doc("Returns a list of all labs in a resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs")
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
    PagedLabs
  >;

  @summary("Get a lab resource.")
  @doc("Returns the properties of a lab resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;
    },
    Lab
  >;

  @summary("Create or update a lab resource.")
  @doc("Operation to create or update a lab resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("The request body.")
      @body
      body: Lab;
    },
    Lab
  >;

  @summary("Update a lab resource.")
  @doc("Operation to update a lab resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("The request body.")
      @body
      body: LabUpdate;
    },
    Lab
  >;

  @summary("Deletes a lab resource.")
  @doc("Operation to delete a lab resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;
    },
    void
  >;

  @summary("Publish or re-publish a lab.")
  @doc("""
Publish or re-publish a lab. This will create or update all lab resources, such
as virtual machines.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/publish")
  @post
  Publish is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;
    },
    void
  >;

  @summary("Manually sync the lab group.")
  @doc("Action used to manually kick off an AAD group sync job.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/syncGroup")
  @post
  SyncGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;
    },
    void
  >;
}

interface OperationResultsOperations {
  @summary("Get an azure operation result.")
  @doc("Returns an azure operation result.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/operationResults/{operationResultId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The operation result ID / name.")
      @path
      operationResultId: string;
    },
    OperationResult | void
  >;
}

interface SchedulesOperations {
  @summary("Get all schedules for a lab.")
  @doc("Returns a list of all schedules for a lab.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/schedules")
  @get
  ListByLab is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedSchedules
  >;

  @summary("Get a lab Schedule.")
  @doc("Returns the properties of a lab Schedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/schedules/{scheduleName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the schedule that uniquely identifies it within containing lab.
Used in resource URIs.
""")
      @path
      scheduleName: string;
    },
    Schedule
  >;

  @summary("Create or update a lab schedule.")
  @doc("Operation to create or update a lab schedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/schedules/{scheduleName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the schedule that uniquely identifies it within containing lab.
Used in resource URIs.
""")
      @path
      scheduleName: string;

      @doc("The request body.")
      @body
      body: Schedule;
    },
    Schedule
  >;

  @summary("Update a lab schedule.")
  @doc("Operation to update a lab schedule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/schedules/{scheduleName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the schedule that uniquely identifies it within containing lab.
Used in resource URIs.
""")
      @path
      scheduleName: string;

      @doc("The request body.")
      @body
      body: ScheduleUpdate;
    },
    Schedule
  >;

  @summary("Deletes a schedule resource.")
  @doc("Operation to delete a schedule resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/schedules/{scheduleName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the schedule that uniquely identifies it within containing lab.
Used in resource URIs.
""")
      @path
      scheduleName: string;
    },
    void
  >;
}

interface SkusOperations {
  @summary("Gets the Azure Lab Services resource SKUs.")
  @doc("Returns a list of Azure Lab Services resource SKUs.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/skus")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedLabServicesSkus
  >;
}

interface UsagesOperations {
  @summary("Gets the list of usages.")
  @doc("""
Returns list of usage per SKU family for the specified subscription in the
specified region.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.LabServices/locations/{location}/usages")
  @get
  ListByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The location name.")
      @path
      location: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    ListUsagesResult
  >;
}

interface UsersOperations {
  @summary("Get all users for a lab.")
  @doc("Returns a list of all users for a lab.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users")
  @get
  ListByLab is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedUsers
  >;

  @summary("Get a lab user.")
  @doc("Returns the properties of a lab user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users/{userName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the user that uniquely identifies it within containing lab. Used in
resource URIs.
""")
      @path
      userName: string;
    },
    User
  >;

  @summary("Create or update a lab user.")
  @doc("Operation to create or update a lab user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users/{userName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the user that uniquely identifies it within containing lab. Used in
resource URIs.
""")
      @path
      userName: string;

      @doc("The request body.")
      @body
      body: User;
    },
    User
  >;

  @summary("Update a lab user.")
  @doc("Operation to update a lab user.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users/{userName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the user that uniquely identifies it within containing lab. Used in
resource URIs.
""")
      @path
      userName: string;

      @doc("The request body.")
      @body
      body: UserUpdate;
    },
    User
  >;

  @summary("Deletes a user resource.")
  @doc("Operation to delete a user resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users/{userName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the user that uniquely identifies it within containing lab. Used in
resource URIs.
""")
      @path
      userName: string;
    },
    void
  >;

  @summary("Invite a user to a lab.")
  @doc("Operation to invite a user to a lab.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/users/{userName}/invite")
  @post
  Invite is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The name of the user that uniquely identifies it within containing lab. Used in
resource URIs.
""")
      @path
      userName: string;

      @doc("The request body.")
      @body
      body: InviteBody;
    },
    void
  >;
}

interface VirtualMachinesOperations {
  @summary("Get all virtual machines for a lab.")
  @doc("Returns a list of all virtual machines for a lab.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines")
  @get
  ListByLab is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("The filter to apply to the operation.")
      @query
      $filter: string;
    },
    PagedVirtualMachines
  >;

  @summary("Get a lab virtual machine.")
  @doc("Returns the properties for a lab virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;
    },
    VirtualMachine
  >;

  @summary("Start a lab virtual machine.")
  @doc("Action to start a lab virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}/start")
  @post
  Start is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("Stop a lab virtual machine.")
  @doc("Action to stop a lab virtual machine.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}/stop")
  @post
  Stop is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("Re-image a lab virtual machine.")
  @doc("""
Re-image a lab virtual machine. The virtual machine will be deleted and
recreated using the latest published snapshot of the reference environment of
the lab.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}/reimage")
  @post
  Reimage is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("""
Redeploy a lab virtual machine to a different compute node. For troubleshooting
connectivity.
""")
  @doc("""
Action to redeploy a lab virtual machine to a different compute node. For
troubleshooting connectivity.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}/redeploy")
  @post
  Redeploy is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;
    },
    void
  >;

  @summary("Reset a lab virtual machine password.")
  @doc("Resets a lab virtual machine password.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LabServices/labs/{labName}/virtualMachines/{virtualMachineName}/resetPassword")
  @post
  ResetPassword is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("""
The name of the lab that uniquely identifies it within containing lab plan.
Used in resource URIs.
""")
      @path
      labName: string;

      @doc("""
The ID of the virtual machine that uniquely identifies it within the containing
lab. Used in resource URIs.
""")
      @path
      virtualMachineName: string;

      @doc("The request body.")
      @body
      body: ResetPasswordBody;
    },
    void
  >;
}
