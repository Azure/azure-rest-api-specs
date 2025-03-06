import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";
import "./../models/servicemodels.tsp";

using TypeSpec.Versioning;
using MdsCommon;
using TypeSpec.Http;
using ServiceModels;
using Azure.Core;

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
  op listAllEntities is Azure.Core.Foundations.NonPagedResourceList<EntityInfo>;

  @doc("Create a new entity.")
  @pollingOperation(getEntityJobStatus)
  op createOrReplaceEntity is Operations.LongRunningResourceCreateOrReplace<
    Entity,
    CommonAcceptedResponse
  >;

  @doc("Patch an existing entity.")
  op updateEntity is Operations.ResourceCreateOrUpdate<Entity>;

  @doc("Get an entity schema by name.")
  op getEntity is Operations.ResourceRead<Entity>;

  @doc("Delete an entity schema by name.")
  op deleteEntity is Operations.ResourceDelete<Entity>;

  @doc("Create a NormalizationTable.")
  op createOrReplaceNormalizationTable is Operations.ResourceCreateOrReplace<NormalizationTable>;

  @doc("Update NormalizationTable.")
  op updateNormalizationTable is Operations.ResourceCreateOrUpdate<NormalizationTable>;

  @doc("Delete NormalizationTable.")
  op deleteNormalizationTable is Operations.ResourceDelete<NormalizationTable>;

  @doc("Get OPC UA mappings.")
  op listOpcuaMapping is Operations.ResourceList<OpcuaMappingModel>;

  @doc("Create OPC UA mappings.")
  op createOrReplaceOpcuaMapping is Operations.ResourceCreateOrReplace<OpcuaMappingModel>;

  @doc("Update OPC UA mappings.")
  op updateOpcuaMapping is Operations.ResourceCreateOrUpdate<OpcuaMappingModel>;
}
