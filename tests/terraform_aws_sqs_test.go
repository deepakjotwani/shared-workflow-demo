package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSQS(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../AWS/SQS",
        Vars: map[string]interface{}{
            "name": []string{"test-sqs", "value2", "value3"},
            "tags": map[string]string{
				"CreatedBy": "Terratest",
			},
        },
    }
    // Run terraform init and terraform plan
    terraform.InitAndPlan(t, terraformOptions)
}
