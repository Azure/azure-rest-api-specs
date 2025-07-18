import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./client.tsp";


using TypeSpec.Http;
using TypeSpec.Versioning;

@service(#{title: "Sample API"})
@versioned(Versions)
namespace Azure.ResourceManager {
    @doc("Service API versions")
    enum Versions {
        @doc("Version 2023-01-01")
        v2023_01_01: "2023-01-01",
    }

    model DiskOptions {
        value: int32;
    }

    model Wrapper {
        options: DiskOptions;
    }

    @route("/number")
    @get
    op GetNumber(@body foo: DiskOptions): Wrapper;
}