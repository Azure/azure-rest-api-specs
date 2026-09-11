# 003002-arm-modify-response

Source eval: `.github/skills/azure-typespec-author/evaluate/evals/003002.eval.yaml`

## Trigger

```text
Modify the LRO createOrUpdate PUT operation in interface Employees so that it returns Azure-AsyncOperation header but NOT Retry-After header in the 201 response. The operation currently uses ArmResourceCreateOrReplaceAsync<Employee> template.
```

## Forced

```text
@azure-typespec-author Modify the LRO createOrUpdate PUT operation in interface Employees so that it returns Azure-AsyncOperation header but NOT Retry-After header in the 201 response. The operation currently uses ArmResourceCreateOrReplaceAsync<Employee> template.
```

## No-skill

```text
Modify the LRO createOrUpdate PUT operation in interface Employees so that it returns Azure-AsyncOperation header but NOT Retry-After header in the 201 response. The operation currently uses ArmResourceCreateOrReplaceAsync<Employee> template.
```
