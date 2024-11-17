locals {
  policy_rg = setproduct(var.rgname, var.policyname)
  policy_params= zipmap(var.policyname, var.parameters)
}

data "azurerm_policy_definition" "policy" {
  for_each = {
    for q in local.policy_rg : "${q[0]}-${q[1]}" => {
      rgname = q[0]
      policyname = q[1]
    }
  }
  display_name = each.value.policyname
}

resource "azurerm_resource_group_policy_assignment" "assignment" {
  for_each = {
    for q in local.policy_rg : "${q[0]}-${q[1]}" => {
      rgname = q[0]
      policyname = join("",regexall("[^%&?/<>:]",q[1]))
      param_value = lookup(local.policy_params,q[1])
    }
  }
  name                 = substr("${each.value.rgname}-${each.value.policyname}",0,64)
  policy_definition_id = data.azurerm_policy_definition.policy[each.key].id
  resource_group_id    = "/subscriptions/${var.subscription_id}/resourceGroups/${each.value.rgname}"
  parameters           = jsonencode(each.value.param_value)
}
