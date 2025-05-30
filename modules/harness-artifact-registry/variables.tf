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

variable "org_id" {
  description = "The numeric organization id."
  type        = string
}

variable "folder_id" {
  description = "The folder to deploy in."
  type        = string
}

variable "project_name" {
  description = "Custom project name for the template project."
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ."
  type        = string
}

variable "location" {
  description = "Artifact Registry location."
  type        = string
}

variable "service_account_email" {
  description = "Terraform service account email"
  type        = string
}

variable "deletion_policy" {
  description = "Project deletion policy. Possible values are: \"PREVENT\", \"ABANDON\", \"DELETE\""
  type        = string
  default     = "PREVENT"
}
