view: ltv_predictions {
  sql_table_name: partner_scratch.ltv_predictions ;;

  dimension: ltv_prediction {
    type: number
    sql: ${TABLE}.ltv_prediction ;;
  }

  dimension: user_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: sum_ltv_prediction {
    type: sum
    sql: ${ltv_prediction} ;;
    value_format_name: usd
  }
  measure: average_ltv_prediction {
    type: average
    sql: ${ltv_prediction} ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
