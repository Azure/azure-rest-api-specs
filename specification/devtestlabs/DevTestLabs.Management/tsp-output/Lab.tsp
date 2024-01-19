import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("A lab.")
model Lab is TrackedResource<LabProperties> {
  @doc("The name of the lab.")
  @path
  @key("name")
  @segment("labs")
  name: string;
}

@armResourceOperations
interface Labs {
  @doc("Get lab.")
  get is ArmResourceRead<
    Lab,
    {
      ...BaseParameters<Lab>;

      @doc("Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing lab. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Lab>;

  @doc("Allows modifying tags of labs. All other properties will be ignored.")
  update is ArmCustomPatchSync<Lab, LabFragment>;

  @doc("Delete lab. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<Lab>;

  @doc("List labs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Lab,
    {
      ...BaseParameters<Lab>;

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
  listBySubscription is ArmListBySubscription<Lab>;

  @doc("Claim a random claimable virtual machine in the lab. This operation can take a while to complete.")
  claimAnyVm is ArmResourceActionAsync<Lab, void, void>;

  @doc("Create virtual machines in a lab. This operation can take a while to complete.")
  createEnvironment is ArmResourceActionAsync<
    Lab,
    LabVirtualMachineCreationParameter,
    void
  >;

  @doc("Exports the lab resource usage into a storage account This operation can take a while to complete.")
  exportResourceUsage is ArmResourceActionAsync<
    Lab,
    ExportResourceUsageParameters,
    void
  >;

  @doc("Generate a URI for uploading custom disk images to a Lab.")
  generateUploadUri is ArmResourceActionSync<
    Lab,
    GenerateUploadUriParameter,
    GenerateUploadUriResponse
  >;

  @doc("Import a virtual machine into a different lab. This operation can take a while to complete.")
  importVirtualMachine is ArmResourceActionAsync<
    Lab,
    ImportLabVirtualMachineRequest,
    void
  >;

  @doc("List disk images available for custom image creation.")
  listVhds is ArmResourceActionSync<Lab, void, LabVhdList>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Evaluates lab policy.")
  @operationId("PolicySets_EvaluatePolicies")
  evaluatePolicies is ArmResourceActionSync<
    Lab,
    EvaluatePoliciesRequest,
    EvaluatePoliciesResponse,
    {
      ...BaseParameters<Lab>;

      @doc("The name of the lab.")
      @path
      labName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GalleryImages_List")
  @doc("List gallery images in a given lab.")
  // FIXME: GalleryImages_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/galleryimages")
  @get
  list is Azure.Core.Foundations.Operation<
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

@@projectedName(Labs.createOrUpdate::parameters.resource, "json", "lab");
@@extension(Labs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "lab"
);
@@doc(Labs.createOrUpdate::parameters.resource, "A lab.");
@@projectedName(Labs.update::parameters.properties, "json", "lab");
@@extension(Labs.update::parameters.properties, "x-ms-client-name", "lab");
@@doc(Labs.update::parameters.properties, "A lab.");
@@projectedName(Labs.createEnvironment::parameters.body,
  "json",
  "labVirtualMachineCreationParameter"
);
@@extension(Labs.createEnvironment::parameters.body,
  "x-ms-client-name",
  "labVirtualMachineCreationParameter"
);
@@doc(Labs.createEnvironment::parameters.body,
  "Properties for creating a virtual machine."
);
@@projectedName(Labs.exportResourceUsage::parameters.body,
  "json",
  "exportResourceUsageParameters"
);
@@extension(Labs.exportResourceUsage::parameters.body,
  "x-ms-client-name",
  "exportResourceUsageParameters"
);
@@doc(Labs.exportResourceUsage::parameters.body,
  "The parameters of the export operation."
);
@@projectedName(Labs.generateUploadUri::parameters.body,
  "json",
  "generateUploadUriParameter"
);
@@extension(Labs.generateUploadUri::parameters.body,
  "x-ms-client-name",
  "generateUploadUriParameter"
);
@@doc(Labs.generateUploadUri::parameters.body,
  "Properties for generating an upload URI."
);
@@projectedName(Labs.importVirtualMachine::parameters.body,
  "json",
  "importLabVirtualMachineRequest"
);
@@extension(Labs.importVirtualMachine::parameters.body,
  "x-ms-client-name",
  "importLabVirtualMachineRequest"
);
@@doc(Labs.importVirtualMachine::parameters.body,
  "This represents the payload required to import a virtual machine from a different lab into the current one"
);
@@projectedName(Labs.evaluatePolicies::parameters.body,
  "json",
  "evaluatePoliciesRequest"
);
@@extension(Labs.evaluatePolicies::parameters.body,
  "x-ms-client-name",
  "evaluatePoliciesRequest"
);
@@doc(Labs.evaluatePolicies::parameters.body,
  "Request body for evaluating a policy set."
);
