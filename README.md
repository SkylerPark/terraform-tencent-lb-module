# terraform-tencent-lb-module

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Component

아래 도구를 이용하여 모듈작성을 하였습니다. 링크를 참고하여 OS 에 맞게 설치 합니다.

> **macos** : ./bin/install-macos.sh

- [pre-commit](https://pre-commit.com)
- [terraform](https://terraform.io)
- [tfenv](https://github.com/tfutils/tfenv)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [tfsec](https://github.com/tfsec/tfsec)
- [tflint](https://github.com/terraform-linters/tflint)

## Services

해당 Terraform 모듈을 사용하여 아래 서비스를 관리 합니다.

- **Tencent LB (Load Balancer)**
  - layer4-instance
  - layer4-listener
  - layer7-instance
  - layer7-listener
  - lb-logging
  - listener-redirection
  - target-attachment

## Usage

아래 예시를 활용하여 작성가능하며 examples 코드를 참고 부탁드립니다.

### layer7

layer7 형식의 clb 를 만들고 instance 로 세팅 하는 예시 입니다.

```hcl
module "layer7" {
  source = "../../modules/layer7-instance"
  name   = "parksm-lb"

  is_public = true
  vpc_id    = module.vpc.id

  security_groups   = [module.layer7_security_group.id]
  bandwidth_max_out = 2048

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      rules = [
        {
          domain      = "test.com"
          url         = "/"
          target_type = "NODE"
          health_check = {
            enabled             = true
            interval            = 3
            healthy_threshold   = 3
            unhealthy_threshold = 2
            matcher             = 2
            path                = "/"
            domain              = "localhost"
            method              = "GET"
            timeout             = 3
          }
          load_balancing_algorithm_type = "LEAST_CONN"
        },
        {
          domain      = "test1.com"
          url         = "/"
          target_type = "NODE"
          health_check = {
            enabled             = true
            interval            = 3
            healthy_threshold   = 3
            unhealthy_threshold = 2
            matcher             = 2
            path                = "/"
            domain              = "localhost"
            method              = "GET"
            timeout             = 3
          }
          load_balancing_algorithm_type = "LEAST_CONN"
        }
      ]
    }
  ]
}

module "parksm_attachment_v1" {
  source        = "../../modules/target-attachment"
  load_balancer = module.layer7.id
  listener      = module.layer7.listeners["80"].id
  rule          = module.layer7.listeners["80"].rules["test.com/"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 80
      weight      = 100
    } if value.is_lb
  ]
}
```

### layer4

layer4 형식의 clb 를 만들고 instance 로 세팅 하는 예시 입니다.

```hcl
module "layer4" {
  source = "../../modules/layer4-instance"
  name   = "parksm-lb"

  is_public = true
  vpc_id    = module.vpc.id

  security_groups   = [module.layer4_security_group.id]
  bandwidth_max_out = 2048

  listeners = [
    {
      port     = 80
      protocol = "TCP"
      health_check = {
        enabled = true
      }
      load_balancing_algorithm_type = "LEAST_CONN"
    }
  ]
}

module "parksm_attachment_v1" {
  source        = "../../modules/target-attachment"
  load_balancer = module.layer4.id
  listener      = module.layer4.listeners["80"].id
  targets = [
    for instance, value in local.instances : {
      instance_id = module.instance[instance].id
      port        = 80
      weight      = 100
    } if value.is_lb
  ]
}
```
