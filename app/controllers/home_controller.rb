class HomeController < ApplicationController
  def index
    
    sql = 'SELECT SUM("total count") "Total Tuples"
        FROM((SELECT COUNT(*)"total count"
            FROM area
            UNION
            SELECT COUNT(*) "total count"
            FROM accident_all))'
    
    @result = ActiveRecord::Base.connection.exec_query(sql).to_a

  end
end
