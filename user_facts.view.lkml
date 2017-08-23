view: user_facts {
  derived_table: {
    sql: SELECT
         u.id
        , count(DISTINCT CASE WHEN o.created_at <= DATE_ADD( u.created_at , INTERVAL 30 DAY) THEN oi.order_id ELSE NULL END) orders_in_first_30_days
        , sum(CASE WHEN o.created_at <= DATE_ADD( u.created_at , INTERVAL 30 DAY) THEN sale_price END) as total_revenue_in_first_30_days
        , count(DISTINCT oi.order_id ) as order_count
        , sum(sale_price) as total_revenue

      FROM
        order_items oi
        LEFT JOIN orders o ON (oi.order_id = o.id )
        LEFT JOIN users u ON (o.user_id = u.id)
      GROUP BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: orders_in_first_30_days {
    type: number
    sql: ${TABLE}.orders_in_first_30_days ;;
  }

  dimension: total_revenue_in_first_30_days {
    type: number
    sql: COALESCE(${TABLE}.total_revenue_in_first_30_days,0) ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  set: detail {
    fields: [id, orders_in_first_30_days, order_count, total_revenue]
  }
}
