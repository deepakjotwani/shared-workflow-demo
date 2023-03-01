package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSQS(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../AWS/SQS",
        Vars: map[string]interface{}{
            "name": ["test-sqs"],
            "tags": {CreatedBy : "terratest"},
        },
    }
    // Run terraform init and terraform plan
    terraform.InitAndPlan(t, terraformOptions)
}
