# Infra

This repository contains the IaC definitions for the Noted infrastructure.

## Koyeb

To deploy Noted on Koyeb, you must use `terraform`.

You first need to configure a Koyeb API token.

```
export KOYEB_TOKEN='<insert API token>'
```

Then, define a `secret.tfvars` file in the `koyeb` folder and fill in the following values.

```
// URI of the Mongo database used in production.
mongo_uri = "<...>"
```

Finally execute the standard terraform flow.

```
cd koyeb
terraform init
terraform plan
terraform apply -var-file="secret.tfvars"
```

## Vercel

Coming soon.
 