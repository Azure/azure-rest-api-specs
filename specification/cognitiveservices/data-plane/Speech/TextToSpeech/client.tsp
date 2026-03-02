import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using CustomvoiceAPI;

@@clientLocation(ProjectsOperationGroup.list, "Projects");
@@clientLocation(ProjectsOperationGroup.get, "Projects");
@@clientLocation(ProjectsOperationGroup.delete, "Projects");
@@clientLocation(ProjectsOperationGroup.create, "Projects");

@@clientLocation(ConsentsOperationGroup.list, "Consents");
@@clientLocation(ConsentsOperationGroup.get, "Consents");
@@clientLocation(ConsentsOperationGroup.delete, "Consents");
@@clientLocation(ConsentsOperationGroup.create, "Consents");
@@clientLocation(ConsentsOperationGroup.post, "Consents");

@@clientLocation(TrainingSetsOperationGroup.list, "TrainingSets");
@@clientLocation(TrainingSetsOperationGroup.get, "TrainingSets");
@@clientLocation(TrainingSetsOperationGroup.delete, "TrainingSets");
@@clientLocation(TrainingSetsOperationGroup.create, "TrainingSets");
@@clientLocation(TrainingSetsOperationGroup.uploadData, "TrainingSets");

@@clientLocation(ModelsOperationGroup.listRecipes, "Models");
@@clientLocation(ModelsOperationGroup.list, "Models");
@@clientLocation(ModelsOperationGroup.get, "Models");
@@clientLocation(ModelsOperationGroup.delete, "Models");
@@clientLocation(ModelsOperationGroup.create, "Models");

@@clientLocation(EndpointsOperationGroup.list, "Endpoints");
@@clientLocation(EndpointsOperationGroup.get, "Endpoints");
@@clientLocation(EndpointsOperationGroup.delete, "Endpoints");
@@clientLocation(EndpointsOperationGroup.create, "Endpoints");
@@clientLocation(EndpointsOperationGroup.resume, "Endpoints");
@@clientLocation(EndpointsOperationGroup.suspend, "Endpoints");

@@clientLocation(BaseModelsOperationGroup.list, "BaseModels");

@@clientLocation(PersonalVoicesOperationGroup.list, "PersonalVoices");
@@clientLocation(PersonalVoicesOperationGroup.get, "PersonalVoices");
@@clientLocation(PersonalVoicesOperationGroup.delete, "PersonalVoices");
@@clientLocation(PersonalVoicesOperationGroup.create, "PersonalVoices");
@@clientLocation(PersonalVoicesOperationGroup.post, "PersonalVoices");

@@clientLocation(OperationsOperationGroup.get, "Operations");
