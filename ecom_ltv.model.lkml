connection: "thelook_mysql"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
persist_for: "5 hours"

# Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: order_items {
  join: orders {
    relationship: many_to_one
    sql_on: ${orders.id} = ${order_items.order_id} ;;
  }

  join: users {
    relationship: many_to_one
    sql_on: ${users.id} = ${orders.user_id} ;;
  }

  join: user_facts {
    relationship: many_to_one
    sql_on: ${user_facts.id} = ${orders.user_id} ;;
  }
  join: ltv_predictions {
    relationship: one_to_one
    sql_on: ${users.id} = ${ltv_predictions.user_id} ;;
  }
}
