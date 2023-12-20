import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A lab.")
model DevTestLab is TrackedResource<LabProperties> {
  @doc("The name of the lab.")
  @path
  @key("name")
  @segment("labs")
  name: string;
}

@armResourceOperations
interface DevTestLabs {
  @doc("Get lab.")
  get is ArmResourceRead<
    DevTestLab,
    {
      ...BaseParameters<DevTestLab>;

      @doc("Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing lab. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLab>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of labs. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLab, LabFragment>;
  @doc("Delete lab. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DevTestLab>;
  @doc("List labs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DevTestLab,
    {
      ...BaseParameters<DevTestLab>;

      @doc("Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
  @doc("List labs in a subscription.")
  listBySubscription is ArmListBySubscription<DevTestLab>;
  @doc("Claim a random claimable virtual machine in the lab. This operation can take a while to complete.")
  claimAnyVm is ArmResourceActionAsync<DevTestLab, void, void>;
  @doc("Create virtual machines in a lab. This operation can take a while to complete.")
  createEnvironment is ArmResourceActionAsync<
    DevTestLab,
    LabVirtualMachineCreationParameter,
    void
  >;
  @doc("Exports the lab resource usage into a storage account This operation can take a while to complete.")
  exportResourceUsage is ArmResourceActionAsync<
    DevTestLab,
    ExportResourceUsageParameters,
    void
  >;
  @doc("Generate a URI for uploading custom disk images to a Lab.")
  generateUploadUri is ArmResourceActionSync<
    DevTestLab,
    GenerateUploadUriParameter,
    GenerateUploadUriResponse
  >;
  @doc("Import a virtual machine into a different lab. This operation can take a while to complete.")
  importVirtualMachine is ArmResourceActionAsync<
    DevTestLab,
    ImportLabVirtualMachineRequest,
    void
  >;
  @doc("List disk images available for custom image creation.")
  listVhds is ArmResourceActionSync<DevTestLab, void, LabVhdList>;
  @doc("Evaluates lab policy.")
  evaluatePolicies is ArmResourceActionSync<
    DevTestLab,
    EvaluatePoliciesRequest,
    EvaluatePoliciesResponse,
    {
      ...BaseParameters<DevTestLab>;

      @doc("The name of the lab.")
      @path
      labName: string;
    }
  >;
  @doc("List gallery images in a given lab.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/galleryimages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the lab.")
      @path
      labName: string;

      @doc("Specify the $expand query. Example: 'properties($select=author)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    },
    GalleryImageList
  >;
}
