# Terraform on AWS

One of my first Terraform projects. I wanted something small enough to read in two minutes but still realistic: an S3 bucket and a web server on EC2, everything defined in code, with variables instead of hardcoded values and nothing sensitive in the repo.

## What it creates

- **An S3 bucket** with versioning turned on, so overwritten or deleted files can be recovered, and all public access blocked.
- **An EC2 instance** (Amazon Linux 2023, `t2.micro` by default). The AMI isn't hardcoded: Terraform looks up the latest Amazon Linux image in the region, so the code doesn't break when AWS publishes a new one. On first boot, a small `user_data` script installs nginx and serves a test page.
- **A security group** attached to the instance. HTTP is open to everyone, but SSH is only allowed from the IP you give it, not from the whole internet.

Every resource gets `Project` and `ManagedBy` tags automatically through the provider's `default_tags`, which makes it easy to find everything in the AWS console.

## Files

| File | What's in it |
|---|---|
| `versions.tf` | Terraform and AWS provider versions |
| `provider.tf` | AWS provider, region and default tags |
| `variables.tf` | region, bucket name, instance type, SSH CIDR, key pair |
| `main.tf` | S3 bucket, versioning and public access block |
| `ec2.tf` | AMI lookup, security group and EC2 instance |
| `outputs.tf` | bucket name, instance ID, public IP and URL |
| `terraform.tfvars.example` | example values to copy |

## Running it

You need Terraform 1.5 or newer and AWS credentials configured locally (for example with `aws configure`).

Copy the example variables and put your own values in. S3 bucket names are global, so pick something unique, and use your own public IP for SSH:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Then the usual workflow:

```bash
terraform init
terraform plan
terraform apply
```

At the end Terraform prints the outputs, including `website_url`. Give the instance a minute to install nginx and open it in a browser.

When you're done, destroy everything so it doesn't keep costing money:

```bash
terraform destroy
```

If the bucket still has files in it, empty it first, otherwise AWS won't let Terraform delete it.

## Notes

- `terraform.tfvars`, the state files and the `.terraform` folder are in `.gitignore`. The state can contain sensitive data, so it should never end up in Git.
- The state is stored locally here because it's a solo lab. In a team I'd keep it in a remote backend (an S3 bucket with locking) so several people can work on the same infrastructure safely.
- Next step for this project would be splitting it into modules and adding a VPC of its own instead of using the default one.
