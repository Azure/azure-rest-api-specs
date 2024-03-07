import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.Contoso.Vehicles.Model {  
  @doc("The kind of vehicle.")
  enum VehicleKind {
    @doc("A car.")
    Car,
  
    @doc("A motorcycle.")
    Motorcycle,
  }
  
  @doc("A Workspace to manage vehicles.")
  @resource("workspaces")
  model VehicleWorkspace {
    @key("workspaceName")
    @doc("The name of the Vehicle Workspace.")
    @visibility("read")
    name: string;
  }
    
  @doc("A vehicle.")
  @resource("vehicles")
  @parentResource(VehicleWorkspace)
  @discriminator("vehicleKind")
  model Vehicle {
    @key("vehicleId")
    @doc("The id of the vehicle.")
    @visibility("read")
    id: string;
  
    @doc("The kind of vehicle.")
    @visibility("read", "create", "update")
    vehicleKind: VehicleKind;
  
    @doc("The name of the vehicle manufacturer.")
    @visibility("read", "create")
    manufacturerName: string;
  
    @doc("The model of the vehicle.")
    @visibility("read", "create")
    modelName: string;
  
    @doc("The model of the vehicle.")
    @visibility("read", "create", "update")
    plateNumber: string;
  }
  
  @doc("A car.")
  @resource("cars")
  @parentResource(VehicleWorkspace)
  model Car {
    @key("carId")
    @doc("The id of the vehicle.")
    @visibility("read")
    id: string;
  
    @doc("The kind of vehicle, which is a Car.")
    @visibility("read", "create", "update")
    vehicleKind: VehicleKind.Car;
  
    @doc("The number of doors in the vehicle.")
    @visibility("read", "create")
    numberOfDoors: int8;
  }
  
  @doc("A motorcycle.")
  @resource("motorcycles")
  @parentResource(VehicleWorkspace)
  model Motorcycle {
    @key("motorcycleId")
    @doc("The id of the motorcycle.")
    @visibility("read")
    id: string;
  
    @doc("The kind of vehicle, which is a Motorcycle.")
    @visibility("read", "create", "update")
    vehicleKind: VehicleKind.Motorcycle;
  
    @doc("If the motorcycle has a engine bars installed.")
    @visibility("read", "create")
    hasEngineBars: boolean;
  }  
}
@useDependency(Versions.v1_0_Preview_2)
namespace Azure.Contoso.Vehicles.Operations {
  interface Vehicles {
    @doc("List all Vehicles.")
    listVehicles is ResourceList<Model.Vehicle>;
  }

  interface Cars {
    @doc("Fetch a Car by its id.")
    get is ResourceRead<Model.Car>;

    @doc("Create or Update a Car.")
    createOrUpdate is ResourceCreateOrUpdate<Model.Car>;

    @doc("List all Cars.")
    list is ResourceList<Model.Car>;
  }

  interface Motorcycles {
    @doc("Fetch a Motorcycle by its id.")
    get is ResourceRead<Model.Motorcycle>;

    @doc("Create or Update a Motorcycle.")
    createOrUpdate is ResourceCreateOrUpdate<Model.Motorcycle>;

    @doc("List all Motorcycle.")
    list is ResourceList<Model.Motorcycle>;
  }
}

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service({
  title: "Azure.Contoso.Vehicles service",
})
@versioned(Versions)
namespace Azure.Contoso.Vehicles.Service {
  @doc("The Azure.Contoso service versions.")
  enum Versions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    @doc("The 2022-11-01-preview version of the Azure.Contoso service.")
    `2022-11-01-preview`,
  }
  interface Vehicles extends Azure.Contoso.Vehicles.Operations.Vehicles {}
  interface Cars extends Azure.Contoso.Vehicles.Operations.Cars {}
  interface Motorcycles extends Azure.Contoso.Vehicles.Operations.Motorcycles {}
}


