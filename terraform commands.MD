### Terraform Commands

1. terraform init

Initializes the working directory containing the Terraform configuration files. It downloads necessary provider plugins and sets up the backend configuration.

```
terraform init
```

2. terraform plan

Generates an execution plan showing the changes Terraform will apply to the infrastructure. It does not make any changes but provides insight into what actions will be taken.

```
terraform plan
```

3. terraform apply

Applies the changes required to achieve the desired state of the configuration. If no saved plan is provided, Terraform will create a new plan and apply it.

```
terraform apply
```

The terraform apply -auto-approve command is used to apply the Terraform execution plan without requiring manual confirmation. Normally, after running terraform apply, Terraform prompts the user to type yes to confirm the changes before proceeding. The -auto-approve flag bypasses this confirmation step, allowing Terraform to apply the plan automatically.

```
terraform apply -auto-approve
```


4. terraform destroy

Destroys all infrastructure resources defined in the configuration. This is useful when you need to tear down environments.

```
terraform destroy
```

The terraform destroy -auto-approve command is used to destroy or tear down all infrastructure resources managed by Terraform without requiring manual confirmation. Typically, when you run terraform destroy, Terraform prompts for confirmation by asking the user to type yes. The -auto-approve flag bypasses this prompt, allowing Terraform to destroy the resources automatically.

```
terraform destroy -auto-approve
```

5. terraform 

Formats your Terraform configuration files to follow consistent style conventions. It makes the configuration more readable and adheres to a standardized format.

```
terraform fmt
```