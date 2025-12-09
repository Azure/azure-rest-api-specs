import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A lab.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Lab extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("labs")
  name: string;

  properties: LabProperties;
}

@armResourceOperations
interface Labs {
  /**
   * Get lab.
   */
  get is ArmResourceRead<
    Lab,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing lab. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Lab,
    LroHeaders = ArmLroLocationHeader<FinalResult = Lab> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of labs. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Lab, PatchModel = LabFragment>;

  /**
   * Delete lab. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Lab,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List labs in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Lab,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<LabList>
  >;

  /**
   * List labs in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Lab,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=defaultStorageAccount)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<LabList>
  >;

  /**
   * Claim a random claimable virtual machine in the lab. This operation can take a while to complete.
   */
  claimAnyVm is ArmResourceActionAsync<Lab, void, OkResponse>;

  /**
   * Create virtual machines in a lab. This operation can take a while to complete.
   */
  createEnvironment is ArmResourceActionAsync<
    Lab,
    LabVirtualMachineCreationParameter,
    OkResponse
  >;

  /**
   * Exports the lab resource usage into a storage account This operation can take a while to complete.
   */
  exportResourceUsage is ArmResourceActionAsync<
    Lab,
    ExportResourceUsageParameters,
    OkResponse
  >;

  /**
   * Generate a URI for uploading custom disk images to a Lab.
   */
  generateUploadUri is ArmResourceActionSync<
    Lab,
    GenerateUploadUriParameter,
    ArmResponse<GenerateUploadUriResponse>
  >;

  /**
   * Import a virtual machine into a different lab. This operation can take a while to complete.
   */
  importVirtualMachine is ArmResourceActionAsync<
    Lab,
    ImportLabVirtualMachineRequest,
    OkResponse
  >;

  /**
   * List disk images available for custom image creation.
   */
  @list
  listVhds is ArmResourceActionSync<Lab, void, ArmResponse<LabVhdList>>;
}

@@doc(Lab.name, "The name of the lab.");
@@doc(Lab.properties, "The properties of the resource.");
@@doc(Labs.createOrUpdate::parameters.resource, "A lab.");
@@doc(Labs.update::parameters.properties, "A lab.");
@@doc(Labs.createEnvironment::parameters.body,
  "Properties for creating a virtual machine."
);
@@doc(Labs.exportResourceUsage::parameters.body,
  "The parameters of the export operation."
);
@@doc(Labs.generateUploadUri::parameters.body,
  "Properties for generating an upload URI."
);
@@doc(Labs.importVirtualMachine::parameters.body,
  "This represents the payload required to import a virtual machine from a different lab into the current one"
);
