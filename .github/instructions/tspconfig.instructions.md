---
applyTo: '**/tspconfig.yaml'
---

## Adding Go support to an existing tspconfig.yaml

Adding in Go support is simple if you're using an existing configuration, and just requires some translation of the C# entry.

Here's an example C# entry:

```yaml
"@azure-tools/typespec-csharp":
	package-dir: "Azure.AI.DocumentIntelligence"
	namespace: "Azure.AI.DocumentIntelligence"
	model-namespace: false
	flavor: azure
```

To generate Go, just do the following translation:

Example (Go, dataplane):

```yaml
"@azure-tools/typespec-go":
    # Take the segments after `Azure`, in the `namespace` property. Each segment 
    # is a file path. The _last_ file path should be prefixed with `az`.
	module: "github.com/Azure/azure-sdk-for-go/sdk/ai/azdocumentintelligence"
    # take the segments and turn them into a file path. Do not include the final segment this time.
	service-dir: "{output-dir}/sdk/ai"
    # take the final segment, prefix it with `az`, and make it all lowercase. 
    # NOTE, this property builds on the one before it, so you don't have to add it again.
	emitter-output-dir: "{service-dir}/azdocumentintelligence"
    # the remainder of these settings are our suggested defaults. More information about each flag can be found here:
    # https://github.com/Azure/autorest.go/blob/main/packages/typespec-go/src/lib.ts
	generate-fakes: true
	inject-spans: true
	single-client: true
	slice-elements-byval: true
	fix-const-stuttering: true
	rawjson-as-bytes: true
	generate-samples: true
	flavor: azure
```
