# How to Compile

## TypeSpec compilation commands

```cmd
npm ci
npx tsv specification/portalservices/Dashboard.Management
```

## Rule Format Failed issue

If you see the following error:

```cmd
Rule Format failed
{"not_added":[],"conflicted":[],"created":[],"deleted":[],"modified":["specification/portalservices/Dashboard.Management/models.tsp"],"renamed":[],"files":[{"path":"specification/portalservices/Dashboard.Management/models.tsp","index":" ","working_dir":"M"}],"staged":[],"ahead":0,"behind":0,"current":"HEAD","tracking":null,"detached":true}diff --git a/<somefile>.tsp b/<somefile>.tsp
index 0d0d79ff3c..db81fab225 100644
--- a/<somefile>.tsp
+++ b/<somefile>.tsp
```

E.g.:
```cmd
{"not_added":[],"conflicted":[],"created":[],"deleted":[],"modified":["specification/portalservices/Dashboard.Management/models.tsp"],"renamed":[],"files":[{"path":"specification/portalservices/Dashboard.Management/models.tsp","index":" ","working_dir":"M"}],"staged":[],"ahead":0,"behind":0,"current":"HEAD","tracking":null,"detached":true}diff --git a/specification/portalservices/Dashboard.Management/models.tsp b/specification/portalservices/Dashboard.Management/models.tsp
index 0d0d79ff3c..db81fab225 100644
--- a/specification/portalservices/Dashboard.Management/models.tsp
+++ b/specification/portalservices/Dashboard.Management/models.tsp
```

Then run the following:
```cmd
tsp format <somefile>.tsp
```

e.g.
```cmd
tsp format specification/portalservices/Dashboard.Management/models.tsp
```

and retry compiling again. [TypeSpec compilation commands](#typespec-compilation-commands).

# References

1. [TypeSpec installations](https://typespec.io/docs/introduction/installation)
1. [TypeSpec VSCode extension](https://typespec.io/docs/introduction/editor/vscode)