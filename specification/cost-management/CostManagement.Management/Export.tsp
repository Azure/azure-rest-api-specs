import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * An export resource.
 */
@extensionResource
model Export is Azure.ResourceManager.ExtensionResource<ExportProperties> {
  ...ResourceNameParameter<
    Resource = Export,
    KeyName = "exportName",
    SegmentName = "exports",
    NamePattern = ""
  >;

  /**
   * The managed identity associated with Export
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity;

  /**
   * The location of the Export's managed identity. Only required when utilizing managed identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface Exports {
  /**
   * The operation to get the export for the defined scope by export name.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    Export,
    Parameters = {
      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last 10 runs of the export.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update a export. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    Export
  >;

  /**
   * The operation to delete a export.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    Export,
    Response = ArmDeletedResponse
  >;

  /**
   * The operation to list all exports at the given scope.
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    Export,
    Parameters = {
      /**
       * May be used to expand the properties within an export. Currently only 'runHistory' is supported and will return information for the last run of each export.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<ExportListResult>
  >;

  /**
   * The operation to run an export.
   */
  @action("run")
  execute is Extension.ActionSync<
    Extension.ScopeParameter,
    Export,
    ExportRunRequest,
    OkResponse,
    OptionalRequestBody = true
  >;

  /**
   * The operation to get the run history of an export for the defined scope and export name.
   */
  @get
  @action("runHistory")
  getExecutionHistory is Extension.ActionSync<
    Extension.ScopeParameter,
    Export,
    void,
    ArmResponse<ExportExecutionListResult>
  >;
}

@@doc(Export.name, "Export Name.");
@@doc(Export.properties, "The properties of the export.");
@@doc(Exports.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Export operation."
);
@@doc(Exports.execute::parameters.body,
  "Parameters supplied to the Execute Export operation."
);
