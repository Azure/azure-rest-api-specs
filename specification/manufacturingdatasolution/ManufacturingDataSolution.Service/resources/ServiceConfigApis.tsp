import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";
import "./../models/servicemodels.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using MdsCommon;
using TypeSpec.Http;
using ServiceModels;
using Azure.Core;
using Azure.Core.Traits;

@versioned(MdsSolution.Versions)
namespace MdsSolution.ServiceApis {
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This is not a versioned operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  @doc("Get the health of the service.    ")
  @route("health")
  @get
  op getServiceHealth(): GenericOkResponse<MdsHealth>;

  @doc("Get the status of an entity job.")
  op getEntityJobStatus is Operations.ResourceRead<JobStatusResponse>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  @doc("Get all entities.")
  op listAllEntities is Azure.Core.Foundations.NonPagedResourceList<
    EntityInfo,
    QueryParametersTrait<{
      @query("top")
      @doc("Return up to the specified number of items from the top. Default is 10.")
      top?: int32 = 10;
    }>
  >;

  @doc("Create a new entity.")
  @pollingOperation(getEntityJobStatus)
  op createEntity is Operations.LongRunningResourceCreateWithServiceProvidedName<
    Entity,
    ResponseHeadersTrait<{
      @doc("The background job location.")
      @header("Operation-Location")
      @pollingLocation
      operationLocation: string;
    }>
  >;

  @pollingOperation(getEntityJobStatus)
  @doc("Update an existing entity.")
  @action("update")
  op updateEntity is Operations.LongRunningResourceCollectionAction<
    Entity,
    Entity,
    {},
    ResponseHeadersTrait<{
      @doc("The background job location.")
      @header("Operation-Location")
      @pollingLocation
      operationLocation: string;
    }>
  >;

  @doc("Get an entity schema by name.")
  op getEntity is Operations.ResourceRead<Entity>;

  @doc("Delete an entity schema by name.")
  op deleteEntity is Operations.ResourceDelete<Entity>;

  @doc("Get NormalizationTable.")
  op getNormalizationTable is Operations.ResourceRead<
    NormalizationTable,
    QueryParametersTrait<{
      @query("version")
      @doc("Version of the table.")
      version?: string;
    }>
  >;

  @doc("Create a NormalizationTable.")
  op createOrReplaceNormalizationTable is Operations.ResourceCreateOrReplace<NormalizationTable>;

  @doc("Update NormalizationTable.")
  op updateNormalizationTable is Operations.ResourceCreateOrUpdate<NormalizationTable>;

  @doc("Delete NormalizationTable.")
  op deleteNormalizationTable is Operations.ResourceDelete<
    NormalizationTable,
    QueryParametersTrait<
      {
        @query("version")
        @doc("Version of the table.")
        version: string;

        @query("force-delete")
        @doc("Force delete the resource.")
        forceDelete: boolean;
      },
      TraitContext.Delete
    >
  >;

  @doc("Get OPC UA mappings.")
  op listOpcuaMapping is Operations.ResourceList<
    OpcuaMappingModel,
    QueryParametersTrait<{
      @query("entityName")
      @doc("The name of the entity.")
      entityName: string;
    }>
  >;

  @doc("Create OPC UA mappings.")
  op createOrReplaceOpcuaMapping is Operations.ResourceCreateOrReplace<OpcuaMappingModel>;

  @doc("Update OPC UA mappings.")
  op updateOpcuaMapping is Operations.ResourceCreateOrUpdate<OpcuaMappingModel>;
}
