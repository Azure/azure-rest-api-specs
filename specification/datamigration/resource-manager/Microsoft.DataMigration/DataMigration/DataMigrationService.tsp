import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * An Azure Database Migration Service (classic) resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataMigrationService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DataMigrationServiceProperties> {
  ...ResourceNameParameter<
    Resource = DataMigrationService,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;

  /**
   * HTTP strong entity tag value. Ignored if submitted
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The resource kind. Only 'vm' (the default) is supported.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Service SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ServiceSku;
}

alias DataMigrationServiceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** Name of the resource group */
    @path
    @segment("resourceGroups")
    @key
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** Name of the service */
    @path
    @segment("services")
    @key
    serviceName: string;
  },
  ApiError
>;

@armResourceOperations(#{ omitTags: true })
interface DataMigrationServices {
  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). The GET method retrieves information about a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_Get")
  @summary("Get DMS (classic) Service Instance")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  get is DataMigrationServiceOps.Read<DataMigrationService>;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). The PUT method creates a new service or updates an existing one. When a service is updated, existing child resources (i.e. tasks) are unaffected. Services currently support a single kind, "vm", which refers to a VM-based service, although other kinds may be added in the future. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request ("ServiceIsBusy"). The provider will reply when successful with 200 OK or 201 Created. Long-running operations use the provisioningState property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_CreateOrUpdate")
  @summary("Create or update DMS (classic) Instance")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is DataMigrationServiceOps.CreateOrUpdateAsync<
    DataMigrationService,
    Response = ArmResourceUpdatedResponse<DataMigrationService> | ArmResourceCreatedResponse<
      DataMigrationService,
      ArmLroLocationHeader<FinalResult = DataMigrationService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). The PATCH method updates an existing service. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request ("ServiceIsBusy").
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_Update")
  @summary("Create or update DMS (classic) Service Instance")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is DataMigrationServiceOps.CustomPatchAsync<
    DataMigrationService,
    PatchModel = DataMigrationService
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). The DELETE method deletes a service. Any running tasks will be canceled.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_Delete")
  @summary("Delete DMS (classic) Service Instance")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is DataMigrationServiceOps.DeleteWithoutOkAsync<
    DataMigrationService,
    Parameters = {
      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * The Services resource is the top-level resource that represents the Azure Database Migration Service (classic). This method returns a list of service resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_ListByResourceGroup")
  @summary("Get services in resource group")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  listByResourceGroup is DataMigrationServiceOps.List<
    DataMigrationService,
    Response = ArmResponse<DataMigrationServiceList>
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This method returns a list of service resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_List")
  @summary("Get services in subscription")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  list is ArmListBySubscription<
    DataMigrationService,
    Response = ArmResponse<DataMigrationServiceList>,
    Error = ApiError
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This action performs a health check and returns the status of the service and virtual machine size.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_CheckStatus")
  @summary("Check service health status")
  @tag("Service resource")
  @tag("Custom operation")
  @tag("POST")
  checkStatus is DataMigrationServiceOps.ActionSync<
    DataMigrationService,
    void,
    ArmResponse<DataMigrationServiceStatusResponse>
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This action starts the service and the service can be used for data migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_Start")
  @summary("Start service")
  @tag("Service resource")
  @tag("Custom operation")
  @tag("POST")
  start is DataMigrationServiceOps.ActionAsync<
    DataMigrationService,
    void,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This action stops the service and the service cannot be used for data migration. The service owner won't be billed when the service is stopped.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_Stop")
  @summary("Stop service")
  @tag("Service resource")
  @tag("Custom operation")
  @tag("POST")
  stop is DataMigrationServiceOps.ActionAsync<
    DataMigrationService,
    void,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * The services resource is the top-level resource that represents the Database Migration Service (classic). The skus action returns the list of SKUs that a service resource can be updated to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_ListSkus")
  @summary("Get compatible SKUs")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  @list
  @get
  @action("skus")
  listSkus is DataMigrationServiceOps.ActionSync<
    DataMigrationService,
    void,
    ArmResponse<ServiceSkuList>
  >;

  /**
   * This method checks whether a proposed nested resource name is valid and available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Services_CheckChildrenNameAvailability")
  @summary("Check nested resource name validity and availability")
  @tag("Custom operation")
  @tag("POST")
  @action("checkNameAvailability")
  checkChildrenNameAvailability is DataMigrationServiceOps.ActionSync<
    DataMigrationService,
    NameAvailabilityRequest,
    ArmResponse<NameAvailabilityResponse>
  >;
}

@@doc(DataMigrationService.name, "Name of the service");
@@doc(DataMigrationService.properties, "Custom service properties");
@@doc(DataMigrationServices.createOrUpdate::parameters.resource,
  "Information about the service"
);
@@doc(DataMigrationServices.update::parameters.properties,
  "Information about the service"
);
@@doc(DataMigrationServices.checkChildrenNameAvailability::parameters.body,
  "Requested name to validate"
);
