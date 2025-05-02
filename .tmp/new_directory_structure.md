An Azure Resource Provider and its 1+ Azure Services
A single Azure Resource Provider (RP) has an RP namespace. This RP namespace can contain 1+ control-plane services and 0+ data-plane service; each service versions as described above . Today, we want the GitHub specs repo to be structured as follows for control-plane & data-plane contracts:
specification/
└── <orgName1>/	 NOTE: Today this has no clear definition (Org name? Service name?)
    ├── cspell.yaml
    └── resource-manager/
        └── <RPNamespace>/		 NOTE: Control-plane only (not data-plane) 
            ├── readme.md		 NOTE: For ARM schema validation; see bullet #2 below
            ├── operations/		 NOTE: See bullet below about the “Operations operation” 
            └── <ServiceName1>/	 CX-facing service name; each version gets Docs & SDK package
                ├── tspconfig.yaml	 TypeSpec files go here
                ├── main.tsp
                ├── models.tsp
                ├── readme.md		 autorest readme with YAML blocks
                └── examples/		 TypeSpec example folder
                    └── <api-version>/	 One folder per service version described in TypeSpec
                        └── <example .json files> 
                └── preview/ and stable/
                    └── <api-version>/	 One folder per service version described in Swagger
                        ├── <swagger .json files>
                        └── examples/	 Swagger example folder
                            └── <example .json files>
            └── <ServiceName2>/	// CX-facing service name; contents identical to above structure
    └── data-plane/
        └── <ServiceName3>/	// CX-facing service name; contents identical to above structure
We don’t want internal teams or customers to think about the orgName, we want customers to think that Azure has RPNamespace’s that are used to manage services (both with customer-facing names) where each service has versions (some preview and some stable), & each version has its own API contract, documentation, and (beta/GA) SDK package(s). 
To enforce these rules, I propose some tweaks to the repo structure:
1.	Force the folder immediately under specification to be the RPNamespace name (replacing orgName). EngSys should validate that this folder name matches the RPnamespace name currently under the resource-manager folder and that there are no files in this folder and that the only subfolders are resource-manager and data-plane. 
•	Ideally, we’d get rid of the resource-manager folder’s RPNamespace subfolder as this extra level in the hierarchy serves no purpose and is just confusing, but this can be done in a later phase.
2.	In the resource-manager folder there must be just 1 readme.md file and at least 2 service name folders (operations & some actual service name). The readme.md file is required by RPaaS for HTTP request schema validation; it must have references to all the swagger files that make up the RP (which includes ALL the services within the RP)
3.	In the data-plane folder there must be no files and at least 1 service name folder.
4.	The ServiceName folder must have only readme.*, tspconfig.yaml and *.tsp files in it. 
•	In the readme.md file, the latest package tag value (which represents a service version) must refer to swagger files that are all in the exact same folder. Also, if the tag value is suffixed with “-preview” then all the swagger paths must refer to files in the preview subfolder; else all swagger paths must refer to files in the stable subfolder.
•	NOTE: If 2+ services want to “share” some TypeSpec/swagger files, these files must be explicitly copied into a consuming service’s folder on its desired timeline. We do not allow multiple services to reference a single copy of a service contract because it is too dangerous to allow one service to change a shared contract, forcing other services to pick up this shared contract instantly, especially if the shared contract introduces breaking changes. Each service must be in control of its own destiny.
5.	The ServiceName folder must have examples, preview and stable subfolders. Additional subfolders are allowed to help organize *.tsp files. The rules should ensure that only the tspconfig.yaml  and *.tsp files are in the ServiceName folder.  
6.	The examples folder should only have a subfolder for each api-version and each api-version folder can contain only example *.json files for this api-version.
7.	The preview and stable folders must only have subfolders whose name match this format: YYYY-MM-DD-preview in the preview folder and YYYY-MM-DD in the stable folder. All the files in the YYYY-MM-DD(-preview) folders must be json (swagger) files.
8.	Each YYYY-MM-DD(-preview) folder must have an examples folder containing only example *.json filder for this api-version.
9.	It is illegal for a preview & stable version to share the same date. For example, if there is a 2024-04-01-preview, then there can never be a 2024-04-01 stable. It would be great for the repo tooling to detect this and prevent merging of the PR. 
10.	Each RPNamespace folder must have a service folder called “operations” this pseudo-service exists to handle the special “Operations operation” (see RPC docs, real-life docs and folder example). While this RP (not service) operation requires an api-version query parameter, the response data is not specific to this api-version; the response is api-version neutral. In addition, the response is always the same regardless of tenant/subscription. Whenever any other service in the RP gets a new api-version, the TypeSpec/Swagger for the operations service must also be updated to match this new api-version. Due to the special nature of the Operations operation, Azure SDKs already build support for this directly into each ARM SDK. Therefore, the operations service folder does not need any readme files in it as the Azure SDK team does not produce SDKs packages from these readme files.
