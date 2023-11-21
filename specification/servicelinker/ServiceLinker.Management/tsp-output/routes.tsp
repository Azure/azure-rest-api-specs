import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ServiceLinkerManagementClient;

interface LinkerOperations {
  @doc("Returns list of Linkers which connects to the resource.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;
    },
    LinkerList
  >;

  @doc("Returns Linker resource for a given name.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;
    },
    LinkerResource
  >;

  @doc("Create or update linker resource.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;

      @doc("Linker details.")
      @body
      parameters: LinkerResource;
    },
    LinkerResource
  >;

  @doc("Delete a link.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;
    },
    void
  >;

  @doc("Operation to update an existing link.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;

      @doc("Linker details.")
      @body
      parameters: LinkerPatch;
    },
    LinkerResource
  >;

  @doc("Validate a link.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}/validateLinker")
  @post
  Validate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;
    },
    ValidateOperationResult | void
  >;

  @doc("list source configurations for a linker.")
  @route("/{resourceUri}/providers/Microsoft.ServiceLinker/linkers/{linkerName}/listConfigurations")
  @post
  ListConfigurations is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the resource to be
connected.
""")
      @path
      resourceUri: string;

      @doc("The name Linker resource.")
      @path
      linkerName: string;
    },
    SourceConfigurationResult
  >;
}

interface OperationsOperations {
  @doc("Lists the available ServiceLinker REST API operations.")
  @route("/providers/Microsoft.ServiceLinker/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
