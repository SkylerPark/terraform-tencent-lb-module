# layer7-with-instance

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 0.13.0 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >1.18.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >1.18.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance"></a> [instance](#module\_instance) | git::https://github.com/SkylerPark/terraform-tencent-cvm-module.git//modules/instance/ | tags/1.0.5 |
| <a name="module_layer7"></a> [layer7](#module\_layer7) | ../../modules/layer7-instance | n/a |
| <a name="module_layer7_security_group"></a> [layer7\_security\_group](#module\_layer7\_security\_group) | git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/ | tags/1.2.0 |
| <a name="module_parksm_attachment_v1"></a> [parksm\_attachment\_v1](#module\_parksm\_attachment\_v1) | ../../modules/target-attachment | n/a |
| <a name="module_public_route_table"></a> [public\_route\_table](#module\_public\_route\_table) | git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/route-table/ | tags/1.2.0 |
| <a name="module_public_subnet_group"></a> [public\_subnet\_group](#module\_public\_subnet\_group) | git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/subnet-group/ | tags/1.2.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/security-group/ | tags/1.2.0 |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | git::https://github.com/SkylerPark/terraform-tencent-cvm-module.git//modules/key-pair/ | tags/1.0.5 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/SkylerPark/terraform-tencent-vpc-module.git//modules/vpc/ | tags/1.2.0 |

## Resources

| Name | Type |
|------|------|
| [tencentcloud_image.rocky8](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/data-sources/image) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
