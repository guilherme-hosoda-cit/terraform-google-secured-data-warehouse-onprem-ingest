/**
 * Copyright 2023-2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  network_name               = "vpc-ingestion"
  restricted_googleapis_cidr = "199.36.153.4/30"
  private_googleapis_cidr    = "199.36.153.8/30"
  subnet_ip                  = "10.0.32.0/28"
}

module "network" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "10.0.0"
  project_id                             = module.data_ingestion_project.project_id
  network_name                           = local.network_name
  shared_vpc_host                        = "false"
  delete_default_internet_gateway_routes = "true"

  subnets = [
    {
      subnet_name           = "sb-restricted-${var.region}"
      subnet_ip             = local.subnet_ip
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "restricted subnet."
    }
  ]

  routes = [{
    name              = "rt-ingestion-1000-all-default-restricted-api"
    description       = "Route through IGW to allow restricted google api access."
    destination_range = local.restricted_googleapis_cidr
    next_hop_internet = "true"
    priority          = "1000"
    },
    {
      name              = "rt-ingestion-1000-all-default-private-api"
      description       = "Route through IGW to allow private google api access."
      destination_range = local.private_googleapis_cidr
      next_hop_internet = "true"
      priority          = "1000"
  }]
}
