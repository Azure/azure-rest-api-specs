## Generate swagger, controllers, models from CADL files

1. Create CADL files like main.cadl, which has reference to models.cadl. Refer - https://github.com/microsoft/cadl/wiki
2. Create a cadl-project.yaml file as shown. May be check the latest versions of cadl library on github.
3. Run commands
```dotnetcli
    npm init -y
	npm  install
	npx cadl comiple main.cadl
```

This should generate the required openapi spec, controllers, models
